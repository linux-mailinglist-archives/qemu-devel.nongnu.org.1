Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 991758B2B4F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Apr 2024 23:49:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s06xX-0004ZY-Cu; Thu, 25 Apr 2024 17:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s06xV-0004Z0-1Y
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 17:48:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s06xS-0005SA-PL
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 17:48:48 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB7875C7CB;
 Thu, 25 Apr 2024 21:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714081721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53FtkQvwG3mUIJrqhee7tUTgfbqDLzbIQSGX8eRpL1E=;
 b=HGzGK9ulWV6WuT61OJRijuzC62rFfooGDMP5GIo7Of2L1KC1CE0T0XyMGnAPjvlgXY6omS
 NbVdID1omhzq/SU/XVnMZr2vL/iCJ/79HJNJNIBw9ynV70tBQnMUhovHzW9P9C8u+Fb+0r
 XN6XiowgMbRTT1SC202qe+lX7Wz1QVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714081721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53FtkQvwG3mUIJrqhee7tUTgfbqDLzbIQSGX8eRpL1E=;
 b=IMUXR3mcN8VEWYie04dBkAZPkr+BEJDCFnZvU/f/l0snrJPStfpQ1jYAM03TndISlRvUih
 3NmjHgt9EQ3GtXAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HGzGK9ul;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IMUXR3mc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714081721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53FtkQvwG3mUIJrqhee7tUTgfbqDLzbIQSGX8eRpL1E=;
 b=HGzGK9ulWV6WuT61OJRijuzC62rFfooGDMP5GIo7Of2L1KC1CE0T0XyMGnAPjvlgXY6omS
 NbVdID1omhzq/SU/XVnMZr2vL/iCJ/79HJNJNIBw9ynV70tBQnMUhovHzW9P9C8u+Fb+0r
 XN6XiowgMbRTT1SC202qe+lX7Wz1QVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714081721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53FtkQvwG3mUIJrqhee7tUTgfbqDLzbIQSGX8eRpL1E=;
 b=IMUXR3mcN8VEWYie04dBkAZPkr+BEJDCFnZvU/f/l0snrJPStfpQ1jYAM03TndISlRvUih
 3NmjHgt9EQ3GtXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33CD61393C;
 Thu, 25 Apr 2024 21:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0CMPO7jPKmYgcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 25 Apr 2024 21:48:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@linux.dev>, marcandre.lureau@redhat.com,
 peterx@redhat.com, armbru@redhat.com, lvivier@redhat.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>
Subject: Re: [PATCH v4 04/14] util/dsa: Implement DSA task enqueue and dequeue.
In-Reply-To: <20240425022117.4035031-5-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-5-hao.xiang@linux.dev>
Date: Thu, 25 Apr 2024 18:48:38 -0300
Message-ID: <87y1916rm1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,linux.dev:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AB7875C7CB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Hao Xiang <hao.xiang@linux.dev> writes:

> * Use a safe thread queue for DSA task enqueue/dequeue.
> * Implement DSA task submission.
> * Implement DSA batch task submission.
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> ---
>  include/qemu/dsa.h |  28 +++++++
>  util/dsa.c         | 201 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 229 insertions(+)
>
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> index f15c05ee85..37cae8d9d2 100644
> --- a/include/qemu/dsa.h
> +++ b/include/qemu/dsa.h
> @@ -13,6 +13,34 @@
>  #include <linux/idxd.h>
>  #include "x86intrin.h"
>  
> +typedef enum DsaTaskType {
> +    DSA_TASK = 0,
> +    DSA_BATCH_TASK
> +} DsaTaskType;
> +
> +typedef enum DsaTaskStatus {
> +    DSA_TASK_READY = 0,
> +    DSA_TASK_PROCESSING,
> +    DSA_TASK_COMPLETION
> +} DsaTaskStatus;
> +
> +typedef void (*dsa_completion_fn)(void *);
> +
> +typedef struct dsa_batch_task {
> +    struct dsa_hw_desc batch_descriptor;
> +    struct dsa_hw_desc *descriptors;
> +    struct dsa_completion_record batch_completion __attribute__((aligned(32)));
> +    struct dsa_completion_record *completions;
> +    struct dsa_device_group *group;
> +    struct dsa_device *device;
> +    dsa_completion_fn completion_callback;
> +    QemuSemaphore sem_task_complete;
> +    DsaTaskType task_type;
> +    DsaTaskStatus status;
> +    int batch_size;
> +    QSIMPLEQ_ENTRY(dsa_batch_task) entry;
> +} dsa_batch_task;
> +
>  /**
>   * @brief Initializes DSA devices.
>   *
> diff --git a/util/dsa.c b/util/dsa.c
> index 05bbf8e31a..75739a1af6 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -244,6 +244,205 @@ dsa_device_group_get_next_device(struct dsa_device_group *group)
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
> +                 struct dsa_batch_task *task)
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
> +        error_report("DSA: Tried to queue task to stopped device queue.");
> +        qemu_mutex_unlock(task_queue_lock);
> +        return -1;
> +    }
> +
> +    /* The queue is empty. This enqueue operation is a 0->1 transition. */
> +    if (QSIMPLEQ_EMPTY(task_queue)) {
> +        notify = true;
> +    }
> +
> +    QSIMPLEQ_INSERT_TAIL(task_queue, task, entry);
> +
> +    /* We need to notify the waiter for 0->1 transitions. */
> +    if (notify) {
> +        qemu_cond_signal(task_queue_cond);
> +    }
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
> + * @return dsa_batch_task* The DSA task being dequeued.
> + */
> +__attribute__((unused))
> +static struct dsa_batch_task *
> +dsa_task_dequeue(struct dsa_device_group *group)
> +{
> +    struct dsa_batch_task *task = NULL;
> +    dsa_task_queue *task_queue = &group->task_queue;
> +    QemuMutex *task_queue_lock = &group->task_queue_lock;
> +    QemuCond *task_queue_cond = &group->task_queue_cond;
> +
> +    qemu_mutex_lock(task_queue_lock);
> +
> +    while (true) {
> +        if (!group->running) {
> +            goto exit;
> +        }
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

You missed my comment in v2 that max_retry_count is UINT64_MAX.

> +            error_report("Submit work retry %lu times.", retry);
> +            return -1;
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
> +submit_wi_async(struct dsa_batch_task *task)
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
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    return dsa_task_enqueue(device_group, task);
> +}
> +
> +/**
> + * @brief Asynchronously submits a DSA batch work item to the
> + *        device work queue.
> + *
> + * @param dsa_batch_task A pointer to the batch buffer zero task.
> + *
> + * @return int Zero if successful, non-zero otherwise.
> + */
> +__attribute__((unused))
> +static int
> +submit_batch_wi_async(struct dsa_batch_task *batch_task)
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
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    return dsa_task_enqueue(device_group, batch_task);
> +}
> +
>  /**
>   * @brief Check if DSA is running.
>   *
> @@ -300,6 +499,8 @@ void dsa_stop(void)
>      if (!group->running) {
>          return;
>      }
> +
> +    dsa_empty_task_queue(group);
>  }
>  
>  /**

