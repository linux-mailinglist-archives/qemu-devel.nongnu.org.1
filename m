Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A081EAE1
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 01:09:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIHSY-0005FG-Fk; Tue, 26 Dec 2023 19:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rIHST-0005F3-Ka
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 19:07:37 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rIHSQ-0007w1-Mj
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 19:07:37 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55559e26ccfso45926a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1703635645; x=1704240445; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXKnxEVYcEkLJSadM8puvwzQfHuxpTirgHRnjcI9WGQ=;
 b=d8Q7yON0fBBDsUrc62EcuoPYiWBtn+AM2tR3xNEuQsgLBlqHidEh77+4ATvOwprZLf
 j3VzsMzr8VrLno1yMjBUoOHZtuKiYucLSr9xGYyusX4mXfXvXfluXq/dDn0wtB6csnJQ
 TSBZEjT9dPvIgRPVt58cPHIPevismCnH1s5lK6P9gQYdE/7QRJxNKrOAfbo6ghWAFzoK
 WfD3uAdIMMFT+pEfdO3U96DBPNzXWrtIUE5Q79k1ya9HZA0mI1KouzVi3KnBIz7Kep+w
 kq0GOgQIMHUoGYF4xy5JC7Fn8+GADWIS+v2d9aSgY7zSQnggAwjqCoDo4Ufslz8wCK3c
 xY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703635645; x=1704240445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXKnxEVYcEkLJSadM8puvwzQfHuxpTirgHRnjcI9WGQ=;
 b=cEViIltdeozsm2XVO8CvtVqYyWy5wO9EEQdjNuWVhsWPAPmZTbP7vrBQVc/4Ew8djg
 /RdOmCUREf6d6G0UHnoDg0G11Nk/VaEiqW8sqNxUKUrdRsJQjlDGJ3M5ABKlMDoz1/d9
 k5Feq9IhOBIdMQOiJBBWetdm0PbgY3VRe6Osgmykk0PjqkJD1PTJ+/K34asE0hyOaLu6
 +YgUrOU2KlPuYlwWJs4h3FHceUW7AXbR7OrJL29bs4/fpputEmaTRSVrKPLui25Ar4aS
 W2flL2uk864eX6g9deeQpN6qBtOybZ4/1SPRNLHt4W7ulx3C01YsJ98Sy9PgApFN0aZp
 l9JQ==
X-Gm-Message-State: AOJu0YxO3xMOtuXylsyqT9unXbO5McgBm1mNVCOIRhEN7QWpgZfxg4tz
 ikdNvTaYx4cJ2EKWNJIdMRl7U4eWYtTZu4BOGPo9MK61EA0Sew==
X-Google-Smtp-Source: AGHT+IEq5JZev3rLRLFsTve0QOxQM3Nx8QcBUlASvTHTnjcllDj4F7hUho4LkmkBADtOxr+auegzilocxb68qioFsK8=
X-Received: by 2002:a50:ab50:0:b0:551:90f1:125b with SMTP id
 t16-20020a50ab50000000b0055190f1125bmr3803805edc.23.1703635645321; Tue, 26
 Dec 2023 16:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-9-hao.xiang@bytedance.com> <87msufwge7.fsf@suse.de>
In-Reply-To: <87msufwge7.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 26 Dec 2023 16:07:14 -0800
Message-ID: <CAAYibXjQ=Q8tThX-fO2XBcXkw_oKc8A+vMe5ZNg8ouA94n9kUg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 08/20] util/dsa: Implement DSA task
 enqueue and dequeue.
