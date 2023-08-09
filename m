Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B0B775982
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 13:01:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTguo-0007lp-GW; Wed, 09 Aug 2023 06:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qTgul-0007lA-Un
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 06:59:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qTguk-0004Ay-66
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 06:59:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 379Aswc1028981; Wed, 9 Aug 2023 10:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3wfa+enqWd4xG2fJG5DMxrejzORbb6nQCI0ghAi9LK0=;
 b=pMB+QX1AZNXJ3387/QoNBc7pMDfzHB3oDlZyAB8Iq9hW+6RRDK9jx1/bffznJ0ZVN9bA
 NND7yHxssagYpUG/NLfFnCA16Q3zoYVYq7RwW8YVzlukn7mDhW9MnM4EYA/h2JeGH4XC
 yLuhIn6iU+BaTbRGAnJs/G0o3Q+AhvyCxEVM7ccBSRjdswk9s+zPMmQFVjtkbLn47IEM
 xSxyOy7HcamSfQF7/wc/RI98Pe1oUVMJ3TW6ZM5c+BLPGHy4a7YWcGFpJaRqtO8Vw5JI
 Z04w5NkUoFxvzZEpec76PH4Zw77YlUnE7WGWmLN6+1+IOXwMf60I9vdfYxF850xjphOL uA== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sc9f8g45f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Aug 2023 10:59:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3799paAs015347; Wed, 9 Aug 2023 10:59:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sb3f313rt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Aug 2023 10:59:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 379AxWoH23397106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Aug 2023 10:59:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 643C920043;
 Wed,  9 Aug 2023 10:59:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48F3020040;
 Wed,  9 Aug 2023 10:59:32 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Aug 2023 10:59:32 +0000 (GMT)
Message-ID: <26b47e37f11835201784dae30cebdd03b87ebdf4.camel@linux.ibm.com>
Subject: Re: [PATCH for-8.1] tests/tcg: Disable filename test for info proc
 mappings
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Date: Wed, 09 Aug 2023 12:59:32 +0200
In-Reply-To: <20230808234958.148910-1-richard.henderson@linaro.org>
References: <20230808234958.148910-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6e-upAfQmytVjQs4sWc9smQPY9umTIbj
X-Proofpoint-GUID: 6e-upAfQmytVjQs4sWc9smQPY9umTIbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_09,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=899 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090093
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 2023-08-08 at 16:49 -0700, Richard Henderson wrote:
> This test fails when host page size !=3D guest page size,
> because qemu may not be able to directly map the file.
>=20
> Fixes: a6341482695 ("tests/tcg: Add a test for info proc mappings")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> =C2=A0tests/tcg/multiarch/gdbstub/test-proc-mappings.py | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
> b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
> index 7b596ac21b..5e3e5a2fb7 100644
> --- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
> +++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
> @@ -33,7 +33,8 @@ def run_test():
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise
> =C2=A0=C2=A0=C2=A0=C2=A0 report(isinstance(mappings, str), "Fetched the m=
appings from the
> inferior")
> -=C2=A0=C2=A0=C2=A0 report("/sha1" in mappings, "Found the test binary na=
me in the
> mappings")
> +=C2=A0=C2=A0=C2=A0 # Broken with host page size > guest page size
> +=C2=A0=C2=A0=C2=A0 # report("/sha1" in mappings, "Found the test binary =
name in the
> mappings")
> =C2=A0
> =C2=A0
> =C2=A0def main():

I'll try to find a way to check host/guest page sizes in Python for
8.2. I think it's fine to disable the check for 8.1.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

