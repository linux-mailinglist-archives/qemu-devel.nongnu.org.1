Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D957574D72C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:15:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqiM-0006Uh-DS; Mon, 10 Jul 2023 09:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qIqiK-0006UU-4t
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:14:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qIqiH-0006ZM-EF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:14:03 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ADBI87030234; Mon, 10 Jul 2023 13:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=O7sKaeoZs9vpZxCAS4Q9o5tb85tbdh6vXUytL0tafds=;
 b=eyy1q+gVQUWuezavsLmFo4VwtIX7E3/iW3Ed/4pBJY0VHQFmEDPc1tOKsHfXt18NE082
 qML3zhUhuhL7Ur97qDXfFFYJs0sDgLnIW/F6jgeYuYVeh6z4tFkR0w5pyeVBzcmVeiVe
 6bn30WzQgvVZP8nabAqm4TsjPljIuK1lZ+swqB4fh1PGWGJBK7VD5wAoaYcgaMHHFstQ
 DGuUkMXT6uC+VI5Qr8UGWX8YvyjvgCvX2uEerqiMjvx6H9QwMKhOyC0mZFcBlJlvLACe
 XPylBAAvgY7cGTi9XHOI5pluDcR9YETUpadnqxoaljxLkmvRLQb0sOUVhJnqj7X+BlWi Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rrjchrnh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 13:13:56 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36ADDAhb005372;
 Mon, 10 Jul 2023 13:13:55 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rrjchrnf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 13:13:55 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36ABoxxg029422;
 Mon, 10 Jul 2023 13:13:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rpye58wnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 13:13:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36ADDoCY41353594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 13:13:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A48922004B;
 Mon, 10 Jul 2023 13:13:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B55920040;
 Mon, 10 Jul 2023 13:13:50 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Jul 2023 13:13:50 +0000 (GMT)
Message-ID: <c9ea1e35ca0b172db14a2b8cd743a823c540a59d.camel@linux.ibm.com>
Subject: Re: [PULL 13/21] tests/tcg/s390x: Test MVCRL with a large value in R0
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth
 <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Date: Mon, 10 Jul 2023 15:13:50 +0200
In-Reply-To: <f697c822-8036-d185-cf79-8f71e4dbdee0@linaro.org>
References: <20230710121543.197250-1-thuth@redhat.com>
 <20230710121543.197250-14-thuth@redhat.com>
 <f697c822-8036-d185-cf79-8f71e4dbdee0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EvHQDByeN8txe9pAylaOBLXhj1_zDmjK
