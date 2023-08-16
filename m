Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D777E14F
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 14:17:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWFRW-0001LG-8p; Wed, 16 Aug 2023 08:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qWFQg-0000oi-7b; Wed, 16 Aug 2023 08:15:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qWFQc-0003Wp-Mg; Wed, 16 Aug 2023 08:15:13 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37GCCJUM021627; Wed, 16 Aug 2023 12:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fkcoUQO65x6p8ntqiks4DWdDPSArzB/Mrz2hQCYPFos=;
 b=k+ZIlFUPL1mawNKExdn4S0FPQM6K7+MEexwWXrBn/9+VXjWQjl0h+PaiaFDNDdo5yr0H
 31Gmm+cYut7zpQugK3Vs5BhyCqI3AjJYoAtvuno3hDRwPc3GjuIzUWch5Udv0WwgN6Fn
 YmhUmcaYfOsQ0h/uHe59N8uh26bPo2fdLxdWqFaq9NpQWAbUt5K1mZ3L20kCJySffAJq
 /QilrL2f6vJx/QwTz2wokk97xHx6NtMgDJChZI9RCBvQHBtv2e/rGsFs5MTl8TATWDW7
 NR090Nd4rao8xNfOcrTtNI/b6NAYwXj3RnK0EFZIAR3+ylDe7oP10GxSqmmthHAlg/lz MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgx1dgca3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 12:14:54 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37GCDVNn027079;
 Wed, 16 Aug 2023 12:14:54 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgx1dgc9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 12:14:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37GAgE3Z013234; Wed, 16 Aug 2023 12:14:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmjukbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 12:14:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37GCEolq27263584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Aug 2023 12:14:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ABCB20040;
 Wed, 16 Aug 2023 12:14:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD72320043;
 Wed, 16 Aug 2023 12:14:49 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Aug 2023 12:14:49 +0000 (GMT)
Message-ID: <f4819a35a00829516ba6bee70701bb8f2f4f965a.camel@linux.ibm.com>
Subject: Re: [PATCH 7/9] gdbstub: remove unused user_ctx field
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
Date: Wed, 16 Aug 2023 14:14:49 +0200
In-Reply-To: <20230815145126.3444183-8-alex.bennee@linaro.org>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
 <20230815145126.3444183-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hx5v_GGu1mogj0fQ-8zvnvAKyplehSej
X-Proofpoint-GUID: uSxrTQp8i7dePoeXXTTOtl-Fo1FZZNDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_10,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 mlxlogscore=749 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160105
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
> This was always NULL so drop it.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
> =C2=A0gdbstub/gdbstub.c | 16 ++++++++--------
> =C2=A01 file changed, 8 insertions(+), 8 deletions(-)

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

