Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0159B80F6C4
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 20:37:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD8YJ-0000yp-2S; Tue, 12 Dec 2023 14:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rD8YH-0000xH-7J
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 14:36:21 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rD8YF-0006KV-4c
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 14:36:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E642B22511;
 Tue, 12 Dec 2023 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702409777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFnJwP3Ugti/RdEukI832IQFqi9dqMHITs60i7bRd4s=;
 b=lIszgjagUeeSw4V86Rzud6+7/YI527AMgJTpP0u2kpU0n9Apd8iiTfdA4kHHSyw+1rilYk
 rnC+oKpR3INrYFJUNaedzkaMqKDZDDa3YOHIC5V79750WPiR35SG1TKU5eL9BTPNcChA3M
 wtjLF6dioeJJyzj3Nq6cOeMM5OuX9ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702409777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFnJwP3Ugti/RdEukI832IQFqi9dqMHITs60i7bRd4s=;
 b=Zy+YewtAIOrsGnsTq6pb3lw2MHSABKAJehAs4F7j/JTYbGan+bPRdG6cbnivJwOXC3tuWR
 leR88v6cAG3NTLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702409776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFnJwP3Ugti/RdEukI832IQFqi9dqMHITs60i7bRd4s=;
 b=Lsdm3ZxA3cTfu72EvTUrKvfHVEKUV0SW8czQ4hwxh9EJdIpUTrxdzXDgn9UJig2OpmmjwG
 QJiGtMrENN/84l/clC0eIt31bdT8fjPi/IeghzlWxTvBeuqWciCOKd7eZpfbnNnCpy8xYr
 XmhNlj86X/L0IVdTXFjLXZGwrXU+v2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702409776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFnJwP3Ugti/RdEukI832IQFqi9dqMHITs60i7bRd4s=;
 b=XgaEe8PhFDCEfzPjx76WNs431+KqGbrHR9MpX8pVsic84kwmq8vKWsEyH1OkKVK4LgrJ5X
 E2WpU36EMTwhHbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A617136C7;
 Tue, 12 Dec 2023 19:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UkmIBjC2eGXrZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 Dec 2023 19:36:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peter.maydell@linaro.org,
 quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v2 09/20] util/dsa: Implement DSA task asynchronous
 completion thread model.
In-Reply-To: <20231114054032.1192027-10-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-10-hao.xiang@bytedance.com>
Date: Tue, 12 Dec 2023 16:36:13 -0300
Message-ID: <87fs072oya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.10
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

