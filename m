Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C52A7DBBEE
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:38:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTP4-0000YQ-G3; Mon, 30 Oct 2023 10:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxTP3-0000YI-Cw
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:38:05 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxTP0-0000yX-F9
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:38:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E575A1F38C;
 Mon, 30 Oct 2023 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698676680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G8IF9m6OlzcjiQBqXsoAAfrxQtL3rX0xnbMgPNuF9lY=;
 b=YafGJ+7J6FPTtYWL3i/cS/822LaJOafsEl4qI8Kj9VoBeNGxHzdJ13wNCt9K0L5sbGfHKJ
 geuJAoHrHsVfb72K93buC511uW/Vy0ZjT7O4C+tpER3Hkv9BjsuciRK/WxJ6XFR0Q1XS79
 x+obKM/FC0wXh7WQD+NCio4HuVrWNFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698676680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G8IF9m6OlzcjiQBqXsoAAfrxQtL3rX0xnbMgPNuF9lY=;
 b=glSMrgl0mbueQnzClUmP/ywBQjkLg0FZ6COxSACxQUXShVrdQXHJmMaCas8+ThB/TGuPtI
 doaAtI6gDKGi1NBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77F3F138F8;
 Mon, 30 Oct 2023 14:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SvnTEMi/P2VuSQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 30 Oct 2023 14:38:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 10/16] migration/multifd: Enable DSA offloading in
 multifd sender path.
In-Reply-To: <20231025193822.2813204-11-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-11-hao.xiang@bytedance.com>
Date: Mon, 30 Oct 2023 11:37:58 -0300
Message-ID: <87il6onpkp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> Multifd sender path gets an array of pages queued by the migration
> thread. It performs zero page checking on every page in the array.
> The pages are classfied as either a zero page or a normal page. This
> change uses Intel DSA to offload the zero page checking from CPU to
> the DSA accelerator. The sender thread submits a batch of pages to DSA
> hardware and waits for the DSA completion thread to signal for work
> completion.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  migration/multifd.c | 101 +++++++++++++++++++++++++++++++++++++-------
>  migration/multifd.h |   3 ++
>  2 files changed, 89 insertions(+), 15 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 452fb158b8..79fecbd3ae 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -13,6 +13,8 @@
>  #include "qemu/osdep.h"
>  #include "qemu/rcu.h"
>  #include "qemu/cutils.h"
> +#include "qemu/dsa.h"
> +#include "qemu/memalign.h"
>  #include "exec/target_page.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/ramblock.h"
> @@ -555,6 +557,8 @@ void multifd_save_cleanup(void)
>              qemu_thread_join(&p->thread);
>          }
>      }
> +    dsa_stop();
> +    dsa_cleanup();
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>          Error *local_err = NULL;
> @@ -571,6 +575,11 @@ void multifd_save_cleanup(void)
>          p->name = NULL;
>          multifd_pages_clear(p->pages);
>          p->pages = NULL;
> +        g_free(p->addr);
> +        p->addr = NULL;
> +        buffer_zero_batch_task_destroy(p->dsa_batch_task);
> +        qemu_vfree(p->dsa_batch_task);
> +        p->dsa_batch_task = NULL;
>          p->packet_len = 0;
>          g_free(p->packet);
>          p->packet = NULL;
> @@ -675,13 +684,71 @@ int multifd_send_sync_main(QEMUFile *f)
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
> +    assert(!dsa_is_running());
> +
> +    for (int i = 0; i < p->pages->num; i++) {
> +        p->dsa_batch_task->results[i] = buffer_is_zero(buf[i], p->page_size);
> +    }
> +}
> +
> +static void buffer_is_zero_use_dsa(MultiFDSendParams *p)
> +{
> +    assert(!migrate_use_main_zero_page());
> +    assert(dsa_is_running());
> +
> +    buffer_is_zero_dsa_batch_async(p->dsa_batch_task,
> +                                   (const void **)p->addr,
> +                                   p->pages->num,
> +                                   p->page_size);
> +}
> +
> +static void multifd_zero_page_check(MultiFDSendParams *p)
> +{
> +    /* older qemu don't understand zero page on multifd channel */
> +    bool use_multifd_zero_page = !migrate_use_main_zero_page();
> +    bool use_multifd_dsa_accel = dsa_is_running();
> +
> +    RAMBlock *rb = p->pages->block;
> +
> +    for (int i = 0; i < p->pages->num; i++) {
> +        p->addr[i] = (ram_addr_t)(rb->host + p->pages->offset[i]);
> +    }
> +
> +    if (!use_multifd_zero_page || !use_multifd_dsa_accel) {
> +        buffer_is_zero_use_cpu(p);
> +    } else {
> +        buffer_is_zero_use_dsa(p);
> +    }
> +
> +    for (int i = 0; i < p->pages->num; i++) {
> +        uint64_t offset = p->pages->offset[i];
> +        bool zero_page = p->dsa_batch_task->results[i];
> +        set_page(p, zero_page, offset);
> +    }
> +}

You're moving existing (not really, but ok) code and adding dsa support
at the same time. The introduction of this function needs to be in a
separate patch. That would be a preliminary patch that isolates all of
the use_cpu code and a subsequent one that adds the use_dsa part.


