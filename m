Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 830B27BCE3D
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 13:41:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpS8A-0000ZU-E5; Sun, 08 Oct 2023 07:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpS83-0000YV-38
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 07:39:23 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpS80-0003Rq-Kn
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 07:39:22 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9b9faf05f51so386576366b.2
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696765158; x=1697369958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BE2Zl2W/41pxXEop0ddPmO4Xpt+rXCIJhPcbT3/SKVM=;
 b=wlS2W1bWkGiulU4g4po0HTd5B2J6V2R33C99kCfmVFcrayh72Vt1hgkE3yEwfQr8+b
 Hgr0F9z/79jC5q/kEg7glrzvFqcTrAQN8Y6WtP5QmX4uIabtwqIW57hkJ9UQc2ZDjWDY
 3pwJSeJ27olUD8IlTgvEjtzePt7ZXDZc67Xzo6yM1aVUw5wQr4wmUyRvS7keeSg5iMKk
 oCt5eKzLhB+zTJ4AJ8v8o98si5gBRFk9SBXaMc+tOVraCdYKZcYYo3lPrd/tanXJfQ19
 c9wMcViTtmpt0aG3IUbf6STY+9dhl+mNptuRfR7ChWBNEDRBHLkZZeNdqrdzAAKSZhSz
 gesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696765158; x=1697369958;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BE2Zl2W/41pxXEop0ddPmO4Xpt+rXCIJhPcbT3/SKVM=;
 b=CTV1f2xaD6M9kzpAMH6sraot5ZWncV3nl8wFQl3u65SDMPynU2WbLXKG5sT7Nyqmw0
 jsBM9Ayew8Uag5gaAQHf2Wt1VU5WyztZpe2QImjQrrod1MZuoCYptQJ4VHfGtA3i0crX
 8qtxjEjSRUd2rsTQTRrbrAfdZN1hHrCPwlCFhdh8kFPttBQmWbzn5qwe/zl8/Ty5B0Tj
 xfFbdp7ijf6mcjb+6bkc3Kz8MA7A2w0a3PQdmKEh4DUyTh6i8bN4xOZ7a1c/v2sEoeJi
 Xhr2WODbmqt9XiHo1Zv35VTwhcWakmpe5dCSV3I/GzZsr6Y5R7W+P83KSGpYgAgyOidV
 2mHw==
X-Gm-Message-State: AOJu0YwNaOf7Xccr1gxARMtsfwb82RNH9cOtFOW442A4c9Ip9CkwcU3z
 ewE7nhJEA5Ztdzn96smRcypcdQ==
X-Google-Smtp-Source: AGHT+IHvgy4LcoA/6545hxwMkEyYEXyMbRQFDKBFYVgpEGZCGqbLZ4z8vVqw/qRJ/WQZhacFmnnM3w==
X-Received: by 2002:a17:907:77c5:b0:9ad:e180:16e3 with SMTP id
 kz5-20020a17090777c500b009ade18016e3mr11598305ejc.37.1696765158338; 
 Sun, 08 Oct 2023 04:39:18 -0700 (PDT)
Received: from [192.168.69.115] (4rc44-h01-176-171-215-42.dsl.sta.abo.bbox.fr.
 [176.171.215.42]) by smtp.gmail.com with ESMTPSA id
 n25-20020a170906841900b0099d9dee8108sm5582689ejx.149.2023.10.08.04.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 04:39:17 -0700 (PDT)
Message-ID: <bb34f0ec-06b4-c635-dce9-385c3b87c57e@linaro.org>
Date: Sun, 8 Oct 2023 13:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 03/10] migration: Refactor error handling in source
 return path
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-4-peterx@redhat.com>
 <f60f3687-d778-3d8e-41f6-39fbcad8f0f8@linaro.org> <ZR7e3cmxCH9LAdnS@x1n>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZR7e3cmxCH9LAdnS@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/10/23 18:05, Peter Xu wrote:
> On Thu, Oct 05, 2023 at 08:11:33AM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Peter,
>>
>> On 5/10/23 00:02, Peter Xu wrote:
>>> rp_state.error was a boolean used to show error happened in return path
>>> thread.  That's not only duplicating error reporting (migrate_set_error),
>>> but also not good enough in that we only do error_report() and set it to
>>> true, we never can keep a history of the exact error and show it in
>>> query-migrate.
>>>
>>> To make this better, a few things done:
>>>
>>>     - Use error_setg() rather than error_report() across the whole lifecycle
>>>       of return path thread, keeping the error in an Error*.
>>>
>>>     - Use migrate_set_error() to apply that captured error to the global
>>>       migration object when error occured in this thread.
>>>
>>>     - With above, no need to have mark_source_rp_bad(), remove it, alongside
>>>       with rp_state.error itself.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    migration/migration.h  |   1 -
>>>    migration/ram.h        |   5 +-
>>>    migration/migration.c  | 123 ++++++++++++++++++-----------------------
>>>    migration/ram.c        |  41 +++++++-------
>>>    migration/trace-events |   4 +-
>>>    5 files changed, 79 insertions(+), 95 deletions(-)
>>
>>
>>> -int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
>>> +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
>>>    {
>>>        int ret = -EINVAL;
>>>        /* from_dst_file is always valid because we're within rp_thread */
>>
>>
>>> @@ -4193,16 +4194,16 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
>>>        ret = qemu_file_get_error(file);
>>>        if (ret || size != local_size) {
>>> -        error_report("%s: read bitmap failed for ramblock '%s': %d"
>>> -                     " (size 0x%"PRIx64", got: 0x%"PRIx64")",
>>> -                     __func__, block->idstr, ret, local_size, size);
>>> +        error_setg(errp, "read bitmap failed for ramblock '%s': %d"
>>> +                   " (size 0x%"PRIx64", got: 0x%"PRIx64")",
>>> +                   block->idstr, ret, local_size, size);
>>>            ret = -EIO;
>>>            goto out;
>>>        }
>>>        if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
>>> -        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIx64,
>>> -                     __func__, block->idstr, end_mark);
>>> +        error_setg(errp, "ramblock '%s' end mark incorrect: 0x%"PRIx64,
>>> +                   block->idstr, end_mark);
>>>            ret = -EINVAL;
>>>            goto out;
>>>        }
>>
>> This function returns -EIO/-EINVAL errors, propagated to its 2 callers
>>   - migrate_handle_rp_recv_bitmap()
>>   - migrate_handle_rp_resume_ack()
> 
> It was only called in migrate_handle_rp_recv_bitmap(), but I think I see
> what you meant..
> 
>> which are only used in source_return_path_thread() where the return
>> value is only checked as boolean.
>>
>> Could we simplify them returning a boolean (which is the pattern with
>> functions taking an Error** as last parameter)?
> 
> Yes, with errp passed in, the "int" retcode is slightly duplicated.  I can
> add one more patch on top of this as further cleanup, as below.
> 
> Thanks,
> 
> ===8<===
>  From b1052befd72beb129012afddf5647339fe4e257c Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 5 Oct 2023 12:03:44 -0400
> Subject: [PATCH] migration: Change ram_dirty_bitmap_reload() retval to bool
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Now we have a Error** passed into the return path thread stack, which is
> even clearer than an int retval.  Change ram_dirty_bitmap_reload() and the
> callers to use a bool instead to replace errnos.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/ram.h       |  2 +-
>   migration/migration.c | 18 +++++++++---------
>   migration/ram.c       | 24 +++++++++++-------------
>   3 files changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/migration/ram.h b/migration/ram.h
> index 14ed666d58..af0290f8ab 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -72,7 +72,7 @@ void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
>   void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
>   int64_t ramblock_recv_bitmap_send(QEMUFile *file,
>                                     const char *block_name);
> -int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
> +bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
>   bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
>   void postcopy_preempt_shutdown_file(MigrationState *s);
>   void *postcopy_preempt_thread(void *opaque);
> diff --git a/migration/migration.c b/migration/migration.c
> index 1a7f214fcf..e7375810be 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1837,29 +1837,29 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
>       ram_save_queue_pages(rbname, start, len, errp);
>   }
>   
> -static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
> -                                         Error **errp)
> +static bool migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
> +                                          Error **errp)
>   {
>       RAMBlock *block = qemu_ram_block_by_name(block_name);
>   
>       if (!block) {
>           error_setg(errp, "MIG_RP_MSG_RECV_BITMAP has invalid block name '%s'",
>                      block_name);
> -        return -EINVAL;
> +        return false;
>       }
>   
>       /* Fetch the received bitmap and refresh the dirty bitmap */
>       return ram_dirty_bitmap_reload(s, block, errp);
>   }
>   
> -static int migrate_handle_rp_resume_ack(MigrationState *s,
> -                                        uint32_t value, Error **errp)
> +static bool migrate_handle_rp_resume_ack(MigrationState *s,
> +                                         uint32_t value, Error **errp)
>   {
>       trace_source_return_path_thread_resume_ack(value);
>   
>       if (value != MIGRATION_RESUME_ACK_VALUE) {
>           error_setg(errp, "illegal resume_ack value %"PRIu32, value);
> -        return -1;
> +        return false;
>       }
>   
>       /* Now both sides are active. */
> @@ -1869,7 +1869,7 @@ static int migrate_handle_rp_resume_ack(MigrationState *s,
>       /* Notify send thread that time to continue send pages */
>       migration_rp_kick(s);
>   
> -    return 0;
> +    return true;
>   }
>   
>   /*
> @@ -2021,14 +2021,14 @@ static void *source_return_path_thread(void *opaque)
>               }
>               /* Format: len (1B) + idstr (<255B). This ends the idstr. */
>               buf[buf[0] + 1] = '\0';
> -            if (migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1), &err)) {
> +            if (!migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1), &err)) {
>                   goto out;
>               }
>               break;
>   
>           case MIG_RP_MSG_RESUME_ACK:
>               tmp32 = ldl_be_p(buf);
> -            if (migrate_handle_rp_resume_ack(ms, tmp32, &err)) {
> +            if (!migrate_handle_rp_resume_ack(ms, tmp32, &err)) {
>                   goto out;
>               }
>               break;
> diff --git a/migration/ram.c b/migration/ram.c
> index 2565f53f5c..982fbbeee1 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4157,23 +4157,25 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
>    * Read the received bitmap, revert it as the initial dirty bitmap.
>    * This is only used when the postcopy migration is paused but wants
>    * to resume from a middle point.
> + *
> + * Returns true if succeeded, false for errors.
>    */
> -int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
> +bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
>   {
> -    int ret = -EINVAL;
>       /* from_dst_file is always valid because we're within rp_thread */
>       QEMUFile *file = s->rp_state.from_dst_file;
>       unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
>       uint64_t local_size = DIV_ROUND_UP(nbits, 8);
>       uint64_t size, end_mark;
>       RAMState *rs = ram_state;
> +    bool result = false;
>   
>       trace_ram_dirty_bitmap_reload_begin(block->idstr);
>   
>       if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
>           error_setg(errp, "Reload bitmap in incorrect state %s",
>                      MigrationStatus_str(s->state));
> -        return -EINVAL;
> +        return false;
>       }
>   
>       /*
> @@ -4191,26 +4193,22 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
>       if (size != local_size) {
>           error_setg(errp, "ramblock '%s' bitmap size mismatch (0x%"PRIx64
>                      " != 0x%"PRIx64")", block->idstr, size, local_size);
> -        ret = -EINVAL;
>           goto out;
>       }
>   
>       size = qemu_get_buffer(file, (uint8_t *)le_bitmap, local_size);
>       end_mark = qemu_get_be64(file);
>   
> -    ret = qemu_file_get_error(file);
> -    if (ret || size != local_size) {
> -        error_setg(errp, "read bitmap failed for ramblock '%s': %d"
> -                   " (size 0x%"PRIx64", got: 0x%"PRIx64")",
> -                   block->idstr, ret, local_size, size);
> -        ret = -EIO;
> +    if (qemu_file_get_error(file) || size != local_size) {
> +        error_setg(errp, "read bitmap failed for ramblock '%s': "
> +                   "(size 0x%"PRIx64", got: 0x%"PRIx64")",
> +                   block->idstr, local_size, size);
>           goto out;
>       }
>   
>       if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
>           error_setg(errp, "ramblock '%s' end mark incorrect: 0x%"PRIx64,
>                      block->idstr, end_mark);
> -        ret = -EINVAL;
>           goto out;
>       }
>   
> @@ -4243,10 +4241,10 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
>        */
>       migration_rp_kick(s);
>   
> -    ret = 0;
> +    result = true;
>   out:
>       g_free(le_bitmap);
> -    return ret;
> +    return result;
>   }
>   
>   static int ram_resume_prepare(MigrationState *s, void *opaque)

Yes, exactly what I meant. For the embedded patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

One step further is to use g_autofree for le_bitmap to remove this
annoying 'out' label. I'll send the patch.