X-Proofpoint-ORIG-GUID: GJUmoo_QBLkBt3Ru3luwHalmhWUlID4i
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, 2023-07-10 at 14:09 +0100, Richard Henderson wrote:
> On 7/10/23 13:15, Thomas Huth wrote:
> > From: Ilya Leoshkevich <iii@linux.ibm.com>
> >=20
> > Add a small test to prevent regressions.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Message-Id: <20230704081506.276055-13-iii@linux.ibm.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> > =C2=A0 tests/tcg/s390x/mie3-mvcrl.c | 46 ++++++++++++++++++++++++++++---
> > -----
> > =C2=A0 1 file changed, 36 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/tests/tcg/s390x/mie3-mvcrl.c b/tests/tcg/s390x/mie3-
> > mvcrl.c
> > index 93c7b0a290..ec78dd1d49 100644
> > --- a/tests/tcg/s390x/mie3-mvcrl.c
> > +++ b/tests/tcg/s390x/mie3-mvcrl.c
> > @@ -1,29 +1,55 @@
> > +#include <stdbool.h>
> > =C2=A0 #include <stdint.h>
> > +#include <stdlib.h>
> > =C2=A0 #include <string.h>
> > =C2=A0=20
> > -
> > -static inline void mvcrl_8(const char *dst, const char *src)
> > +static void mvcrl(const char *dst, const char *src, size_t len)
> > =C2=A0 {
> > +=C2=A0=C2=A0=C2=A0 register long r0 asm("r0") =3D len;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm volatile (
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "llill %%r0, 8\n"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ".insn sse, 0xE5=
0A00000000, 0(%[dst]), 0(%[src])"
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : : [dst] "d" (dst), [src] =
"d" (src)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "r0", "memory");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : : [dst] "d" (dst), [src] =
"d" (src), "r" (r0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "memory");
> > =C2=A0 }
> > =C2=A0=20
> > -
> > -int main(int argc, char *argv[])
> > +static bool test(void)
> > =C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *alpha =3D "abcdefghijklmnop";
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* array missing 'i' */
> > -=C2=A0=C2=A0=C2=A0 char tstr[17] =3D "abcdefghjklmnop\0" ;
> > +=C2=A0=C2=A0=C2=A0 char tstr[17] =3D "abcdefghjklmnop\0";
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* mvcrl reference use: 'open a hole in =
an array' */
> > -=C2=A0=C2=A0=C2=A0 mvcrl_8(tstr + 9, tstr + 8);
> > +=C2=A0=C2=A0=C2=A0 mvcrl(tstr + 9, tstr + 8, 8);
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* place missing 'i' */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tstr[8] =3D 'i';
> > =C2=A0=20
> > -=C2=A0=C2=A0=C2=A0 return strncmp(alpha, tstr, 16ul);
> > +=C2=A0=C2=A0=C2=A0 return strncmp(alpha, tstr, 16ul) =3D=3D 0;
> > +}
> > +
> > +static bool test_bad_r0(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0 char src[256];
> > +
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * PoP says: Bits 32-55 of general register 0 =
should contain
> > zeros;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * otherwise, the program may not operate comp=
atibly in the
> > future.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * Try it anyway in order to check whether thi=
s would crash
> > QEMU itself.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 mvcrl(src, src, (size_t)-1);
> > +
> > +=C2=A0=C2=A0=C2=A0 return true;
> > +}
>=20
> gcc 11 doesn't like this:
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/4623964826#L3921
>=20
> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
> project/qemu/tests/tcg/s390x/mie3-mvcrl.c: In=20
> function =E2=80=98test_bad_r0=E2=80=99:
> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:42:5:=20
> error: =E2=80=98src=E2=80=99 may be used uninitialized [-Werror=3Dmaybe-u=
ninitialized]
> =C2=A0=C2=A0=C2=A0 42 |=C2=A0=C2=A0=C2=A0=C2=A0 mvcrl(src, src, (size_t)-=
1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~=
~~~~~~~~~~~~~~~~~
> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:6:13:=20
> note: by argument 1 of type =E2=80=98const char *=E2=80=99 to =E2=80=98mv=
crl=E2=80=99 declared here
> =C2=A0=C2=A0=C2=A0=C2=A0 6 | static void mvcrl(const char *dst, const cha=
r *src, size_t
> len)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~
> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:34:10:=20
> note: =E2=80=98src=E2=80=99 declared here
> =C2=A0=C2=A0=C2=A0 34 |=C2=A0=C2=A0=C2=A0=C2=A0 char src[256];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^~~
> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:42:5:=20
> error: =E2=80=98src=E2=80=99 may be used uninitialized [-Werror=3Dmaybe-u=
ninitialized]
> =C2=A0=C2=A0=C2=A0 42 |=C2=A0=C2=A0=C2=A0=C2=A0 mvcrl(src, src, (size_t)-=
1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~=
~~~~~~~~~~~~~~~~~
> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:6:13:=20
> note: by argument 2 of type =E2=80=98const char *=E2=80=99 to =E2=80=98mv=
crl=E2=80=99 declared here
> =C2=A0=C2=A0=C2=A0=C2=A0 6 | static void mvcrl(const char *dst, const cha=
r *src, size_t
> len)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~
> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:34:10:=20
> note: =E2=80=98src=E2=80=99 declared here
> =C2=A0=C2=A0=C2=A0 34 |=C2=A0=C2=A0=C2=A0=C2=A0 char src[256];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^~~
> cc1: all warnings being treated as errors
>=20
> How it sees any use of the structure, initialized or otherwise, I
> don't know -- it's all=20
> hidden within the asm.=C2=A0 However, src[256] =3D { } is enough to silen=
ce
> the error.
>=20
>=20
> r~

Thanks for having a look at this. I assume you applied this fixup, and
I don't need to send a follow-up patch?

