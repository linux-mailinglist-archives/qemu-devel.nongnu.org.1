Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27083743C0A
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFDPJ-0000yB-Ff; Fri, 30 Jun 2023 08:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFDPC-0000up-OE
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:39:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFDPA-0006F2-QZ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:39:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UCH5Qn007237; Fri, 30 Jun 2023 12:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=mqhgwu/yGYxmmCpOEm3IXaQoGD9NIpbmacILncwIOE8=;
 b=Z0jo0MDFH6q0o+tJK13Qp1MKEG8DKAAMv71lmfT7jbN9YX8NdHaZ7gE7Iky6U3Hx9GsW
 5CdBaQdFnSo0P0+cNGImKzr2i9M02lNvNvEXHBV/6D13PxCfAr8ldvhqzI/vgHfk964A
 Hzqa+2BS7GQxKWTDap0zTSZpw58kgyHBg6+Vpc8yDT7q8fNSloFP/XATz2gOoV/5Iy6/
 ATK2O0JOer3lW1C7jl7zUmoq0BqQ+HPLXrPxkUisx9n/2+7srl0OTeleRLp+S0HtNEli
 JDyEYinEFuNb0TEuazoMrp69XJ05KjOFeIKsu2YHkSELE27bkK33zLOt30LoQ1heRSQ7 mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhxwtgh0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 12:39:12 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UCZxJ7028560;
 Fri, 30 Jun 2023 12:39:11 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhxwtggyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 12:39:11 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U3Rorb004120;
 Fri, 30 Jun 2023 12:39:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr45458p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 12:39:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UCd7AA28770848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 12:39:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F31C020043;
 Fri, 30 Jun 2023 12:39:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0E4B20040;
 Fri, 30 Jun 2023 12:39:06 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 12:39:06 +0000 (GMT)
Message-ID: <9d6b93c20340059f1a2fbea4a7a531e2e35ba34d.camel@linux.ibm.com>
Subject: Re: [PULL 3/5] tcg: add perfmap and jitdump
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Vanderson M . do Rosario"
 <vandersonmr2@gmail.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>
Date: Fri, 30 Jun 2023 14:39:06 +0200
In-Reply-To: <e122d115-0d0f-59d2-b593-2210ca1118df@linaro.org>
References: <20230116223637.3512814-1-richard.henderson@linaro.org>
 <20230116223637.3512814-4-richard.henderson@linaro.org>
 <e1112615-0e6c-e0ea-aa60-1d94d1da26ea@linaro.org>
 <e122d115-0d0f-59d2-b593-2210ca1118df@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cDNhcYjdlISderFSESjyFdvseK--Bixb
X-Proofpoint-ORIG-GUID: c74Axu9R2byXS_g1IL-wFDJrU0d0eLVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=941 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300107
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

On Thu, 2023-06-29 at 14:59 +0200, Richard Henderson wrote:
> On 6/29/23 13:31, Philippe Mathieu-Daud=C3=A9 wrote:
> > > diff --git a/tcg/tcg.c b/tcg/tcg.c
> > > index da91779890..9b7df71e7a 100644
> > > --- a/tcg/tcg.c
> > > +++ b/tcg/tcg.c
> > > @@ -61,6 +61,7 @@
> > > =C2=A0 #include "exec/log.h"
> > > =C2=A0 #include "tcg/tcg-ldst.h"
> > > =C2=A0 #include "tcg-internal.h"
> > > +#include "accel/tcg/perf.h"
> >=20
> > Is it OK to include an header from QEMU's accel/tcg/ here?
> > I thought we wanted to keep tcg/ kinda independant (or maybe
> > this is already too late and this isn't a concern anymore).
>=20
> It's not ideal, no.=C2=A0 Perf really should live in tcg/.
>=20
>=20
> r~

This would require to somehow get rid of this:

#if defined(TARGET_I386)
            q[insn].address -=3D tb->cs_base;
#endif

I'll try to come up with a patch.

