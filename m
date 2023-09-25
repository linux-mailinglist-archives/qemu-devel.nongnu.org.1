Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 770A87ADCB4
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qko6i-0006z1-CR; Mon, 25 Sep 2023 12:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qko6g-0006yP-2w; Mon, 25 Sep 2023 12:06:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qko6d-0007Tp-Us; Mon, 25 Sep 2023 12:06:45 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PFaH9c028111; Mon, 25 Sep 2023 16:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ILDFhSyBR1K5cu04UipssV2ewO+7jrcWS2P3hp9SRaQ=;
 b=D5Is3SFQO3XYA59bE4f3TngZ7DutRVvjZWlbas6APbxkukp38BHS8AxydNfcLXHoInz6
 AA/919yC8SQnu/sUthdXUNoVNh374ShcuVAWo+M0zMljvoLu6SO+WRn8dupkyIZHGOMb
 gnVYGbc2IxzRqS9Rs6JXwtdI1G0+Wj0tVAI/kpCD4zV1pV4USCcwB36mWH66EOIo9X3j
 7Vobn+ILGCFgRcxenMeQ9iQEpk1cTAU2UrQlYnnzfSLIwHpcEqBTAmK8l+fcKO13BUmY
 fndOASfR65sm8Rd7fB2fEF19szCPcEYaox+OV+35kD1FMCrSq18rE/NdiyVBLm88BlUL Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tb9a8yewh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 16:06:23 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PG65DE018772;
 Mon, 25 Sep 2023 16:06:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tb9a8ye9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 16:06:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PFcSfd008244; Mon, 25 Sep 2023 16:06:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbmuh7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 16:06:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38PG62GG19071590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Sep 2023 16:06:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 485B92004F;
 Mon, 25 Sep 2023 16:06:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05A9920043;
 Mon, 25 Sep 2023 16:06:01 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.62.152]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Sep 2023 16:06:00 +0000 (GMT)
Message-ID: <5f569e3a8b54e84b7302a565454a511bf79f76ba.camel@linux.ibm.com>
Subject: Re: [PATCH v23 01/20] CPU topology: extend with s390 specifics
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Halil
 Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Thomas
 Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, Pierre
 Morel <pmorel@linux.ibm.com>
Date: Mon, 25 Sep 2023 18:06:00 +0200
In-Reply-To: <87ediuwcrt.fsf@pond.sub.org>
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-2-nsg@linux.ibm.com> <87ediuwcrt.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z9G21ysGT02qFUxnMk7gpP4fTDQZg4Cg
X-Proofpoint-GUID: HoN_tPaiqo7gzpPeYV4btFHAeWpj27TY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_13,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 mlxlogscore=861 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250124
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2023-09-19 at 14:47 +0200, Markus Armbruster wrote:
> Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:
>=20
> > From: Pierre Morel <pmorel@linux.ibm.com>
> >=20
> > S390 adds two new SMP levels, drawers and books to the CPU
> > topology.
> > S390 CPUs have specific topology features like dedication and
> > entitlement. These indicate to the guest information on host
> > vCPU scheduling and help the guest make better scheduling decisions.
> >=20
> > Let us provide the SMP properties with books and drawers levels
> > and S390 CPU with dedication and entitlement,
> >=20
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > ---
> >  qapi/machine-common.json            | 21 +++++++++++++
> >  qapi/machine.json                   | 19 ++++++++++--
> >  include/hw/boards.h                 | 10 +++++-
> >  include/hw/qdev-properties-system.h |  4 +++
> >  target/s390x/cpu.h                  |  6 ++++
> >  hw/core/machine-smp.c               | 48 ++++++++++++++++++++++++-----
> >  hw/core/machine.c                   |  4 +++
> >  hw/core/qdev-properties-system.c    | 13 ++++++++
> >  hw/s390x/s390-virtio-ccw.c          |  4 +++
> >  softmmu/vl.c                        |  6 ++++
> >  target/s390x/cpu.c                  |  7 +++++
> >  qapi/meson.build                    |  1 +
> >  qemu-options.hx                     |  7 +++--
> >  13 files changed, 137 insertions(+), 13 deletions(-)
> >  create mode 100644 qapi/machine-common.json
> >=20
> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > new file mode 100644
> > index 0000000000..e40421bb37
> > --- /dev/null
> > +++ b/qapi/machine-common.json
>=20
> Why do you need a separate QAPI sub-module?
>=20
> > @@ -0,0 +1,21 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=3Dpython
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
> > +# See the COPYING file in the top-level directory.
> > +
> > +##
> > +# =3D Machines S390 data types
> > +##
> > +
> > +##
> > +# @CpuS390Entitlement:
> > +#
> > +# An enumeration of cpu entitlements that can be assumed by a virtual
> > +# S390 CPU
> > +#
> > +# Since: 8.2
> > +##
> > +{ 'enum': 'CpuS390Entitlement',
> > +  'prefix': 'S390_CPU_ENTITLEMENT',
> > +  'data': [ 'auto', 'low', 'medium', 'high' ] }
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index a08b6576ca..a63cb951d2 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -9,6 +9,7 @@
>    ##
>    # =3D Machines
> >  ##
> > =20
> >  { 'include': 'common.json' }
> > +{ 'include': 'machine-common.json' }
>=20
> Section structure is borked :)
>=20
> Existing section "Machine" now ends at the new "Machines S390 data
> types" you pull in here.  The contents of below moves from "Machines" to
> "Machines S390 data types".
>=20
> Before I explain how to avoid this, I'd like to understand why we need a
> new sub-module.

Should I just move the include statements above the section header?
I assume I could also include it in qapi-schema.json before the machine.jso=
n
include and that that is the reason we don't have
the same problem with e.g. migration.json.
But just moving the includes seems cleaner.


[...]

