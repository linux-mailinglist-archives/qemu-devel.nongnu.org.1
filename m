Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D537800843
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:34:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r90qB-0002Rr-5o; Fri, 01 Dec 2023 05:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1r90q9-0002RO-5I; Fri, 01 Dec 2023 05:33:45 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1r90q7-000280-9h; Fri, 01 Dec 2023 05:33:44 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B18tGXE028222; Fri, 1 Dec 2023 10:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=UsPMtwDMpayYl8/dOMFeRUz7N00zDhDCQqHAxG3FEPg=;
 b=k3J3MxgJajmDEewCy6PiF+H9knjqyzhEhEsuwBvL4rzbhDf9I2r8KGCoO/gr9gvauwwf
 QFFaMgZvPz9NIoGB9oGH7lGvea/1oDSMVAVCnULK0qpJ18GuoeelJNiJDevV4ez+FELG
 u8k4ccPe/W/AAhppe2lPDgzAz9swI75/0gea6Mwxsfbs0el6FlU1xqlbbT6JG2WzDKuX
 hTPBpxkvuyXNtxJFa0JZiTzDyPOEeBZ4NZ1Vo+Mpqn/BrS7ETXf9k588nxY/mhnj4FIa
 gvJ5YjybTGRfi9ylmmsK/clXspwDXMa0zgitB9toXrvEdtgKIc2lsgDWDOMA1nSwoJY0 aw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uq9hygp5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Dec 2023 10:33:38 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B1AXbxR008636
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 1 Dec 2023 10:33:37 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Dec
 2023 02:33:33 -0800
Date: Fri, 1 Dec 2023 16:03:29 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Alex Benn?e <alex.bennee@linaro.org>
CC: <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <quic_tsoni@quicinc.com>, <quic_pheragu@quicinc.com>,
 <quic_eberman@quicinc.com>, <quic_yvasi@quicinc.com>,
 <quic_cvanscha@quicinc.com>, <quic_mnalajal@quicinc.com>
Subject: Re: [RFC/PATCH v0 03/12] gunyah: Basic support
Message-ID: <20231201103329.GA3618015@quicinc.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-4-quic_svaddagi@quicinc.com>
 <87cyvs8pmh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87cyvs8pmh.fsf@draig.linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: OwWqypnBFXG9j72tMbU5CVOLJKnEe6fZ
X-Proofpoint-ORIG-GUID: OwWqypnBFXG9j72tMbU5CVOLJKnEe6fZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=851 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

* Alex Benn?e <alex.bennee@linaro.org> [2023-11-29 16:56:38]:

> Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> writes:
>=20
> > Add a new accelerator, gunyah, with basic functionality of creating a
> > VM. Subsequent patches will add support for other functions required to
> > run a VM.
> >
> > Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
>=20
> Hmm this failed to build:
>=20
>   FAILED: libqemu-aarch64-softmmu.fa.p/accel_gunyah_gunyah-all.c.o=20
>   cc -m64 -mcx16 -Ilibqemu-aarch64-softmmu.fa.p -I. -I../.. -Itarget/arm =
-I../../target/arm -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 =
-I/usr/include/capstone -I/usr/include/spice-server -I/usr/include/spice-1 =
-I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiag=
nostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstac=
k-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes -Wstrict-pr=
ototypes -Wredundant-decls -Wold-style-declaration -Wold-style-definition -=
Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifier=
s -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wimp=
licit-fallthrough=3D2 -Wmissing-format-attribute -Wno-missing-include-dirs =
-Wno-shift-negative-value -Wno-psabi -Wshadow=3Dlocal -isystem /home/alex/l=
src/qemu.git/linux-headers -isystem linux-headers -iquote . -iquote /home/a=
lex/lsrc/qemu.git -iquote /home/alex/lsrc/qemu.git/include -iquote /home/al=
ex/lsrc/qemu.git/host/include/x86_64 -iquote /home/alex/lsrc/qemu.git/host/=
include/generic -iquote /home/alex/lsrc/qemu.git/tcg/i386 -pthread -D_GNU_S=
OURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fn=
o-common -fwrapv -fPIE -isystem../../linux-headers -isystemlinux-headers -D=
NEED_CPU_H '-DCONFIG_TARGET=3D"aarch64-softmmu-config-target.h"' '-DCONFIG_=
DEVICES=3D"aarch64-softmmu-config-devices.h"' -MD -MQ libqemu-aarch64-softm=
mu.fa.p/accel_gunyah_gunyah-all.c.o -MF libqemu-aarch64-softmmu.fa.p/accel_=
gunyah_gunyah-all.c.o.d -o libqemu-aarch64-softmmu.fa.p/accel_gunyah_gunyah=
-all.c.o -c ../../accel/gunyah/gunyah-all.c
>   ../../accel/gunyah/gunyah-all.c:21:10: fatal error: linux-headers/linux=
/gunyah.h: No such file or directory
>      21 | #include "linux-headers/linux/gunyah.h"
>         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   compilation terminated.
>=20
> Easiest solution:
>=20
>   add PATCH after 02 importing headers
>=20
> I usually add a !MERGE to the summary just to remind myself that we'll
> need to properly update the headers before we merge. e.g: linux-headers: =
update to v6.6-with-gunyah (!MERGE)

