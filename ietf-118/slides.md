---
title: "IPsec BEET MODE : IETF 118, Prague, November 2023 "
author: | 
  | Antony Antony
  | Steffen Klassert"
output:
  beamer_presentation:
    theme: "Berlin"
    keep_tex: true
includes:
    in_header: header_pagenrs1.tex
incremental: TRUE
---

# Goal
* Revive  and Standarize BEET Mode
    * It is in use for 15 years.

# History from 2003 - 2009

* IETF draft-nikander-esp-beet-mode-09 : expired
   * then HIP working group (not in IPsecME)

* Current BEET mode supported software
    * Linux kernel initial commit in 2006

    * strongSwan supports using private IKE Notify

    * iproute2 command line tool to setup SA (ip xfrm)

# Removed sections
* Is anyone using BEET mode for Mobile IP?
    * Current proposal removed Mobile IP.

* PF_KEY details.
    * This does not belong to this ID


# BEET PH Header esp\-\>nexthdr \= 94

Only used when there are IPv4 fragments or IPv4 options.

* Linux Heders: include/uapi/linux/in.h

    "IPPROTO_BEETPH = 94 IP option pseudo header for BEET"

* IANA
    "94 	IPIP 	IP-within-IP Encapsulation Protocol	[John_Ioannidis]"


# Questions?

* Are there any other use cases of BEET mode?
* Any other BEET mode issue to address in this document?

# Backup slide 1: IANA 94 contact

https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml

Decimal, Keyword,Protocol,IPv6 Extension Header, Reference

94, IPIP,IP-within-IP Encapsulation Protocol, "[John_Ioannidis]"

4,IPv4	IPv4 encapsulation,	[RFC2003],

[John_Ioannidis] 	John Ioannidis 	mailto:ji&tla.org 	2015-01-06

# Backup slide 1

RFC 4301 Section 4.1
“Note: AH and ESP cannot be applied using transport mode
to IPv4 packets that are fragments.  Only tunnel mode can be
employed in such cases.  For IPv6, it would be feasible to
carry a plaintext fragment on a transport mode SA; however,
for simplicity, this restriction also applies to IPv6 packets.”
