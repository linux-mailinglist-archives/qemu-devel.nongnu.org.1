Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEF480F204
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:12:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5LR-0004Dg-Bz; Tue, 12 Dec 2023 11:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rD5LP-0004Cx-Kk
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:10:51 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rD5LN-0005ot-Em
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:10:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA5A12250D;
 Tue, 12 Dec 2023 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702397445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iru6t63huG2Wws+rvE8ALZuG5c1A1xksKBdDDrmcngs=;
 b=eiWXCeuIFKQz+VzKqavs/o0v2Yka+J2WksEv1N6ZFJ3QmhQGGYv1/NDLwfqm4iuhZuDE6a
 Hd/M1B1tjGJaUBKQTpiP5rXTx77PfL0ep2ptCe6YbHcEglk5OrYctgHW7q1bKYJINKfCJX
 +gmHQJ/nMt3lLRl4EJF+muKP0zOY2zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702397445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iru6t63huG2Wws+rvE8ALZuG5c1A1xksKBdDDrmcngs=;
 b=efVlEdn76OZBgoQEyOGWDYtDrr3KFwQR69g6LDJhJVdTsHFe7SyRbHvFGzcJqm83etw2tx
 NfwC0OsTq2LOhdCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702397443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iru6t63huG2Wws+rvE8ALZuG5c1A1xksKBdDDrmcngs=;
 b=j22FGIB08J7JMrGJlGSCAt6ECqOPRzHTRoZrg2kbdeZPao9rinbTk70osRrLnOdzi/p9ht
 VDTcUTBooElNmBJXmX3LWWcGxJjcG0zLSOBp2aCTf1hLITt/o9+k6UTtlaVgk8DPYMyx/N
 JfTZ3tJsVKfunaNrVoSVyaPMIoZFtkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702397443;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iru6t63huG2Wws+rvE8ALZuG5c1A1xksKBdDDrmcngs=;
 b=G4B+oEPMHdJmSAY0eP2SfgQJ9xj5A+UxrPfwo1SOm72YCc7NVkRfFVoMXo1N7tuVSdKmWs
 7HqsNbechS+frNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49B2613725;
 Tue, 12 Dec 2023 16:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BqT/AQOGeGUWIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 Dec 2023 16:10:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peter.maydell@linaro.org,
 quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v2 08/20] util/dsa: Implement DSA task enqueue and dequeue.
