Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0D9D89C1
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Nov 2024 16:54:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFbPC-00015d-0A; Mon, 25 Nov 2024 10:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFbP9-00015P-E3
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:53:39 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFbP6-0006WM-LU
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:53:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF94E1F442;
 Mon, 25 Nov 2024 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732550013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/L0ph3Fq/djRyuklf0IyAeuWukOVUYfmXPjupZ5pOM=;
 b=iC2yHFfVnMKJr5fN2eszBI5enqtuxEwfrPuw4ZplTxiktj9ScwBNiQ3LLpqVNo/eQxifuu
 FVYJ2/52r8m/daW1FWp6duzFjbRNM+1GNheGaFkXy6l9ibS/iJ3ELkSqRbsWq8f/KQw01C
 PzVc6/LTEQN9g9auTaakAhzJUkc/15o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732550013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/L0ph3Fq/djRyuklf0IyAeuWukOVUYfmXPjupZ5pOM=;
 b=UC5K8PMe+oC6UqzcPAvWyTC9Ayixj3YLYNSyQ8PDljiiJRl+N8hGRdgUrr3lkOgeIrzWqP
 rXHdobkHtjiyUvAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YHt3uoxY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bCc2B7zM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732550012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/L0ph3Fq/djRyuklf0IyAeuWukOVUYfmXPjupZ5pOM=;
 b=YHt3uoxYZzLm/81hHnVqYg0Otb29P0X6lQKCnph4wB+gTxnptTolsZaZnc/k0ypPYTXAOD
 ocnMZ/mdyD0+7Z0VcPsibXdBKeDYQNuE7PFYCCY++zjgLpybRekmxKBEyi5Epcr3ZFE6mR
 l5Tx5dDQ3WESEkmplo1h/P1BeA5SrjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732550012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/L0ph3Fq/djRyuklf0IyAeuWukOVUYfmXPjupZ5pOM=;
 b=bCc2B7zMnMal18cAiL5nob3r8k8vqxH5Zl7Ia9fl4ezlJQ3Pr5rXyx7bHYcZUlbUOZZ+Qk
 +lhC0gMfKTgRoNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5423213890;
 Mon, 25 Nov 2024 15:53:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id drgEB3ydRGcGZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 15:53:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v7 06/12] util/dsa: Implement zero page checking in DSA
 task.
In-Reply-To: <20241114220132.27399-7-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
 <20241114220132.27399-7-yichen.wang@bytedance.com>
