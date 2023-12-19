Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53F8180DC
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 06:13:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFSPG-0005pb-5d; Tue, 19 Dec 2023 00:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rFSPC-0005pP-RI
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 00:12:35 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rFSP9-0006RL-Aa
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 00:12:34 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3363aa1b7d2so3896849f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 21:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1702962747; x=1703567547; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibGzIztVP9yqVAYiX+TQfgyRlHGzOUCLw+bvzmfw9s0=;
 b=aAi0K5kRijOEpkr2fmUTbe+Uz28iHIgjrdBZjTCF9YpNJn0yAmYy46obfKq08l903r
 8bqj614yPLQ4GkNl1T6a5AYTkGqIzacMwe2DHpvG3NMJRMisRWklnmL7AQag++eR+hmr
 l+5yPsY8KDaMJQ3yvq+Y4Z/za119Zu11ZPZYym/0xrI7O9F/8+MLY6MFoyzZKdLhMcS6
 LP+45Q91TMj/25a2wQ/OAdpXmBj/rOVjxBkHBMeQquOpuS8WbTq/3nzaDUVPW0Xr86Zf
 X4gK9VyUTVZlD9J5uOdAmvKR0Rl91XCHs2ra1gPXxf0lGljqM8GT69Mag9eP3uushKKE
 Cbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702962747; x=1703567547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ibGzIztVP9yqVAYiX+TQfgyRlHGzOUCLw+bvzmfw9s0=;
 b=Aoo+DIzUZBL+sIQ53ORuSsYaG7kyIYeZXFNfLaq2W6Q834Ri8YKDPP754oxnusFBJ8
 VPimZlC0F34UkrNZc874JwLrJQNO76/7dmtHpAaxVUvNHyhL7dZrme66seElOIKWh4cF
 q82hEm8Otk5BkmC96ZRnUTEH1xETEuQEzDai+WVCQQ2SaTUZymRNwiN7F+BBIAZ4VrhQ
 2DvaxBtQM7H+uK4ISWI7cfdEIlLDElvCCqLzh/EM+HrOwOMhuV/H8YrgcPN0XJCD1X/E
 z52oe3sEPkeSc8LKsJnMxym8MySnF112QSrr5ObhqpF+AJea8GP68D+50a65OTel+lB3
 Wfig==
X-Gm-Message-State: AOJu0Yym6bYBajm0re12B11FF+31DrqyVJCvZdr6AYBJGgLztL4DcZR5
 HKDI1zeaH+7lymE4PqRNtneIGNR6JQZH3MBcFriIuQ==
X-Google-Smtp-Source: AGHT+IE1feEKD8H64AcOMRCN3mKbbRHRj/dgRvlQzz7dTDlUoziu/GsJCznHTwVpqNGKZPhyhB+21yNZTtYQRZU0Xqs=
X-Received: by 2002:a05:6000:4e8:b0:332:fe7e:2a36 with SMTP id
 cr8-20020a05600004e800b00332fe7e2a36mr5698812wrb.30.1702962747343; Mon, 18
 Dec 2023 21:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-10-hao.xiang@bytedance.com>
 <543e9270-4ab7-4096-bda7-187dd9be47ef@intel.com>
 <CAAYibXh4YeePb4rZNxLjo+UAed51cV+0zE7pxaS9zGn2=aDXOw@mail.gmail.com>
 <6ec82a24-f040-43a9-a81d-b5dad0e07a22@intel.com>
In-Reply-To: <6ec82a24-f040-43a9-a81d-b5dad0e07a22@intel.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 18 Dec 2023 21:12:15 -0800
Message-ID: <CAAYibXiiP1g5s=wRnOMn8KMpUptPRoGMr8RzgHWNPqOaAoC52g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 09/20] util/dsa: Implement DSA task
 asynchronous completion thread model.
To: "Wang, Lei" <lei4.wang@intel.com>
Cc: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com, 
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=hao.xiang@bytedance.com; helo=mail-wr1-x436.google.com
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

On Mon, Dec 18, 2023 at 5:34=E2=80=AFPM Wang, Lei <lei4.wang@intel.com> wro=
te:
>
> On 12/19/2023 2:57, Hao Xiang wrote:> On Sun, Dec 17, 2023 at 7:11=E2=80=
=AFPM Wang, Lei
> <lei4.wang@intel.com> wrote:
> >>
> >> On 11/14/2023 13:40, Hao Xiang wrote:> * Create a dedicated thread for=
 DSA task
