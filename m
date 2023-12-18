Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC69817A3E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:58:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIoC-00082f-0p; Mon, 18 Dec 2023 13:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rFIo9-00081t-OL
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 13:57:41 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rFIo7-0000l3-10
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 13:57:41 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0835bso4332655a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 10:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1702925857; x=1703530657; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiBgI8mbD9ydyoUYvjFmAISZqtaAA416yKQoSAftD30=;
 b=O71XdosXYknS1/C/weQPsgJAFyapu2WSEOBFEGvp3zR/g/UqWvS2oel6ainjQRqmaq
 VxLCOlxJ+6dyBHmPA48sEYF4JGY9C1g6K2QMHV5v2dNTcWH7Lh84Awpym+0+hBkhKAQJ
 hs0jf7N9s1uuNe7eX11x1yu5GEmsk3vlXi4DLwXBmTXLIx4bLP2YSIqgrLky/cP4axBk
 mZasWOOE1b9ctWWZKMBSDku6l8T8BHwe+rN7S6u91lJVxpPCVWSSZIK4Wem4hWjy4qnc
 LucXUd55hssm81DY4rOl2qE+k9c7JEN0Ct+3yx7DSPeUBNiwdUtndPFVa5WjRNskNx07
 QNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925857; x=1703530657;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SiBgI8mbD9ydyoUYvjFmAISZqtaAA416yKQoSAftD30=;
 b=ClwAHnggewtgi6vBVjuXYtPfmDT9Y2IE4ovcDb/o7lj4TXWCOOZVBG7JzeLKlEVJkP
 sqmS7EWI+wH/OFhnhoUEkhlj5R65Z+EhNBRflY2QRd1eKcR+3dLlsHyLm+H6XGCEFumH
 MGGcx65OlRXqL06Hyg/SS1z6U2A44ijs/3NLWNDHGPPNlw5jF1xr9+kjAOOw820Bw9SO
 0cBbuNc780GMGvXK4IO7S6KZdC1Wzev+B+MayaZ6Yc/Duczgcy9qwjN58zEJC3oUPA9g
 Q3aj1AnxACnnqpkA0xqBpklGw3AwmwvQh/T9dNYX3HATUNoe3aHXlf+VufcTEeJ6Gf0M
 YtmQ==
X-Gm-Message-State: AOJu0YwX7HzP8T1GaYKG9fmGjmBPLtGt0AOBNJFpc4ix4ngGIcSlIOxb
 hyaFpJ7Ljt74TTM6MY51QQgms4Vwcn71cTFecgKOfQ==
X-Google-Smtp-Source: AGHT+IGDSyYJPy8PLkQoS6cPDfuYJVxAViqSd1QgfIFDEjfAeBzKBgvqTr5AuVq6ILHzRgXfT6wDi5ryTff8uRytqMk=
X-Received: by 2002:a17:906:208d:b0:a23:3753:c64c with SMTP id
 13-20020a170906208d00b00a233753c64cmr1902452ejq.57.1702925856846; Mon, 18 Dec
 2023 10:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-10-hao.xiang@bytedance.com>
 <543e9270-4ab7-4096-bda7-187dd9be47ef@intel.com>
In-Reply-To: <543e9270-4ab7-4096-bda7-187dd9be47ef@intel.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 18 Dec 2023 10:57:25 -0800
Message-ID: <CAAYibXh4YeePb4rZNxLjo+UAed51cV+0zE7pxaS9zGn2=aDXOw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 09/20] util/dsa: Implement DSA task
 asynchronous completion thread model.
To: "Wang, Lei" <lei4.wang@intel.com>
Cc: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com, 
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x52f.google.com
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

On Sun, Dec 17, 2023 at 7:11=E2=80=AFPM Wang, Lei <lei4.wang@intel.com> wro=
te:
>
> On 11/14/2023 13:40, Hao Xiang wrote:> * Create a dedicated thread for DS=
A task
> completion.
> > * DSA completion thread runs a loop and poll for completed tasks.
> > * Start and stop DSA completion thread during DSA device start stop.
> >
> > User space application can directly submit task to Intel DSA
> > accelerator by writing to DSA's device memory (mapped in user space).
>
> > +            }
> > +            return;
> > +        }
> > +    } else {
> > +        assert(batch_status =3D=3D DSA_COMP_BATCH_FAIL ||
> > +            batch_status =3D=3D DSA_COMP_BATCH_PAGE_FAULT);
>
> Nit: indentation is broken here.
>
> > +    }
> > +
> > +    for (int i =3D 0; i < count; i++) {
> > +
> > +        completion =3D &batch_task->completions[i];
> > +        status =3D completion->status;
> > +
> > +        if (status =3D=3D DSA_COMP_SUCCESS) {
> > +            results[i] =3D (completion->result =3D=3D 0);
> > +            continue;
> > +        }
> > +
> > +        if (status !=3D DSA_COMP_PAGE_FAULT_NOBOF) {
> > +            fprintf(stderr,
> > +                    "Unexpected completion status =3D %u.\n", status);
> > +            assert(false);
> > +        }
> > +    }
> > +}
> > +
> > +/**
> > + * @brief Handles an asynchronous DSA batch task completion.
> > + *
> > + * @param task A pointer to the batch buffer zero task structure.
> > + */
> > +static void
> > +dsa_batch_task_complete(struct buffer_zero_batch_task *batch_task)
> > +{
> > +    batch_task->status =3D DSA_TASK_COMPLETION;
> > +    batch_task->completion_callback(batch_task);
> > +}
> > +
> > +/**
> > + * @brief The function entry point called by a dedicated DSA
> > + *        work item completion thread.
> > + *
> > + * @param opaque A pointer to the thread context.
> > + *
> > + * @return void* Not used.
> > + */
> > +static void *
> > +dsa_completion_loop(void *opaque)
>
> Per my understanding, if a multifd sending thread corresponds to a DSA de=
vice,
> then the batch tasks are executed in parallel which means a task may be
> completed slower than another even if this task is enqueued earlier than =
it. If
> we poll on the slower task first it will block the handling of the faster=
 one,