To: Fabiano Rosas <farosas@suse.de>
Cc: peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com, 
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Dec 12, 2023 at 8:10=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > * Use a safe thread queue for DSA task enqueue/dequeue.
> > * Implement DSA task submission.
> > * Implement DSA batch task submission.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  include/qemu/dsa.h |  35 ++++++++
> >  util/dsa.c         | 196 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 231 insertions(+)
> >
> > diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> > index 30246b507e..23f55185be 100644
> > --- a/include/qemu/dsa.h
> > +++ b/include/qemu/dsa.h
> > @@ -12,6 +12,41 @@
> >  #include <linux/idxd.h>
> >  #include "x86intrin.h"
> >
> > +enum dsa_task_type {
>
> Our coding style requires CamelCase for enums and typedef'ed structures.

When I wrote this, I found numerous instances where snake case and no
typedef enum are used. But I do see the camel case and typedef'ed
instances now. Converted to that.

>
> > +    DSA_TASK =3D 0,
> > +    DSA_BATCH_TASK
> > +};
> > +
> > +enum dsa_task_status {
> > +    DSA_TASK_READY =3D 0,
> > +    DSA_TASK_PROCESSING,
> > +    DSA_TASK_COMPLETION
> > +};
> > +
> > +typedef void (*buffer_zero_dsa_completion_fn)(void *);
>
> We don't really need the "buffer_zero" mention in any of this
> code. Simply dsa_batch_task or batch_task would suffice.

I removed "buffer_zero" prefix in some of the places.

>
> > +
> > +typedef struct buffer_zero_batch_task {
> > +    struct dsa_hw_desc batch_descriptor;
> > +    struct dsa_hw_desc *descriptors;
> > +    struct dsa_completion_record batch_completion __attribute__((align=
ed(32)));
> > +    struct dsa_completion_record *completions;
> > +    struct dsa_device_group *group;
> > +    struct dsa_device *device;
> > +    buffer_zero_dsa_completion_fn completion_callback;
> > +    QemuSemaphore sem_task_complete;
> > +    enum dsa_task_type task_type;
> > +    enum dsa_task_status status;
> > +    bool *results;
> > +    int batch_size;
> > +    QSIMPLEQ_ENTRY(buffer_zero_batch_task) entry;
> > +} buffer_zero_batch_task;
>
> I see data specific to this implementation and data coming from the
> library, maybe these would be better organized in two separate
> structures with the qemu-specific having a pointer to the generic
> one. Looking ahead in the series, there seems to be migration data
> coming into this as well.

I refactored to create a generic structure batch_task and a DSA
specific version dsa_batch_task. batch_task has a pointer to
dsa_batch_task if DSA compilation option is enabled.

