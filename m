Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C206181EC93
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 07:28:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rINNM-0002VH-Kx; Wed, 27 Dec 2023 01:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rINNK-0002Ur-5V
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 01:26:42 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rINNE-00080p-8K
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 01:26:41 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55322dbabf6so5110893a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 22:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1703658389; x=1704263189; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMRA59xRtUlpRqSsAaJwNbsAcOwC1+EUx2kZcgjWpJE=;
 b=G6DRQRr6mS/xpvkKfIJ9WZLpLJwfUBQ8OE9ApiZPSD53FCBUT458TwBZUmY07poNke
 FCiq7FbBgQJsB4KMCe+QAj4W7Tk//nYDQzjvEfvrGKOeRDDhIShyyV1hyBKKcsSmLDPS
 vbvNpfgwU/d9rx/qH+7TeKuFTIOKYsi4/pQzw2mrNGfDZYMdexY3lyQ/yUgtUaAEUVF8
 f8Yw98FQjO8X5K9FlUbn5HE/CptfK37J/B9gBLWdrcqRXnay0aaoinTLCiVWMfhJdT6w
 JkTvnVvY4ln9o3/QVc5zHXJb+8xmC8Yl8B21lV7cIeyh1uosTnP2lx82ZuRGewKcWeCX
 tokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703658389; x=1704263189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMRA59xRtUlpRqSsAaJwNbsAcOwC1+EUx2kZcgjWpJE=;
 b=BWaxCC7sjDhBMyqivLMb/iwtGikKay1YE2d3qF6RBiv0L5pe6tvLayc3SFSzfJa9B3
 qJhspTV9VNmE560B33Fm+60SJySEmnaBcljoLkKuZ1kBMwtppVYtjQzITAg8V/mmaOA0
 5gmMdITqqzPFCWcqcnPhCq3HVbBRH/8YHBWa6r8ILSQGvlofmqlkqSCDuIPZfpj0/4Ta
 KFnTXT3S9oGVPLjqoHwPDMmEMLfrBcB9SxX3yTMjuYa8iT26Ge42GMNfDKNyU6Oavy3B
 LLQKnqjmhwcSpleVzJbL98zOspZtRwu6zVXRCNjDiL7CXdkZhYH16XD9QO57ET8ZEbuW
 Tn8g==
X-Gm-Message-State: AOJu0YyHRWEzGuvmcmrjYo7M5BW/lkRROgrZVUClpJx6nuHXJeQ8rjhJ
 DpY5FxvOm4/l1NkYS2B7y21cXqdnjD0cdDtHN35KX8uknjW63w==
X-Google-Smtp-Source: AGHT+IFf8vCWnxVuKvLoGOWZU7xfl5jlhSNb22JSXBJ43US/3/y2lTNgGtGRjLGEK4OhjckdZWbC8cwh+ItzCrlrXe8=
X-Received: by 2002:a50:9b43:0:b0:554:1f03:cbcc with SMTP id
 a3-20020a509b43000000b005541f03cbccmr5799380edj.59.1703658388787; Tue, 26 Dec
 2023 22:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-12-hao.xiang@bytedance.com> <87o7euxkv7.fsf@suse.de>
In-Reply-To: <87o7euxkv7.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 26 Dec 2023 22:26:17 -0800
Message-ID: <CAAYibXjv74iLB=Z9Wi=txeKCg+VTAGWwPK-FsXE9rV-gPinf-A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 11/20] util/dsa: Implement DSA task
 asynchronous submission and wait for completion.
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

