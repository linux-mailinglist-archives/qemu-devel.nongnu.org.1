Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE97486F7
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3tr-00012Q-Mq; Wed, 05 Jul 2023 10:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qH3tp-00010M-QM; Wed, 05 Jul 2023 10:54:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qH3tn-0005C3-UE; Wed, 05 Jul 2023 10:54:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365ElGfa025131; Wed, 5 Jul 2023 14:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5EcbGLiAS27e6YrPvxrZ/zZwp5TJxanTNX8WdJ0MeSE=;
 b=G/uMO4dhAFSvk+tsWtjWU4PJEEo3E0EKt+bilesKMnDW45ZKf1SSGE3kwSUeYZZ17cU6
 jQDnQzbGG8FHsP3A3rlcG0QtU8iTHYTVk2UB1VRvr13nsN5p5Wev4Jd3ZPi2dUqWibCe
 Ur9XfVa8ND7whnbeARKYekfo5CWlZy6rrN7pTi7jnuk6DNcK2oTxIVhN02l8VY2A3jU7
 1yHORxdWxsMsEzP194D8egMKIdXgCgKZtP42gQWlbTSf8CixJzcB6N+/xNI7VgDZsc+k
 5/WEpxvL/fuDGVsUeiI3MXklz7Tgju/7oN8l2alHOCDFeZwz1lr+w3QZMDrjOp29jRY9 XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak4074y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 14:54:27 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365EnijE004352;
 Wed, 5 Jul 2023 14:54:26 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak4074e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 14:54:26 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 365CKgve016327;
 Wed, 5 Jul 2023 14:54:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
 by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3rjbs6fee3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 14:54:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 365EsO7459638240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Jul 2023 14:54:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2807B58059;
 Wed,  5 Jul 2023 14:54:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14E5658063;
 Wed,  5 Jul 2023 14:54:23 +0000 (GMT)
Received: from [9.61.162.136] (unknown [9.61.162.136])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Jul 2023 14:54:22 +0000 (GMT)
Message-ID: <96628b6b-a9e9-c817-7d2a-211bb47f5eb5@linux.ibm.com>
Date: Wed, 5 Jul 2023 10:54:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] block/file-posix: fix g_file_get_contents return path
Content-Language: en-US
To: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, dmitry.fomichev@wdc.com, stefanha@redhat.com,
 hare@suse.de, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20230604061658.49004-1-faithilikerun@gmail.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230604061658.49004-1-faithilikerun@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mkr8JAmKGqw4c0vUIL-lwridoB6D7iyN
X-Proofpoint-GUID: rjQpk0Km68f0hNEaI8LCZLH9gmZrhNBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_06,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050131
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/4/23 2:16 AM, Sam Li wrote:
> The g_file_get_contents() function returns a g_boolean. If it fails, the
> returned value will be 0 instead of -1. Solve the issue by skipping
> assigning ret value.
> 
> This issue was found by Matthew Rosato using virtio-blk-{pci,ccw} backed
> by an NVMe partition e.g. /dev/nvme0n1p1 on s390x.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>

Polite ping on this patch -- this issue still exists in master as of today and this patch resolves it for me.  Just want to make sure it gets into 8.1

Thanks,
Matt

> ---
>  block/file-posix.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index ac1ed54811..0d9d179a35 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1232,7 +1232,6 @@ static int hdev_get_max_hw_transfer(int fd, struct stat *st)
>  static int get_sysfs_str_val(struct stat *st, const char *attribute,
>                               char **val) {
>      g_autofree char *sysfspath = NULL;
> -    int ret;
>      size_t len;
>  
>      if (!S_ISBLK(st->st_mode)) {
> @@ -1242,8 +1241,7 @@ static int get_sysfs_str_val(struct stat *st, const char *attribute,
>      sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/%s",
>                                  major(st->st_rdev), minor(st->st_rdev),
>                                  attribute);
> -    ret = g_file_get_contents(sysfspath, val, &len, NULL);
> -    if (ret == -1) {
> +    if (!g_file_get_contents(sysfspath, val, &len, NULL)) {
>          return -ENOENT;
>      }
>  
> @@ -1253,7 +1251,7 @@ static int get_sysfs_str_val(struct stat *st, const char *attribute,
>      if (*(p + len - 1) == '\n') {
>          *(p + len - 1) = '\0';
>      }
> -    return ret;
> +    return 0;
>  }
>  #endif
>  


