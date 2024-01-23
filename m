Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A030837968
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 01:38:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS4n9-0002Vw-9L; Mon, 22 Jan 2024 19:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rS4n7-0002VO-Hz
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 19:37:25 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rS4n4-0006XE-QD
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 19:37:25 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a30799d6aa0so121563766b.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 16:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1705970240; x=1706575040; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zNYkAf+pAWZ5P/wemzIAysrxKKqDwI5MJuW+hGmdps=;
 b=Qd5t6CIicfkcT5m7LPaCAc/WuuHPPCGAI84kebY5NZLYgX6o03hU3HFWzMhb0IZjZX
 r6+RiFIrfNWw9iPSkM3gdv6TJWCKvl3dtTtWP/ydUTscyuzx2MDU5Rz+a0SzH7NBKG7K
 X9y6rgyvcRDnakaXf+M4wsEPsAT7e0bBOanNg42pUg+tU8sdu5HDNAYaGmNAcmTsheBg
 901f6z4PDlIimcQiUPX7Qw/ApTONguZdAZDqE3cBfRYCjlh2jw+xqTKc2JoSnr6o/6iA
 WU1crxULLctyhVOrDBi62bLx6IAFsNA3b0BpsUEcUjzgQhQbRwx9D+J4hMSFim8AEJw3
 hXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705970240; x=1706575040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zNYkAf+pAWZ5P/wemzIAysrxKKqDwI5MJuW+hGmdps=;
 b=JyfeHrWb1cCHv/dss918IDhZar3hOdhj6ApLDAUEGEC0OE5RmKtRvpykk31wMvkYjE
 SjRcO5LsD7q5LgC0sBQQW7icb7aXI+xKs+Iz6Ws7swhlMRNF+nw6Hodpi52HTiWYCRgj
 o7YfV1z4xU72PMMksskJrNiIxc/W4K5fwwkVi1a6ZeF70vUt1hvR7cgfv55noALnldkh
 7htDF9NvXqOCuH0KLobGJE8oUEFPRDKaPrVv0Vs2L15F70rNGu6lk0mzKR9oIRzc1FET
 3XMEbK2C/CzKPgpK0eOlG+AGZqcqmEVjGd5Bd4BA5x+RhGdCK7i28XI+mWt5+aikyDwI
 TSSw==
X-Gm-Message-State: AOJu0YxZZpaI3KBU8WR3EnQnFY69Ob1wd81F52ZbetVMIxEDg7pyi5OM
 X5HRbfo0c/fWjxrpHcF8UAwRC9CL8iL2TyEuLLmImxDYVP9nP2ZiMpLJmKZW+48tE0bOzSkDe6r
 vnTDP2CkNlRZCRNYTgML1XznXsP57lYNf05Edgw==
X-Google-Smtp-Source: AGHT+IHgwKrI+nMOYBehBKOEqM/LIMtZonaADdKUj+VR6j3uAdgdpT0mmtQNzDV17Fpjc6hPNoJO0ktlFPUksYzCWO0=
X-Received: by 2002:a17:907:c312:b0:a30:a777:452e with SMTP id
 tl18-20020a170907c31200b00a30a777452emr415751ejc.88.1705970240339; Mon, 22
 Jan 2024 16:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-14-hao.xiang@bytedance.com>
 <DE3242A8-37B9-4825-BA5E-15A69964D862@nutanix.com>
In-Reply-To: <DE3242A8-37B9-4825-BA5E-15A69964D862@nutanix.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 22 Jan 2024 16:37:09 -0800
Message-ID: <CAAYibXjRaqPaTiPPL0AhK4BP2acOYJE1sr38G12saQwrZuihZw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 13/20] migration/multifd: Prepare to
 introduce DSA acceleration on the multifd path.
To: Shivam Kumar <shivam.kumar1@nutanix.com>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "peterx@redhat.com" <peterx@redhat.com>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x636.google.com
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

