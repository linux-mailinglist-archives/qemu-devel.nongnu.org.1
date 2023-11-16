Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEBE7EE400
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:16:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3e4M-0002nH-Ng; Thu, 16 Nov 2023 10:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r3e4L-0002n8-Bz
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:14:13 -0500
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r3e4J-00037R-B6
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:14:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1CB5D20503;
 Thu, 16 Nov 2023 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700147647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZvz/H1Sb088biJ/2OFIVITRi6gMOy5hqoQiIXH0jPc=;
 b=N7pfOu6OkLdL5ah0MdHWmjZJTrvU/PS+lrinGxDR8Uqo736Pc7XfdQjcFqYH4QWT0MmDCh
 Dm9zM1RAA1bW6GfUXiNQ6cE7XXPpXPMmTpVEZ9xypkoAzumG2snb4hEJU5wRkMyT5/l2/0
 pszOdVaWHOtwb54dmQqTbOVMDuKE/aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700147647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZvz/H1Sb088biJ/2OFIVITRi6gMOy5hqoQiIXH0jPc=;
 b=e9lccflJKBguYHryM9mWtRlxJBgG8GftLNOuJIBREJ7aqm89GjnpxK4BScj9FF6zwFFOpX
 UiiKeGHYEtG7qVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA3B01377E;
 Thu, 16 Nov 2023 15:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NnJnHb4xVmWiTAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 16 Nov 2023 15:14:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peter.maydell@linaro.org,
 quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 04/20] So we use multifd to transmit zero pages.
