Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90A79E00C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 08:32:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJOv-0001Vr-5v; Wed, 13 Sep 2023 02:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qgJOa-0001K8-VR; Wed, 13 Sep 2023 02:30:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qgJOY-00005i-GQ; Wed, 13 Sep 2023 02:30:40 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38D66wQx031957; Wed, 13 Sep 2023 06:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QEMrhgHzEjou2OdYpiU4LtTarJVBHYR/713vcLGcDNs=;
 b=RaMVaYoXY/wupoSU9ODLGIw1qqpRz9o2W1sRedN9HvHnteUmELosEvwIILyGzOWT8gz6
 gFrSY5M4XDepr7Po6ZvktwqV5ip0aT7CdcWPbu9ovi2m+RMsUzf+CUC4OorvXnK6xMEM
 hbOz+Vs/Zy2j4SwOh46m0qonLcGLDztukedGRkHIa+R2X+jWcq8mKtv9YTBAp3TI0pos
 9AlvTT/AXqHdqcoBF7KMwbvuwakpsT9u9tUzaxIqXgbB0tZ/n0iz8jhDeivBYYkd1hwf
 IcJAXCJBv+J6WVyfjOQWLwNJpNo+IDGW1Hn8V680eizDjqiWbuRjbZdukdDKN8qMAoUF xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t36w29pp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Sep 2023 06:30:31 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38D6Ig4X029409;
 Wed, 13 Sep 2023 06:30:30 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t36w29pns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Sep 2023 06:30:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38D68QAv002304; Wed, 13 Sep 2023 06:30:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158k8pt3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Sep 2023 06:30:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38D6US2d12255982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Sep 2023 06:30:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56D3020043;
 Wed, 13 Sep 2023 06:30:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1487820040;
 Wed, 13 Sep 2023 06:30:28 +0000 (GMT)
Received: from [9.179.15.72] (unknown [9.179.15.72])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Sep 2023 06:30:27 +0000 (GMT)
Message-ID: <167950e7-eced-f4ca-03ca-40b61a3b0a46@linux.ibm.com>
Date: Wed, 13 Sep 2023 08:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ppc/xive: Fix uint32_t overflow
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20230913055639.174032-1-clg@kaod.org>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230913055639.174032-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UgGxthCuPOp50zEWVpR-rjNnu4iLxnWq
X-Proofpoint-ORIG-GUID: MzPzH_JMsk4up7GDPU1FI-zfrZxqbT0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=930 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130051
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 13/09/2023 07:56, Cédric Le Goater wrote:
> As reported by Coverity, "idx << xive->pc_shift" is evaluated using
> 32-bit arithmetic, and then used in a context expecting a "uint64_t".
> Add a uint64_t cast.
> 
> Fixes: Coverity CID 1519049
> Fixes: b68147b7a5bf ("ppc/xive: Add support for the PC MMIOs")
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---


Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   hw/intc/pnv_xive.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 9b10e905195a..a36b3bf08c92 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -210,7 +210,7 @@ static uint64_t pnv_xive_vst_addr_remote(PnvXive *xive, uint32_t type,
>           return 0;
>       }
>   
> -    remote_addr |= idx << xive->pc_shift;
> +    remote_addr |= ((uint64_t) idx) << xive->pc_shift;
>   
>       vst_addr = address_space_ldq_be(&address_space_memory, remote_addr,
>                                       MEMTXATTRS_UNSPECIFIED, &result);

