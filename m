Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB3704467
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 06:51:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pymdS-0005fw-TI; Tue, 16 May 2023 00:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1pymdO-0005fC-T0; Tue, 16 May 2023 00:50:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1pymdN-0002Lj-2N; Tue, 16 May 2023 00:50:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G4d0Rn024683; Tue, 16 May 2023 04:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qFWOHC5LaV5JMnzJtrXoyydAUNv+HaN91FaxExWFWnU=;
 b=qfNwKJQPkABaURaxEI+CsjB0uhzI7KFmv3XV7vKKZDfO69JRLGBM1lmog9dfmIfU7V2K
 wCzTiec9BkRQ3071k+Bd6t71ynwlnK5KZzj7mdiWWIJf5wAzJWQH/AnAGHufvJmfpq0n
 NHiWmvWKZ3WWyUNPCe3nN2JmIztI8A1Y+ltW01kIPieeZNMuM8K8VWq3+LkgwxEGEjJO
 R4pkdgtcAuwRabSLzeHW2beRMQMYoaxb0kivTl5mccgfRpwR793q6c0B2cMNATpc5MEv
 3ufta9mr1Red6l4X/J3u+JUZs2NBMIMWgnivr6Yy7wvUjc4A3QD5Qi8uVzM8x5RNxp9u Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm2am8w8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 04:49:39 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34G4gV5i004165;
 Tue, 16 May 2023 04:49:39 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm2am8w7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 04:49:39 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G1UPMC025232;
 Tue, 16 May 2023 04:49:38 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
 by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3qj265td6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 04:49:37 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34G4na3U3342978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 04:49:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B3E45806A;
 Tue, 16 May 2023 04:49:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C3A658065;
 Tue, 16 May 2023 04:49:28 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 May 2023 04:49:28 +0000 (GMT)
Message-ID: <0e2f97ca-621e-7530-e697-99af208eb043@linux.ibm.com>
Date: Tue, 16 May 2023 10:19:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 01/16] migration: Don't use INT64_MAX for unlimited rate
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-2-quintela@redhat.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230515195709.63843-2-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hHKPuwfZ6cRYWVQjUzknrTB2AF3ZPr9h
X-Proofpoint-GUID: TQ8_k1ahaICWrx6ajWYhwP-LKWpo6XsH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160038
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 5/16/23 01:26, Juan Quintela wrote:
> Define and use RATE_LIMIT_MAX instead.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   migration/migration-stats.h | 6 ++++++
>   migration/migration.c       | 4 ++--
>   migration/qemu-file.c       | 6 +++++-
>   3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index cf8a4f0410..e782f1b0df 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -15,6 +15,12 @@
>   
>   #include "qemu/stats64.h"
>   
> +/*
> + * If rate_limit_max is 0, there is special code to remove the rate
                         .. there is a check in qemu_file_rate_limit() ..
> + * limit.
> + */
> +#define RATE_LIMIT_MAX 0
> +
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   /*
>    * These are the ram migration statistic counters.  It is loosely
>    * based on MigrationStats.  We change to Stat64 any counter that
> diff --git a/migration/migration.c b/migration/migration.c
> index 039bba4804..c41c7491bb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2304,7 +2304,7 @@ static void migration_completion(MigrationState *s)
>                    * them if migration fails or is cancelled.
>                    */
>                   s->block_inactive = !migrate_colo();
> -                qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
> +                qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
>                   ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
>                                                            s->block_inactive);
>               }
> @@ -3048,7 +3048,7 @@ static void *bg_migration_thread(void *opaque)
>       rcu_register_thread();
>       object_ref(OBJECT(s));
>   
> -    qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
> +    qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
>   
>       setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>       /*
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 597054759d..4bc875b452 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -27,6 +27,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/iov.h"
>   #include "migration.h"
> +#include "migration-stats.h"
>   #include "qemu-file.h"
>   #include "trace.h"
>   #include "options.h"
> @@ -732,7 +733,10 @@ int qemu_file_rate_limit(QEMUFile *f)
>       if (qemu_file_get_error(f)) {
>           return 1;
>       }
> -    if (f->rate_limit_max > 0 && f->rate_limit_used > f->rate_limit_max) {
> +    if (f->rate_limit_max == RATE_LIMIT_MAX) {
> +        return 0;
> +    }
> +    if (f->rate_limit_used > f->rate_limit_max) {
>           return 1;
>       }
>       return 0;

