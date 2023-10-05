Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 861BE7B9BCE
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 10:24:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoJdj-0000UG-GD; Thu, 05 Oct 2023 04:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoJdf-0000Tz-UK
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 04:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoJda-0000Bv-D9
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 04:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696494192;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RRiQxkcjEPeBvP2e2aSvQuwlAXqkr8r74Y44adLbktk=;
 b=Phhnak9FJnaBHeyKjf3D/IOmuOo8dwX0Apts7fM4FF4/sJ/BcYP5elKCq9TF4udy5D8PC1
 9TUl5F1eHDUtcT6gInL4oTCiLPMNqRmC/Tt5uQpNITQHK/sRNONS+uPXkGTj1ZaAQ+T/53
 jujYWqQNFSA8gjNFJX3w1OVPGvm48kU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-XyAryHGwPVKcMjByKLzz4Q-1; Thu, 05 Oct 2023 04:22:55 -0400
X-MC-Unique: XyAryHGwPVKcMjByKLzz4Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40590e6bd67so4921415e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 01:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696494174; x=1697098974;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRiQxkcjEPeBvP2e2aSvQuwlAXqkr8r74Y44adLbktk=;
 b=jQkgn4yZxE10gQNkWNZNManLkAFSDt63cMZzpN98XXv565eCwi+btrMfcnGYjDhfQN
 7bELuAauc6u+o1HScD4LBtUK9d2qMPQqEUMxg1b9YlAWEIhfZA5r3rI1SEEN2QJiEd7f
 R16htvm2Owc+BEKlZg4uOG5MxhGzWrA3CKXHQklRy8pWqBZuQeO4rf5BzWwGY3tBEPBd
 9gL/2y87wV0w+s9eOnH2QDOUowuB9TW6K2ry934Qp9xdkqmsKPIXWd15JNbWvLR24VUo
 zBvwPmYLzK8Du43i85ZRdWcAFXQWSBQKSdxYJBdFOcEbGXb/4WJVLcj0CEUPfbyyroDo
 KdiQ==
X-Gm-Message-State: AOJu0YyMHY7IOYGaiLueb9LmSsVUZ1qVbjmEH3YuNDfnrOM/ATV4rC+6
 NnPqdXo3MnbXyMNTdxMrQqRDPWMBRWoiTmVHKmjmpHbcx0cWpndQ9MBU7EKYjjnXhIJCiSTzi1C
 WUsF8tzJaB48blrM=
X-Received: by 2002:a5d:46c8:0:b0:323:117b:9780 with SMTP id
 g8-20020a5d46c8000000b00323117b9780mr3935958wrs.66.1696494174350; 
 Thu, 05 Oct 2023 01:22:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEera6atsjeYjqibMCGR0DIY10p+qu8k+pvIF3jjJH5A17SmPzWETrrLMbirAySfkkPHBDb2w==
X-Received: by 2002:a5d:46c8:0:b0:323:117b:9780 with SMTP id
 g8-20020a5d46c8000000b00323117b9780mr3935946wrs.66.1696494174013; 
 Thu, 05 Oct 2023 01:22:54 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 q8-20020a05600000c800b00324ae863ac1sm1189981wrx.35.2023.10.05.01.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 01:22:53 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 03/10] migration: Refactor error handling in source
 return path
In-Reply-To: <20231004220240.167175-4-peterx@redhat.com> (Peter Xu's message
 of "Wed, 4 Oct 2023 18:02:33 -0400")
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-4-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 10:22:52 +0200
Message-ID: <87wmw1o4v7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> rp_state.error was a boolean used to show error happened in return path
> thread.  That's not only duplicating error reporting (migrate_set_error),
> but also not good enough in that we only do error_report() and set it to
> true, we never can keep a history of the exact error and show it in
> query-migrate.
>
> To make this better, a few things done:
>
>   - Use error_setg() rather than error_report() across the whole lifecycle
>     of return path thread, keeping the error in an Error*.

Good.

>   - Use migrate_set_error() to apply that captured error to the global
>     migration object when error occured in this thread.

Good.

>   - With above, no need to have mark_source_rp_bad(), remove it, alongside
>     with rp_state.error itself.

Good.

>  uint64_t ram_pagesize_summary(void);
> -int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
> +int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
> +                         Error **errp);


good.

