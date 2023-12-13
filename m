Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DD8113FD
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 15:02:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDPnV-00005F-Rp; Wed, 13 Dec 2023 09:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rDPnR-00004q-Mg
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:01:10 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rDPnP-0006l1-IA
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:01:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15530225AB;
 Wed, 13 Dec 2023 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702476064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHu2JR56n+MnI6vlxX2NIYdRVk0JnBqUUQif1wojNrw=;
 b=wREPKYoUQS2yWQiR7UDN8ncQ/4KQiL8jMjS+gg2kR6zneJWLheKXA/mdJF5vBPfaAkk4cL
 8h2A6nMhZIYz/skjDZdwPSSmGhMuC6OKoum9T6Pkl0nZ9T5fC8g4U0qD76K8W40XCMUBdI
 cqkYfJh4E6SHmZHzyARU0GKZ/4QkL2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702476064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHu2JR56n+MnI6vlxX2NIYdRVk0JnBqUUQif1wojNrw=;
 b=1F9Cb/PXtW1g5QlXfabjMsAmOI2Plgjg2U0JTYZhuzM7q6ZPiPayqVKr9Z5xFxBw0JcREm
 6DtaCSeqUm0xxyAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702476063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHu2JR56n+MnI6vlxX2NIYdRVk0JnBqUUQif1wojNrw=;
 b=BBMjBbfR4wQj4gmSWh5ZUi5qSGG5BDbupz6wMxEE9lh9YnQ6X2yt6ANlyv5KcB+d6CCc76
 UILzRsIDZY/d6W5aNB3S+zcNfM04zGaBCg1DSWVwLLMch4OGUErKBRthK7PuJIZGjXy+io
 zhIUdC2Le6JASa8h7UjxfJDDnwneIIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702476063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHu2JR56n+MnI6vlxX2NIYdRVk0JnBqUUQif1wojNrw=;
 b=UYeYR0FPhbzru53+bXMCTxHrWjDe7a1bHdtqRZRmvzqRc7gNafqqE8twAawTovaWNmeVGa
 LW3AenuiES0s0MCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97B131377F;
 Wed, 13 Dec 2023 14:01:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0A/vFx65eWUBHQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Dec 2023 14:01:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peter.maydell@linaro.org,
 quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v2 11/20] util/dsa: Implement DSA task asynchronous
 submission and wait for completion.
In-Reply-To: <20231114054032.1192027-12-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-12-hao.xiang@bytedance.com>
Date: Wed, 13 Dec 2023 11:01:00 -0300
Message-ID: <87o7euxkv7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: 3.59
X-Rspamd-Queue-Id: 15530225AB
X-Rspamd-Server: rspamd1
X-Spam-Score: -10.81
X-Spamd-Result: default: False [-10.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all:c];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+];
 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
 RCPT_COUNT_SEVEN(0.00)[8]; WHITELIST_DMARC(-7.00)[suse.de:D:+];
 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BBMjBbfR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UYeYR0FP;
 dmarc=pass (policy=none) header.from=suse.de;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> * Add a DSA task completion callback.