On Sun, Jan 14, 2024 at 10:46=E2=80=AFPM Shivam Kumar <shivam.kumar1@nutani=
x.com> wrote:
>
>
>
> > On 04-Jan-2024, at 6:14 AM, Hao Xiang <hao.xiang@bytedance.com> wrote:
> >
> > 1. Refactor multifd_send_thread function.
> > 2. Implement buffer_is_zero_use_cpu to handle CPU based zero page
> > checking.
> > 3. Introduce the batch task structure in MultiFDSendParams.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> > include/qemu/dsa.h  | 43 +++++++++++++++++++++++--
> > migration/multifd.c | 77 ++++++++++++++++++++++++++++++++++++---------
> > migration/multifd.h |  2 ++
> > util/dsa.c          | 51 +++++++++++++++++++++++++-----
> > 4 files changed, 148 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> > index e002652879..fe7772107a 100644
> > --- a/include/qemu/dsa.h
> > +++ b/include/qemu/dsa.h
> > @@ -2,6 +2,7 @@
> > #define QEMU_DSA_H
> >
> > #include "qemu/error-report.h"
> > +#include "exec/cpu-common.h"
> > #include "qemu/thread.h"
> > #include "qemu/queue.h"
> >
> > @@ -42,6 +43,20 @@ typedef struct dsa_batch_task {
> >     QSIMPLEQ_ENTRY(dsa_batch_task) entry;
> > } dsa_batch_task;
> >
> > +#endif
> > +
> > +struct batch_task {
> > +    /* Address of each pages in pages */
> > +    ram_addr_t *addr;
> > +    /* Zero page checking results */
> > +    bool *results;
> > +#ifdef CONFIG_DSA_OPT
> > +    struct dsa_batch_task *dsa_batch;
> > +#endif
> > +};
> > +
> > +#ifdef CONFIG_DSA_OPT
> > +
> > /**
> >  * @brief Initializes DSA devices.
> >  *
> > @@ -74,7 +89,7 @@ void dsa_cleanup(void);
> > bool dsa_is_running(void);
> >
> > /**
> > - * @brief Initializes a buffer zero batch task.
> > + * @brief Initializes a buffer zero DSA batch task.
> >  *
> >  * @param task A pointer to the batch task to initialize.
> >  * @param results A pointer to an array of zero page checking results.
> > @@ -102,7 +117,7 @@ void buffer_zero_batch_task_destroy(struct dsa_batc=
h_task *task);
> >  * @return Zero if successful, otherwise non-zero.
> >  */
> > int
> > -buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
> > +buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
> >                                const void **buf, size_t count, size_t l=
en);
> >
> > #else
> > @@ -128,6 +143,30 @@ static inline void dsa_stop(void) {}
> >
> > static inline void dsa_cleanup(void) {}
> >
> > +static inline int
> > +buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
> > +                               const void **buf, size_t count, size_t =
len)
> > +{
> > +    exit(1);
> > +}
> > +
> > #endif
> >
> > +/**
> > + * @brief Initializes a general buffer zero batch task.
> > + *
> > + * @param task A pointer to the general batch task to initialize.
> > + * @param batch_size The number of zero page checking tasks in the bat=
ch.
> > + */
> > +void
> > +batch_task_init(struct batch_task *task, int batch_size);
> > +
> > +/**
> > + * @brief Destroys a general buffer zero batch task.
> > + *
> > + * @param task A pointer to the general batch task to destroy.
> > + */
> > +void
> > +batch_task_destroy(struct batch_task *task);
> > +
> > #endif
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index eece85569f..e7c549b93e 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -14,6 +14,8 @@
> > #include "qemu/cutils.h"
> > #include "qemu/rcu.h"
> > #include "qemu/cutils.h"
> > +#include "qemu/dsa.h"
> > +#include "qemu/memalign.h"
> > #include "exec/target_page.h"
> > #include "sysemu/sysemu.h"
> > #include "exec/ramblock.h"
> > @@ -574,6 +576,8 @@ void multifd_save_cleanup(void)
> >         p->name =3D NULL;
> >         multifd_pages_clear(p->pages);
> >         p->pages =3D NULL;
> > +        batch_task_destroy(p->batch_task);
> > +        p->batch_task =3D NULL;
> >         p->packet_len =3D 0;
> >         g_free(p->packet);
> >         p->packet =3D NULL;
> > @@ -678,13 +682,66 @@ int multifd_send_sync_main(QEMUFile *f)
> >     return 0;
> > }
> >
> > +static void set_page(MultiFDSendParams *p, bool zero_page, uint64_t of=
fset)
> > +{
> > +    RAMBlock *rb =3D p->pages->block;
> > +    if (zero_page) {
> > +        p->zero[p->zero_num] =3D offset;
> > +        p->zero_num++;
> > +        ram_release_page(rb->idstr, offset);
> > +    } else {
> > +        p->normal[p->normal_num] =3D offset;
> > +        p->normal_num++;
> > +    }
> > +}
> > +
> > +static void buffer_is_zero_use_cpu(MultiFDSendParams *p)
> > +{
> > +    const void **buf =3D (const void **)p->batch_task->addr;
> > +    assert(!migrate_use_main_zero_page());
> > +
> > +    for (int i =3D 0; i < p->pages->num; i++) {
> > +        p->batch_task->results[i] =3D buffer_is_zero(buf[i], p->page_s=
ize);
> > +    }
> > +}
> > +
> > +static void set_normal_pages(MultiFDSendParams *p)
> > +{
> > +    for (int i =3D 0; i < p->pages->num; i++) {
> > +        p->batch_task->results[i] =3D false;
> > +    }
> > +}
> Please correct me if I am wrong but set_normal_pages will not be a part o=
f the final patch, right? They are there for testing out the performance ag=
ainst different zero page ration scenarios. If it=E2=80=99s so, can we isol=
ate these parts into a separate patch.