> >> completion.
> >>> * DSA completion thread runs a loop and poll for completed tasks.
> >>> * Start and stop DSA completion thread during DSA device start stop.
> >>>
> >>> User space application can directly submit task to Intel DSA
> >>> accelerator by writing to DSA's device memory (mapped in user space).
> >>
> >>> +            }
> >>> +            return;
> >>> +        }
> >>> +    } else {
> >>> +        assert(batch_status =3D=3D DSA_COMP_BATCH_FAIL ||
> >>> +            batch_status =3D=3D DSA_COMP_BATCH_PAGE_FAULT);
> >>
> >> Nit: indentation is broken here.
> >>
> >>> +    }
> >>> +
> >>> +    for (int i =3D 0; i < count; i++) {
> >>> +
> >>> +        completion =3D &batch_task->completions[i];
> >>> +        status =3D completion->status;
> >>> +
> >>> +        if (status =3D=3D DSA_COMP_SUCCESS) {
> >>> +            results[i] =3D (completion->result =3D=3D 0);
> >>> +            continue;
> >>> +        }
> >>> +
> >>> +        if (status !=3D DSA_COMP_PAGE_FAULT_NOBOF) {
> >>> +            fprintf(stderr,
> >>> +                    "Unexpected completion status =3D %u.\n", status=
);
> >>> +            assert(false);
> >>> +        }
> >>> +    }
> >>> +}
> >>> +
> >>> +/**
> >>> + * @brief Handles an asynchronous DSA batch task completion.
> >>> + *
> >>> + * @param task A pointer to the batch buffer zero task structure.
> >>> + */
> >>> +static void
> >>> +dsa_batch_task_complete(struct buffer_zero_batch_task *batch_task)
> >>> +{
> >>> +    batch_task->status =3D DSA_TASK_COMPLETION;
> >>> +    batch_task->completion_callback(batch_task);
> >>> +}
> >>> +
> >>> +/**
> >>> + * @brief The function entry point called by a dedicated DSA
> >>> + *        work item completion thread.
> >>> + *
> >>> + * @param opaque A pointer to the thread context.
> >>> + *
> >>> + * @return void* Not used.
> >>> + */
> >>> +static void *
> >>> +dsa_completion_loop(void *opaque)
> >>
> >> Per my understanding, if a multifd sending thread corresponds to a DSA=
 device,
