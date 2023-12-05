Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0880C804948
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 06:20:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rANpw-0004jT-5l; Tue, 05 Dec 2023 00:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1rANpt-0004jF-Mb
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 00:19:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1rANpf-0003eS-9m
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 00:19:09 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231205051848epoutp0411fb4ecc325b5165f549d850db585c38~d19FdnOPV1077810778epoutp04k
 for <qemu-devel@nongnu.org>; Tue,  5 Dec 2023 05:18:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231205051848epoutp0411fb4ecc325b5165f549d850db585c38~d19FdnOPV1077810778epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1701753528;
 bh=se0WlhZi83mS4wKDDIBErdLB2/qRgs4St77gizj7hiY=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=StzWVGLCVPPYhDPyzBLhRxe35ifmQbm0WkPtc6PLfCROSeMGSl4wn+/iPm41z+67B
 blYv/KLho/uowZmi9vCqywZhZ7UwgemHrxMzwH9n2BYYsygssAjKoF3RR3JV9Yx1Aw
 hYsSERRZ2dSasP/JiZZGZn65Bz9+KEIjDCUNMB6c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20231205051848epcas2p3ac106fe3e23ef139cabd461efc58250e~d19FGZGun0969009690epcas2p3L;
 Tue,  5 Dec 2023 05:18:48 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SkpjM2GcKz4x9Px; Tue,  5 Dec
 2023 05:18:47 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-1c-656eb2b659a5
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 63.D0.09622.6B2BE656; Tue,  5 Dec 2023 14:18:46 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH-for-8.2?] hw/ufs: avoid generating the same ID string
 for different LU devices
From: Jeuk Kim <jeuk20.kim@samsung.com>
To: =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Akinobu Mita <akinobu.mita@gmail.com>, qemu-block <qemu-block@nongnu.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <9112b12a-0a11-43c8-aa7d-77ca5b957428@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231205051846epcms2p87a7524f04634a0738b8a6f92536058c2@epcms2p8>
Date: Tue, 05 Dec 2023 14:18:46 +0900
X-CMS-MailID: 20231205051846epcms2p87a7524f04634a0738b8a6f92536058c2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmue62TXmpBmcOmFu8OtDBaLFmhbDF
 rHftbBbHe3ewOLB47Jx1l93jzrU9bB5Prm1mCmCOyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
 NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqmpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
 Si1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjO2Dr3FXPBY8mKy7dWMjcwHpXoYuTkkBAw
 kbj99yE7iC0ksINR4ua6lC5GDg5eAUGJvzuEQUxhgRSJc5crISoUJOZs6wCrFhbQlJi+fiIT
 SAmbgLrE6YXmIGERgXKJJxfusoCEmQX8JXo7jCH28ErMaH/KAmFLS2xfvpURxOYUsJO4+fw8
 K0RcQ+LHsl5mCFtU4ubqt+ww9vtj8xkhbBGJ1ntnoWoEJR783A0Vl5Q49e0x1JzpjBIL/pt2
 MXIB2QsYJX41T4dq0Je41rER7AheAV+JGQ8+gC1gEVCV+HDwGdQgF4lXnx6AxZkFtCWWLXzN
 DPGLpsT6XfogpoSAssSRWywQFXwSHYf/ssO8uGPeEyYIW0VicfNhVohyKYkNu0Mhwh4S235/
 YJnAqDgLEcizkKyahbBqASPzKkax1ILi3PTUYqMCI3i0JufnbmIEJzkttx2MU95+0DvEyMTB
 eIhRgoNZSYR33q3sVCHelMTKqtSi/Pii0pzU4kOMpkBPTmSWEk3OB6bZvJJ4QxNLAxMzM0Nz
 I1MDcyVx3nutc1OEBNITS1KzU1MLUotg+pg4OKUamHJMNh09KtNXbbY671rWmubc4ClsrW2X
 cxrDrlTL3mfOn8TU8eRhWE3K7aL1PJ9ORu05ZeCxdPq8HKOeeOdLmsGsV1j7bj5M0lffF9Kz
 vGXiB0nf3Wo7a3c/7yqMCdk+M7uo9P9Kj8l5jGmh/2cFff+ZeWVt2Is9sw11Z6TInn3K6uU6
 5cK+UvEesZToz/EBRfaKFx7fvfMpcbXj9unvUlezCB4PKv99KMrh4JH1Z6yfh/ulee9K0dKe
 fGhW46WUXYXZjScXmibF3j+6Teat+1573ZCKuFMuM5MtNGc25Abt7mQ8WMb5uO8Y4xzF3JSP
 6+wZDyQLMOR6PPL6ZeidptcrvSPvQFDQvuNL1vW/U2Ipzkg01GIuKk4EAIc261n7AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231204192120epcas2p3e10bef4174d3ff1e7a6caaa55ed5a7ab
References: <9112b12a-0a11-43c8-aa7d-77ca5b957428@linaro.org>
 <20231204150543.48252-1-akinobu.mita@gmail.com>
 <1f537ae8-c3e6-4213-b2c7-b9398b8e1f64@linaro.org>
 <CGME20231204192120epcas2p3e10bef4174d3ff1e7a6caaa55ed5a7ab@epcms2p8>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=jeuk20.kim@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: jeuk20.kim@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Philippe,

