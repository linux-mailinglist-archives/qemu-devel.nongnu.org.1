Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45176769014
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQOEX-0002hC-Qu; Mon, 31 Jul 2023 04:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qQOEI-0002gb-Cb; Mon, 31 Jul 2023 04:26:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qQOEE-0001Ik-C5; Mon, 31 Jul 2023 04:26:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36V8HuV4031922; Mon, 31 Jul 2023 08:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/H6LUgiJ242YXAlZJT3DwAyT2cg/5Za58n4xZjtf6V4=;
 b=BjY7HYn5urXPcgLRJT9DKOvCpL1+p9Dejo59g2TCc9wfqIG4Of9C/049gpDz5+ZKaPZk
 1lQh1lG/IdSUCvLS01yamtSNnj+1QXi4T0YF6Ksz97LIqnQ/OAKMIGTkDcc/UBcLtthN
 eYG0p/E2Z4naAk1nkSYf/jIWscJNSf7G4cT9lP4ElDF/6aT4rFT9hdn9puX7MV2hQ8xf
 bL5Yn0ljYQ2Hb2zkJFf+A2g6vC4v8OeHZPFfUI9w5TSX/5UCOruLgM3kfqr9/uZxsR+t
 7Di5eyfV3rEcdwcsF5uf1smBtk8FiKIusAkNwV0kb1RsIlzLrl4hq8o4ZzdobjbYkF0F +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s69av84f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 08:26:06 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36V8J7gX002542;
 Mon, 31 Jul 2023 08:26:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s69av84ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 08:26:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36V6OBGK015559; Mon, 31 Jul 2023 08:26:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3mhjsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 08:26:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36V8Q2S23932742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Jul 2023 08:26:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6D002004B;
 Mon, 31 Jul 2023 08:26:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D32320040;
 Mon, 31 Jul 2023 08:26:02 +0000 (GMT)
Received: from [9.171.78.34] (unknown [9.171.78.34])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Jul 2023 08:26:02 +0000 (GMT)
Message-ID: <f054a26eee85be8dba7095b6c4c86fd79331fcd4.camel@linux.ibm.com>
Subject: Re: [PATCH] target/s390x: Move trans_exc_code update to
 do_program_interrupt
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: david@redhat.com, qemu-s390x@nongnu.org, Claudio Fontana <cfontana@suse.de>
Date: Mon, 31 Jul 2023 10:26:01 +0200
In-Reply-To: <920b0af5-4acb-3eaa-755f-608359117cd2@linaro.org>
References: <20230728195538.488932-1-richard.henderson@linaro.org>
 <920b0af5-4acb-3eaa-755f-608359117cd2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x2A-lH9cChAVQjx1ooLnrJLOUPn6tb5f
X-Proofpoint-ORIG-GUID: 3TpxQRmqNYcP7JO5XfpJ3Erc0dbMPwVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_01,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307310072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

On Fri, 2023-07-28 at 13:02 -0700, Richard Henderson wrote:
> On 7/28/23 12:55, Richard Henderson wrote:
> > This solves a problem in which the store to LowCore during tlb_fill
> > triggers a clean-page TB invalidation for page0 during translation,
> > which results in an assertion failure for locked pages.
> >=20
> > By delaying the store until after the exception has been raised,
> > we will have unwound the pages locked for translation and the
> > problem does not arise.=C2=A0 There are plenty of other updates to
> > LowCore while delivering an interrupt/exception; trans_exc_code
> > does not need to be special.
> >=20
> > Reported-by: Claudio Fontana <cfontana@suse.de>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> > =C2=A0 target/s390x/tcg/excp_helper.c | 42 +++++++++++++++++++++++-----=
-
> > -----
> > =C2=A0 1 file changed, 29 insertions(+), 13 deletions(-)

[...]

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (env->int_pgm_code) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PGM_PER:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->per_perc_atmid & P=
ER_CODE_EVENT_NULLIFICATION) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FALL THROUGH */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 advance =3D !(env->per_perc=
_atmid &
> > PER_CODE_EVENT_NULLIFICATION);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 case PGM_ASCE_TYPE:
> > +=C2=A0=C2=A0=C2=A0 case PGM_REG_FIRST_TRANS:
> > +=C2=A0=C2=A0=C2=A0 case PGM_REG_SEC_TRANS:
> > +=C2=A0=C2=A0=C2=A0 case PGM_REG_THIRD_TRANS:
> > +=C2=A0=C2=A0=C2=A0 case PGM_SEGMENT_TRANS:
> > +=C2=A0=C2=A0=C2=A0 case PGM_PAGE_TRANS:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(env->int_pgm_code =
=3D=3D env->tlb_fill_exc);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_trans_exc_code =3D true=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>=20
> I should have mentioned that this block of exceptions came from page
> 3-76=20
> (Translation-Exception Identification for DAT Exceptions) of the 13th
> edition of the PoO.
>=20
> > +=C2=A0=C2=A0=C2=A0 case PGM_PROTECTION:
> > +=C2=A0=C2=A0=C2=A0 case PGM_TRANS_SPEC:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(env->int_pgm_code =
=3D=3D env->tlb_fill_exc);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_trans_exc_code =3D true=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 advance =3D true;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>=20
> These exceptions came from seeing an early kernel fault, grepping for
> the set of=20
> exceptions raised in mmu_helper.c, and eliminating PGM_ADDRESSING per
> the first hunk.

Does POp specify that the CPU stores Translation-Exception
Identification on Translation-Specification Exceptions
(PGM_TRANS_SPEC)? I re-read the 0xA8 documentation a few times, but
could not find it.

It's also interesting what the kernel was attempting when it got
PGM_TRANS_SPEC and recovered from it. Maybe something else is wrong?

Other than the POp question:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

>=20
> I wasn't sure where to look for the full specification of exception
> effects, but this did=20
> solve the kernel fault.
>=20
>=20
> r~