> even if the zero checking task for that thread is finished and it can go =
ahead
> and send the data to the wire, this may lower the network resource utiliz=
ation.
>

Hi Lei, thanks for reviewing. You are correct that we can keep pulling
a task enqueued first while others in the queue have already been
completed. In fact, only one DSA completion thread (pulling thread) is
used here even when multiple DSA devices are used. The pulling loop is
the most CPU intensive activity in the DSA workflow and that acts
directly against the goal of saving CPU usage. The trade-off I want to
take here is a slightly higher latency on DSA task completion but more
CPU savings. A single DSA engine can reach 30 GB/s throughput on
memory comparison operation. We use kernel tcp stack for network
transfer. The best I see is around 10GB/s throughput.  RDMA can
potentially go higher but I am not sure if it can go higher than 30
GB/s throughput anytime soon.

> > +{
> > +    struct dsa_completion_thread *thread_context =3D
> > +        (struct dsa_completion_thread *)opaque;
> > +    struct buffer_zero_batch_task *batch_task;
> > +    struct dsa_device_group *group =3D thread_context->group;
> > +
> > +    rcu_register_thread();
> > +
> > +    thread_context->thread_id =3D qemu_get_thread_id();
> > +    qemu_sem_post(&thread_context->sem_init_done);
> > +
> > +    while (thread_context->running) {
> > +        batch_task =3D dsa_task_dequeue(group);
> > +        assert(batch_task !=3D NULL || !group->running);
> > +        if (!group->running) {
> > +            assert(!thread_context->running);
> > +            break;
> > +        }
> > +        if (batch_task->task_type =3D=3D DSA_TASK) {
> > +            poll_task_completion(batch_task);
> > +        } else {
> > +            assert(batch_task->task_type =3D=3D DSA_BATCH_TASK);
> > +            poll_batch_task_completion(batch_task);
> > +        }
> > +
> > +        dsa_batch_task_complete(batch_task);
> > +    }
> > +
> > +    rcu_unregister_thread();
> > +    return NULL;
> > +}
> > +
> > +/**
> > + * @brief Initializes a DSA completion thread.
> > + *
> > + * @param completion_thread A pointer to the completion thread context=
.
> > + * @param group A pointer to the DSA device group.
> > + */
> > +static void
> > +dsa_completion_thread_init(
> > +    struct dsa_completion_thread *completion_thread,
> > +    struct dsa_device_group *group)
> > +{
> > +    completion_thread->stopping =3D false;
> > +    completion_thread->running =3D true;
> > +    completion_thread->thread_id =3D -1;
> > +    qemu_sem_init(&completion_thread->sem_init_done, 0);
> > +    completion_thread->group =3D group;
> > +
> > +    qemu_thread_create(&completion_thread->thread,
> > +                       DSA_COMPLETION_THREAD,
> > +                       dsa_completion_loop,
> > +                       completion_thread,
> > +                       QEMU_THREAD_JOINABLE);
> > +
> > +    /* Wait for initialization to complete */
> > +    while (completion_thread->thread_id =3D=3D -1) {
> > +        qemu_sem_wait(&completion_thread->sem_init_done);
> > +    }
> > +}
> > +
> > +/**
> > + * @brief Stops the completion thread (and implicitly, the device grou=
p).
> > + *
> > + * @param opaque A pointer to the completion thread.
> > + */
> > +static void dsa_completion_thread_stop(void *opaque)
> > +{
> > +    struct dsa_completion_thread *thread_context =3D
> > +        (struct dsa_completion_thread *)opaque;
> > +
> > +    struct dsa_device_group *group =3D thread_context->group;
> > +
> > +    qemu_mutex_lock(&group->task_queue_lock);
> > +
> > +    thread_context->stopping =3D true;
> > +    thread_context->running =3D false;
> > +
> > +    dsa_device_group_stop(group);
> > +
> > +    qemu_cond_signal(&group->task_queue_cond);
> > +    qemu_mutex_unlock(&group->task_queue_lock);
> > +
> > +    qemu_thread_join(&thread_context->thread);
> > +
> > +    qemu_sem_destroy(&thread_context->sem_init_done);
> > +}
> > +
> >  /**
> >   * @brief Check if DSA is running.
> >   *
> > @@ -446,7 +685,7 @@ submit_batch_wi_async(struct buffer_zero_batch_task=
 *batch_task)
> >   */
> >  bool dsa_is_running(void)
> >  {
> > -    return false;
> > +    return completion_thread.running;
> >  }
> >
> >  static void
> > @@ -481,6 +720,7 @@ void dsa_start(void)
> >          return;
> >      }
> >      dsa_device_group_start(&dsa_group);
> > +    dsa_completion_thread_init(&completion_thread, &dsa_group);
> >  }
> >
> >  /**
> > @@ -496,6 +736,7 @@ void dsa_stop(void)
> >          return;
> >      }
> >
> > +    dsa_completion_thread_stop(&completion_thread);
> >      dsa_empty_task_queue(group);
> >  }
> >