set_normal_pages is used for performance testing and testing only. It
won't introduce any "incorrect" behavior and I would love to see it
being part of the upstream code. But the argument that testing change
should remain private is always correct. So I am totally OK with
isolating the parts into a separate patch.

> > +
> > +static void multifd_zero_page_check(MultiFDSendParams *p)
> > +{
> > +    /* older qemu don't understand zero page on multifd channel */
> > +    bool use_multifd_zero_page =3D !migrate_use_main_zero_page();
> > +
> > +    RAMBlock *rb =3D p->pages->block;
> > +
> > +    for (int i =3D 0; i < p->pages->num; i++) {
> > +        p->batch_task->addr[i] =3D (ram_addr_t)(rb->host + p->pages->o=
ffset[i]);
> > +    }
> > +
> > +    if (use_multifd_zero_page) {
> > +        buffer_is_zero_use_cpu(p);
> > +    } else {
> > +        /* No zero page checking. All pages are normal pages. */
> > +        set_normal_pages(p);
> > +    }
> > +
> > +    for (int i =3D 0; i < p->pages->num; i++) {
> > +        uint64_t offset =3D p->pages->offset[i];
> > +        bool zero_page =3D p->batch_task->results[i];
> > +        set_page(p, zero_page, offset);
> > +    }
> > +}
> > +
> > static void *multifd_send_thread(void *opaque)
> > {
> >     MultiFDSendParams *p =3D opaque;
> >     MigrationThread *thread =3D NULL;
> >     Error *local_err =3D NULL;
> > -    /* qemu older than 8.2 don't understand zero page on multifd chann=
el */
> > -    bool use_multifd_zero_page =3D !migrate_use_main_zero_page();
> >     int ret =3D 0;
> >     bool use_zero_copy_send =3D migrate_zero_copy_send();
> >
> > @@ -710,7 +767,6 @@ static void *multifd_send_thread(void *opaque)
> >         qemu_mutex_lock(&p->mutex);
> >
> >         if (p->pending_job) {
> > -            RAMBlock *rb =3D p->pages->block;
> >             uint64_t packet_num =3D p->packet_num;
> >             uint32_t flags;
> >
> > @@ -723,18 +779,7 @@ static void *multifd_send_thread(void *opaque)
> >                 p->iovs_num =3D 1;
> >             }
> >
> > -            for (int i =3D 0; i < p->pages->num; i++) {
> > -                uint64_t offset =3D p->pages->offset[i];
> > -                if (use_multifd_zero_page &&
> > -                    buffer_is_zero(rb->host + offset, p->page_size)) {
> > -                    p->zero[p->zero_num] =3D offset;
> > -                    p->zero_num++;
> > -                    ram_release_page(rb->idstr, offset);
> > -                } else {
> > -                    p->normal[p->normal_num] =3D offset;
> > -                    p->normal_num++;
> > -                }
> > -            }
> > +            multifd_zero_page_check(p);
> >
> >             if (p->normal_num) {
> >                 ret =3D multifd_send_state->ops->send_prepare(p, &local=
_err);
> > @@ -975,6 +1020,8 @@ int multifd_save_setup(Error **errp)
> >         p->pending_job =3D 0;
> >         p->id =3D i;
> >         p->pages =3D multifd_pages_init(page_count);
> > +        p->batch_task =3D g_malloc0(sizeof(struct batch_task));
> > +        batch_task_init(p->batch_task, page_count);
> >         p->packet_len =3D sizeof(MultiFDPacket_t)
> >                       + sizeof(uint64_t) * page_count;
> >         p->packet =3D g_malloc0(p->packet_len);
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 13762900d4..97b5f888a7 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -119,6 +119,8 @@ typedef struct {
> >      * pending_job !=3D 0 -> multifd_channel can use it.
> >      */
> >     MultiFDPages_t *pages;
> > +    /* Zero page checking batch task */
> > +    struct batch_task *batch_task;
> >
> >     /* thread local variables. No locking required */
> >
> > diff --git a/util/dsa.c b/util/dsa.c
> > index 5a2bf33651..f6224a27d4 100644
> > --- a/util/dsa.c
> > +++ b/util/dsa.c
> > @@ -802,7 +802,7 @@ buffer_zero_task_init_int(struct dsa_hw_desc *descr=
iptor,
> > }
> >
> > /**
> > - * @brief Initializes a buffer zero batch task.
> > + * @brief Initializes a buffer zero DSA batch task.
> >  *
> >  * @param task A pointer to the batch task to initialize.
> >  * @param results A pointer to an array of zero page checking results.
> > @@ -1107,29 +1107,64 @@ void dsa_cleanup(void)
> >  * @return Zero if successful, otherwise non-zero.
> >  */
> > int
> > -buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
> > +buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
> >                                const void **buf, size_t count, size_t l=
en)
> > {
> > -    if (count <=3D 0 || count > batch_task->batch_size) {
> > +    struct dsa_batch_task *dsa_batch =3D batch_task->dsa_batch;
> > +
> > +    if (count <=3D 0 || count > dsa_batch->batch_size) {
> >         return -1;
> >     }
> >
> > -    assert(batch_task !=3D NULL);
> > +    assert(dsa_batch !=3D NULL);
> >     assert(len !=3D 0);
> >     assert(buf !=3D NULL);
> >
> >     if (count =3D=3D 1) {
> >         /* DSA doesn't take batch operation with only 1 task. */
> > -        buffer_zero_dsa_async(batch_task, buf[0], len);
> > +        buffer_zero_dsa_async(dsa_batch, buf[0], len);
> >     } else {
> > -        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
> > +        buffer_zero_dsa_batch_async(dsa_batch, buf, count, len);
> >     }
> >
> > -    buffer_zero_dsa_wait(batch_task);
> > -    buffer_zero_cpu_fallback(batch_task);
> > +    buffer_zero_dsa_wait(dsa_batch);
> > +    buffer_zero_cpu_fallback(dsa_batch);
> >
> >     return 0;
> > }
> >
> > #endif
> >
> > +/**
> > + * @brief Initializes a general buffer zero batch task.
> > + *
> > + * @param task A pointer to the general batch task to initialize.
> > + * @param batch_size The number of zero page checking tasks in the bat=
ch.
> > + */
> > +void
> > +batch_task_init(struct batch_task *task, int batch_size)
> > +{
> > +    task->addr =3D g_new0(ram_addr_t, batch_size);
> > +    task->results =3D g_new0(bool, batch_size);
> > +#ifdef CONFIG_DSA_OPT
> > +    task->dsa_batch =3D qemu_memalign(64, sizeof(struct dsa_batch_task=
));
> > +    buffer_zero_batch_task_init(task->dsa_batch, task->results, batch_=
size);
> > +#endif
> > +}
> > +
> > +/**
> > + * @brief Destroys a general buffer zero batch task.
> > + *
> > + * @param task A pointer to the general batch task to destroy.
> > + */
> > +void
> > +batch_task_destroy(struct batch_task *task)
> > +{
> > +    g_free(task->addr);
> > +    g_free(task->results);
> > +#ifdef CONFIG_DSA_OPT
> > +    buffer_zero_batch_task_destroy(task->dsa_batch);
> > +    qemu_vfree(task->dsa_batch);
> > +#endif
> > +}
> > +
> > --
> > 2.30.2
> >
> >
> >
>