Date: Mon, 25 Nov 2024 12:53:29 -0300
Message-ID: <875xobpax2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CF94E1F442
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWELVE(0.00)[18];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Hao Xiang <hao.xiang@linux.dev>
>
> Create DSA task with operation code DSA_OPCODE_COMPVAL.
> Here we create two types of DSA tasks, a single DSA task and
> a batch DSA task. Batch DSA task reduces task submission overhead
> and hence should be the default option. However, due to the way DSA
> hardware works, a DSA batch task must contain at least two individual
> tasks. There are times we need to submit a single task and hence a
> single DSA task submission is also required.
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  include/qemu/dsa.h |  44 ++++++--
>  util/dsa.c         | 254 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 269 insertions(+), 29 deletions(-)
>
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> index d24567f0be..cb407b8b49 100644
> --- a/include/qemu/dsa.h
> +++ b/include/qemu/dsa.h
> @@ -16,6 +16,7 @@
>  #define QEMU_DSA_H
>  
>  #include "qapi/error.h"
> +#include "exec/cpu-common.h"
>  #include "qemu/thread.h"
>  #include "qemu/queue.h"
>  
> @@ -70,10 +71,11 @@ typedef struct QemuDsaBatchTask {
>      QemuDsaTaskStatus status;
>      int batch_size;
>      bool *results;
> +    /* Address of each pages in pages */
> +    ram_addr_t *addr;
>      QSIMPLEQ_ENTRY(QemuDsaBatchTask) entry;
>  } QemuDsaBatchTask;
>  
> -
>  /**
>   * @brief Initializes DSA devices.
>   *
> @@ -105,8 +107,26 @@ void qemu_dsa_cleanup(void);
>   */
>  bool qemu_dsa_is_running(void);
>  
> +/**
> + * @brief Initializes a buffer zero DSA batch task.
> + *
> + * @param batch_size The number of zero page checking tasks in the batch.
> + * @return A pointer to the zero page checking tasks initialized.
> + */
> +QemuDsaBatchTask *
> +buffer_zero_batch_task_init(int batch_size);
> +
> +/**
> + * @brief Performs the proper cleanup on a DSA batch task.
> + *
> + * @param task A pointer to the batch task to cleanup.
> + */
> +void buffer_zero_batch_task_destroy(QemuDsaBatchTask *task);
> +
>  #else
>  
> +typedef struct QemuDsaBatchTask {} QemuDsaBatchTask;
> +
>  static inline bool qemu_dsa_is_running(void)
>  {
>      return false;
> @@ -114,19 +134,27 @@ static inline bool qemu_dsa_is_running(void)
>  
>  static inline int qemu_dsa_init(const strList *dsa_parameter, Error **errp)
>  {
> -    if (dsa_parameter != NULL && strlen(dsa_parameter) != 0) {
> -        error_setg(errp, "DSA is not supported.");
> -        return -1;
> -    }
> -
> -    return 0;
> +    error_setg(errp, "DSA accelerator is not enabled.");
> +    return -1;

This should have been fixed in the patch that introduced this function.

>  }
>  
>  static inline void qemu_dsa_start(void) {}
>  
>  static inline void qemu_dsa_stop(void) {}
>  
> -static inline void qemu_dsa_cleanup(void) {}

Where did this go?

> +static inline QemuDsaBatchTask *buffer_zero_batch_task_init(int batch_size)
> +{
> +    return NULL;
> +}
> +
> +static inline void buffer_zero_batch_task_destroy(QemuDsaBatchTask *task) {}
> +
> +static inline int
> +buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
> +                              const void **buf, size_t count, size_t len)
> +{
> +    return -1;
> +}
>  
>  #endif
>  
> diff --git a/util/dsa.c b/util/dsa.c
> index c3ca71df86..408c163195 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -48,6 +48,7 @@ uint32_t max_retry_count;
>  static QemuDsaDeviceGroup dsa_group;
>  static QemuDsaCompletionThread completion_thread;
>  
> +static void buffer_zero_dsa_completion(void *context);
>  
>  /**
>   * @brief This function opens a DSA device's work queue and
> @@ -174,7 +175,6 @@ dsa_device_group_start(QemuDsaDeviceGroup *group)
>   *
>   * @param group A pointer to the DSA device group.
>   */
> -__attribute__((unused))
>  static void
>  dsa_device_group_stop(QemuDsaDeviceGroup *group)
>  {
> @@ -210,7 +210,6 @@ dsa_device_group_cleanup(QemuDsaDeviceGroup *group)
>   * @return struct QemuDsaDevice* A pointer to the next available DSA device
>   *         in the group.
>   */
> -__attribute__((unused))
>  static QemuDsaDevice *
>  dsa_device_group_get_next_device(QemuDsaDeviceGroup *group)
>  {
> @@ -283,7 +282,6 @@ dsa_task_enqueue(QemuDsaDeviceGroup *group,
>   * @param group A pointer to the DSA device group.
>   * @return QemuDsaBatchTask* The DSA task being dequeued.
>   */
> -__attribute__((unused))
>  static QemuDsaBatchTask *
>  dsa_task_dequeue(QemuDsaDeviceGroup *group)
>  {
> @@ -338,22 +336,6 @@ submit_wi_int(void *wq, struct dsa_hw_desc *descriptor)
>      return 0;
>  }
>  
> -/**
> - * @brief Synchronously submits a DSA work item to the
> - *        device work queue.
> - *
> - * @param wq A pointer to the DSA work queue's device memory.
> - * @param descriptor A pointer to the DSA work item descriptor.
> - *
> - * @return int Zero if successful, non-zero otherwise.
> - */
> -__attribute__((unused))
> -static int
> -submit_wi(void *wq, struct dsa_hw_desc *descriptor)
> -{
> -    return submit_wi_int(wq, descriptor);
> -}
> -

Why is this being removed?

>  /**
>   * @brief Asynchronously submits a DSA work item to the
>   *        device work queue.
> @@ -362,7 +344,6 @@ submit_wi(void *wq, struct dsa_hw_desc *descriptor)
>   *
>   * @return int Zero if successful, non-zero otherwise.
>   */
> -__attribute__((unused))
>  static int
>  submit_wi_async(QemuDsaBatchTask *task)
>  {
> @@ -391,7 +372,6 @@ submit_wi_async(QemuDsaBatchTask *task)
>   *
>   * @return int Zero if successful, non-zero otherwise.
>   */
> -__attribute__((unused))
>  static int
>  submit_batch_wi_async(QemuDsaBatchTask *batch_task)
>  {
> @@ -750,3 +730,235 @@ void qemu_dsa_cleanup(void)
>      dsa_device_group_cleanup(&dsa_group);
>  }
>  
> +
> +/* Buffer zero comparison DSA task implementations */
> +/* =============================================== */
> +
> +/**
> + * @brief Sets a buffer zero comparison DSA task.
> + *
> + * @param descriptor A pointer to the DSA task descriptor.
> + * @param buf A pointer to the memory buffer.
> + * @param len The length of the buffer.
> + */
> +static void
> +buffer_zero_task_set_int(struct dsa_hw_desc *descriptor,
> +                         const void *buf,
> +                         size_t len)
> +{
> +    struct dsa_completion_record *completion =
> +        (struct dsa_completion_record *)descriptor->completion_addr;
> +
> +    descriptor->xfer_size = len;
> +    descriptor->src_addr = (uintptr_t)buf;
> +    completion->status = 0;
> +    completion->result = 0;
> +}
> +
> +/**
> + * @brief Resets a buffer zero comparison DSA batch task.
> + *
> + * @param task A pointer to the DSA batch task.
> + */
> +static void
> +buffer_zero_task_reset(QemuDsaBatchTask *task)
> +{
> +    task->completions[0].status = DSA_COMP_NONE;
> +    task->task_type = QEMU_DSA_TASK;
> +    task->status = QEMU_DSA_TASK_READY;
> +}
> +
> +/**
> + * @brief Resets a buffer zero comparison DSA batch task.
> + *
> + * @param task A pointer to the batch task.
> + * @param count The number of DSA tasks this batch task will contain.
> + */
> +static void
> +buffer_zero_batch_task_reset(QemuDsaBatchTask *task, size_t count)
> +{
> +    task->batch_completion.status = DSA_COMP_NONE;
> +    task->batch_descriptor.desc_count = count;
> +    task->task_type = QEMU_DSA_BATCH_TASK;
> +    task->status = QEMU_DSA_TASK_READY;
> +}
> +
> +/**
> + * @brief Sets a buffer zero comparison DSA task.
> + *
> + * @param task A pointer to the DSA task.
> + * @param buf A pointer to the memory buffer.
> + * @param len The buffer length.
> + */
> +static void
> +buffer_zero_task_set(QemuDsaBatchTask *task,
> +                     const void *buf,
> +                     size_t len)
> +{
> +    buffer_zero_task_reset(task);
> +    buffer_zero_task_set_int(&task->descriptors[0], buf, len);
> +}
> +
> +/**
> + * @brief Sets a buffer zero comparison batch task.
> + *
> + * @param batch_task A pointer to the batch task.
> + * @param buf An array of memory buffers.
> + * @param count The number of buffers in the array.
> + * @param len The length of the buffers.
> + */
> +static void
> +buffer_zero_batch_task_set(QemuDsaBatchTask *batch_task,
> +                           const void **buf, size_t count, size_t len)
> +{
> +    assert(count > 0);
> +    assert(count <= batch_task->batch_size);
> +
> +    buffer_zero_batch_task_reset(batch_task, count);
> +    for (int i = 0; i < count; i++) {
> +        buffer_zero_task_set_int(&batch_task->descriptors[i], buf[i], len);
> +    }
> +}
> +
> +/**
> + * @brief Asychronously perform a buffer zero DSA operation.
> + *
> + * @param task A pointer to the batch task structure.
> + * @param buf A pointer to the memory buffer.
> + * @param len The length of the memory buffer.
> + *
> + * @return int Zero if successful, otherwise an appropriate error code.
> + */
> +__attribute__((unused))
> +static int
> +buffer_zero_dsa_async(QemuDsaBatchTask *task,
> +                      const void *buf, size_t len)
> +{
> +    buffer_zero_task_set(task, buf, len);
> +
> +    return submit_wi_async(task);
> +}
> +
> +/**
> + * @brief Sends a memory comparison batch task to a DSA device and wait
> + *        for completion.
> + *
> + * @param batch_task The batch task to be submitted to DSA device.
> + * @param buf An array of memory buffers to check for zero.
> + * @param count The number of buffers.
> + * @param len The buffer length.
> + */
> +__attribute__((unused))
> +static int
> +buffer_zero_dsa_batch_async(QemuDsaBatchTask *batch_task,
> +                            const void **buf, size_t count, size_t len)
> +{
> +    assert(count <= batch_task->batch_size);
> +    buffer_zero_batch_task_set(batch_task, buf, count, len);
> +
> +    return submit_batch_wi_async(batch_task);
> +}
> +
> +/**
> + * @brief The completion callback function for buffer zero
> + *        comparison DSA task completion.
> + *
> + * @param context A pointer to the callback context.
> + */
> +static void
> +buffer_zero_dsa_completion(void *context)
> +{
> +    assert(context != NULL);
> +
> +    QemuDsaBatchTask *task = (QemuDsaBatchTask *)context;
> +    qemu_sem_post(&task->sem_task_complete);
> +}
> +
> +/**
> + * @brief Wait for the asynchronous DSA task to complete.
> + *
> + * @param batch_task A pointer to the buffer zero comparison batch task.
> + */
> +__attribute__((unused))
> +static void
> +buffer_zero_dsa_wait(QemuDsaBatchTask *batch_task)
> +{
> +    qemu_sem_wait(&batch_task->sem_task_complete);
> +}
> +
> +/**
> + * @brief Initializes a buffer zero comparison DSA task.
> + *
> + * @param descriptor A pointer to the DSA task descriptor.
> + * @param completion A pointer to the DSA task completion record.
> + */
> +static void
> +buffer_zero_task_init_int(struct dsa_hw_desc *descriptor,
> +                          struct dsa_completion_record *completion)
> +{
> +    descriptor->opcode = DSA_OPCODE_COMPVAL;
> +    descriptor->flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
> +    descriptor->comp_pattern = (uint64_t)0;
> +    descriptor->completion_addr = (uint64_t)completion;
> +}
> +
> +/**
> + * @brief Initializes a buffer zero DSA batch task.
> + *
> + * @param batch_size The number of zero page checking tasks in the batch.
> + * @return A pointer to the zero page checking tasks initialized.
> + */
> +QemuDsaBatchTask *
> +buffer_zero_batch_task_init(int batch_size)
> +{
> +    QemuDsaBatchTask *task = qemu_memalign(64, sizeof(QemuDsaBatchTask));
> +    int descriptors_size = sizeof(*task->descriptors) * batch_size;
> +
> +    memset(task, 0, sizeof(*task));
> +    task->addr = g_new0(ram_addr_t, batch_size);
> +    task->results = g_new0(bool, batch_size);
> +    task->batch_size = batch_size;
> +    task->descriptors =
> +        (struct dsa_hw_desc *)qemu_memalign(64, descriptors_size);
> +    memset(task->descriptors, 0, descriptors_size);
> +    task->completions = (struct dsa_completion_record *)qemu_memalign(
> +        32, sizeof(*task->completions) * batch_size);
> +
> +    task->batch_completion.status = DSA_COMP_NONE;
> +    task->batch_descriptor.completion_addr = (uint64_t)&task->batch_completion;
> +    /* TODO: Ensure that we never send a batch with count <= 1 */
> +    task->batch_descriptor.desc_count = 0;
> +    task->batch_descriptor.opcode = DSA_OPCODE_BATCH;
> +    task->batch_descriptor.flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
> +    task->batch_descriptor.desc_list_addr = (uintptr_t)task->descriptors;
> +    task->status = QEMU_DSA_TASK_READY;
> +    task->group = &dsa_group;
> +    task->device = dsa_device_group_get_next_device(&dsa_group);
> +
> +    for (int i = 0; i < task->batch_size; i++) {
> +        buffer_zero_task_init_int(&task->descriptors[i],
> +                                  &task->completions[i]);
> +    }
> +
> +    qemu_sem_init(&task->sem_task_complete, 0);
> +    task->completion_callback = buffer_zero_dsa_completion;
> +
> +    return task;
> +}
> +
> +/**
> + * @brief Performs the proper cleanup on a DSA batch task.
> + *
> + * @param task A pointer to the batch task to cleanup.
> + */
> +void
> +buffer_zero_batch_task_destroy(QemuDsaBatchTask *task)
> +{
> +    g_free(task->addr);
> +    g_free(task->results);
> +    qemu_vfree(task->descriptors);
> +    qemu_vfree(task->completions);
> +    task->results = NULL;
> +    qemu_sem_destroy(&task->sem_task_complete);
> +    qemu_vfree(task);
> +}

