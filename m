Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8214682AA73
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:05:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqzl-0002Fu-Ra; Thu, 11 Jan 2024 04:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rNqzj-00029k-AH; Thu, 11 Jan 2024 04:04:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rNqzg-00031J-Ny; Thu, 11 Jan 2024 04:04:59 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40B8vET0009351; Thu, 11 Jan 2024 09:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kLSk0/iPF7vI+cVkjkisxcQmm3lww7o0m/qWrlSJ/DY=;
 b=gEmFWOUCw24orCUSWLETGJrdwf2od0NHWpP6LicND318D2XkU52IdGTtcRbdA49JMS80
 xaoXD0cYHR+dBflGYvRABAZk7CzJfFKMuCV8qQVP1sKpbY4YNpuYkM9N69I4Ef6DQSuP
 A3g+g9z+qYGVwMBS10jHg3Mhg2ZQADuh+xEV5eAU0+hwcKcif2YiH42pGRZwxxlKb+hT
 bjI36qYpbzmk/LjpQ2oIPOzUR5r4jTJqqMrHkLqziFXN2Se+xAcvm9cnU2Rc2hWJ0BR/
 GKRqVqfPzxPhLQWQFoCJ7Df7ASAYKgPBMf7hX8awmQ+IyBCSJvQeqJPdPinD/ZzHonkn BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjd96r7ne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 09:04:52 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40B8wMJC017184;
 Thu, 11 Jan 2024 09:04:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjd96r7mu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 09:04:52 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40B8c9oS022960; Thu, 11 Jan 2024 09:04:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfj6ntg2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 09:04:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40B94m5n59638038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jan 2024 09:04:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAC342004F;
 Thu, 11 Jan 2024 09:04:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6319B2004E;
 Thu, 11 Jan 2024 09:04:48 +0000 (GMT)
Received: from [9.171.79.56] (unknown [9.171.79.56])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jan 2024 09:04:48 +0000 (GMT)
Message-ID: <38c85f036543ede783bf21de63c90c62101a7fb0.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] tests/tcg/s390x: Test LOAD ADDRESS EXTENDED
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Date: Thu, 11 Jan 2024 10:04:48 +0100
In-Reply-To: <22d8218a-70ee-4ab6-a284-2fbaeceb7052@redhat.com>
References: <20240109232319.600102-1-iii@linux.ibm.com>
 <20240109232319.600102-3-iii@linux.ibm.com>
 <22d8218a-70ee-4ab6-a284-2fbaeceb7052@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nXZ4m8do-8s_9lI48WrZkI63y0sAQ7Mi
X-Proofpoint-ORIG-GUID: Ym4xc3WkmNV3eft3V5uAVEM54HzJz5im
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_04,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=792
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401110072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On Thu, 2024-01-11 at 09:37 +0100, Thomas Huth wrote:
> On 10/01/2024 00.22, Ilya Leoshkevich wrote:
> > Add a small test to prevent regressions. Userspace runs in primary
> > mode, so LAE should always set the access register to 0.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 tests/tcg/s390x/Makefile.target |=C2=A0 1 +
> > =C2=A0 tests/tcg/s390x/lae.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 25 +++++++++++++++++++++++++
> > =C2=A0 2 files changed, 26 insertions(+)
> > =C2=A0 create mode 100644 tests/tcg/s390x/lae.c
> >=20
> > diff --git a/tests/tcg/s390x/Makefile.target
> > b/tests/tcg/s390x/Makefile.target
> > index 0e670f3f8b9..30994dcf9c2 100644
> > --- a/tests/tcg/s390x/Makefile.target
> > +++ b/tests/tcg/s390x/Makefile.target
> > @@ -44,6 +44,7 @@ TESTS+=3Dclgebr
> > =C2=A0 TESTS+=3Dclc
> > =C2=A0 TESTS+=3Dlaalg
> > =C2=A0 TESTS+=3Dadd-logical-with-carry
> > +TESTS+=3Dlae
> > =C2=A0=20
> > =C2=A0 cdsg: CFLAGS+=3D-pthread
> > =C2=A0 cdsg: LDFLAGS+=3D-pthread
> > diff --git a/tests/tcg/s390x/lae.c b/tests/tcg/s390x/lae.c
> > new file mode 100644
> > index 00000000000..661e95f9978
> > --- /dev/null
> > +++ b/tests/tcg/s390x/lae.c
> > @@ -0,0 +1,25 @@
> > +/*
> > + * Test the LOAD ADDRESS EXTENDED instruction.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#include <assert.h>
> > +#include <stdlib.h>
> > +
> > +int main(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0 unsigned long long ar =3D -1, b2 =3D 100000, r, x2 =
=3D 500;
> > +=C2=A0=C2=A0=C2=A0 int tmp;
> > +
> > +=C2=A0=C2=A0=C2=A0 asm("ear %[tmp],%[r]\n"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "lae %[r],42(%[x2],%[b2])\n=
"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ear %[ar],%[r]\n"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sar %[r],%[tmp]"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : [tmp] "=3D&r" (tmp), [r] =
"=3D&r" (r), [ar] "+r" (ar)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : [b2] "r" (b2), [x2] "r" (=
x2)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "memory");
> > +=C2=A0=C2=A0=C2=A0 assert(ar =3D=3D 0xffffffff00000000ULL);
> > +=C2=A0=C2=A0=C2=A0 assert(r =3D=3D 100542);
> > +
> > +=C2=A0=C2=A0=C2=A0 return EXIT_SUCCESS;
> > +}
>=20
> I'm sorry, but it fails when building with Clang (version 17):
>=20
> .../qemu/tests/tcg/s390x/lae.c:14:9: error: invalid operand for
> instruction
> =C2=A0=C2=A0=C2=A0 14 |=C2=A0=C2=A0=C2=A0=C2=A0 asm("ear %[tmp],%[r]\n"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^
> <inline asm>:1:10: note: instantiated into assembly here
> =C2=A0=C2=A0=C2=A0=C2=A0 1 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ear %r2,%r1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> .../qemu/tests/tcg/s390x/lae.c:16:10: error: invalid operand for
> instruction
> =C2=A0=C2=A0=C2=A0 16 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=
ear %[ar],%[r]\n"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^
> <inline asm>:3:9: note: instantiated into assembly here
> =C2=A0=C2=A0=C2=A0=C2=A0 3 | ear %r0,%r1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^
> .../qemu/tests/tcg/s390x/lae.c:17:10: error: invalid operand for
> instruction
> =C2=A0=C2=A0=C2=A0 17 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=
sar %[r],%[tmp]"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^
> <inline asm>:4:5: note: instantiated into assembly here
> =C2=A0=C2=A0=C2=A0=C2=A0 4 | sar %r1,%r2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^
> 3 errors generated.
>=20
> Any suggestions how to fix it best?
>=20
> =C2=A0 Thomas
>=20

clang wants %aN there, and I don't see a way to convert %rN to %aN.
Seems like I'll have to hardcode the register number. I'll send a v2.