> >> then the batch tasks are executed in parallel which means a task may b=
e
> >> completed slower than another even if this task is enqueued earlier th=
an it. If
> >> we poll on the slower task first it will block the handling of the fas=
ter one,
> >> even if the zero checking task for that thread is finished and it can =
go ahead
> >> and send the data to the wire, this may lower the network resource uti=
lization.
> >>
> >
> > Hi Lei, thanks for reviewing. You are correct that we can keep pulling
> > a task enqueued first while others in the queue have already been
> > completed. In fact, only one DSA completion thread (pulling thread) is
> > used here even when multiple DSA devices are used. The pulling loop is
> > the most CPU intensive activity in the DSA workflow and that acts
> > directly against the goal of saving CPU usage. The trade-off I want to
> > take here is a slightly higher latency on DSA task completion but more
> > CPU savings. A single DSA engine can reach 30 GB/s throughput on
> > memory comparison operation. We use kernel tcp stack for network
> > transfer. The best I see is around 10GB/s throughput.  RDMA can
> > potentially go higher but I am not sure if it can go higher than 30
> > GB/s throughput anytime soon.
>
> Hi Hao, that makes sense, if the DSA is faster than the network, then a l=
ittle
> bit of latency in DSA checking is tolerable. In the long term, I think th=
e best
> form of the DSA task checking thread is to use an fd or such sort of thin=
g that
> can multiplex the checking of different DSA devices, then we can serve th=
e DSA
> task in the order they complete rather than FCFS.
>
I have experimented using N completion threads and each thread pulls
tasks submitted to a particular DSA device. That approach uses too
many CPU cycles. If Intel can come up with a better workflow for DSA
completion, there is definitely space for improvement here.
> >
> >>> +{
> >>> +    struct dsa_completion_thread *thread_context =3D
> >>> +        (struct dsa_completion_thread *)opaque;
> >>> +    struct buffer_zero_batch_task *batch_task;
> >>> +    struct dsa_device_group *group =3D thread_context->group;
> >>> +
> >>> +    rcu_register_thread();
> >>> +
> >>> +    thread_context->thread_id =3D qemu_get_thread_id();
> >>> +    qemu_sem_post(&thread_context->sem_init_done);
> >>> +
> >>> +    while (thread_context->running) {
> >>> +        batch_task =3D dsa_task_dequeue(group);
> >>> +        assert(batch_task !=3D NULL || !group->running);
> >>> +        if (!group->running) {
> >>> +            assert(!thread_context->running);
> >>> +            break;
> >>> +        }
> >>> +        if (batch_task->task_type =3D=3D DSA_TASK) {
> >>> +            poll_task_completion(batch_task);
> >>> +        } else {
> >>> +            assert(batch_task->task_type =3D=3D DSA_BATCH_TASK);
> >>> +            poll_batch_task_completion(batch_task);
> >>> +        }
> >>> +
> >>> +        dsa_batch_task_complete(batch_task);
> >>> +    }
> >>> +
> >>> +    rcu_unregister_thread();
> >>> +    return NULL;
> >>> +}
> >>> +
> >>> +/**
> >>> + * @brief Initializes a DSA completion thread.
> >>> + *
> >>> + * @param completion_thread A pointer to the completion thread conte=
xt.
> >>> + * @param group A pointer to the DSA device group.
> >>> + */
> >>> +static void
> >>> +dsa_completion_thread_init(
> >>> +    struct dsa_completion_thread *completion_thread,
> >>> +    struct dsa_device_group *group)
> >>> +{
> >>> +    completion_thread->stopping =3D false;
> >>> +    completion_thread->running =3D true;
> >>> +    completion_thread->thread_id =3D -1;
> >>> +    qemu_sem_init(&completion_thread->sem_init_done, 0);
> >>> +    completion_thread->group =3D group;
> >>> +
> >>> +    qemu_thread_create(&completion_thread->thread,
> >>> +                       DSA_COMPLETION_THREAD,
> >>> +                       dsa_completion_loop,
> >>> +                       completion_thread,
> >>> +                       QEMU_THREAD_JOINABLE);
> >>> +
> >>> +    /* Wait for initialization to complete */
> >>> +    while (completion_thread->thread_id =3D=3D -1) {
> >>> +        qemu_sem_wait(&completion_thread->sem_init_done);
> >>> +    }
> >>> +}
> >>> +
> >>> +/**
> >>> + * @brief Stops the completion thread (and implicitly, the device gr=
oup).
> >>> + *
> >>> + * @param opaque A pointer to the completion thread.
> >>> + */
> >>> +static void dsa_completion_thread_stop(void *opaque)
> >>> +{
> >>> +    struct dsa_completion_thread *thread_context =3D
> >>> +        (struct dsa_completion_thread *)opaque;
> >>> +
> >>> +    struct dsa_device_group *group =3D thread_context->group;
> >>> +
> >>> +    qemu_mutex_lock(&group->task_queue_lock);
> >>> +
> >>> +    thread_context->stopping =3D true;
> >>> +    thread_context->running =3D false;
> >>> +
> >>> +    dsa_device_group_stop(group);
> >>> +
> >>> +    qemu_cond_signal(&group->task_queue_cond);
> >>> +    qemu_mutex_unlock(&group->task_queue_lock);
> >>> +
> >>> +    qemu_thread_join(&thread_context->thread);
> >>> +
> >>> +    qemu_sem_destroy(&thread_context->sem_init_done);
> >>> +}
> >>> +
> >>>  /**
> >>>   * @brief Check if DSA is running.
> >>>   *
> >>> @@ -446,7 +685,7 @@ submit_batch_wi_async(struct buffer_zero_batch_ta=
sk *batch_task)
> >>>   */
> >>>  bool dsa_is_running(void)
> >>>  {
> >>> -    return false;
> >>> +    return completion_thread.running;
> >>>  }
> >>>
> >>>  static void
> >>> @@ -481,6 +720,7 @@ void dsa_start(void)
> >>>          return;
> >>>      }
> >>>      dsa_device_group_start(&dsa_group);
> >>> +    dsa_completion_thread_init(&completion_thread, &dsa_group);
> >>>  }
> >>>
> >>>  /**
> >>> @@ -496,6 +736,7 @@ void dsa_stop(void)
> >>>          return;
> >>>      }
> >>>
> >>> +    dsa_completion_thread_stop(&completion_thread);
> >>>      dsa_empty_task_queue(group);
> >>>  }
> >>>

