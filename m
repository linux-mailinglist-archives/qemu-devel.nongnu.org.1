Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E4C771C0A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 10:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSvIW-00067R-2R; Mon, 07 Aug 2023 04:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qSvIG-00065L-Mt; Mon, 07 Aug 2023 04:08:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qSvIE-0000Oh-Aw; Mon, 07 Aug 2023 04:08:48 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37781kPK022111; Mon, 7 Aug 2023 08:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6d+v3Akrvh6E8f7XahNXEBjGLlLhCWAr5LAKU0vzmgk=;
 b=e9m5IsRfN9+p0JYdDua9IWy6AW6Jw1aWpKIez39pP98ITx69786NBoqNLyMwoug8WmOM
 t/ZOu5fZDf5Xg9zyhXROiSawTlcp6VB1nmDyEiw4rv2fVUVUuNp7TFvZab53hoW5sszR
 i+Ma41TSNEAW1HYwlMfTzuZnDQEVkY6JFSN8erCblLQHb5IExXy2no3JKT1m/dnFhoxj
 epKwhhgPM8YCgnIAKQdQSJ8jfvxOJ6aLm59uQVeycxA2TID5u8StrXcjXWl46REMKG+4
 EC5kEKIAbScVvBVRDGU9Lllvgcsli1UyNooh7Ze9W2xqAEzytevvXEF6adxhf+HBe0ku Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3savqw0d8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 08:08:38 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37781oWN022677;
 Mon, 7 Aug 2023 08:08:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3savqw0d7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 08:08:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3776X5mZ000382; Mon, 7 Aug 2023 08:08:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28k35a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 08:08:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37788Ynd54591778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 08:08:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81D0C20040;
 Mon,  7 Aug 2023 08:08:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 217722004D;
 Mon,  7 Aug 2023 08:08:34 +0000 (GMT)
Received: from [9.171.18.187] (unknown [9.171.18.187])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 08:08:34 +0000 (GMT)
Message-ID: <9ef4a41fddc9c27bef7dab401c85eb79c42b7fe5.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] tests/tcg/s390x: Test VSTRS
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Claudio Fontana <cfontana@suse.de>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Date: Mon, 07 Aug 2023 10:08:33 +0200
In-Reply-To: <85745fff-825c-0084-00ff-9875fe1a6f5a@suse.de>
References: <20230804233748.218935-1-iii@linux.ibm.com>
 <20230804233748.218935-4-iii@linux.ibm.com>
 <85745fff-825c-0084-00ff-9875fe1a6f5a@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 29Z4AUOsqQqVg3GqZYok2MOC_Yxtza2l
X-Proofpoint-GUID: HIPKJ706__ATT1OwbaC6mxwOddr2uYit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_06,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Sun, 2023-08-06 at 13:05 +0200, Claudio Fontana wrote:
> On 8/5/23 01:03, Ilya Leoshkevich wrote:
> > Add a small test to prevent regressions.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0tests/tcg/s390x/Makefile.target |=C2=A0 1 +
> > =C2=A0tests/tcg/s390x/vxeh2_vstrs.c=C2=A0=C2=A0 | 88
> > +++++++++++++++++++++++++++++++++
> > =C2=A02 files changed, 89 insertions(+)
> > =C2=A0create mode 100644 tests/tcg/s390x/vxeh2_vstrs.c
> >=20
> > diff --git a/tests/tcg/s390x/Makefile.target
> > b/tests/tcg/s390x/Makefile.target
> > index 1fc98099070..8ba36e5985b 100644
> > --- a/tests/tcg/s390x/Makefile.target
> > +++ b/tests/tcg/s390x/Makefile.target
> > @@ -73,6 +73,7 @@ ifneq ($(CROSS_CC_HAS_Z15),)
> > =C2=A0Z15_TESTS=3Dvxeh2_vs
> > =C2=A0Z15_TESTS+=3Dvxeh2_vcvt
> > =C2=A0Z15_TESTS+=3Dvxeh2_vlstr
> > +Z15_TESTS+=3Dvxeh2_vstrs
> > =C2=A0$(Z15_TESTS): CFLAGS+=3D-march=3Dz15 -O2
> > =C2=A0TESTS+=3D$(Z15_TESTS)
> > =C2=A0endif
> > diff --git a/tests/tcg/s390x/vxeh2_vstrs.c
> > b/tests/tcg/s390x/vxeh2_vstrs.c
> > new file mode 100644
> > index 00000000000..313ec1d728f
> > --- /dev/null
> > +++ b/tests/tcg/s390x/vxeh2_vstrs.c
> > @@ -0,0 +1,88 @@
> > +/*
> > + * Test the VSTRS instruction.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#include <assert.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include "vx.h"
> > +
> > +static inline __attribute__((__always_inline__)) int
> > +vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const S390Vector *v4, const uint8_t m5,=
 const uint8_t m6)
> > +{
> > +=C2=A0=C2=A0=C2=A0 int cc;
> > +
> > +=C2=A0=C2=A0=C2=A0 asm("vstrs %[v1],%[v2],%[v3],%[v4],%[m5],%[m6]\n"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ipm %[cc]"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : [v1] "=3Dv" (v1->v)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , [cc] "=3Dr" (cc)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : [v2] "v" (v2->v)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , [v3] "v" (v3->v)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , [v4] "v" (v4->v)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , [m5] "i" (m5)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , [m6]=C2=A0 "i" (m6)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "cc");
> > +
> > +=C2=A0=C2=A0=C2=A0 return (cc >> 28) & 3;
> Following the POp, I am puzzled by the use of an "int" to contain the
> register result of the IPM instruction, should it not be a 64bit
> variable?
> bits 0-31 are left unchanged / are uninteresting, is that enough to
> avoid having to use a properly sized variable?

The compiler understands that if the type is int, then the asm block
will not touch the upper 32 bits of the register that's assigned to it.
This observation is used not only in the QEMU tests, but also all over
arch/s390 in the Linux kernel.

>=20
> I see that this is done elsewhere in the tests (sometimes a 64bit
> variable is used, sometimes just 'int'), so I assume it's probably
> fine.
>=20
> Otherwise lgtm,
>=20
> Claudio

[...]
>=20

