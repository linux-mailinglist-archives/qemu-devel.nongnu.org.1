Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DAB7591E2
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:45:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3j3-0001SG-Pl; Wed, 19 Jul 2023 05:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3iZ-0001Kh-JX; Wed, 19 Jul 2023 05:43:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3iX-0002G7-11; Wed, 19 Jul 2023 05:43:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J9eILN010092; Wed, 19 Jul 2023 09:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dAlIlMg6ImnCIVcGXpk9eL/tfO0YlBg/TEcWnz2UK2g=;
 b=guvAHmTRd+k97oWfdYnKOi1xWuVkDBn199pFLG8lBWLuPrbSQZKJXQbMi0y6fqCUJzZR
 c+L+6eqBDQWNVp6OLinySFuB/Mkmu8yRnTcAX+Tcsj5AYRGnn2eEDupBA7BD3okBTRp6
 aIlKHsKBo6O0z0NW3ewt6gsx6nolqRRUl9krqwaLx8ye2UyYhri8KVDC+IDNCIlVFy6d
 m/MLdZOD+vbF+4Y/dW08sX4LTMjciuGB8NY4VeRrWo9oedULKy1UhPlgMok0E04mQvCK
 jtxvM1f50n2aeEFgQms+HkBcFu9kt42QnBX5QrFR2gvmUy1UMzJXsmR2Pdi+jkKSwqCD 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxd4rgpmm-13
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:43:28 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J9LhIu014666;
 Wed, 19 Jul 2023 09:34:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxd4rgebs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:34:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J8CCWh029098; Wed, 19 Jul 2023 09:34:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv6smh0e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:34:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36J9YKQS28050124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 09:34:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D93C120043;
 Wed, 19 Jul 2023 09:34:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A685A20040;
 Wed, 19 Jul 2023 09:34:20 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 09:34:20 +0000 (GMT)
Message-ID: <42c07b30625903256e3448a621ab58a06fcc7ad3.camel@linux.ibm.com>
Subject: Re: [PATCH 07/14] target/s390x: Fix assertion failure in
 VFMIN/VFMAX with reserved type
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Wed, 19 Jul 2023 11:34:20 +0200
In-Reply-To: <581f6cc6-befb-4c6e-8ed6-191429d9be1c@redhat.com>
References: <20230718213531.117976-1-iii@linux.ibm.com>
 <20230718213531.117976-8-iii@linux.ibm.com>
 <581f6cc6-befb-4c6e-8ed6-191429d9be1c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZD-Z7hy5SZ-qDWux1N6nMGzufW6F7axn
X-Proofpoint-GUID: tUwGIe_UOwGX6F6-Mk6TKaPZPfjyfXI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=687 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190087
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

On Wed, 2023-07-19 at 10:40 +0200, David Hildenbrand wrote:
> On 18.07.23 23:21, Ilya Leoshkevich wrote:
> > Passing reserved type to VFMIN/VFMAX causes an assertion failure in
> > vfmin_res() and vfmax_res(). These instructions should raise a
> > specification exception in this case.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Fixes: da4807527f3b ("s390x/tcg: Implement VECTOR FP
> > (MAXIMUM|MINIMUM)")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 target/s390x/tcg/vec_fpu_helper.c | 24 +++++++++++++++---------
> > =C2=A0 1 file changed, 15 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/target/s390x/tcg/vec_fpu_helper.c
> > b/target/s390x/tcg/vec_fpu_helper.c
> > index 75cf605b9f4..f1671679879 100644
> > --- a/target/s390x/tcg/vec_fpu_helper.c
> > +++ b/target/s390x/tcg/vec_fpu_helper.c
> > @@ -915,7 +915,7 @@ static void vfminmax32(S390Vector *v1, const
> > S390Vector *v2,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32 b =3D s3=
90_vec_read_float32(v3, i);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32 result;
> > =C2=A0=20
>=20
> Why not check for invalid types once first and leave the rest of that
> function alone?
>=20
> diff --git a/target/s390x/tcg/vec_fpu_helper.c
> b/target/s390x/tcg/vec_fpu_helper.c
> index 75cf605b9f..e0b2a78632 100644
> --- a/target/s390x/tcg/vec_fpu_helper.c
> +++ b/target/s390x/tcg/vec_fpu_helper.c
> @@ -910,6 +910,11 @@ static void vfminmax32(S390Vector *v1, const
> S390Vector *v2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390Vector tmp =3D {};
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> =C2=A0=20
> +=C2=A0=C2=A0=C2=A0 if (type > S390_MINMAX_TYPE_F) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_s390_program_interrupt(en=
v, PGM_SPECIFICATION, retaddr);
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 4; i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32 a =3D s390=
_vec_read_float32(v2, i);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32 b =3D s390=
_vec_read_float32(v3, i);
>=20

I have taken another look, and turns out there already is:

static DisasJumpType op_vfmax(DisasContext *s, DisasOps *o)
{
    ...

    if (m6 =3D=3D 5 || m6 =3D=3D 6 || m6 =3D=3D 7 || m6 > 13) {
        gen_program_exception(s, PGM_SPECIFICATION);
        return DISAS_NORETURN;
    }

What the fuzzer has found was the m6 =3D=3D 13 case, so only a small
adjustment is needed.

