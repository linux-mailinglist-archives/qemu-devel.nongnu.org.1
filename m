Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D6470DCA3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RBU-0006qN-GY; Tue, 23 May 2023 08:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1q1RBK-0006q4-T7; Tue, 23 May 2023 08:32:03 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1q1RBG-000147-0L; Tue, 23 May 2023 08:32:02 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 21DA946974;
 Tue, 23 May 2023 14:31:43 +0200 (CEST)
Message-ID: <5023cb18-9e9a-4666-e6b5-a7eb0e8dbd6c@proxmox.com>
Date: Tue, 23 May 2023 14:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 09/12] migration: Use migration_transferred_bytes() to
 calculate rate_limit
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Halil Pasic <pasic@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Peter Xu <peterx@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230518171304.95006-1-quintela@redhat.com>
 <20230518171304.95006-10-quintela@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20230518171304.95006-10-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Am 18.05.23 um 19:13 schrieb Juan Quintela:
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index feec7d7369..97759a45f3 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -24,7 +24,9 @@ bool migration_rate_exceeded(QEMUFile *f)
>          return true;
>      }
>  
> -    uint64_t rate_limit_used = stat64_get(&mig_stats.rate_limit_used);
> +    uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
> +    uint64_t rate_limit_current = migration_transferred_bytes(f);
> +    uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
>      uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);
>  
>      if (rate_limit_max == RATE_LIMIT_DISABLED) {

Hi,
just wanted to let you know that the call to
migration_transferred_bytes(f) here can introduce a huge performance
penalty when taking a snapshot. I ran into the issue when testing
something else, with a single-disk snapshot. Without this call it takes
about two seconds, with the call about two minutes.

Best Regards,
Fiona