In-Reply-To: <20231114054032.1192027-9-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-9-hao.xiang@bytedance.com>
Date: Tue, 12 Dec 2023 13:10:40 -0300
Message-ID: <87msufwge7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: 9.78
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: DA5A12250D
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j22FGIB0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G4B+oEPM;
 dmarc=pass (policy=none) header.from=suse.de;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Spamd-Result: default: False [-13.31 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(0.00)[~all:c];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
 RCPT_COUNT_SEVEN(0.00)[8]; MX_GOOD(-0.01)[];
 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; MID_RHS_MATCH_FROM(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 WHITELIST_DMARC(-7.00)[suse.de:D:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -13.31
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

> * Use a safe thread queue for DSA task enqueue/dequeue.
> * Implement DSA task submission.
> * Implement DSA batch task submission.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  include/qemu/dsa.h |  35 ++++++++
>  util/dsa.c         | 196 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 231 insertions(+)
>
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> index 30246b507e..23f55185be 100644
> --- a/include/qemu/dsa.h
> +++ b/include/qemu/dsa.h
> @@ -12,6 +12,41 @@
>  #include <linux/idxd.h>
>  #include "x86intrin.h"
>  
> +enum dsa_task_type {

Our coding style requires CamelCase for enums and typedef'ed structures.

> +    DSA_TASK = 0,
> +    DSA_BATCH_TASK
> +};
> +
> +enum dsa_task_status {
> +    DSA_TASK_READY = 0,
> +    DSA_TASK_PROCESSING,
> +    DSA_TASK_COMPLETION
> +};
> +
> +typedef void (*buffer_zero_dsa_completion_fn)(void *);

We don't really need the "buffer_zero" mention in any of this
code. Simply dsa_batch_task or batch_task would suffice.

> +
> +typedef struct buffer_zero_batch_task {
> +    struct dsa_hw_desc batch_descriptor;
> +    struct dsa_hw_desc *descriptors;
> +    struct dsa_completion_record batch_completion __attribute__((aligned(32)));
> +    struct dsa_completion_record *completions;
> +    struct dsa_device_group *group;
> +    struct dsa_device *device;
> +    buffer_zero_dsa_completion_fn completion_callback;
> +    QemuSemaphore sem_task_complete;
> +    enum dsa_task_type task_type;
> +    enum dsa_task_status status;
> +    bool *results;
> +    int batch_size;
> +    QSIMPLEQ_ENTRY(buffer_zero_batch_task) entry;
> +} buffer_zero_batch_task;

I see data specific to this implementation and data coming from the
library, maybe these would be better organized in two separate
structures with the qemu-specific having a pointer to the generic
one. Looking ahead in the series, there seems to be migration data
coming into this as well.

> +
> +#else
> +
> +struct buffer_zero_batch_task {
> +    bool *results;
> +};
> +
>  #endif
>  
>  /**
> diff --git a/util/dsa.c b/util/dsa.c
> index 8edaa892ec..f82282ce99 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -245,6 +245,200 @@ dsa_device_group_get_next_device(struct dsa_device_group *group)
>      return &group->dsa_devices[current];
>  }
>  
> +/**
> + * @brief Empties out the DSA task queue.
> + *
> + * @param group A pointer to the DSA device group.
> + */
> +static void
> +dsa_empty_task_queue(struct dsa_device_group *group)
> +{
> +    qemu_mutex_lock(&group->task_queue_lock);
> +    dsa_task_queue *task_queue = &group->task_queue;
> +    while (!QSIMPLEQ_EMPTY(task_queue)) {
> +        QSIMPLEQ_REMOVE_HEAD(task_queue, entry);
> +    }
> +    qemu_mutex_unlock(&group->task_queue_lock);
> +}
> +
> +/**
> + * @brief Adds a task to the DSA task queue.
> + *
> + * @param group A pointer to the DSA device group.
> + * @param context A pointer to the DSA task to enqueue.
> + *
> + * @return int Zero if successful, otherwise a proper error code.
> + */
> +static int
> +dsa_task_enqueue(struct dsa_device_group *group,
> +                 struct buffer_zero_batch_task *task)
> +{
> +    dsa_task_queue *task_queue = &group->task_queue;
> +    QemuMutex *task_queue_lock = &group->task_queue_lock;
> +    QemuCond *task_queue_cond = &group->task_queue_cond;
> +
> +    bool notify = false;
> +
> +    qemu_mutex_lock(task_queue_lock);
> +
> +    if (!group->running) {
> +        fprintf(stderr, "DSA: Tried to queue task to stopped device queue\n");
> +        qemu_mutex_unlock(task_queue_lock);
> +        return -1;
> +    }
> +
> +    // The queue is empty. This enqueue operation is a 0->1 transition.
> +    if (QSIMPLEQ_EMPTY(task_queue))
> +        notify = true;
> +
> +    QSIMPLEQ_INSERT_TAIL(task_queue, task, entry);
> +
> +    // We need to notify the waiter for 0->1 transitions.
> +    if (notify)
> +        qemu_cond_signal(task_queue_cond);
> +
> +    qemu_mutex_unlock(task_queue_lock);
> +
> +    return 0;
> +}
> +
> +/**
> + * @brief Takes a DSA task out of the task queue.
> + *
> + * @param group A pointer to the DSA device group.
> + * @return buffer_zero_batch_task* The DSA task being dequeued.
> + */
> +__attribute__((unused))
> +static struct buffer_zero_batch_task *
> +dsa_task_dequeue(struct dsa_device_group *group)
> +{
> +    struct buffer_zero_batch_task *task = NULL;
> +    dsa_task_queue *task_queue = &group->task_queue;
> +    QemuMutex *task_queue_lock = &group->task_queue_lock;
> +    QemuCond *task_queue_cond = &group->task_queue_cond;
> +
> +    qemu_mutex_lock(task_queue_lock);
> +
> +    while (true) {
> +        if (!group->running)
> +            goto exit;
> +        task = QSIMPLEQ_FIRST(task_queue);
> +        if (task != NULL) {
> +            break;
> +        }
> +        qemu_cond_wait(task_queue_cond, task_queue_lock);
> +    }
> +
> +    QSIMPLEQ_REMOVE_HEAD(task_queue, entry);
> +
> +exit:
> +    qemu_mutex_unlock(task_queue_lock);
> +    return task;
> +}
> +
> +/**
> + * @brief Submits a DSA work item to the device work queue.
> + *
> + * @param wq A pointer to the DSA work queue's device memory.
> + * @param descriptor A pointer to the DSA work item descriptor.
> + *
> + * @return Zero if successful, non-zero otherwise.
> + */
> +static int
> +submit_wi_int(void *wq, struct dsa_hw_desc *descriptor)
> +{
> +    uint64_t retry = 0;
> +
> +    _mm_sfence();
> +
> +    while (true) {
> +        if (_enqcmd(wq, descriptor) == 0) {
> +            break;
> +        }
> +        retry++;
> +        if (retry > max_retry_count) {

'max_retry_count' is UINT64_MAX so 'retry' will wrap around.

> +            fprintf(stderr, "Submit work retry %lu times.\n", retry);
> +            exit(1);

Is this not the case where we'd fallback to the CPU?

You should not exit() here, but return non-zero as the documentation
mentions and the callers expect.

> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +/**
> + * @brief Synchronously submits a DSA work item to the
> + *        device work queue.
> + *
> + * @param wq A pointer to the DSA worjk queue's device memory.
> + * @param descriptor A pointer to the DSA work item descriptor.
> + *
> + * @return int Zero if successful, non-zero otherwise.
> + */
> +__attribute__((unused))
> +static int
> +submit_wi(void *wq, struct dsa_hw_desc *descriptor)
> +{
> +    return submit_wi_int(wq, descriptor);
> +}
> +
> +/**
> + * @brief Asynchronously submits a DSA work item to the
> + *        device work queue.
> + *
> + * @param task A pointer to the buffer zero task.
> + *
> + * @return int Zero if successful, non-zero otherwise.
> + */
> +__attribute__((unused))
> +static int
> +submit_wi_async(struct buffer_zero_batch_task *task)
> +{
> +    struct dsa_device_group *device_group = task->group;
> +    struct dsa_device *device_instance = task->device;
> +    int ret;
> +
> +    assert(task->task_type == DSA_TASK);
> +
> +    task->status = DSA_TASK_PROCESSING;
> +
> +    ret = submit_wi_int(device_instance->work_queue,
> +                        &task->descriptors[0]);
> +    if (ret != 0)
> +        return ret;
> +
> +    return dsa_task_enqueue(device_group, task);
> +}
> +
> +/**
> + * @brief Asynchronously submits a DSA batch work item to the
> + *        device work queue.
> + *
> + * @param batch_task A pointer to the batch buffer zero task.
> + *
> + * @return int Zero if successful, non-zero otherwise.
> + */
> +__attribute__((unused))
> +static int
> +submit_batch_wi_async(struct buffer_zero_batch_task *batch_task)
> +{
> +    struct dsa_device_group *device_group = batch_task->group;
> +    struct dsa_device *device_instance = batch_task->device;
> +    int ret;
> +
> +    assert(batch_task->task_type == DSA_BATCH_TASK);
> +    assert(batch_task->batch_descriptor.desc_count <= batch_task->batch_size);
> +    assert(batch_task->status == DSA_TASK_READY);
> +
> +    batch_task->status = DSA_TASK_PROCESSING;
> +
> +    ret = submit_wi_int(device_instance->work_queue,
> +                        &batch_task->batch_descriptor);
> +    if (ret != 0)
> +        return ret;
> +
> +    return dsa_task_enqueue(device_group, batch_task);
> +}

At this point in the series submit_wi_async() and
submit_batch_wi_async() look the same to me without the asserts. Can't
we consolidate them?

There's also the fact that both functions receive a _batch_ task but one
is supposed to work in batches and the other is not. That could be
solved by renaming the structure I guess.

> +
>  /**
>   * @brief Check if DSA is running.
>   *
> @@ -301,6 +495,8 @@ void dsa_stop(void)
>      if (!group->running) {
>          return;
>      }
> +
> +    dsa_empty_task_queue(group);
>  }
>  
>  /**

