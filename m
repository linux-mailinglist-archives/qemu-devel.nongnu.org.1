Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A71AD765313
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 14:00:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOzST-0006N2-EN; Thu, 27 Jul 2023 07:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qOzSQ-0006Ll-DB; Thu, 27 Jul 2023 07:47:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qOzSO-0005eM-GQ; Thu, 27 Jul 2023 07:47:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RBiOwN003520; Thu, 27 Jul 2023 11:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MMVLndyLbco5i3g7r+xTy3pnH56VJtdXLxYJ949iWs4=;
 b=XDxnnnPFW4beTKtyNecgN4ddZU8QShb4s5vvK8D8t1juI2y4+U5BlnAdIl+z36Rrz8B9
 TRYMKfTbHdJKQZDGEN0FVdf6NJYzmhhLiRnGSIHonxj+Rb1szVTVgS54jbi7wvk3oY7U
 GPHuaWt3hk6gJAFqzbxxt+7CRmvYDoPwiL84xurWjv39AVCOsvln+Ioxux2sT0kn+TP4
 gQ6KL/luSA6W08hWkfX8GcOtl3k1fuc4ebtf22eNjz7D9j6BQN5DALt7oB4ZgT8Y5Hjo
 ScqtPi3CcDsi+vLlL4KvuJYi3hjAr5XRRoWlN/aodV9VAUUjJKurPX1GbAmFL1PNaPbh PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3qyfr1jg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 11:46:49 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RBjSiq005984;
 Thu, 27 Jul 2023 11:46:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3qyfr1j3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 11:46:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RAMc5u014365; Thu, 27 Jul 2023 11:46:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0stydew9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 11:46:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36RBkmkJ26215008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jul 2023 11:46:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E929758065;
 Thu, 27 Jul 2023 11:46:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A91458052;
 Thu, 27 Jul 2023 11:46:47 +0000 (GMT)
Received: from [9.61.104.64] (unknown [9.61.104.64])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Jul 2023 11:46:47 +0000 (GMT)
Message-ID: <648eecec-3035-22a5-3040-cd9906534d29@linux.ibm.com>
Date: Thu, 27 Jul 2023 07:46:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] block/file-posix: fix g_file_get_contents return path
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: dlemoal@kernel.org, dmitry.fomichev@wdc.com, hare@suse.de,
 qemu-block@nongnu.org
References: <20230604061658.49004-1-faithilikerun@gmail.com>
 <96628b6b-a9e9-c817-7d2a-211bb47f5eb5@linux.ibm.com>
In-Reply-To: <96628b6b-a9e9-c817-7d2a-211bb47f5eb5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mGfo27wDcFmfaBvHQwdSDQEo6AFz2L2q
X-Proofpoint-GUID: 6s-TU1xJpfu-SZy1Q3nauIfzholrWKMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270103
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/5/23 10:54 AM, Matthew Rosato wrote:
> On 6/4/23 2:16 AM, Sam Li wrote:
>> The g_file_get_contents() function returns a g_boolean. If it fails, the
>> returned value will be 0 instead of -1. Solve the issue by skipping
>> assigning ret value.
>>
>> This issue was found by Matthew Rosato using virtio-blk-{pci,ccw} backed
>> by an NVMe partition e.g. /dev/nvme0n1p1 on s390x.
>>
>> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> 
> Polite ping on this patch -- this issue still exists in master as of today and this patch resolves it for me.  Just want to make sure it gets into 8.1
> 

Ping -- I can still reproduce this crash on -rc1.  Any chance this patch can get picked up for the 8.1 release?

@Sam I see you sent a v2 of only patch #2 in this series ('block/file-posix: fix wps checking in raw_co_prw')..  I wonder if this one just got forgotten since it wasn't sent as part of v2.  Maybe try a resend of this patch by itself (plus the review tags added)?

Thanks,
Matt

> 
>> ---
>>  block/file-posix.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index ac1ed54811..0d9d179a35 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -1232,7 +1232,6 @@ static int hdev_get_max_hw_transfer(int fd, struct stat *st)
>>  static int get_sysfs_str_val(struct stat *st, const char *attribute,
>>                               char **val) {
>>      g_autofree char *sysfspath = NULL;
>> -    int ret;
>>      size_t len;
>>  
>>      if (!S_ISBLK(st->st_mode)) {
>> @@ -1242,8 +1241,7 @@ static int get_sysfs_str_val(struct stat *st, const char *attribute,
>>      sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/%s",
>>                                  major(st->st_rdev), minor(st->st_rdev),
>>                                  attribute);
>> -    ret = g_file_get_contents(sysfspath, val, &len, NULL);
>> -    if (ret == -1) {
>> +    if (!g_file_get_contents(sysfspath, val, &len, NULL)) {
>>          return -ENOENT;
>>      }
>>  
>> @@ -1253,7 +1251,7 @@ static int get_sysfs_str_val(struct stat *st, const char *attribute,
>>      if (*(p + len - 1) == '\n') {
>>          *(p + len - 1) = '\0';
>>      }
>> -    return ret;
>> +    return 0;
>>  }
>>  #endif
>>  
> 
> 


