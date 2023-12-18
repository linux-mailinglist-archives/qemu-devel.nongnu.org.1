Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1041B816550
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 04:21:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF4Bf-0003uh-GY; Sun, 17 Dec 2023 22:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rF4Bd-0003uZ-3j
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 22:20:57 -0500
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rF4Bb-0000Qe-0d
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 22:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702869655; x=1734405655;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=u1uRzvuE9t2vnWrWvuPdu/awcTk5hNka/Ai9fGHVNm8=;
 b=eLuJ7vV0Kuk2CNpftVadCRVxGBbMmwAh3S9/q+LgJymdY9AZwv0urofu
 z+XLXJvfkG9hdJMyhGKkNAmok/oGdtsGMeMJKwrtg7dKhUvvaqrHqBMl4
 ePfRjnSlZbd3ukeO/bP7ewOacGMfanOjP0OVUumkHQM6UQ4lk1nwSdw3W
 zecmgHOg+EH/gM4eLRLC0Y6lXlg9j8LOaNb9FWvxQ7BZDNabQQLANfbS6
 /e+RnGIgoHbF7EJUU7CJwyA4Lv0OiUIVsAz3/Vg6oQZVgVOomPEiD8jRh
 iaTsEKsfEBdpKjYN2u/Cth8HZBj10zReRuqXTqKxXpWTfqPMrJOHGCukQ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="375603714"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; d="scan'208";a="375603714"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2023 19:20:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="804385240"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; d="scan'208";a="804385240"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.93.5.108])
 ([10.93.5.108])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2023 19:20:50 -0800
Message-ID: <3a309e76-be33-4226-b341-567d2791dbfe@intel.com>
Date: Mon, 18 Dec 2023 11:20:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] migration/multifd: Prepare to introduce DSA
 acceleration on the multifd path.
Content-Language: en-US
To: Hao Xiang <hao.xiang@bytedance.com>, farosas@suse.de,
 peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-14-hao.xiang@bytedance.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <20231114054032.1192027-14-hao.xiang@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.086,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/14/2023 13:40, Hao Xiang wrote:> 1. Refactor multifd_send_thread function.