Thank you for informing me.
I want this issue is fixed for the 8.2 release.

I created an issue like you said, but I couldn't assign the milestone (I'm =
guessing it's a permission problem).
https://gitlab.com/qemu-project/qemu/-/issues/2018
Could you help me with this?

Regardless, I'm going to submit a pull request to fix the issue right away.

Thank you.

On 4/12/23, Philippe Mathieu-Daud=C3=A9=20wrote:=0D=0A>=20Hi=20Jeuk,=0D=0A>=
=20=0D=0A>=20On=204/12/23=2017:50,=20Philippe=20Mathieu-Daud=C3=A9=20wrote:=
=0D=0A>>=20On=204/12/23=2016:05,=20Akinobu=20Mita=20wrote:=0D=0A>>>=20QEMU=
=20would=20not=20start=20when=20trying=20to=20create=20two=20UFS=20host=20c=
ontrollers=20and=0D=0A>>>=20a=20UFS=20logical=20unit=20for=20each=20with=20=
the=20following=20options:=0D=0A>>>=0D=0A>>>=20-device=20ufs,id=3Dbus0=20=
=5C=0D=0A>>>=20-device=20ufs-lu,drive=3Ddrive1,bus=3Dbus0,lun=3D0=20=5C=0D=
=0A>>>=20-device=20ufs,id=3Dbus1=20=5C=0D=0A>>>=20-device=20ufs-lu,drive=3D=
drive2,bus=3Dbus1,lun=3D0=20=5C=0D=0A>>>=0D=0A>>>=20This=20is=20because=20t=
he=20same=20ID=20string=20(=220:0:0/scsi-disk=22)=20is=20generated=0D=0A>>>=
=20for=20both=20UFS=20logical=20units.=0D=0A>>>=0D=0A>>>=20To=20fix=20this=
=20issue,=20prepend=20the=20parent=20pci=20device's=20path=20to=20make=0D=
=0A>>>=20the=20ID=20string=20unique.=0D=0A>>>=20(=220000:00:03.0/0:0:0/scsi=
-disk=22=20and=20=220000:00:04.0/0:0:0/scsi-disk=22)=0D=0A>>>=0D=0A>>>=20Fi=
xes:=20096434fea13a=20(=22hw/ufs:=20Modify=20lu.c=20to=20share=20codes=20wi=
th=20SCSI=0D=0A>>>=20subsystem=22)=0D=0A>=0D=0A>=20If=20you=20think=20this=
=20must=20be=20fixed=20for=20the=208.2=20release,=20please=20assign=0D=0A>=
=20a=20release=20blocker=20issues=20to=20the=20GitLab=208.2=20milestone=20h=
ere:=0D=0A>=20https://gitlab.com/qemu-project/qemu/-/milestones/10=0D=0A>=
=0D=0A>>>=20Signed-off-by:=20Akinobu=20Mita=20<akinobu.mita=40gmail.com>=0D=
=0A>>=0D=0A>>=20Reviewed-by:=20Philippe=20Mathieu-Daud=C3=A9=20<philmd=40li=
naro.org>=0D=0A>>=0D=0A>>>=20---=0D=0A>>>=20=C2=A0=20hw/ufs/ufs.c=208=20+++=
+++++=0D=0A>>>=20=C2=A0=201=20file=20changed,=208=20insertions(+)=0D=0A>>>=
=0D=0A>>>=20diff=20--git=20a/hw/ufs/ufs.c=20b/hw/ufs/ufs.c=0D=0A>>>=20index=
=2068c5f1f6c9..eccdb852a0=20100644=0D=0A>>>=20---=20a/hw/ufs/ufs.c=0D=0A>>>=
=20+++=20b/hw/ufs/ufs.c=0D=0A>>>=20=40=40=20-1323,9=20+1323,17=20=40=40=20s=
tatic=20bool=20ufs_bus_check_address(BusState=0D=0A>>>=20*qbus,=20DeviceSta=
te=20*qdev,=0D=0A>>>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20return=20true;=0D=
=0A>>>=20=C2=A0=20=7D=0D=0A>>>=20+static=20char=20*ufs_bus_get_dev_path(Dev=
iceState=20*dev)=0D=0A>>>=20+=7B=0D=0A>>>=20+=C2=A0=C2=A0=C2=A0=20BusState=
=20*bus=20=3D=20qdev_get_parent_bus(dev);=0D=0A>>>=20+=0D=0A>>>=20+=C2=A0=
=C2=A0=C2=A0=20return=20qdev_get_dev_path(bus->parent);=0D=0A>>>=20+=7D=0D=
=0A>>>=20+=0D=0A>>>=20=C2=A0=20static=20void=20ufs_bus_class_init(ObjectCla=
ss=20*class,=20void=20*data)=0D=0A>>>=20=C2=A0=20=7B=0D=0A>>>=20=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=20BusClass=20*bc=20=3D=20BUS_CLASS(class);=0D=0A>>>=
=20+=C2=A0=C2=A0=C2=A0=20bc->get_dev_path=20=3D=20ufs_bus_get_dev_path;=0D=
=0A>>>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20bc->check_address=20=3D=20ufs_bus=
_check_address;=0D=0A>>>=20=C2=A0=20=7D=0D=0A