> * DSA completion thread will call the tasks's completion callback
> on every task/batch task completion.
> * DSA submission path to wait for completion.
> * Implement CPU fallback if DSA is not able to complete the task.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> ---
>  include/qemu/dsa.h |  14 +++++
>  util/dsa.c         | 153 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 164 insertions(+), 3 deletions(-)
>
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> index b10e7b8fb7..3f8ee07004 100644
> --- a/include/qemu/dsa.h
> +++ b/include/qemu/dsa.h
> @@ -65,6 +65,20 @@ void buffer_zero_batch_task_init(struct buffer_zero_batch_task *task,
>   */
>  void buffer_zero_batch_task_destroy(struct buffer_zero_batch_task *task);
>  
> +/**
> + * @brief Performs buffer zero comparison on a DSA batch task asynchronously.
> + *
> + * @param batch_task A pointer to the batch task.
> + * @param buf An array of memory buffers.
> + * @param count The number of buffers in the array.
> + * @param len The buffer length.
> + *
> + * @return Zero if successful, otherwise non-zero.
> + */
> +int
> +buffer_is_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_task,
> +                               const void **buf, size_t count, size_t len);
> +
>  /**
>   * @brief Initializes DSA devices.
>   *
> diff --git a/util/dsa.c b/util/dsa.c
> index 3cc017b8a0..06c6fbf2ca 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -470,6 +470,41 @@ poll_completion(struct dsa_completion_record *completion,
>      return 0;
>  }
>  
> +/**
> + * @brief Use CPU to complete a single zero page checking task.
> + *
> + * @param task A pointer to the task.
> + */
> +static void
> +task_cpu_fallback(struct buffer_zero_batch_task *task)
> +{
> +    assert(task->task_type == DSA_TASK);
> +
> +    struct dsa_completion_record *completion = &task->completions[0];
> +    const uint8_t *buf;
> +    size_t len;
> +
> +    if (completion->status == DSA_COMP_SUCCESS) {
> +        return;
> +    }
> +
> +    /*
> +     * DSA was able to partially complete the operation. Check the
> +     * result. If we already know this is not a zero page, we can
> +     * return now.
> +     */
> +    if (completion->bytes_completed != 0 && completion->result != 0) {
> +        task->results[0] = false;
> +        return;
> +    }
> +
> +    /* Let's fallback to use CPU to complete it. */
> +    buf = (const uint8_t *)task->descriptors[0].src_addr;
> +    len = task->descriptors[0].xfer_size;
> +    task->results[0] = buffer_is_zero(buf + completion->bytes_completed,
> +                                      len - completion->bytes_completed);
> +}
> +
>  /**
>   * @brief Complete a single DSA task in the batch task.
>   *
> @@ -548,6 +583,62 @@ poll_batch_task_completion(struct buffer_zero_batch_task *batch_task)
>      }
>  }
>  
> +/**
> + * @brief Use CPU to complete the zero page checking batch task.
> + *
> + * @param batch_task A pointer to the batch task.
> + */
> +static void
> +batch_task_cpu_fallback(struct buffer_zero_batch_task *batch_task)
> +{
> +    assert(batch_task->task_type == DSA_BATCH_TASK);
> +
> +    struct dsa_completion_record *batch_completion =
> +        &batch_task->batch_completion;
> +    struct dsa_completion_record *completion;
> +    uint8_t status;
> +    const uint8_t *buf;
> +    size_t len;
> +    bool *results = batch_task->results;
> +    uint32_t count = batch_task->batch_descriptor.desc_count;
> +
> +    // DSA is able to complete the entire batch task.
> +    if (batch_completion->status == DSA_COMP_SUCCESS) {
> +        assert(count == batch_completion->bytes_completed);
> +        return;
> +    }
> +
> +    /*
> +     * DSA encounters some error and is not able to complete
> +     * the entire batch task. Use CPU fallback.
> +     */
> +    for (int i = 0; i < count; i++) {
> +        completion = &batch_task->completions[i];
> +        status = completion->status;
> +        if (status == DSA_COMP_SUCCESS) {
> +            continue;
> +        }
> +        assert(status == DSA_COMP_PAGE_FAULT_NOBOF);
> +
> +        /*
> +         * DSA was able to partially complete the operation. Check the
> +         * result. If we already know this is not a zero page, we can
> +         * return now.
> +         */
> +        if (completion->bytes_completed != 0 && completion->result != 0) {
> +            results[i] = false;
> +            continue;
> +        }
> +
> +        /* Let's fallback to use CPU to complete it. */
> +        buf = (uint8_t *)batch_task->descriptors[i].src_addr;
> +        len = batch_task->descriptors[i].xfer_size;
> +        results[i] =
> +            buffer_is_zero(buf + completion->bytes_completed,
> +                           len - completion->bytes_completed);

Here the same thing is happening as in other patches, the batch task
operation is just a repeat of the task operation n times. So this whole
inner code here could be nicely replaced by task_cpu_fallback() with
some adjustment of the function arguments. That makes intuitive sense
and removes code duplication.

> +    }
> +}
> +
>  /**
>   * @brief Handles an asynchronous DSA batch task completion.
>   *
> @@ -825,7 +916,6 @@ buffer_zero_batch_task_set(struct buffer_zero_batch_task *batch_task,
>   *
>   * @return int Zero if successful, otherwise an appropriate error code.
>   */
> -__attribute__((unused))
>  static int
>  buffer_zero_dsa_async(struct buffer_zero_batch_task *task,
>                        const void *buf, size_t len)
> @@ -844,7 +934,6 @@ buffer_zero_dsa_async(struct buffer_zero_batch_task *task,
>   * @param count The number of buffers.
>   * @param len The buffer length.
>   */
> -__attribute__((unused))
>  static int
>  buffer_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_task,
>                              const void **buf, size_t count, size_t len)
> @@ -876,13 +965,29 @@ buffer_zero_dsa_completion(void *context)
>   *
>   * @param batch_task A pointer to the buffer zero comparison batch task.
>   */
> -__attribute__((unused))
>  static void
>  buffer_zero_dsa_wait(struct buffer_zero_batch_task *batch_task)
>  {
>      qemu_sem_wait(&batch_task->sem_task_complete);
>  }
>  
> +/**
> + * @brief Use CPU to complete the zero page checking task if DSA
> + *        is not able to complete it.
> + *
> + * @param batch_task A pointer to the batch task.
> + */
> +static void
> +buffer_zero_cpu_fallback(struct buffer_zero_batch_task *batch_task)
> +{
> +    if (batch_task->task_type == DSA_TASK) {
> +        task_cpu_fallback(batch_task);
> +    } else {
> +        assert(batch_task->task_type == DSA_BATCH_TASK);
> +        batch_task_cpu_fallback(batch_task);
> +    }
> +}
> +
>  /**
>   * @brief Check if DSA is running.
>   *
> @@ -956,6 +1061,41 @@ void dsa_cleanup(void)
>      dsa_device_group_cleanup(&dsa_group);
>  }
>  
> +/**
> + * @brief Performs buffer zero comparison on a DSA batch task asynchronously.
> + *
> + * @param batch_task A pointer to the batch task.
> + * @param buf An array of memory buffers.
> + * @param count The number of buffers in the array.
> + * @param len The buffer length.
> + *
> + * @return Zero if successful, otherwise non-zero.
> + */
> +int
> +buffer_is_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_task,
> +                               const void **buf, size_t count, size_t len)
> +{
> +    if (count <= 0 || count > batch_task->batch_size) {
> +        return -1;
> +    }
> +
> +    assert(batch_task != NULL);
> +    assert(len != 0);
> +    assert(buf != NULL);
> +
> +    if (count == 1) {
> +        // DSA doesn't take batch operation with only 1 task.
> +        buffer_zero_dsa_async(batch_task, buf[0], len);
> +    } else {
> +        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
> +    }
> +
> +    buffer_zero_dsa_wait(batch_task);
> +    buffer_zero_cpu_fallback(batch_task);
> +
> +    return 0;
> +}
> +
>  #else
>  
>  void buffer_zero_batch_task_init(struct buffer_zero_batch_task *task,
> @@ -981,5 +1121,12 @@ void dsa_stop(void) {}
>  
>  void dsa_cleanup(void) {}
>  
> +int
> +buffer_is_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_task,
> +                               const void **buf, size_t count, size_t len)
> +{
> +    exit(1);
> +}
> +
>  #endif