> * Create a dedicated thread for DSA task completion.
> * DSA completion thread runs a loop and poll for completed tasks.
> * Start and stop DSA completion thread during DSA device start stop.
>
> User space application can directly submit task to Intel DSA
> accelerator by writing to DSA's device memory (mapped in user space).
> Once a task is submitted, the device starts processing it and write
> the completion status back to the task. A user space application can
> poll the task's completion status to check for completion. This change
> uses a dedicated thread to perform DSA task completion checking.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  util/dsa.c | 243 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 242 insertions(+), 1 deletion(-)
>
> diff --git a/util/dsa.c b/util/dsa.c
> index f82282ce99..0e68013ffb 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -44,6 +44,7 @@
>  
>  #define DSA_WQ_SIZE 4096
>  #define MAX_DSA_DEVICES 16
> +#define DSA_COMPLETION_THREAD "dsa_completion"
>  
>  typedef QSIMPLEQ_HEAD(dsa_task_queue, buffer_zero_batch_task) dsa_task_queue;
>  
> @@ -61,8 +62,18 @@ struct dsa_device_group {
>      dsa_task_queue task_queue;
>  };
>  
> +struct dsa_completion_thread {
> +    bool stopping;
> +    bool running;
> +    QemuThread thread;
> +    int thread_id;
> +    QemuSemaphore sem_init_done;
> +    struct dsa_device_group *group;
> +};
> +
>  uint64_t max_retry_count;
>  static struct dsa_device_group dsa_group;
> +static struct dsa_completion_thread completion_thread;
>  
>  
>  /**
> @@ -439,6 +450,234 @@ submit_batch_wi_async(struct buffer_zero_batch_task *batch_task)
>      return dsa_task_enqueue(device_group, batch_task);
>  }
>  
> +/**
> + * @brief Poll for the DSA work item completion.
> + *
> + * @param completion A pointer to the DSA work item completion record.
> + * @param opcode The DSA opcode.
> + *
> + * @return Zero if successful, non-zero otherwise.
> + */
> +static int
> +poll_completion(struct dsa_completion_record *completion,
> +                enum dsa_opcode opcode)
> +{
> +    uint8_t status;
> +    uint64_t retry = 0;
> +
> +    while (true) {
> +        // The DSA operation completes successfully or fails.
> +        status = completion->status;
> +        if (status == DSA_COMP_SUCCESS ||

Should we read directly from completion->status or is the compiler smart
enough to not optimize 'status' out?

> +            status == DSA_COMP_PAGE_FAULT_NOBOF ||
> +            status == DSA_COMP_BATCH_PAGE_FAULT ||
> +            status == DSA_COMP_BATCH_FAIL) {
> +            break;
> +        } else if (status != DSA_COMP_NONE) {
> +            /* TODO: Error handling here on unexpected failure. */

Let's make sure this is dealt with before merging.

> +            fprintf(stderr, "DSA opcode %d failed with status = %d.\n",
> +                    opcode, status);
> +            exit(1);

return instead of exiting.

> +        }
> +        retry++;
> +        if (retry > max_retry_count) {
> +            fprintf(stderr, "Wait for completion retry %lu times.\n", retry);
> +            exit(1);

same here

> +        }
> +        _mm_pause();
> +    }
> +
> +    return 0;
> +}
> +
> +/**
> + * @brief Complete a single DSA task in the batch task.
> + *
> + * @param task A pointer to the batch task structure.
> + */
> +static void
> +poll_task_completion(struct buffer_zero_batch_task *task)
> +{
> +    assert(task->task_type == DSA_TASK);
> +
> +    struct dsa_completion_record *completion = &task->completions[0];
> +    uint8_t status;
> +
> +    poll_completion(completion, task->descriptors[0].opcode);
> +
> +    status = completion->status;
> +    if (status == DSA_COMP_SUCCESS) {
> +        task->results[0] = (completion->result == 0);
> +        return;
> +    }
> +
> +    assert(status == DSA_COMP_PAGE_FAULT_NOBOF);
> +}
> +
> +/**
> + * @brief Poll a batch task status until it completes. If DSA task doesn't
> + *        complete properly, use CPU to complete the task.
> + *
> + * @param batch_task A pointer to the DSA batch task.
> + */
> +static void
> +poll_batch_task_completion(struct buffer_zero_batch_task *batch_task)
> +{
> +    struct dsa_completion_record *batch_completion = &batch_task->batch_completion;
> +    struct dsa_completion_record *completion;
> +    uint8_t batch_status;
> +    uint8_t status;
> +    bool *results = batch_task->results;
> +    uint32_t count = batch_task->batch_descriptor.desc_count;
> +
> +    poll_completion(batch_completion,
> +                    batch_task->batch_descriptor.opcode);
> +
> +    batch_status = batch_completion->status;
> +
> +    if (batch_status == DSA_COMP_SUCCESS) {
> +        if (batch_completion->bytes_completed == count) {
> +            // Let's skip checking for each descriptors' completion status
> +            // if the batch descriptor says all succedded.
> +            for (int i = 0; i < count; i++) {
> +                assert(batch_task->completions[i].status == DSA_COMP_SUCCESS);
> +                results[i] = (batch_task->completions[i].result == 0);
> +            }
> +            return;
> +        }
> +    } else {
> +        assert(batch_status == DSA_COMP_BATCH_FAIL ||
> +            batch_status == DSA_COMP_BATCH_PAGE_FAULT);
> +    }
> +
> +    for (int i = 0; i < count; i++) {
> +

extra whitespace

> +        completion = &batch_task->completions[i];
> +        status = completion->status;
> +
> +        if (status == DSA_COMP_SUCCESS) {
> +            results[i] = (completion->result == 0);
> +            continue;
> +        }
> +
> +        if (status != DSA_COMP_PAGE_FAULT_NOBOF) {
> +            fprintf(stderr,
> +                    "Unexpected completion status = %u.\n", status);
> +            assert(false);

return here

> +        }
> +    }
> +}
> +
> +/**
> + * @brief Handles an asynchronous DSA batch task completion.
> + *
> + * @param task A pointer to the batch buffer zero task structure.
> + */
> +static void
> +dsa_batch_task_complete(struct buffer_zero_batch_task *batch_task)
> +{
> +    batch_task->status = DSA_TASK_COMPLETION;
> +    batch_task->completion_callback(batch_task);
> +}
> +
> +/**
> + * @brief The function entry point called by a dedicated DSA
> + *        work item completion thread.
> + *
> + * @param opaque A pointer to the thread context.
> + *
> + * @return void* Not used.
> + */
> +static void *
> +dsa_completion_loop(void *opaque)
> +{
> +    struct dsa_completion_thread *thread_context =
> +        (struct dsa_completion_thread *)opaque;
> +    struct buffer_zero_batch_task *batch_task;
> +    struct dsa_device_group *group = thread_context->group;
> +
> +    rcu_register_thread();
> +
> +    thread_context->thread_id = qemu_get_thread_id();
> +    qemu_sem_post(&thread_context->sem_init_done);
> +
> +    while (thread_context->running) {
> +        batch_task = dsa_task_dequeue(group);
> +        assert(batch_task != NULL || !group->running);
> +        if (!group->running) {
> +            assert(!thread_context->running);

This is racy if the compiler reorders "thread_context->running = false"
and "group->running = false". I'd put this under the task_queue_lock or
add a compiler barrier at dsa_completion_thread_stop().

> +            break;
> +        }
> +        if (batch_task->task_type == DSA_TASK) {
> +            poll_task_completion(batch_task);
> +        } else {
> +            assert(batch_task->task_type == DSA_BATCH_TASK);
> +            poll_batch_task_completion(batch_task);
> +        }
> +
> +        dsa_batch_task_complete(batch_task);
> +    }
> +
> +    rcu_unregister_thread();
> +    return NULL;
> +}
> +
> +/**
> + * @brief Initializes a DSA completion thread.
> + *
> + * @param completion_thread A pointer to the completion thread context.
> + * @param group A pointer to the DSA device group.
> + */
> +static void
> +dsa_completion_thread_init(
> +    struct dsa_completion_thread *completion_thread,
> +    struct dsa_device_group *group)
> +{
> +    completion_thread->stopping = false;
> +    completion_thread->running = true;
> +    completion_thread->thread_id = -1;
> +    qemu_sem_init(&completion_thread->sem_init_done, 0);
> +    completion_thread->group = group;
> +
> +    qemu_thread_create(&completion_thread->thread,
> +                       DSA_COMPLETION_THREAD,
> +                       dsa_completion_loop,
> +                       completion_thread,
> +                       QEMU_THREAD_JOINABLE);
> +
> +    /* Wait for initialization to complete */
> +    while (completion_thread->thread_id == -1) {
> +        qemu_sem_wait(&completion_thread->sem_init_done);
> +    }

This is racy, the thread can set 'thread_id' before this enters the loop
and the semaphore will be left unmatched. Not a huge deal but it might
cause confusion when debugging the initialization.

> +}
> +
> +/**
> + * @brief Stops the completion thread (and implicitly, the device group).
> + *
> + * @param opaque A pointer to the completion thread.
> + */
> +static void dsa_completion_thread_stop(void *opaque)
> +{
> +    struct dsa_completion_thread *thread_context =
> +        (struct dsa_completion_thread *)opaque;
> +
> +    struct dsa_device_group *group = thread_context->group;
> +
> +    qemu_mutex_lock(&group->task_queue_lock);
> +
> +    thread_context->stopping = true;
> +    thread_context->running = false;
> +
> +    dsa_device_group_stop(group);
> +
> +    qemu_cond_signal(&group->task_queue_cond);
> +    qemu_mutex_unlock(&group->task_queue_lock);
> +
> +    qemu_thread_join(&thread_context->thread);
> +
> +    qemu_sem_destroy(&thread_context->sem_init_done);
> +}
> +
>  /**
>   * @brief Check if DSA is running.
>   *
> @@ -446,7 +685,7 @@ submit_batch_wi_async(struct buffer_zero_batch_task *batch_task)
>   */
>  bool dsa_is_running(void)
>  {
> -    return false;
> +    return completion_thread.running;
>  }
>  
>  static void
> @@ -481,6 +720,7 @@ void dsa_start(void)
>          return;
>      }
>      dsa_device_group_start(&dsa_group);
> +    dsa_completion_thread_init(&completion_thread, &dsa_group);
>  }
>  
>  /**
> @@ -496,6 +736,7 @@ void dsa_stop(void)
>          return;
>      }
>  
> +    dsa_completion_thread_stop(&completion_thread);
>      dsa_empty_task_queue(group);
>  }

