Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E067A2212
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:13:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAVM-0003Rn-W8; Fri, 15 Sep 2023 11:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qhAVK-0003Oi-1F; Fri, 15 Sep 2023 11:13:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qhAVD-0002qq-I7; Fri, 15 Sep 2023 11:13:09 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38FF7RhX001290; Fri, 15 Sep 2023 15:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3rL+PgYMavuWtXtIUs08z44CzPNrgXcgFex6uW/WezM=;
 b=ZN6ISjfn0xO4d9hW76No012ZMKhmzavupO3ocvdGMo6p5DvJvfA/akuWsSbG6Z+E7HS3
 njMygIlYQdJMHVqXFo9l8mmWyc5zSZ9gKW5421qEu38sjMRew/HADgOjMzx0/tM8Inab
 7jPxQLP6QbKJ6KC+c9tHb46WOaljeopdV6qPzzIZ3Y0gHiceK5GbMp9W2tk9717a4LTg
 td5lbCJYNCimUUqaQalrJpA87TfuyNShon0H55CH4y87BB/A1DISbvNsLLMDJ+YgBE/M
 N3WRU5YVF9meatLxGwzz0f0nu321IXoR/AyeSdqZir4NgH/9918OFdBGz5xv3jv3fq3M jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4s63s40a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 15:12:42 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38FF7dIH004206;
 Fri, 15 Sep 2023 15:12:41 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4s63s400-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 15:12:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38FEVcFj011942; Fri, 15 Sep 2023 15:12:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r2m7j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 15:12:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38FFCdP926345854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 15:12:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2F4D58066;
 Fri, 15 Sep 2023 15:12:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B883E58063;
 Fri, 15 Sep 2023 15:12:34 +0000 (GMT)
Received: from [9.79.181.197] (unknown [9.79.181.197])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Sep 2023 15:12:34 +0000 (GMT)
Message-ID: <76e01d80-c1ff-6a7c-9f2d-3fa2e02b7144@linux.ibm.com>
Date: Fri, 15 Sep 2023 20:42:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/4] accel/tcg: Remove unused tcg_flush_jmp_cache() stub
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
References: <20230914195229.78244-1-philmd@linaro.org>
 <20230914195229.78244-3-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230914195229.78244-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HWZAubNdNqEnXDwSVZFHgkhkHIZLGmPF
X-Proofpoint-GUID: tut3qvJtJEuXdTVdgVmRiq90SVuZXzPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_11,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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



On 9/15/23 01:22, Philippe Mathieu-Daudé wrote:
> Since commit ba7d3d1858 ("cpu_common_reset: wrap TCG
> specific code in tcg_enabled()") we protect the single call
> to tcg_flush_jmp_cache() with a check on tcg_enabled(). The
> stub isn't needed anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit log might need rephrase as I see multiple instance of call,
with one without check for tcg_enabled() in plugin_cpu_update__async but 
seems to be building only with tcg enabled so no build breaks.

Thanks
Harsh
> ---
>   accel/stubs/tcg-stub.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index f088054f34..dd890d6cf6 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -18,10 +18,6 @@ void tb_flush(CPUState *cpu)
>   {
>   }
>   
> -void tcg_flush_jmp_cache(CPUState *cpu)
> -{
> -}
> -
>   int probe_access_flags(CPUArchState *env, vaddr addr, int size,
>                          MMUAccessType access_type, int mmu_idx,
>                          bool nonfault, void **phost, uintptr_t retaddr)