In-Reply-To: <20231114054032.1192027-5-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-5-hao.xiang@bytedance.com>
Date: Thu, 16 Nov 2023 12:14:04 -0300
Message-ID: <87pm09ennn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> From: Juan Quintela <quintela@redhat.com>
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> ---
>  migration/multifd.c |  7 ++++---
>  migration/options.c | 13 +++++++------
>  migration/ram.c     | 45 ++++++++++++++++++++++++++++++++++++++-------
>  qapi/migration.json |  1 -
>  4 files changed, 49 insertions(+), 17 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 1b994790d5..1198ffde9c 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/rcu.h"
> +#include "qemu/cutils.h"
>  #include "exec/target_page.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/ramblock.h"
> @@ -459,7 +460,6 @@ static int multifd_send_pages(QEMUFile *f)
>      p->packet_num = multifd_send_state->packet_num++;
>      multifd_send_state->pages = p->pages;
>      p->pages = pages;
> -
>      qemu_mutex_unlock(&p->mutex);
>      qemu_sem_post(&p->sem);
>  
> @@ -684,7 +684,7 @@ static void *multifd_send_thread(void *opaque)
>      MigrationThread *thread = NULL;
>      Error *local_err = NULL;
>      /* qemu older than 8.2 don't understand zero page on multifd channel */
> -    bool use_zero_page = !migrate_use_main_zero_page();
> +    bool use_multifd_zero_page = !migrate_use_main_zero_page();
>      int ret = 0;
>      bool use_zero_copy_send = migrate_zero_copy_send();
>  
> @@ -713,6 +713,7 @@ static void *multifd_send_thread(void *opaque)
>              RAMBlock *rb = p->pages->block;
>              uint64_t packet_num = p->packet_num;
>              uint32_t flags;
> +
>              p->normal_num = 0;
>              p->zero_num = 0;
>  
> @@ -724,7 +725,7 @@ static void *multifd_send_thread(void *opaque)
>  
>              for (int i = 0; i < p->pages->num; i++) {
>                  uint64_t offset = p->pages->offset[i];
> -                if (use_zero_page &&
> +                if (use_multifd_zero_page &&

We could have a new function in multifd_ops for zero page
handling. We're already considering an accelerator for the compression
method in the other series[1] and in this series we're adding an
accelerator for zero page checking. It's about time we make the
multifd_ops generic instead of only compression/no compression.

1- [PATCH v2 0/4] Live Migration Acceleration with IAA Compression
https://lore.kernel.org/r/20231109154638.488213-1-yuan1.liu@intel.com

>                      buffer_is_zero(rb->host + offset, p->page_size)) {
>                      p->zero[p->zero_num] = offset;
>                      p->zero_num++;
> diff --git a/migration/options.c b/migration/options.c
> index 00c0c4a0d6..97d121d4d7 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -195,6 +195,7 @@ Property migration_properties[] = {
>      DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
>      DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
>      DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
> +    DEFINE_PROP_MIG_CAP("x-main-zero-page", MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
>      DEFINE_PROP_MIG_CAP("x-background-snapshot",
>              MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT),
>  #ifdef CONFIG_LINUX
> @@ -288,13 +289,9 @@ bool migrate_multifd(void)
>  
>  bool migrate_use_main_zero_page(void)
>  {
> -    //MigrationState *s;
> -
> -    //s = migrate_get_current();
> +    MigrationState *s = migrate_get_current();
>  
> -    // We will enable this when we add the right code.
> -    // return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
> -    return true;
> +    return s->capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];

What happens if we disable main-zero-page while multifd is not enabled?

>  }
>  
>  bool migrate_pause_before_switchover(void)
> @@ -457,6 +454,7 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
>      MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE,
>      MIGRATION_CAPABILITY_RETURN_PATH,
>      MIGRATION_CAPABILITY_MULTIFD,
> +    MIGRATION_CAPABILITY_MAIN_ZERO_PAGE,
>      MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER,
>      MIGRATION_CAPABILITY_AUTO_CONVERGE,
>      MIGRATION_CAPABILITY_RELEASE_RAM,
> @@ -534,6 +532,9 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>              error_setg(errp, "Postcopy is not yet compatible with multifd");
>              return false;
>          }
> +        if (new_caps[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE]) {
> +            error_setg(errp, "Postcopy is not yet compatible with main zero copy");
> +        }

Won't this will breaks compatibility for postcopy? A command that used
to work now will have to disable main-zero-page first.

>      }
>  
>      if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> diff --git a/migration/ram.c b/migration/ram.c
> index 8c7886ab79..f7a42feff2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2059,17 +2059,42 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
>      if (save_zero_page(rs, pss, offset)) {
>          return 1;
>      }
> -
>      /*
> -     * Do not use multifd in postcopy as one whole host page should be
> -     * placed.  Meanwhile postcopy requires atomic update of pages, so even
> -     * if host page size == guest page size the dest guest during run may
> -     * still see partially copied pages which is data corruption.
> +     * Do not use multifd for:
> +     * 1. Compression as the first page in the new block should be posted out
> +     *    before sending the compressed page
> +     * 2. In postcopy as one whole host page should be placed
>       */
> -    if (migrate_multifd() && !migration_in_postcopy()) {
> +    if (!migrate_compress() && migrate_multifd() && !migration_in_postcopy()) {
> +        return ram_save_multifd_page(pss->pss_channel, block, offset);
> +    }

This could go into ram_save_target_page_multifd like so:

if (!migrate_compress() && !migration_in_postcopy() && !migration_main_zero_page()) {
    return ram_save_multifd_page(pss->pss_channel, block, offset);
} else {
  return ram_save_target_page_legacy();
}

> +
> +    return ram_save_page(rs, pss);
> +}
> +
> +/**
> + * ram_save_target_page_multifd: save one target page
> + *
> + * Returns the number of pages written
> + *
> + * @rs: current RAM state
> + * @pss: data about the page we want to send
> + */
> +static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
> +{
> +    RAMBlock *block = pss->block;
> +    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> +    int res;
> +
> +    if (!migration_in_postcopy()) {
>          return ram_save_multifd_page(pss->pss_channel, block, offset);
>      }
>  
> +    res = save_zero_page(rs, pss, offset);
> +    if (res > 0) {
> +        return res;
> +    }
> +
>      return ram_save_page(rs, pss);
>  }
>  
> @@ -2982,9 +3007,15 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>      }
>  
>      migration_ops = g_malloc0(sizeof(MigrationOps));
> -    migration_ops->ram_save_target_page = ram_save_target_page_legacy;
> +
> +    if (migrate_multifd() && !migrate_use_main_zero_page()) {
> +        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
> +    } else {
> +        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
> +    }

This should not check main-zero-page. Just have multifd vs. legacy and
have the multifd function defer to _legacy if main-zero-page or
in_postcopy.

>  
>      qemu_mutex_unlock_iothread();
> +
>      ret = multifd_send_sync_main(f);
>      qemu_mutex_lock_iothread();
>      if (ret < 0) {
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 09e4393591..9783289bfc 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -531,7 +531,6 @@
>  #     and can result in more stable read performance.  Requires KVM
>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>  #
> -#
>  # @main-zero-page: If enabled, the detection of zero pages will be
>  #                  done on the main thread.  Otherwise it is done on
>  #                  the multifd threads.

