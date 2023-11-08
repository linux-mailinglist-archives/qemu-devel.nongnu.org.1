Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A17E5EB1
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 20:34:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0oIk-0008WM-DW; Wed, 08 Nov 2023 14:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul.knight@oasis-open.org>)
 id 1r0oIh-0008W6-DF
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 14:33:19 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paul.knight@oasis-open.org>)
 id 1r0oIf-0004qK-0K
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 14:33:19 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7a956887c20so2046639f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 11:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oasis-open-org.20230601.gappssmtp.com; s=20230601; t=1699471995; x=1700076795;
 darn=nongnu.org; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9I12sN3bYvArj8wrZUCoYQV5h7w6GNNiyJck2N4AIgU=;
 b=RCAvFZiYn7QuwiCSMuiV7d2miVWMeDUoYDKElWOfvw/kIGXf81gxD34YqhVb1WjvzS
 cJ4vk/Z4XcARh1QTg3SBOCYnaVRD5T4MNVGlH8i5kXnRPGiYrTSGy6k2QpMB3ff7qMIl
 orwsK8auJ/aMzzodc/QHFGf7rg/qWskozFt9/Drey/AW8+xXbDLfrg3BnJ7Qof1Ci+YE
 p2F2lcfjCt38yalUoIEO6cXh1v+l+AQ9JAufzbXraUkXX07F4Lx0N1k5wekEvAYEqvE7
 NF9iMHgwr1TRlYNtB7zQnKDqW5/Y/1ZlfnKQGiEhVIzRaQmGyvvSffW1FxqUonDYK+Yf
 SkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699471995; x=1700076795;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9I12sN3bYvArj8wrZUCoYQV5h7w6GNNiyJck2N4AIgU=;
 b=pKlRZ5cGST5XcDRU0jsL2X9LxMwgwAoEpmBJeWdU7UFe+13/tq3k8g5EMhifRWOC8r
 UyUaD02uPgv1+5T7toDT5zfiwkTpr7yzrY40PsOYQKXt2gu8MS8s3KcCEumhRnyUT3AF
 A0tX6e9/XEDQve1lKRWWcCB4cTqamOCgg7poOuJLvzdp+QYj8063Rwla8IFftEBUhRMT
 1n5SMrxS9kT6HqYrvCqjUcdHdqiGdnzKcKXl2YxF8UDvB0XKCbUGN2Qt+OuRWqQCxeQM
 vhUBYoQGnFej2NNe2Akxf/tuyMDF32DEiuD9gLkqBFpHS+YH5SPeZt+hYqSiL7SdG/Dq
 +xkw==
X-Gm-Message-State: AOJu0YxvZnUz2aklDd9SOEMfVYZm3UFmYOFM3jzxZ8N+97QDFBRmzLlY
 y6px7rYimWkH5mHSXJMyZrS9Td/dDnkkWhjjs1NIpw==
X-Google-Smtp-Source: AGHT+IElanGZ5BTlx6OBcuOpjBD5A1wBi/8drWr/XXiU6HZgTAvgz7DH/f5Dt9UYFKLuSxTphVf5HilF3qEd/+6rT/8=
X-Received: by 2002:a05:6602:3812:b0:786:25a3:ef30 with SMTP id
 bb18-20020a056602381200b0078625a3ef30mr3962649iob.7.1699471994336; Wed, 08
 Nov 2023 11:33:14 -0800 (PST)
MIME-Version: 1.0
From: Paul Knight <paul.knight@oasis-open.org>
Date: Wed, 8 Nov 2023 14:33:03 -0500
Message-ID: <CADgeAH_67CQZoVGEB_ddGEZA5+kUzmQe_3yfA1U6-c-K2mJi7g@mail.gmail.com>
Subject: Invitation to comment on Virtual I/O Device (VIRTIO) Version 1.3 -
 ends December 8th
To: project-announce@lists.oasis-open.org, members@lists.oasis-open.org, 
 virtio@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Content-Type: multipart/alternative; boundary="0000000000008753570609a9289d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=paul.knight@oasis-open.org; helo=mail-io1-xd31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--0000000000008753570609a9289d
Content-Type: text/plain; charset="UTF-8"

OASIS members and other interested parties,

OASIS and the OASIS Virtual I/O Device (VIRTIO) TC are pleased to announce
that Virtual I/O Device (VIRTIO) Version 1.3 is now available for public
review and comment.

Specification Overview:

This document describes the specifications of the 'virtio' family of
devices. These devices are found in virtual environments, yet by design
they look like physical devices to the guest within the virtual machine -
and this document treats them as such. This similarity allows the guest to
use standard drivers and discovery mechanisms. The purpose of virtio and
this specification is that virtual environments and guests should have a
straightforward, efficient, standard and extensible mechanism for virtual
devices, rather than boutique per-environment or per-OS mechanisms.

