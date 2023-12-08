Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5980A12B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 11:37:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBYDg-0006Nn-Da; Fri, 08 Dec 2023 05:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rBYDc-0006NH-Fi
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 05:36:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rBYDa-0002CH-GE
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 05:36:28 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B89gRJo026104; Fri, 8 Dec 2023 10:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UHOjwufiLUqYEnj0tfguu8+JH2xMe/L9ZMJngXuROxo=;
 b=h3d0jOZzM3Ag70EL4mNcxUX+qN4xJ6OiIi19+rTIGckofEQhxp0DAXtG+VXU4OU8Rp1o
 tmGHkksfL9oE0dcC6ZjK+S4zrlEcN0tIDI6FPLcVL9Sda8aGtUv0Q4wsAueZmNfeX93q
 tg/CF6PzguyfG7xvI7sZlykEIUXeYdm7vKmrUKy+JUzTmCfm68mYegJJafj5j2dJxMaF
 IHFQMX8n+3IDsOsGKCFKQbF+VNbuA/VGJFuAimhyttgtEaY3J1L7Toyu2EQNV5dN2Suj
 1OHetjI0uLJRbL2cv4ITeqFMrrLZlISQ1vrzCwuwJfh7LqpdWrbp8BzFZOsg42XjsFoC Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv0ra9dnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 10:36:23 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B8ALuis021022;
 Fri, 8 Dec 2023 10:36:17 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv0ra9cyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 10:36:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B89W15Z004688; Fri, 8 Dec 2023 10:35:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav4s39d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 10:35:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B8AZ5n215532694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Dec 2023 10:35:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7556020040;
 Fri,  8 Dec 2023 10:35:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 007D72004B;
 Fri,  8 Dec 2023 10:35:05 +0000 (GMT)
Received: from [9.171.70.26] (unknown [9.171.70.26])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Dec 2023 10:35:04 +0000 (GMT)
Message-ID: <b1bdabb0f37292e5791883b152bb2e13ffe384e0.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] accel/tcg: Remove #ifdef TARGET_I386 from perf.c
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, qemu-devel@nongnu.org
Date: Fri, 08 Dec 2023 11:35:04 +0100
In-Reply-To: <87edfxxbnx.fsf@draig.linaro.org>
References: <20231208003754.3688038-1-iii@linux.ibm.com>
 <20231208003754.3688038-4-iii@linux.ibm.com>
 <87edfxxbnx.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EqoGODjdprm3lceiWkSsp_LA3mBmdr7x
X-Proofpoint-GUID: UUkUHEP-ekPPkJD4J3QbQ0fzOc_b39zT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_06,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Fri, 2023-12-08 at 09:53 +0000, Alex Benn=C3=A9e wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > Preparation for moving perf.c to tcg/.
> >=20
> > This affects only profiling guest code, which has code in a non-0
> > based
> > segment, e.g., 16-bit code, which is not particularly important.
>=20
> I have no objection to removing the wart. Is it worth adding a note::
> to
> tcg.rst to say that profiles of 16-bit x64 code will be junk?
>=20
> Anyway:
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I haven't tried them, but I don't think they work well anyway. With the
current logic, the samples are assigned to ip (without cs!), so if
there is code in different segments, there will be, to put it mildly,
ambiguities. Come to think of it, the patch even improves the
situation, since now the samples are assigned to cs*16+ip. In any
case, I don't think there is any good tooling to work with 16-bit
profiles.

> > Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0accel/tcg/perf.c | 4 ----
> > =C2=A01 file changed, 4 deletions(-)
> >=20
> > diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
> > index ba75c1bbe45..68a46b1b524 100644
> > --- a/accel/tcg/perf.c
> > +++ b/accel/tcg/perf.c
> > @@ -337,10 +337,6 @@ void perf_report_code(uint64_t guest_pc,
> > TranslationBlock *tb,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q[insn].address =3D ge=
n_insn_data[insn * start_words + 0];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tb_cflags(tb) & CF=
_PCREL) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 q[insn].address |=3D (guest_pc &
> > qemu_target_page_mask());
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > -#if defined(TARGET_I386)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q[i=
nsn].address -=3D tb->cs_base;
> > -#endif
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q[insn].flags =3D DEBU=
GINFO_SYMBOL | (jitdump ?
> > DEBUGINFO_LINE : 0);
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20


