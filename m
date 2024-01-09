Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF00828237
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 09:42:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7gk-0003lk-13; Tue, 09 Jan 2024 03:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1rN7ge-0003l7-6j
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 03:42:16 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1rN7gU-0001gy-Pb
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 03:42:15 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240109084154epoutp01e09b41eeadd1523d6a8d4fd1b11e491e~ooTZsy7U81995019950epoutp01G
 for <qemu-devel@nongnu.org>; Tue,  9 Jan 2024 08:41:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240109084154epoutp01e09b41eeadd1523d6a8d4fd1b11e491e~ooTZsy7U81995019950epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1704789714;
 bh=Sczxlnao9GzPLVmsqV6BEzRnVYquj4xVnmd2Xz/C1wI=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=mg0H3RLD1i9UWWuoQpucq+tdwLGfTGk4TxPlX4EaiuouWxIESAQGRRzxcsdXA/KRO
 R85ip5w8zEK/eKC/KWZBSjgNqzhICXQ6sKGWux+Lzb0US1y5PorIIiHZwO6v0gm4oP
 7NWaKwpvz2uQhWAPfHs4KJpaDJm8IqldV9op2tXw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20240109084153epcas2p3f5950c02e7a842b34e1b86a02bd9f24b~ooTZYJGBg2478724787epcas2p3x;
 Tue,  9 Jan 2024 08:41:53 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.101]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4T8PYY1TRWz4x9QL; Tue,  9 Jan
 2024 08:41:53 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-91-659d06d1e4aa
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 5F.45.18994.1D60D956; Tue,  9 Jan 2024 17:41:53 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 2/3] hw/scsi: add mode sense support for zbc device
From: Daejun Park <daejun7.park@samsung.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Seokhwan Kim <sukka.kim@samsung.com>, Yonggil Song
 <yonggil.song@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240109084052epcms2p2895e6b6bbd84880df6dac43166491f14@epcms2p2>
Date: Tue, 09 Jan 2024 17:40:52 +0900
X-CMS-MailID: 20240109084052epcms2p2895e6b6bbd84880df6dac43166491f14
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTVPci29xUg9XHOSxeHtK0uLL/PKPF
 /a3XGC32b/vHanG8dweLxaqOuYwWU88fYXJg9/hxrp3N48m1zUwe7/ddZfPo27KKMYAlKtsm
 IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
 oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xrJ9
 D9gLtilUNPWyNTAule9i5OSQEDCRuLroCUsXIxeHkMAeRondW08AORwcvAKCEn93CIPUCAu4
 Syx7uYUVxBYSUJJYf3EWO0RcT+LWwzWMIDabgI7E9BP32UHmiAisYpT49rMRrIFZIFjib+cb
 VohlvBIz2p+yQNjSEtuXb2WEsDUkfizrZYawRSVurn7LDmO/PzYfqkZEovXeWagaQYkHP3dD
 xSUlbs/dBFWfL/H/ynIou0Zi24F5ULa+xLWOjWB7eQV8Jc7cewoWZxFQlfh0/TbUTBeJxU/n
 sEDcrC2xbOFrZlA4MAtoSqzfpQ9iSggoSxy5BVXBJ9Fx+C87zFcNG39jZe+Y94QJwlaTWPdz
 PRPEGBmJW/MYJzAqzUKE8ywka2chrF3AyLyKUSq1oDg3PTXZqMBQNy+1HB67yfm5mxjBqVHL
 dwfj6/V/9Q4xMnEwHmKU4GBWEuFV+DwnVYg3JbGyKrUoP76oNCe1+BCjKdDTE5mlRJPzgck5
 ryTe0MTSwMTMzNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGpohPe66E2LyXtioL
 XLk1a++ZL467fGN9ZpaVqwu/XlZl+Nxgsn38xMlXfKK3befc1hVUb5e1LVmW8UdmW2HCn5DH
 /HoTrT8dtD9TeENsyVahqzNKLE7P5lKSWlZzxiVUTHbxpwd6lv93HN7DVC14lFt3UvKujhWZ
 7vs0DKcec/BZpx4Vdo4h0Inp3942P+uukvzbe+QYb1la3bj1qHM568F03nf7Xm+Ijwlhd+PZ
 +f6+gv7D5eqyaSvnmcXcEWzI0pl56v/SBYvfpl3cxXL3cZG03AuJtYuzqj3ml59J2CAisf/A
 EvFz028n9C+Mmfayr6SXx4O7Nn2L4NsXUhz1ilJbprJ6nJx8wm7l/J8cj5VYijMSDbWYi4oT
 AcR/QjQWBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240109084052epcms2p2895e6b6bbd84880df6dac43166491f14