The documents and related files are available here:

Virtual I/O Device (VIRTIO) Version 1.3
Committee Specification Draft 01
06 October 2023

Editable source (Authoritative):
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/tex/
HTML:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html
PDF:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.pdf
Example driver listing:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/listings/
PDF file marked to indicate changes from Version 1.2 Committee
Specification 01:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01-diff-from-v1.2-cs01.pdf

For your convenience, OASIS provides a complete package of the
specification document and any related files in ZIP distribution files. You
can download the ZIP file at:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.zip

A public review metadata record documenting this and any previous public
reviews is available at:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01-public-review-metadata.html

How to Provide Feedback

OASIS and the OASIS Virtual I/O Device (VIRTIO) TC value your feedback. We
solicit input from developers, users and others, whether OASIS members or
not, for the sake of improving the interoperability and quality of its
technical work.

The public review starts 09 November 2023 at 00:00 UTC and ends 08 December
2023 at 23:59 UTC.

Comments may be submitted to the TC by any person through the use of the
OASIS TC Comment Facility which can be used by following the instructions
on the TC's "Send A Comment" page (
https://www.oasis-open.org/committees/comments/index.php?wg_abbrev=virtio).

Comments submitted by TC non-members for this work and for other work of
this TC are publicly archived and can be viewed at:

https://lists.oasis-open.org/archives/virtio-comment/

All comments submitted to OASIS are subject to the OASIS Feedback License,
which ensures that the feedback you provide carries the same obligations at
least as the obligations of the TC members. In connection with this public
review, we call your attention to the OASIS IPR Policy [1] applicable
especially [2] to the work of this technical committee. All members of the
TC should be familiar with this document, which may create obligations
regarding the disclosure and availability of a member's patent, copyright,
trademark and license rights that read on an approved OASIS specification.

OASIS invites any persons who know of any such claims to disclose these if
they may be essential to the implementation of the above specification, so
that notice of them may be posted to the notice page for this TC's work.

Additional information about the specification and the VIRTIO TC can be
found at the TC's public home page:
https://www.oasis-open.org/committees/virtio/

========== Additional references:

[1] https://www.oasis-open.org/policies-guidelines/ipr/

[2] https://github.com/oasis-tcs/virtio-admin/blob/master/IPR.md
https://www.oasis-open.org/policies-guidelines/ipr/#Non-Assertion-Mode
Non-Assertion Mode
-- 
Paul Knight <paul.knight@oasis-open.org>....Document Process Analyst
<https://www.oasis-open.org/people/staff/paul-knight>
OASIS <https://www.oasis-open.org/>...Setting the standard for open
collaboration

--0000000000008753570609a9289d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>OASIS members and other interested parties,<br><br>OA=
SIS and the OASIS Virtual I/O Device (VIRTIO) TC are pleased to announce th=
at Virtual I/O Device (VIRTIO) Version 1.3 is now available for public revi=
ew and comment.<br><br>Specification Overview:<br><br>This document describ=
es the specifications of the &#39;virtio&#39; family of devices. These devi=
ces are found in virtual environments, yet by design they look like physica=
l devices to the guest within the virtual machine - and this document treat=
s them as such. This similarity allows the guest to use standard drivers an=
d discovery mechanisms. The purpose of virtio and this specification is tha=
t virtual environments and guests should have a straightforward, efficient,=
 standard and extensible mechanism for virtual devices, rather than boutiqu=
e per-environment or per-OS mechanisms.<br><br>The documents and related fi=
les are available here:<br><br>Virtual I/O Device (VIRTIO) Version 1.3<br>C=
ommittee Specification Draft 01<br>06 October 2023<br><br>Editable source (=
Authoritative):<br><a href=3D"https://docs.oasis-open.org/virtio/virtio/v1.=
3/csd01/tex/">https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/tex/</a>=
<br>HTML:<br><a href=3D"https://docs.oasis-open.org/virtio/virtio/v1.3/csd0=
1/virtio-v1.3-csd01.html">https://docs.oasis-open.org/virtio/virtio/v1.3/cs=
d01/virtio-v1.3-csd01.html</a><br>PDF:<br><a href=3D"https://docs.oasis-ope=
n.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.pdf">https://docs.oasis-op=
en.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.pdf</a><br>Example driver=
 listing:<br><a href=3D"https://docs.oasis-open.org/virtio/virtio/v1.3/csd0=
