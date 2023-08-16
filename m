Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BD77DE88
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 12:22:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWDdg-00078o-A2; Wed, 16 Aug 2023 06:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qWDdd-00077v-Jg; Wed, 16 Aug 2023 06:20:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qWDdY-0002gY-LL; Wed, 16 Aug 2023 06:20:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37GAAGUs010194; Wed, 16 Aug 2023 10:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9u900TCHbujvcFWLfqN5QGm8BAQg5s0UB5ycX/mLN88=;
 b=kCHxSDQRcrFoxqP3in4ab13FZUA0E2W7rWTy55E8rHMbcBgq6cF5x/qiFlsw+cBEqeuy
 /nKiGYrxiYwvPqd0E0sUKsX1ymb1vW4WswKNW9uhFe+GRLb0weqWDS0ifgrktmLVblT3
 ZtEtjEPREzfdoPo43H0aFCjC15vM/rwPiV4/4kkyss3qeTC8jgqky5lnkATiHOoekMlt
 YMznEdIci5P1AH0Mq0PRZZw19OxcIHnf75FpJqTAqZ+tr1ILaUzHPpcx8OOGavEiKlN0
 +xLonj62ueCoMUOx+Kg/9YEjZhMlnMboIHaPHKS5diZeV1lglZd4PWaje/QTDT0E0xXG TA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgv49s6cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 10:20:06 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37GAB3cY016667;
 Wed, 16 Aug 2023 10:20:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgv49s6c9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 10:20:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37G8sVlb002418; Wed, 16 Aug 2023 10:20:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendnbgyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 10:20:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37GAK1nc43123036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Aug 2023 10:20:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A55352004D;
 Wed, 16 Aug 2023 10:20:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F9362004B;
 Wed, 16 Aug 2023 10:20:01 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Aug 2023 10:20:01 +0000 (GMT)
Message-ID: <130aa9ee49dffd9ecc1006b17b9e82734837d7d9.camel@linux.ibm.com>
Subject: Re: [PATCH 4/9] tests: remove test-gdbstub.py
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Akihiko
 Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>, David
 Hildenbrand <david@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Nicholas
 Piggin <npiggin@gmail.com>
Date: Wed, 16 Aug 2023 12:20:01 +0200
In-Reply-To: <20230815145126.3444183-5-alex.bennee@linaro.org>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
 <20230815145126.3444183-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FWSOOWtZ3zsaCxVSnJ9iK_iQImQnL2Hi
X-Proofpoint-GUID: y5vWNht9k8vlPQaD1DUiIywo0YhqueDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_08,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=929 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2023-08-15 at 15:51 +0100, Alex Benn=C3=A9e wrote:
> This isn't directly called by our CI and because it doesn't run via
> our run-test.py script does things slightly differently. Lets remove
> it as we have plenty of working in-tree tests now for various aspects
> of gdbstub.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
> =C2=A0tests/guest-debug/test-gdbstub.py | 177 ---------------------------=
-
> --
> =C2=A01 file changed, 177 deletions(-)
> =C2=A0delete mode 100644 tests/guest-debug/test-gdbstub.py

There doesn't seem to be a hbreak test elsewhere, but according to a
comment in tcg/multiarch/gdbstub/memory.py it would be mapped to a
normal break anyway.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

