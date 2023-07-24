Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E197D75F2A1
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:17:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsbx-0007Bf-9A; Mon, 24 Jul 2023 06:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qNsbs-0007BB-6M; Mon, 24 Jul 2023 06:16:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qNsbp-0001v6-0W; Mon, 24 Jul 2023 06:16:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36OAEa7G021628; Mon, 24 Jul 2023 10:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WRtGFJkD+m4CDL0iNdVQRZdqVJEm44c78r1VGHuqMEA=;
 b=VuKBpzMP5v6fgfBjlsCFWSbyqDTlLVmKmngHGoOTo4quuLkKH7bjdovbybBB837lmTrs
 pnYXZrLu1uuaQX89wNle5iwxDtFO3hCbKgAlII0dAcJ0aodHVY2CR8Pna+8gJkmqgGUS
 DwgqjXDkfdwf/qodbi52GD2iYyKlOs7mjEboQMVKjvXA7jXx2YNFS9ZqTdu3aUVvi5RE
 znTXNviwjSo9yxDacTLO+Fe6r9vWUOzJ9h/fAUzCaM1c9D4fAvc6c2ngQW81ToQVjMMD
 SQkbnFrpgv1e9avvaFl52Ski4v74O28i7/tTbf7eohwJCSZl1c2n87X2bcEwhnXbSarX Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1me6546t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 10:16:01 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36O9hYcZ015015;
 Mon, 24 Jul 2023 10:16:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1me65466-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 10:16:00 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36O82F2n014387; Mon, 24 Jul 2023 10:15:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0stxjgbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 10:15:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36OAFtGQ20513388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jul 2023 10:15:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A9C120067;
 Mon, 24 Jul 2023 10:15:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1092520043;
 Mon, 24 Jul 2023 10:15:54 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.9.136]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Jul 2023 10:15:53 +0000 (GMT)
Message-ID: <29c6965c8f2c9ec03074656c60966387d213234f.camel@linux.ibm.com>
Subject: Re: [PATCH v21 01/20] s390x/cpu topology: add s390 specifics to CPU
 topology
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
Date: Mon, 24 Jul 2023 12:15:53 +0200
In-Reply-To: <29268e39-49ba-588a-022d-30b0882fea37@linux.ibm.com>
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-2-pmorel@linux.ibm.com>
 <9c8847ad9d8e07c2e41f9c20716ba3ed6dd6b3dc.camel@linux.ibm.com>
 <29268e39-49ba-588a-022d-30b0882fea37@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OWObDLs29L-vdcmLCLFonv9Bsahw4Crm
X-Proofpoint-ORIG-GUID: cDhDB3ucMEkDcXJ0Iy1oI9R1YwaYWw5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240089
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 2023-07-21 at 13:24 +0200, Pierre Morel wrote:
>=20
> On 7/18/23 18:31, Nina Schoetterl-Glausch wrote:
> > Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> >=20
> > Some notes below.
> >=20
> > The s390x/ prefix in the title might suggest that this patch
> > is s390 specific, but it touches common files.
>=20
>=20
> Right.
>=20
> What do you suggest?
>=20
> I can cut it in two or squash it with patch number 2.
>=20
> The first idea was to separate the patch to ease the review but the
> functionality introduced in patch 1 do only make sense with patch 2.
>=20
> So I would be for squashing the first two patches.
>=20
> ?

Oh, I'd just change the title.

CPU topology: extend with s390 specifics

or similar, it was just a nit not to create the impression that the
patch only touches s390 stuff.
>=20
>=20
> >=20
> > On Fri, 2023-06-30 at 11:17 +0200, Pierre Morel wrote:
> > > S390 adds two new SMP levels, drawers and books to the CPU
> > > topology.
> > > The S390 CPU have specific topology features like dedication
> > S390 CPUs have specific topology features like dedication and
> > entitlement. These indicate to the guest information on host
> > vCPU scheduling and help the guest make better scheduling
> > decisions.
> >=20
> > > and entitlement to give to the guest indications on the host
> > > vCPUs scheduling and help the guest take the best decisions
> > > on the scheduling of threads on the vCPUs.
> > >=20
> > > Let us provide the SMP properties with books and drawers levels
> > > and S390 CPU with dedication and entitlement,
> > >=20
> > > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > > ---
> > > =C2=A0=C2=A0qapi/machine-common.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 +++++++++++++
> > > =C2=A0=C2=A0qapi/machine.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 =
++++++++++---
> > > =C2=A0=C2=A0include/hw/boards.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++-
> > > =C2=A0=C2=A0include/hw/qdev-properties-system.h |=C2=A0 4 +++
> > > =C2=A0=C2=A0target/s390x/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +=
+++
> > > =C2=A0=C2=A0hw/core/machine-smp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 48
> > > ++++++++++++++++++++++++---
> > > --
> > > =C2=A0=C2=A0hw/core/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 +++
> > > =C2=A0=C2=A0hw/core/qdev-properties-system.c=C2=A0=C2=A0=C2=A0 | 13 +=
+++++++
> > > =C2=A0=C2=A0hw/s390x/s390-virtio-ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > > =C2=A0=C2=A0softmmu/vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++
> > > =C2=A0=C2=A0target/s390x/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +=
++++
> > > =C2=A0=C2=A0qapi/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
> > > =C2=A0=C2=A0qemu-options.hx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 7 +++--
> > > =C2=A0=C2=A013 files changed, 137 insertions(+), 14 deletions(-)
> > > =C2=A0=C2=A0create mode 100644 qapi/machine-common.json
> > >=20
> > > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > > new file mode 100644
> > > index 0000000000..bc0d76829c
> > > --- /dev/null
> > > +++ b/qapi/machine-common.json
> > > @@ -0,0 +1,22 @@
> > > +# -*- Mode: Python -*-
> > > +# vim: filetype=3Dpython
> > > +#
> > > +# This work is licensed under the terms of the GNU GPL, version
> > > 2 or
> > > later.
> > > +# See the COPYING file in the top-level directory.
> > > +
> > > +##
> > > +# =3D Machines S390 data types
> > Common definitions for machine.json and machine-target.json
> >=20
> >=20
> > [...]


