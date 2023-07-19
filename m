Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97175952E
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 14:32:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM6KN-0005is-CP; Wed, 19 Jul 2023 08:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM6KB-0005gV-G8; Wed, 19 Jul 2023 08:30:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM6K5-0004VX-Uw; Wed, 19 Jul 2023 08:30:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JC8xIb019566; Wed, 19 Jul 2023 12:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vaVQSOXN6VLR1MjHv8EYevnK0jBbur+ueDu1DIVZ0Kg=;
 b=jTRU6yVWuakKUktTgj92Rx4cA9zX6WVcrb1RQnOTyizEsaCIuxsQflHSur/hT25l8iEs
 dmWWHJZ2bJkvedfnDSd9LVv7xFGVk7mPYm8o5dObjNlRll1BbToFUtKEBidkOsWbPP2N
 io2/nJI3CX3Y1x/pP3lyd+tzhPrCsgf0XeXvh9ARJ+44ND2hM3sTtUFKJxRtl771p5na
 K7HXsMIQZvnrps2xfWteckeOCImMrwoKVevJr3x01iCo4fI0yrtK4iJKbvhZqlKfJ+ch
 dJMh8mEAajpr1S6QZFjGmYnPEPIyD02kay0ZkokpkV4p1VR0Z03Y3r6YkrSkIkgGcn8y dA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxesh1med-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 12:30:27 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JC9NLE023108;
 Wed, 19 Jul 2023 12:30:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxesh1me1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 12:30:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J8O7LA003362; Wed, 19 Jul 2023 12:30:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xhm9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 12:30:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36JCUN2h26018406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 12:30:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7795A2004B;
 Wed, 19 Jul 2023 12:30:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F87520040;
 Wed, 19 Jul 2023 12:30:23 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 12:30:23 +0000 (GMT)
Message-ID: <ddf29fdedb5dbbe10a0204ed0d3714315e33174d.camel@linux.ibm.com>
Subject: Re: [PATCH v2 06/14] tcg/{i386, s390x}: Add earlyclobber to the
 op_add2's first output
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Wed, 19 Jul 2023 14:30:23 +0200
In-Reply-To: <61be191f-c1b1-cfbc-d50a-1ee9cdd7d667@linaro.org>
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-7-iii@linux.ibm.com>
 <61be191f-c1b1-cfbc-d50a-1ee9cdd7d667@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d6Nb2X5bBpD3LpY_3SumL3saPx4T1OPz
X-Proofpoint-GUID: wzhE5gfUB1oH4noLZ8eAv8mpMwCXC_xR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_08,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190108
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

On Wed, 2023-07-19 at 14:08 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Ilya,
>=20
> On 19/7/23 11:44, Ilya Leoshkevich wrote:
> > i386 and s390x implementations of op_add2 require an earlyclobber,
> > which is currently missing. This breaks VCKSM in s390x guests.
> > E.g., on
> > x86_64 the following op:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 add2_i32 tmp2,tmp3,tmp2,tmp3,tmp3,tmp2=C2=A0=
=C2=A0 dead: 0 2 3 4 5=C2=A0
> > pref=3Dnone,0xffff
> >=20
> > is translated to:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 addl=C2=A0=C2=A0=C2=A0=C2=A0 %ebx, %r12d
> > =C2=A0=C2=A0=C2=A0=C2=A0 adcl=C2=A0=C2=A0=C2=A0=C2=A0 %r12d, %ebx
> >=20
> > Introduce a new C_N1_O1_I4 constraint, and make sure that
> > earlyclobber
> > of aliased outputs is honored.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Fixes: 82790a870992 ("tcg: Add markup for output requires new
> > register")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 tcg/i386/tcg-target-con-set.h=C2=A0 | 2 +-
> > =C2=A0 tcg/i386/tcg-target.c.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0 tcg/s390x/tcg-target-con-set.h | 5 ++---
> > =C2=A0 tcg/s390x/tcg-target.c.inc=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> > =C2=A0 tcg/tcg.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
8 +++++++-
> > =C2=A0 5 files changed, 13 insertions(+), 8 deletions(-)
>=20
>=20
> > diff --git a/tcg/tcg.c b/tcg/tcg.c
> > index 652e8ea6b93..ddfe9a96cb7 100644
> > --- a/tcg/tcg.c
> > +++ b/tcg/tcg.c
> > @@ -648,6 +648,7 @@ static void tcg_out_movext3(TCGContext *s,
> > const TCGMovExtend *i1,
> > =C2=A0 #define C_O2_I2(O1, O2, I1, I2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 C_PFX4(c_o2_i2_, O1, O2,
> > I1, I2),
> > =C2=A0 #define C_O2_I3(O1, O2, I1, I2, I3)=C2=A0=C2=A0=C2=A0=C2=A0 C_PF=
X5(c_o2_i3_, O1, O2,
> > I1, I2, I3),
> > =C2=A0 #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2,
> > I1, I2, I3, I4),
> > +#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1,
> > O2, I1, I2, I3, I4),
>=20
> No need for O2. Also can you place it earlier just after C_N1_I2?

Shouldn't it still be a 6-argument constraint?
INDEX_op_add2_i32 and friends take 6 arguments after all.

> -- >8 --
> @@ -643,6 +643,7 @@ static void tcg_out_movext3(TCGContext *s, const=20
> TCGMovExtend *i1,
> =C2=A0 #define C_O1_I4(O1, I1, I2, I3, I4)=C2=A0=C2=A0=C2=A0=C2=A0 C_PFX5=
(c_o1_i4_, O1, I1,
> I2,=20
> I3, I4),
>=20
> =C2=A0 #define C_N1_I2(O1, I1, I2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C_PFX3(c_n1_i2_, O1, I1,
> I2),
> +#define C_N1_O1_I4(O1, I1, I2, I3, I4)=C2=A0 C_PFX5(c_n1_o1_i4_, O1, I1,
> I2,=20
> I3, I4),
>=20
> =C2=A0 #define C_O2_I1(O1, O2, I1)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C_PFX3(c_o2_i1_, O1, O2,
> I1),
> =C2=A0 #define C_O2_I2(O1, O2, I1, I2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 C_PFX4(c_o2_i2_, O1, O2,
> I1, I2),
> ---
>=20
> Thanks,
>=20
> Phil.


