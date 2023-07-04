Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07A746B80
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:07:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGb2i-0006S1-F8; Tue, 04 Jul 2023 04:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGb2X-0006RI-TZ; Tue, 04 Jul 2023 04:05:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGb2V-0000Sn-IG; Tue, 04 Jul 2023 04:05:37 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3647qaYj026997; Tue, 4 Jul 2023 08:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yUt7vyeQ+bQVqieGtgOKWG5T41yXxcqPbm79CWvzbcc=;
 b=Kdu9HP/TWbbKyhoEP7REJAupUuYj8Ug3Dl0kE/ndyILSdUrwWFRt0+uRD4DJBk1F1Rzp
 pIgyvd1G2MJNsizyLH/h1IvSD8y9dbRGTF3+03KlimRJJ8h8y/qhpYngEChjOeeOCYlr
 jKy/1a+nbjByA8IRrvEKURn5Qm40pUBZNeGfWyuFxynYEVnFcAOHjvXpRlAp3fW35Q/h
 iHI+tifeBIQdZ5K0V+2igrqdmoZTeBDypbHjLQclL5R0RmqOrPfAxqgh0AGsDdQNxpVl
 YamcfnIKBPIJQ1h8t+awkfJ0XHpltB0T1IrS/s/42EXngm89iDLvoPnqK79kjm3zg7p8 dg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfe0gbpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:05:32 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3647vH21008824;
 Tue, 4 Jul 2023 08:05:32 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfe0gbna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:05:31 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3644V0VF014180;
 Tue, 4 Jul 2023 08:05:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rjbs51ch7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:05:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36485RbZ22676018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 08:05:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A57D42004D;
 Tue,  4 Jul 2023 08:05:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E48220043;
 Tue,  4 Jul 2023 08:05:27 +0000 (GMT)
Received: from [9.179.30.217] (unknown [9.179.30.217])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 08:05:27 +0000 (GMT)
Message-ID: <e893b9be6e71946120f6e54422814f7d4219f484.camel@linux.ibm.com>
Subject: Re: [PATCH 05/12] target/s390x: Fix LRA overwriting the top 32 bits
 on DAT error
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org
Date: Tue, 04 Jul 2023 10:05:26 +0200
In-Reply-To: <b105761d-9602-030a-e578-12d9cd0a0283@redhat.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-6-iii@linux.ibm.com>
 <b105761d-9602-030a-e578-12d9cd0a0283@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dJoeK0qhaiV-YNAnllk_o2XF00_W-eQX
X-Proofpoint-ORIG-GUID: uCZadksqJMuKL-ose_HYFCThsNRiirs7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=855
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040065
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

On Tue, 2023-07-04 at 09:47 +0200, David Hildenbrand wrote:
> On 03.07.23 17:50, Ilya Leoshkevich wrote:
> > When a DAT error occurs, LRA is supposed to write the error
> > information
> > to the bottom 32 bits of R1, and leave the top 32 bits of R1 alone.
> >=20
> > Fix by passing the original value of R1 into helper and copying the
> > top 32 bits to the return value.
> >=20
> > Fixes: d8fe4a9c284f ("target-s390: Convert LRA")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 target/s390x/helper.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 +-
> > =C2=A0 target/s390x/tcg/mem_helper.c | 4 ++--
> > =C2=A0 target/s390x/tcg/translate.c=C2=A0 | 2 +-
> > =C2=A0 3 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> > index 6bc01df73d7..05102578fc9 100644
> > --- a/target/s390x/helper.h
> > +++ b/target/s390x/helper.h
> > @@ -355,7 +355,7 @@ DEF_HELPER_FLAGS_4(idte, TCG_CALL_NO_RWG, void,
> > env, i64, i64, i32)
> > =C2=A0 DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64,
> > i32)
> > =C2=A0 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
> > =C2=A0 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
> > -DEF_HELPER_2(lra, i64, env, i64)
> > +DEF_HELPER_3(lra, i64, env, i64, i64)
> > =C2=A0 DEF_HELPER_1(per_check_exception, void, env)
> > =C2=A0 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64,
> > i64)
> > =C2=A0 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
> > diff --git a/target/s390x/tcg/mem_helper.c
> > b/target/s390x/tcg/mem_helper.c
> > index 84ad85212c9..94d93d7ea78 100644
> > --- a/target/s390x/tcg/mem_helper.c
> > +++ b/target/s390x/tcg/mem_helper.c
> > @@ -2356,7 +2356,7 @@ void HELPER(purge)(CPUS390XState *env)
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 /* load real address */
> > -uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
> > +uint64_t HELPER(lra)(CPUS390XState *env, uint64_t r1, uint64_t
> > addr)
> > =C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t asc =3D env->psw.mask & PSW_MAS=
K_ASC;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t ret, tec;
> > @@ -2370,7 +2370,7 @@ uint64_t HELPER(lra)(CPUS390XState *env,
> > uint64_t addr)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exc =3D mmu_translate(env, addr, MMU_S39=
0_LRA, asc, &ret,
> > &flags, &tec);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (exc) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cc =3D 3;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D exc | 0x80000000;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D (r1 & 0xFFFFFFFF000=
00000) | exc | 0x80000000;
>=20
> ull missing for large constant?

Will do.

Just for my understanding, why is this necessary?
The current code base tends towards using ULL, but it's a little bit
inconsistent:

$ git grep -i 0xfffffffff | wc -l
2338
$ git grep -i 0xfffffffff | grep -i -v ul | wc -l
95


>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cc =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret |=3D addr & =
~TARGET_PAGE_MASK;
> > diff --git a/target/s390x/tcg/translate.c
> > b/target/s390x/tcg/translate.c
> > index 0cef6efbef4..a6079ab7b4f 100644
> > --- a/target/s390x/tcg/translate.c
> > +++ b/target/s390x/tcg/translate.c
> > @@ -2932,7 +2932,7 @@ static DisasJumpType op_lctlg(DisasContext
> > *s, DisasOps *o)
> > =C2=A0=20
> > =C2=A0 static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
> > =C2=A0 {
> > -=C2=A0=C2=A0=C2=A0 gen_helper_lra(o->out, cpu_env, o->in2);
> > +=C2=A0=C2=A0=C2=A0 gen_helper_lra(o->out, cpu_env, o->out, o->in2);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_cc_static(s);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return DISAS_NEXT;
> > =C2=A0 }
>=20
> Can't we use something like in1_r1 + wout_r1_32 instead ? *maybe*
> cleaner :)
>=20

The problem is that we want all 64 bits for the non-error case.