1/listings/">https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/listings/=
</a><br>PDF file marked to indicate changes from Version 1.2 Committee Spec=
ification 01:<br><a href=3D"https://docs.oasis-open.org/virtio/virtio/v1.3/=
csd01/virtio-v1.3-csd01-diff-from-v1.2-cs01.pdf">https://docs.oasis-open.or=
g/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01-diff-from-v1.2-cs01.pdf</a><br=
><br>For your convenience, OASIS provides a complete package of the specifi=
cation document and any related files in ZIP distribution files. You can do=
wnload the ZIP file at:<br><a href=3D"https://docs.oasis-open.org/virtio/vi=
rtio/v1.3/csd01/virtio-v1.3-csd01.zip">https://docs.oasis-open.org/virtio/v=
irtio/v1.3/csd01/virtio-v1.3-csd01.zip</a><br><br>A public review metadata =
record documenting this and any previous public reviews is available at:<br=
><a href=3D"https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.=
3-csd01-public-review-metadata.html">https://docs.oasis-open.org/virtio/vir=
tio/v1.3/csd01/virtio-v1.3-csd01-public-review-metadata.html</a><br><br>How=
 to Provide Feedback<br><br>OASIS and the OASIS Virtual I/O Device (VIRTIO)=
 TC value your feedback. We solicit input from developers, users and others=
, whether OASIS members or not, for the sake of improving the interoperabil=
ity and quality of its technical work.<br><br>The public review starts 09 N=
ovember 2023 at 00:00 UTC and ends 08 December 2023 at 23:59 UTC.<br><br>Co=
mments may be submitted to the TC by any person through the use of the OASI=
S TC Comment Facility which can be used by following the instructions on th=
e TC&#39;s &quot;Send A Comment&quot; page (<a href=3D"https://www.oasis-op=
en.org/committees/comments/index.php?wg_abbrev=3Dvirtio">https://www.oasis-=
open.org/committees/comments/index.php?wg_abbrev=3Dvirtio</a>).<br><br>Comm=
ents submitted by TC non-members for this work and for other work of this T=
C are publicly archived and can be viewed at:<br><br><a href=3D"https://lis=
ts.oasis-open.org/archives/virtio-comment/">https://lists.oasis-open.org/ar=
chives/virtio-comment/</a><br><br>All comments submitted to OASIS are subje=
ct to the OASIS Feedback License, which ensures that the feedback you provi=
de carries the same obligations at least as the obligations of the TC membe=
rs. In connection with this public review, we call your attention to the OA=
SIS IPR Policy [1] applicable especially [2] to the work of this technical =
committee. All members of the TC should be familiar with this document, whi=
ch may create obligations regarding the disclosure and availability of a me=
mber&#39;s patent, copyright, trademark and license rights that read on an =
approved OASIS specification.<br><br>OASIS invites any persons who know of =
any such claims to disclose these if they may be essential to the implement=
ation of the above specification, so that notice of them may be posted to t=
he notice page for this TC&#39;s work.<br><br>Additional information about =
the specification and the VIRTIO TC can be found at the TC&#39;s public hom=
e page:<br><a href=3D"https://www.oasis-open.org/committees/virtio/">https:=
//www.oasis-open.org/committees/virtio/</a><br><br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D Additional references:<br><br>[1] <a href=3D"https://www.oasis-open.=
org/policies-guidelines/ipr/">https://www.oasis-open.org/policies-guideline=
s/ipr/</a><br><br>[2] <a href=3D"https://github.com/oasis-tcs/virtio-admin/=
blob/master/IPR.md">https://github.com/oasis-tcs/virtio-admin/blob/master/I=
PR.md</a><br><a href=3D"https://www.oasis-open.org/policies-guidelines/ipr/=
#Non-Assertion-Mode">https://www.oasis-open.org/policies-guidelines/ipr/#No=
n-Assertion-Mode</a><br>Non-Assertion Mode<br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature" da=
ta-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><di=
v><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><font style=3D"color:rgb(0,0,0)=
;background-color:rgb(255,255,255)" color=3D"#888888"><a href=3D"mailto:pau=
l.knight@oasis-open.org" target=3D"_blank">Paul Knight</a>...</font><span s=
tyle=3D"color:rgb(0,0,0)">.</span><a href=3D"https://www.oasis-open.org/peo=
ple/staff/paul-knight" target=3D"_blank">Document Process Analyst</a></div>=
<div dir=3D"ltr"><font style=3D"color:rgb(0,0,0);background-color:rgb(255,2=
55,255)" color=3D"#888888"><a href=3D"https://www.oasis-open.org/" target=
=3D"_blank">OASIS</a>...</font><font color=3D"#000000">Setting the standard=
 for open collaboration</font></div></div></div></div></div></div></div></d=
iv></div></div></div></div></div></div></div>

--0000000000008753570609a9289d--