>
> > +
> > +#else
> > +
> > +struct buffer_zero_batch_task {
> > +    bool *results;
> > +};
> > +
> >  #endif
> >
> >  /**
> > diff --git a/util/dsa.c b/util/dsa.c
> > index 8edaa892ec..f82282ce99 100644
> > --- a/util/dsa.c
> > +++ b/util/dsa.c
> > @@ -245,6 +245,200 @@ dsa_device_group_get_next_device(struct dsa_devic=
e_group *group)
> >      return &group->dsa_devices[current];
> >  }
> >
> > +/**
> > + * @brief Empties out the DSA task queue.
> > + *
> > + * @param group A pointer to the DSA device group.
> > + */
> > +static void
> > +dsa_empty_task_queue(struct dsa_device_group *group)
> > +{
> > +    qemu_mutex_lock(&group->task_queue_lock);
> > +    dsa_task_queue *task_queue =3D &group->task_queue;
> > +    while (!QSIMPLEQ_EMPTY(task_queue)) {
> > +        QSIMPLEQ_REMOVE_HEAD(task_queue, entry);
> > +    }
> > +    qemu_mutex_unlock(&group->task_queue_lock);
> > +}
> > +
> > +/**
> > + * @brief Adds a task to the DSA task queue.
> > + *
> > + * @param group A pointer to the DSA device group.
> > + * @param context A pointer to the DSA task to enqueue.
> > + *
> > + * @return int Zero if successful, otherwise a proper error code.
> > + */
> > +static int
> > +dsa_task_enqueue(struct dsa_device_group *group,
> > +                 struct buffer_zero_batch_task *task)
> > +{
> > +    dsa_task_queue *task_queue =3D &group->task_queue;
> > +    QemuMutex *task_queue_lock =3D &group->task_queue_lock;
> > +    QemuCond *task_queue_cond =3D &group->task_queue_cond;
> > +
> > +    bool notify =3D false;
> > +
> > +    qemu_mutex_lock(task_queue_lock);
> > +
> > +    if (!group->running) {
> > +        fprintf(stderr, "DSA: Tried to queue task to stopped device qu=
eue\n");
> > +        qemu_mutex_unlock(task_queue_lock);
> > +        return -1;
> > +    }
> > +
> > +    // The queue is empty. This enqueue operation is a 0->1 transition=
.
> > +    if (QSIMPLEQ_EMPTY(task_queue))
> > +        notify =3D true;
> > +
> > +    QSIMPLEQ_INSERT_TAIL(task_queue, task, entry);
> > +
> > +    // We need to notify the waiter for 0->1 transitions.
> > +    if (notify)
> > +        qemu_cond_signal(task_queue_cond);
> > +
> > +    qemu_mutex_unlock(task_queue_lock);
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * @brief Takes a DSA task out of the task queue.
> > + *
> > + * @param group A pointer to the DSA device group.
> > + * @return buffer_zero_batch_task* The DSA task being dequeued.
> > + */
> > +__attribute__((unused))
> > +static struct buffer_zero_batch_task *
> > +dsa_task_dequeue(struct dsa_device_group *group)
> > +{
> > +    struct buffer_zero_batch_task *task =3D NULL;
> > +    dsa_task_queue *task_queue =3D &group->task_queue;
> > +    QemuMutex *task_queue_lock =3D &group->task_queue_lock;
> > +    QemuCond *task_queue_cond =3D &group->task_queue_cond;
> > +
> > +    qemu_mutex_lock(task_queue_lock);
> > +
> > +    while (true) {
> > +        if (!group->running)
> > +            goto exit;
> > +        task =3D QSIMPLEQ_FIRST(task_queue);
> > +        if (task !=3D NULL) {
> > +            break;
> > +        }
> > +        qemu_cond_wait(task_queue_cond, task_queue_lock);
> > +    }
> > +
> > +    QSIMPLEQ_REMOVE_HEAD(task_queue, entry);
> > +
> > +exit:
> > +    qemu_mutex_unlock(task_queue_lock);
> > +    return task;
> > +}
> > +
> > +/**
> > + * @brief Submits a DSA work item to the device work queue.
> > + *
> > + * @param wq A pointer to the DSA work queue's device memory.
> > + * @param descriptor A pointer to the DSA work item descriptor.
> > + *
> > + * @return Zero if successful, non-zero otherwise.
> > + */
> > +static int
> > +submit_wi_int(void *wq, struct dsa_hw_desc *descriptor)
> > +{
> > +    uint64_t retry =3D 0;
> > +
> > +    _mm_sfence();
> > +
> > +    while (true) {
> > +        if (_enqcmd(wq, descriptor) =3D=3D 0) {
> > +            break;
> > +        }
> > +        retry++;
> > +        if (retry > max_retry_count) {
>
> 'max_retry_count' is UINT64_MAX so 'retry' will wrap around.
>
> > +            fprintf(stderr, "Submit work retry %lu times.\n", retry);
> > +            exit(1);
>
> Is this not the case where we'd fallback to the CPU?

"retry" here means _enqcmd returned a failure because the shared DSA
queue is full. When we run out of retry counts, we definitely have a
bug that prevents any DSA task from completing. So this situation is
really not expected and we don't want to fallback to use CPU.

>
> You should not exit() here, but return non-zero as the documentation
> mentions and the callers expect.

 I will propagate this error all the way up to multifd_send_thread.

>
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * @brief Synchronously submits a DSA work item to the
> > + *        device work queue.
> > + *
> > + * @param wq A pointer to the DSA worjk queue's device memory.
> > + * @param descriptor A pointer to the DSA work item descriptor.
> > + *
> > + * @return int Zero if successful, non-zero otherwise.
> > + */
> > +__attribute__((unused))
> > +static int
> > +submit_wi(void *wq, struct dsa_hw_desc *descriptor)
> > +{
> > +    return submit_wi_int(wq, descriptor);
> > +}
> > +
> > +/**
> > + * @brief Asynchronously submits a DSA work item to the
> > + *        device work queue.
> > + *
> > + * @param task A pointer to the buffer zero task.
> > + *
> > + * @return int Zero if successful, non-zero otherwise.
> > + */
> > +__attribute__((unused))
> > +static int
> > +submit_wi_async(struct buffer_zero_batch_task *task)
> > +{
> > +    struct dsa_device_group *device_group =3D task->group;
> > +    struct dsa_device *device_instance =3D task->device;
> > +    int ret;
> > +
> > +    assert(task->task_type =3D=3D DSA_TASK);
> > +
> > +    task->status =3D DSA_TASK_PROCESSING;
> > +
> > +    ret =3D submit_wi_int(device_instance->work_queue,
> > +                        &task->descriptors[0]);
> > +    if (ret !=3D 0)
> > +        return ret;
> > +
> > +    return dsa_task_enqueue(device_group, task);
> > +}
> > +
> > +/**
> > + * @brief Asynchronously submits a DSA batch work item to the
> > + *        device work queue.
> > + *
> > + * @param batch_task A pointer to the batch buffer zero task.
> > + *
> > + * @return int Zero if successful, non-zero otherwise.
> > + */
> > +__attribute__((unused))
> > +static int
> > +submit_batch_wi_async(struct buffer_zero_batch_task *batch_task)
> > +{
> > +    struct dsa_device_group *device_group =3D batch_task->group;
> > +    struct dsa_device *device_instance =3D batch_task->device;
> > +    int ret;
> > +
> > +    assert(batch_task->task_type =3D=3D DSA_BATCH_TASK);
> > +    assert(batch_task->batch_descriptor.desc_count <=3D batch_task->ba=
tch_size);
> > +    assert(batch_task->status =3D=3D DSA_TASK_READY);
> > +
> > +    batch_task->status =3D DSA_TASK_PROCESSING;
> > +
> > +    ret =3D submit_wi_int(device_instance->work_queue,
> > +                        &batch_task->batch_descriptor);
> > +    if (ret !=3D 0)
> > +        return ret;
> > +
> > +    return dsa_task_enqueue(device_group, batch_task);
> > +}
>
> At this point in the series submit_wi_async() and
> submit_batch_wi_async() look the same to me without the asserts. Can't
> we consolidate them?
>
> There's also the fact that both functions receive a _batch_ task but one
> is supposed to work in batches and the other is not. That could be
> solved by renaming the structure I guess.

So we do need to have two functions to handle a single task and a
batch task respectively. This is due to how DSA is designed at the
lower level. When we submit a task to DSA hardware, the task
description can be an individual task or a batch task containing a
pointer to an array of individual tasks. The workflow tries to
aggregate a lot of individual tasks and put them into a batch task.
However, there are times when only 1 task is available but DSA doesn't
accept a batch task description with only 1 individual task in it so
we always need a path to submit an individual task. I used to have two
data structures representing an individual task and a batch task but I
converged them into the batch task right now. The two functions are
just using different fields of the same structure to process
individual task vs batch task. submit_wi_async and
submit_batch_wi_async are different on the actual descriptor passed
into the submit_wi_int call. Yes, the two functions look similar but
they are not completely the same and because its implementation is so
simple it doesn't worth adding a unified helper layer to have them
both calling that helper layer. I went back and forth between the
current implementation and the solution you suggested but ended up
using the current implementation. But let me know if you still prefer
a converged helper function.

>
> > +
> >  /**
> >   * @brief Check if DSA is running.
> >   *
> > @@ -301,6 +495,8 @@ void dsa_stop(void)
> >      if (!group->running) {
> >          return;
> >      }
> > +
> > +    dsa_empty_task_queue(group);
> >  }
> >
> >  /**

