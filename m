Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F06779A81B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:03:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfgYB-0004Cs-Ex; Mon, 11 Sep 2023 09:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qfgXd-0003xj-Bi; Mon, 11 Sep 2023 09:01:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qfgXa-0000Fe-Kf; Mon, 11 Sep 2023 09:01:25 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BCxPDY017490; Mon, 11 Sep 2023 13:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0uZOb7Sjoljt5CRSiGv62irmLADsREfBvPHa4fLT/NI=;
 b=mtbjLBQCizPC7UiELrOSX/a0pzH/Elw1u0Pu9ZBltq5vxbdnCMrMxnXrM+G8fxegRb4B
 PZScDfh2tHVtXwT3pmBoPOkVlIk6Uf/x1aWHeKnaFhuLGo9L0modUjpF005Mgavb3hm6
 TqtCBvURICqyQ9Q/0sUlfxvV5ydFK+nZvurKENzJLqUKQvBztejgWaQQgufHxemHDQsi
 Iszkmmgijm0817aI3rObElmJQljFBRQa7cEdiD+rZb8mFuVjeJP3KsvCgZ6maO7mtF3y
 PCQWirXUYD9b/005j/KgfFNUxi4LYpe9TeMjBlehb2qDDb1Fd8H42RdlfnCFjnKXInEn iQ== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t23cq827v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 13:01:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BAP9hH022941; Mon, 11 Sep 2023 13:01:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t141nakg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 13:01:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38BD1JgV2621976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 13:01:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E77AA58056;
 Mon, 11 Sep 2023 13:01:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1F8C5803F;
 Mon, 11 Sep 2023 13:01:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 11 Sep 2023 13:01:18 +0000 (GMT)
Message-ID: <4d99d39a-c8f7-9531-61f6-2fdac8237eb8@linux.ibm.com>
Date: Mon, 11 Sep 2023 09:01:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/7] hw/tpm: spelling fixes
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230909131258.354675-1-mjt@tls.msk.ru>
 <20230909131258.354675-7-mjt@tls.msk.ru>
 <cc3e0b0f-e4e1-71d0-bddd-f68aa56aa658@tls.msk.ru>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <cc3e0b0f-e4e1-71d0-bddd-f68aa56aa658@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AiydzCq5PgUb6mwkGg9uTy6o90VDJktF
X-Proofpoint-GUID: AiydzCq5PgUb6mwkGg9uTy6o90VDJktF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011
 phishscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 mlxlogscore=858 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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


On 9/11/23 05:54, Michael Tokarev wrote:
>
> Stefan, can you take a quick look please?
>
> https://patchew.org/QEMU/20230909131258.354675-1-mjt@tls.msk.ru/20230909131258.354675-7-mjt@tls.msk.ru/ 
>


I lost subscription to the mailing list for some reason and missed the 
patch, looks good, though.

Thanks.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


>
> Most of this is s/Familiy/Family/ in a few places, I guess it's
> some copy-paste error.
>
> 09.09.2023 16:12, Michael Tokarev:
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   hw/tpm/tpm_tis.h        | 2 +-
>>   hw/tpm/tpm_tis_common.c | 2 +-
>>   hw/tpm/tpm_tis_i2c.c    | 4 ++--
>>   hw/tpm/tpm_tis_isa.c    | 2 +-
>>   hw/tpm/tpm_tis_sysbus.c | 2 +-
>>   5 files changed, 6 insertions(+), 6 deletions(-)
>
> Thanks,
>
> /mjt
>
>