> 2. Implement buffer_is_zero_use_cpu to handle CPU based zero page
> checking.
> 3. Introduce the batch task structure in MultiFDSendParams.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  migration/multifd.c | 82 ++++++++++++++++++++++++++++++++++++---------
>  migration/multifd.h |  3 ++
>  2 files changed, 70 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 1198ffde9c..68ab97f918 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -14,6 +14,8 @@
>  #include "qemu/cutils.h"
>  #include "qemu/rcu.h"
>  #include "qemu/cutils.h"
> +#include "qemu/dsa.h"
> +#include "qemu/memalign.h"
>  #include "exec/target_page.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/ramblock.h"
> @@ -574,6 +576,11 @@ void multifd_save_cleanup(void)
>          p->name = NULL;
>          multifd_pages_clear(p->pages);
>          p->pages = NULL;
> +        g_free(p->addr);
> +        p->addr = NULL;
> +        buffer_zero_batch_task_destroy(p->batch_task);
> +        qemu_vfree(p->batch_task);
> +        p->batch_task = NULL;
>          p->packet_len = 0;
>          g_free(p->packet);
>          p->packet = NULL;
> @@ -678,13 +685,66 @@ int multifd_send_sync_main(QEMUFile *f)
>      return 0;
>  }
>  
> +static void set_page(MultiFDSendParams *p, bool zero_page, uint64_t offset)
> +{
> +    RAMBlock *rb = p->pages->block;
> +    if (zero_page) {
> +        p->zero[p->zero_num] = offset;
> +        p->zero_num++;
> +        ram_release_page(rb->idstr, offset);
> +    } else {
> +        p->normal[p->normal_num] = offset;
> +        p->normal_num++;
> +    }
> +}
> +
> +static void buffer_is_zero_use_cpu(MultiFDSendParams *p)
> +{
> +    const void **buf = (const void **)p->addr;
> +    assert(!migrate_use_main_zero_page());
> +
> +    for (int i = 0; i < p->pages->num; i++) {
> +        p->batch_task->results[i] = buffer_is_zero(buf[i], p->page_size);
> +    }
> +}
> +
> +static void set_normal_pages(MultiFDSendParams *p)
> +{
> +    for (int i = 0; i < p->pages->num; i++) {
> +        p->batch_task->results[i] = false;
> +    }
> +}
> +
> +static void multifd_zero_page_check(MultiFDSendParams *p)
> +{
> +    /* older qemu don't understand zero page on multifd channel */
> +    bool use_multifd_zero_page = !migrate_use_main_zero_page();
> +
> +    RAMBlock *rb = p->pages->block;
> +
> +    for (int i = 0; i < p->pages->num; i++) {
> +        p->addr[i] = (ram_addr_t)(rb->host + p->pages->offset[i]);
> +    }
> +
> +    if (use_multifd_zero_page) {
> +        buffer_is_zero_use_cpu(p);
> +    } else {
> +        // No zero page checking. All pages are normal pages.

Please pay attention to the comment style here and in other patches.

> +        set_normal_pages(p);
> +    }
> +
> +    for (int i = 0; i < p->pages->num; i++) {
> +        uint64_t offset = p->pages->offset[i];
> +        bool zero_page = p->batch_task->results[i];
> +        set_page(p, zero_page, offset);
> +    }
> +}
> +
>  static void *multifd_send_thread(void *opaque)
>  {
>      MultiFDSendParams *p = opaque;
>      MigrationThread *thread = NULL;
>      Error *local_err = NULL;
> -    /* qemu older than 8.2 don't understand zero page on multifd channel */
> -    bool use_multifd_zero_page = !migrate_use_main_zero_page();
>      int ret = 0;
>      bool use_zero_copy_send = migrate_zero_copy_send();
>  
> @@ -710,7 +770,6 @@ static void *multifd_send_thread(void *opaque)
>          qemu_mutex_lock(&p->mutex);
>  
>          if (p->pending_job) {
> -            RAMBlock *rb = p->pages->block;
>              uint64_t packet_num = p->packet_num;
>              uint32_t flags;
>  
> @@ -723,18 +782,7 @@ static void *multifd_send_thread(void *opaque)
>                  p->iovs_num = 1;
>              }
>  
> -            for (int i = 0; i < p->pages->num; i++) {
> -                uint64_t offset = p->pages->offset[i];
> -                if (use_multifd_zero_page &&
> -                    buffer_is_zero(rb->host + offset, p->page_size)) {
> -                    p->zero[p->zero_num] = offset;
> -                    p->zero_num++;
> -                    ram_release_page(rb->idstr, offset);
> -                } else {
> -                    p->normal[p->normal_num] = offset;
> -                    p->normal_num++;
> -                }
> -            }
> +            multifd_zero_page_check(p);
>  
>              if (p->normal_num) {
>                  ret = multifd_send_state->ops->send_prepare(p, &local_err);
> @@ -976,6 +1024,10 @@ int multifd_save_setup(Error **errp)
>          p->pending_job = 0;
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);
> +        p->addr = g_new0(ram_addr_t, page_count);
> +        p->batch_task =
> +            (struct buffer_zero_batch_task *)qemu_memalign(64, sizeof(*p->batch_task));
> +        buffer_zero_batch_task_init(p->batch_task, page_count);
>          p->packet_len = sizeof(MultiFDPacket_t)
>                        + sizeof(uint64_t) * page_count;
>          p->packet = g_malloc0(p->packet_len);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 13762900d4..62f31b03c0 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -119,6 +119,9 @@ typedef struct {
>       * pending_job != 0 -> multifd_channel can use it.
>       */
>      MultiFDPages_t *pages;
> +    /* Address of each pages in pages */

s/pages/page

> +    ram_addr_t *addr;

I think there is not need to introduce this variable since is can be simply
derived by:

	p->addr[i] = (ram_addr_t)(rb->host + p->pages->offset[i]);

and it is useless when we check the zero page in main thread (main-zero-page=y)

> +    struct buffer_zero_batch_task *batch_task;
>  
>      /* thread local variables. No locking required */
>  

