Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EAC746B59
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGawf-0003yA-P7; Tue, 04 Jul 2023 03:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGawd-0003w4-2D; Tue, 04 Jul 2023 03:59:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGawa-0007Sk-SS; Tue, 04 Jul 2023 03:59:30 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3647pfAB017047; Tue, 4 Jul 2023 07:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3AU3VjmQG1CvSDOqUfxLAKzzrYL/jf3p9kDOLYvsz+c=;
 b=Etz7+lUsZ27bf/0FxuxHj+GQCDkN5frEaxiWywtwqDhff6uuwW5T5jRDWAzy4xRA80pv
 ZlvFHEqDzWXhyc5d53pIeEpejDpO2hU283YQNT8eU6fEyWk1Ufp31H0Xv1pNV0n2xaKW
 wp+Qh7Ez6YlpWtFkHapOlP7Hp5Q2tVm/426NGLbWonCM7nwbJtu6X5GOMCD6Dlk/k3x/
 7pqio6I0vIvB7dXvo7rLDEmkRUnaywkKy7RoPq95dpUPhoferdqP+mB3iuGzo+eQmagN
 Ahi6LSYh69ibcy4DypTCV/JDQMa+wHv7UtlTLM/KxQXQUSyU6rOdG+No14l6O3Idm9KX pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfdh052v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 07:59:26 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3647s1u2024681;
 Tue, 4 Jul 2023 07:59:25 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfdh052a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 07:59:25 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36440KDf012565;
 Tue, 4 Jul 2023 07:59:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4scg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 07:59:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3647xLom1966608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 07:59:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70A472004E;
 Tue,  4 Jul 2023 07:59:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12A4A20043;
 Tue,  4 Jul 2023 07:59:21 +0000 (GMT)
Received: from [9.179.30.217] (unknown [9.179.30.217])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 07:59:20 +0000 (GMT)
Message-ID: <ad53af9b371bd3906eb67dd618ebe7bef58d40d7.camel@linux.ibm.com>
Subject: Re: [PATCH 09/12] tests/tcg/s390x: Test LARL with a large offset
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Date: Tue, 04 Jul 2023 09:59:20 +0200
In-Reply-To: <9b6a6d07-cba5-fb74-9ac2-97d0457a334c@redhat.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-10-iii@linux.ibm.com>
 <9b6a6d07-cba5-fb74-9ac2-97d0457a334c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BVNfn5Nk2eNyb4SSDUZYOepfDGe0Fbz6
X-Proofpoint-GUID: qLTYANTZwv1XAXI2n-gShDVv2d4lEUTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=849 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 2023-07-04 at 09:56 +0200, David Hildenbrand wrote:
> On 03.07.23 17:50, Ilya Leoshkevich wrote:
> > Add a small test to prevent regressions.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 tests/tcg/s390x/Makefile.target |=C2=A0 1 +
> > =C2=A0 tests/tcg/s390x/larl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 17 +++++++++++++++++
> > =C2=A0 2 files changed, 18 insertions(+)
> > =C2=A0 create mode 100644 tests/tcg/s390x/larl.c
> >=20
> > diff --git a/tests/tcg/s390x/Makefile.target
> > b/tests/tcg/s390x/Makefile.target
> > index 2ef22c88d95..dbf64c991e9 100644
> > --- a/tests/tcg/s390x/Makefile.target
> > +++ b/tests/tcg/s390x/Makefile.target
> > @@ -37,6 +37,7 @@ TESTS+=3Dex-relative-long
> > =C2=A0 TESTS+=3Dex-branch
> > =C2=A0 TESTS+=3Dmxdb
> > =C2=A0 TESTS+=3Depsw
> > +TESTS+=3Dlarl
> > =C2=A0=20
> > =C2=A0 cdsg: CFLAGS+=3D-pthread
> > =C2=A0 cdsg: LDFLAGS+=3D-pthread
> > diff --git a/tests/tcg/s390x/larl.c b/tests/tcg/s390x/larl.c
> > new file mode 100644
> > index 00000000000..b9ced99a023
> > --- /dev/null
> > +++ b/tests/tcg/s390x/larl.c
> > @@ -0,0 +1,17 @@
> > +/*
> > + * Test the LARL instruction.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#include <stdlib.h>
> > +
> > +int main(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0 long algfi =3D (long)main;
> > +=C2=A0=C2=A0=C2=A0 long larl;
> > +
> > +=C2=A0=C2=A0=C2=A0 asm("algfi %[r],0xd0000000" : [r] "+r" (algfi) : : =
"cc");
> > +=C2=A0=C2=A0=C2=A0 asm("larl %[r],main+0xd0000000" : [r] "=3Dr" (larl)=
);
>=20
> Not sure if worth combining both statements.

I thought it would be easier on the eyes; this way one immediately sees
that they are independent.

And maybe I should've added a comment about this, but the reason I used
algfi instead of C addition was that I feared that the compiler might
generate larl, making the test useless.

>=20
> > +
> > +=C2=A0=C2=A0=C2=A0 return algfi =3D=3D larl ? EXIT_SUCCESS : EXIT_FAIL=
URE;
> > +}
>=20
> Acked-by: David Hildenbrand <david@redhat.com>
>=20