> @@ -1793,37 +1782,36 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
>       */
>      if (!QEMU_IS_ALIGNED(start, our_host_ps) ||
>          !QEMU_IS_ALIGNED(len, our_host_ps)) {
> -        error_report("%s: Misaligned page request, start: " RAM_ADDR_FMT
> -                     " len: %zd", __func__, start, len);
> -        mark_source_rp_bad(ms);
> +        error_setg(errp, "MIG_RP_MSG_REQ_PAGES: Misaligned page request, start:"
> +                   RAM_ADDR_FMT " len: %zd", start, len);
>          return;
>      }
>  
> -    if (ram_save_queue_pages(rbname, start, len)) {
> -        mark_source_rp_bad(ms);
> -    }
> +    ram_save_queue_pages(rbname, start, len, errp);

ram_save_queue_pages() returns an int.
I think this function should return an int.

Next is independent of this patch:

> -static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name)
> +static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
> +                                         Error **errp)
>  {
>      RAMBlock *block = qemu_ram_block_by_name(block_name);
>  
>      if (!block) {
> -        error_report("%s: invalid block name '%s'", __func__, block_name);
> +        error_setg(errp, "MIG_RP_MSG_RECV_BITMAP has invalid block name '%s'",
> +                   block_name);
>          return -EINVAL;

We sent -EINVAL.

>      }
>  
>      /* Fetch the received bitmap and refresh the dirty bitmap */
> -    return ram_dirty_bitmap_reload(s, block);
> +    return ram_dirty_bitmap_reload(s, block, errp);
>  }
>  
> -static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
> +static int migrate_handle_rp_resume_ack(MigrationState *s,
> +                                        uint32_t value, Error **errp)
>  {
>      trace_source_return_path_thread_resume_ack(value);
>  
>      if (value != MIGRATION_RESUME_ACK_VALUE) {
> -        error_report("%s: illegal resume_ack value %"PRIu32,
> -                     __func__, value);
> +        error_setg(errp, "illegal resume_ack value %"PRIu32, value);
>          return -1;

And here -1.

On both callers we just check if it is different from zero.  We never
use the return value as errno, so I think we should move to -1, if there
is an error, that is what errp is for.


> -/* Returns 0 if the RP was ok, otherwise there was an error on the RP */
> -static int await_return_path_close_on_source(MigrationState *ms)
> +static void await_return_path_close_on_source(MigrationState *ms)
>  {
> -    int ret;
> -
>      if (!ms->rp_state.rp_thread_created) {
> -        return 0;
> +        return;
>      }
>  
>      trace_migration_return_path_end_before();
> @@ -2060,18 +2050,10 @@ static int await_return_path_close_on_source(MigrationState *ms)
>          }
>      }
>  
> -    trace_await_return_path_close_on_source_joining();
>      qemu_thread_join(&ms->rp_state.rp_thread);
>      ms->rp_state.rp_thread_created = false;
> -    trace_await_return_path_close_on_source_close();
> -
> -    ret = ms->rp_state.error;
> -    ms->rp_state.error = false;
> -
>      migration_release_dst_files(ms);
> -
> -    trace_migration_return_path_end_after(ret);
> -    return ret;
> +    trace_migration_return_path_end_after();
>  }
>  
>  static inline void
> @@ -2367,7 +2349,10 @@ static void migration_completion(MigrationState *s)
>          goto fail;
>      }
>  
> -    if (await_return_path_close_on_source(s)) {
> +    await_return_path_close_on_source(s);
> +
> +    /* If return path has error, should have been set here */
> +    if (migrate_has_error(s)) {
>          goto fail;
>      }

In general, I think this is bad.  We are moving for

int foo(..)
{

}

....

if (foo()) {
     goto fail;
}

to:

void foo(..)
{

}

....

foo();

if (bar()) {
     goto fail;
}

I would preffer to move the other way around.  Move the error
synchrconously. My plan is that at some point in time
qemu_file_get_error() dissapears, i.e. we return the error when we
receive it and we handle it synchronously.

And yes, that is a something will take a lot of time, but I will hope we
move on that direction, not in trusting more setting internal errors,
use void functions and then check with yet another functions.


On top of your changes:

> -int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
>  {
>      int ret = -EINVAL;
>      /* from_dst_file is always valid because we're within rp_thread */
> @@ -4163,8 +4165,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
>      trace_ram_dirty_bitmap_reload_begin(block->idstr);
>  
>      if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> -        error_report("%s: incorrect state %s", __func__,
> -                     MigrationStatus_str(s->state));
> +        error_setg(errp, "Reload bitmap in incorrect state %s",
> +                   MigrationStatus_str(s->state));
>          return -EINVAL;

return -1

same for the rest of the cases. Callers only check for != 0, and if you
want details, you need to look at errp.

See the nice series for migration/rdma.c for why this is better (and
more consistent).

Rest of the patch is very nice.

Thanks, Juan.


