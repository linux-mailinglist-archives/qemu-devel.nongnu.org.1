Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3967F7594A9
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 13:53:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM5ja-0002UB-Qk; Wed, 19 Jul 2023 07:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qM5jX-0002Tu-QT
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:52:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qM5jV-00033y-VH
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:52:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JBfmij016434; Wed, 19 Jul 2023 11:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6u+vit3Y4UJT0kiEL1k5x4+hmhILwrE+i6MqLLNDcwg=;
 b=X2Ha6DaCZJqE667Rc6WWSBo9nbvvldZFOW1+bEXykCE5isECAAh4I5/qMe1OIgIfOE0+
 ATeVPiUHL1Uw2mJ86vndoxAtucck9Kn4Ib7Rrmww8a5PUKu9Ngb+HxcneVMG7QjoFpY8
 e9rO6+3s+KBlu+58HN7tNoygw+ercQbWhkqZUaunqOtWU+er2PX7NzfJIY2rRIapzMl8
 orLlUbDrBJxPiRg526lSSpCbKpiO09NjSDQUJQnypHP2Wv36fwUET61Lyz/M5k3jK34V
 e/tapvfiMacwF+/pZTEFw2nnnfBwD7e7czVR/j76icJQJO93zduvxS6q7zbKUWQkngIr Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxeh016s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 11:52:37 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JBoSaM020958;
 Wed, 19 Jul 2023 11:52:36 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxeh016ry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 11:52:36 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JBbH4B007106; Wed, 19 Jul 2023 11:52:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv80j749w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 11:52:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36JBqYtu59310490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 11:52:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5891720043;
 Wed, 19 Jul 2023 11:52:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A24320040;
 Wed, 19 Jul 2023 11:52:34 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 11:52:34 +0000 (GMT)
Message-ID: <e55cdccbd4bee15a091ae47b99a3d98c9d2654f5.camel@linux.ibm.com>
Subject: Re: [PATCH 17/18] host/include/i386: Implement clmul.h
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
Date: Wed, 19 Jul 2023 13:52:34 +0200
In-Reply-To: <20230713211435.13505-18-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
 <20230713211435.13505-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wauGbdxmG6JRXReplJxb9iGeo8rG5iMn
X-Proofpoint-GUID: gXA8S-vW9IYI8G7NmlyFdHKHDyoIZjT2
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_07,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190104
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

On Thu, 2023-07-13 at 22:14 +0100, Richard Henderson wrote:
> Detect PCLMUL in cpuinfo; implement the accel hooks.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> =C2=A0host/include/i386/host/cpuinfo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0host/include/i386/host/crypto/clmul.h=C2=A0=C2=A0 | 187
> ++++++++++++++++++++++++
> =C2=A0host/include/x86_64/host/crypto/clmul.h |=C2=A0=C2=A0 1 +
> =C2=A0util/cpuinfo-i386.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> =C2=A04 files changed, 190 insertions(+)
> =C2=A0create mode 100644 host/include/i386/host/crypto/clmul.h
> =C2=A0create mode 100644 host/include/x86_64/host/crypto/clmul.h

...

> diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
> index 3a7b7e0ad1..c6f6364826 100644
> --- a/util/cpuinfo-i386.c
> +++ b/util/cpuinfo-i386.c
> @@ -39,6 +39,7 @@ unsigned __attribute__((constructor))
> cpuinfo_init(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info |=3D (c & bit_SSE4_=
1 ? CPUINFO_SSE4 : 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info |=3D (c & bit_MOVBE=
 ? CPUINFO_MOVBE : 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info |=3D (c & bit_POPCN=
T ? CPUINFO_POPCNT : 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info |=3D (c & bit_PCLMULQDQ =
? CPUINFO_PCLMUL : 0);

I wanted to give this a try, but my cpuid.h has only
bit_VPCLMULQDQ, and I don't see it in [1] either.
Where is this supposed to come from? Does qemu/cpuid.h need an update?

...

[1]
https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dblob;f=3Dgcc/config/i386/cpuid.h;h=
=3D03fd6fc9478e8ef87d0f7191b9f80539e9c3e939;hb=3Drefs/heads/master