I had run update-linux-headers.sh after Patch 02 before trying to compile r=
est of
the patch series. It was run against a Linux kernel tree having the Gunyah
patches. If it helps, I can include the actual header itself as a Patch (wi=
th
!MERGE noted), so that it saves some trouble.

> There are some other merge failures bellow so perhaps its time to do a
> re-base and send v1?

Yes working on v1. I have tested virtio-pci working I think, testing SMP no=
w after
which will send out v1 (hopefully early next week).

> Whats the current state of the kernel merge?

The kernel patches are being reworked to avoid pinning of memory and to all=
ow
on-demand allocation of VM memory. That should address the major feedback
received. We expect the next version of kernel patches to be published later
this month, and a potential merge in kernel.org hopefully before April (6.9=
)?!

It will also require some rework in Qemu support to use the new guest
memfd APIs for allocating VM memory (for confidential VMs). I will publish
support for it in v2 (could be a month away I think).

> <snip>
> > diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions=
=2Esh
> > index 9da3fe299b..0c95f79645 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -112,6 +112,7 @@ meson_options_help() {
> >    printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Gues=
t Agent'
> >    printf "%s\n" '  hax             HAX acceleration support'
> >    printf "%s\n" '  hvf             HVF acceleration support'
> > +  printf "%s\n" '  gunyah          Gunyah acceleration support'
>=20
> need rebasing due to hax drop
>=20
> >    printf "%s\n" '  iconv           Font glyph conversion support'
> >    printf "%s\n" '  jack            JACK sound support'
> >    printf "%s\n" '  keyring         Linux keyring support'
> > @@ -312,6 +313,8 @@ _meson_option_parse() {
> >      --disable-guest-agent) printf "%s" -Dguest_agent=3Ddisabled ;;
> >      --enable-guest-agent-msi) printf "%s" -Dguest_agent_msi=3Denabled =
;;
> >      --disable-guest-agent-msi) printf "%s" -Dguest_agent_msi=3Ddisable=
d ;;
> > +    --enable-gunyah) printf "%s" -Dgunyah=3Denabled ;;
> > +    --disable-gunyah) printf "%s" -Dgunyah=3Ddisabled ;;
>=20
> ditto.
>=20
> >      --enable-hax) printf "%s" -Dhax=3Denabled ;;
> >      --disable-hax) printf "%s" -Dhax=3Ddisabled ;;
> >      --enable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=3D=
true ;;
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 96158093cc..a712f1a3b3 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -33,6 +33,7 @@
> >  #include "hw/qdev-properties.h"
> >  #include "internals.h"
> >  #include "cpregs.h"
> > +#include "sysemu/gunyah.h"
>=20
> This should be moved up next to the other accelerator includes.

Sure thanks for this feedback. Will incorporate them in v1.

- vatsa