On Wed, Dec 13, 2023 at 6:01=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > * Add a DSA task completion callback.
> > * DSA completion thread will call the tasks's completion callback
> > on every task/batch task completion.
> > * DSA submission path to wait for completion.
> > * Implement CPU fallback if DSA is not able to complete the task.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> > ---
> >  include/qemu/dsa.h |  14 +++++
> >  util/dsa.c         | 153 ++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 164 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> > index b10e7b8fb7..3f8ee07004 100644
> > --- a/include/qemu/dsa.h
> > +++ b/include/qemu/dsa.h
> > @@ -65,6 +65,20 @@ void buffer_zero_batch_task_init(struct buffer_zero_=
batch_task *task,
> >   */
> >  void buffer_zero_batch_task_destroy(struct buffer_zero_batch_task *tas=
k);
> >
> > +/**
> > + * @brief Performs buffer zero comparison on a DSA batch task asynchro=
nously.
> > + *
> > + * @param batch_task A pointer to the batch task.
> > + * @param buf An array of memory buffers.
> > + * @param count The number of buffers in the array.
> > + * @param len The buffer length.
> > + *
> > + * @return Zero if successful, otherwise non-zero.
> > + */
> > +int
> > +buffer_is_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_ta=
sk,
> > +                               const void **buf, size_t count, size_t =
len);
> > +
> >  /**
> >   * @brief Initializes DSA devices.
> >   *
> > diff --git a/util/dsa.c b/util/dsa.c
> > index 3cc017b8a0..06c6fbf2ca 100644
> > --- a/util/dsa.c
> > +++ b/util/dsa.c
> > @@ -470,6 +470,41 @@ poll_completion(struct dsa_completion_record *comp=
letion,
> >      return 0;
> >  }
> >
> > +/**
> > + * @brief Use CPU to complete a single zero page checking task.
> > + *
> > + * @param task A pointer to the task.
> > + */
> > +static void
> > +task_cpu_fallback(struct buffer_zero_batch_task *task)
> > +{
> > +    assert(task->task_type =3D=3D DSA_TASK);
> > +
> > +    struct dsa_completion_record *completion =3D &task->completions[0]=
;
> > +    const uint8_t *buf;
> > +    size_t len;
> > +
> > +    if (completion->status =3D=3D DSA_COMP_SUCCESS) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * DSA was able to partially complete the operation. Check the
> > +     * result. If we already know this is not a zero page, we can
> > +     * return now.
> > +     */
> > +    if (completion->bytes_completed !=3D 0 && completion->result !=3D =
0) {
> > +        task->results[0] =3D false;
> > +        return;
> > +    }
> > +
> > +    /* Let's fallback to use CPU to complete it. */
> > +    buf =3D (const uint8_t *)task->descriptors[0].src_addr;
> > +    len =3D task->descriptors[0].xfer_size;
> > +    task->results[0] =3D buffer_is_zero(buf + completion->bytes_comple=
ted,
> > +                                      len - completion->bytes_complete=
d);
> > +}
> > +
> >  /**
> >   * @brief Complete a single DSA task in the batch task.
> >   *
> > @@ -548,6 +583,62 @@ poll_batch_task_completion(struct buffer_zero_batc=
h_task *batch_task)
> >      }
> >  }
> >
> > +/**
> > + * @brief Use CPU to complete the zero page checking batch task.
> > + *
> > + * @param batch_task A pointer to the batch task.
> > + */
> > +static void
> > +batch_task_cpu_fallback(struct buffer_zero_batch_task *batch_task)
> > +{
> > +    assert(batch_task->task_type =3D=3D DSA_BATCH_TASK);
> > +
> > +    struct dsa_completion_record *batch_completion =3D
> > +        &batch_task->batch_completion;
> > +    struct dsa_completion_record *completion;
> > +    uint8_t status;
> > +    const uint8_t *buf;
> > +    size_t len;
> > +    bool *results =3D batch_task->results;
> > +    uint32_t count =3D batch_task->batch_descriptor.desc_count;
> > +
> > +    // DSA is able to complete the entire batch task.
> > +    if (batch_completion->status =3D=3D DSA_COMP_SUCCESS) {
> > +        assert(count =3D=3D batch_completion->bytes_completed);
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * DSA encounters some error and is not able to complete
> > +     * the entire batch task. Use CPU fallback.
> > +     */
> > +    for (int i =3D 0; i < count; i++) {
> > +        completion =3D &batch_task->completions[i];
> > +        status =3D completion->status;
> > +        if (status =3D=3D DSA_COMP_SUCCESS) {
> > +            continue;
> > +        }
> > +        assert(status =3D=3D DSA_COMP_PAGE_FAULT_NOBOF);
> > +
> > +        /*
> > +         * DSA was able to partially complete the operation. Check the
> > +         * result. If we already know this is not a zero page, we can
> > +         * return now.
> > +         */
> > +        if (completion->bytes_completed !=3D 0 && completion->result !=
=3D 0) {
> > +            results[i] =3D false;
> > +            continue;
> > +        }
> > +
> > +        /* Let's fallback to use CPU to complete it. */
> > +        buf =3D (uint8_t *)batch_task->descriptors[i].src_addr;
> > +        len =3D batch_task->descriptors[i].xfer_size;
> > +        results[i] =3D
> > +            buffer_is_zero(buf + completion->bytes_completed,
> > +                           len - completion->bytes_completed);
>
> Here the same thing is happening as in other patches, the batch task
> operation is just a repeat of the task operation n times. So this whole
> inner code here could be nicely replaced by task_cpu_fallback() with
> some adjustment of the function arguments. That makes intuitive sense
> and removes code duplication.

Added a helper function task_cpu_fallback_int() to remove the duplicated co=
de.

>
> > +    }
> > +}
> > +
> >  /**
> >   * @brief Handles an asynchronous DSA batch task completion.
> >   *
> > @@ -825,7 +916,6 @@ buffer_zero_batch_task_set(struct buffer_zero_batch=
_task *batch_task,
> >   *
> >   * @return int Zero if successful, otherwise an appropriate error code=
.
> >   */
> > -__attribute__((unused))
> >  static int
> >  buffer_zero_dsa_async(struct buffer_zero_batch_task *task,
> >                        const void *buf, size_t len)
> > @@ -844,7 +934,6 @@ buffer_zero_dsa_async(struct buffer_zero_batch_task=
 *task,
> >   * @param count The number of buffers.
> >   * @param len The buffer length.
> >   */
> > -__attribute__((unused))
> >  static int
> >  buffer_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_task,
> >                              const void **buf, size_t count, size_t len=
)
> > @@ -876,13 +965,29 @@ buffer_zero_dsa_completion(void *context)
> >   *
> >   * @param batch_task A pointer to the buffer zero comparison batch tas=
k.
> >   */
> > -__attribute__((unused))
> >  static void
> >  buffer_zero_dsa_wait(struct buffer_zero_batch_task *batch_task)
> >  {
> >      qemu_sem_wait(&batch_task->sem_task_complete);
> >  }
> >
> > +/**
> > + * @brief Use CPU to complete the zero page checking task if DSA
> > + *        is not able to complete it.
> > + *
> > + * @param batch_task A pointer to the batch task.
> > + */
> > +static void
> > +buffer_zero_cpu_fallback(struct buffer_zero_batch_task *batch_task)
> > +{
> > +    if (batch_task->task_type =3D=3D DSA_TASK) {
> > +        task_cpu_fallback(batch_task);
> > +    } else {
> > +        assert(batch_task->task_type =3D=3D DSA_BATCH_TASK);
> > +        batch_task_cpu_fallback(batch_task);
> > +    }
> > +}
> > +
> >  /**
> >   * @brief Check if DSA is running.
> >   *
> > @@ -956,6 +1061,41 @@ void dsa_cleanup(void)
> >      dsa_device_group_cleanup(&dsa_group);
> >  }
> >
> > +/**
> > + * @brief Performs buffer zero comparison on a DSA batch task asynchro=
nously.
> > + *
> > + * @param batch_task A pointer to the batch task.
> > + * @param buf An array of memory buffers.
> > + * @param count The number of buffers in the array.
> > + * @param len The buffer length.
> > + *
> > + * @return Zero if successful, otherwise non-zero.
> > + */
> > +int
> > +buffer_is_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_ta=
sk,
> > +                               const void **buf, size_t count, size_t =
len)
> > +{
> > +    if (count <=3D 0 || count > batch_task->batch_size) {
> > +        return -1;
> > +    }
> > +
> > +    assert(batch_task !=3D NULL);
> > +    assert(len !=3D 0);
> > +    assert(buf !=3D NULL);
> > +
> > +    if (count =3D=3D 1) {
> > +        // DSA doesn't take batch operation with only 1 task.
> > +        buffer_zero_dsa_async(batch_task, buf[0], len);
> > +    } else {
> > +        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
> > +    }
> > +
> > +    buffer_zero_dsa_wait(batch_task);
> > +    buffer_zero_cpu_fallback(batch_task);
> > +
> > +    return 0;
> > +}
> > +
> >  #else
> >
> >  void buffer_zero_batch_task_init(struct buffer_zero_batch_task *task,
> > @@ -981,5 +1121,12 @@ void dsa_stop(void) {}
> >
> >  void dsa_cleanup(void) {}
> >
> > +int
> > +buffer_is_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_ta=
sk,
> > +                               const void **buf, size_t count, size_t =
len)
> > +{
> > +    exit(1);
> > +}
> > +
> >  #endif

