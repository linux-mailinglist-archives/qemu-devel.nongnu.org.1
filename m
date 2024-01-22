Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A598366D1
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:08:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvtX-0001Rd-FY; Mon, 22 Jan 2024 10:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rRvtM-0001PQ-1L; Mon, 22 Jan 2024 10:07:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rRvtK-00033i-2f; Mon, 22 Jan 2024 10:07:15 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MDB9qp027298; Mon, 22 Jan 2024 15:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yHxhP+TKCeApLrQHrvtfrkxA3HxXu76edoE+20DCaBU=;
 b=Q4ZmmcEa5cMN+MvL+txYLtS3qtN6JLDuGUYIsht8OKG3MmkuTiEZXb5fzygPsBIywM9h
 JoviY4opEn8iGauOdm2arZa8fZizkZkMQBe/Gldt3e9NJalLv9k2Te8CujXY5HwcE2Tj
 1d3+tK6VBh+5QaCbEfAUsoJG/askHo6yXI2koIQ38B62LC/ckAgoT4Ehuzc/Br28tDdn
 Vjvf0spTv66T8Swglr6omEqNNeVTMLPk9I1fIyt7wL5pMv9kX58f77ggJOQmARLOBxTk
 /w5IVSUdASZRKFebh6HmULR4jR0Wv9SA3HHQ0c8TSgn2GS13VzoSzLOtY/2GpK123dZL MA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsryckhrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 15:06:51 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MEt0PA003671;
 Mon, 22 Jan 2024 15:06:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsryckhpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 15:06:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MF0wn6022429; Mon, 22 Jan 2024 15:06:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0krw1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 15:06:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40MF6lAh14025292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 15:06:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D554C58055;
 Mon, 22 Jan 2024 15:06:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD0DD58059;
 Mon, 22 Jan 2024 15:06:45 +0000 (GMT)
Received: from [9.61.119.211] (unknown [9.61.119.211])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jan 2024 15:06:45 +0000 (GMT)
Message-ID: <8bd02b29-d90f-4b6a-8cb8-a024be6f8a7c@linux.ibm.com>
Date: Mon, 22 Jan 2024 10:06:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] s390x/pci: fix ISM reset
To: Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, clg@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240118185151.265329-1-mjrosato@linux.ibm.com>
 <d2482bd3-7f0a-4f6e-a366-539f0122162f@tls.msk.ru>
 <85e2c13a-73cf-40df-9708-4012f4dccf55@tls.msk.ru>
 <3933b2ce-2c96-440d-abc0-c7b12094f2ac@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <3933b2ce-2c96-440d-abc0-c7b12094f2ac@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SkBCqn_NpPyEpCik96iJrCuWu4A6508w
X-Proofpoint-GUID: zRssz2yqZxQTlk9ojw_88MuDCu1w8_49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=851
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220103
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 1/22/24 5:49 AM, Thomas Huth wrote:
> On 22/01/2024 11.31, Michael Tokarev wrote:
>> 22.01.2024 13:18, Michael Tokarev :
>> ..
>>> Is it this a material for -stable, or there's no need to bother?
>>
>> Actually it's been Cc'd to qemu-stable@ already, I haven't noticed.
>> Still there's a question which branches should get which patches.
> ...
>> So all 3 are okay for 8.2.
>>
>> What about 8.1 and 7.2 which are the current still-maintained stable branches?
>> (I think this 8.1 release will be the last in series).
> 
> IIUC the main issue that this series fixes is the bug that has been uncovered by commit ef1535901a07f2e49fa25c8bcee7f0b73801d824 ("s390x: do a subsystem reset before the unprotect on reboot") - and that one is in 8.2 only. So I think it should be OK to just backport this to 8.2 and skip 8.1 and 7.2.
> 

Agreed.

Thanks,
Matt