References: <CGME20240109084052epcms2p2895e6b6bbd84880df6dac43166491f14@epcms2p2>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=daejun7.park@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_TEMPERROR=0.01,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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
Reply-To: daejun7.park@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Gentle ping.
Would you mind review this patch for zbc devices?
Thanks,

Daejun

> This patch enables mode sense for zbc devices.
>
> Signed-off-by: Daejun Park
> ---
>=C2=A0=20hw/scsi/scsi-disk.c=2013=20++++++++-----=0D=0A>=C2=A0=201=20file=
=20changed,=208=20insertions(+),=205=20deletions(-)=0D=0A>=0D=0A>=20diff=20=
--git=20a/hw/scsi/scsi-disk.c=20b/hw/scsi/scsi-disk.c=0D=0A>=20index=206691=
f5edb8..f1ecb77317=20100644=0D=0A>=20---=20a/hw/scsi/scsi-disk.c=0D=0A>=20+=
++=20b/hw/scsi/scsi-disk.c=0D=0A>=20=40=40=20-1083,11=20+1083,14=20=40=40=
=20static=20int=20mode_sense_page(SCSIDiskState=20*s,=20int=20page,=20uint8=
_t=20**p_outbuf,=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
int=20page_control)=0D=0A>=C2=A0=20=7B=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20sta=
tic=20const=20int=20mode_sense_valid=5B0x3f=5D=20=3D=20=7B=0D=0A>=20-=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=5BMODE_PAGE_VENDOR_SPECIFIC=5D=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=3D=20(1=20<<=20TYPE_DISK)=20(1=20<<=20TYPE_ROM),=
=0D=0A>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=5BMODE_PAGE_HD_GEOMETRY=5D=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=20(1=20<<=20TYPE_=
DISK),=0D=0A>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=5BMODE_PAGE_FLEXIBLE_=
DISK_GEOMETRY=5D=20=3D=20(1=20<<=20TYPE_DISK),=0D=0A>=20-=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=5BMODE_PAGE_CACHING=5D=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=20(1=20<<=20TYPE_DISK)=20(1=20<<=
=20TYPE_ROM),=0D=0A>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=5BMODE_PAGE_R_=
W_ERROR=5D=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=3D=20(1=20<<=20TYPE_DISK)=20(1=20<<=20TYPE_ROM),=0D=0A>=20+=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=5BMODE_PAGE_VENDOR_SPECIFIC=5D=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=3D=20(1=20<<=20TYPE_DISK)=20(1=20<<=20TYPE_ROM)=0D=0A>=20+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20(1=20<<=20TYPE_ZBC),=
=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=5BMODE_PAGE_HD_GEOMETRY=5D=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=20(1=20<<=20TYPE_=
DISK)=20(1=20<<=20TYPE_ZBC),=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=5BMODE_PAGE_FLEXIBLE_DISK_GEOMETRY=5D=20=3D=20(1=20<<=20TYPE_DISK)=20(1=20=
<<=20TYPE_ZBC),=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=5BMODE_PAGE_=
CACHING=5D=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=3D=20(1=20<<=20TYPE_DISK)=20(1=20<<=20TYPE_ROM)=0D=0A>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20(1=20<<=20TYPE_ZBC),=0D=0A>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=5BMODE_PAGE_R_W_ERROR=5D=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=20(1=20<<=20TYPE_=
DISK)=20(1=20<<=20TYPE_ROM)=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20(1=20<<=20TYPE_ZBC),=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=5BMODE_PAGE_AUDIO_CTL=5D=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=20(1=20<<=20TYPE_ROM),=0D=0A>=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=5BMODE_PAGE_CAPABILITIES=5D=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=20(1=20<<=20TYPE_ROM),=0D=0A>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=5BMODE_PAGE_APPLE_VENDOR=5D=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=20(1=20<<=20TYPE_ROM),=0D=0A>=20--=
=0D=0A>=202.25.1=0D=0A>

