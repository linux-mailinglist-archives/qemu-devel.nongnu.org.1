Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E3D8181A4
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 07:43:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFTo0-0005Xf-Gj; Tue, 19 Dec 2023 01:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rFTny-0005XX-KJ
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 01:42:14 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rFTnv-0006h1-T0
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 01:42:14 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2358a75b69so397893866b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 22:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1702968128; x=1703572928; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSeXWF3JK1MBTamzTQqVoPrjkM2nLy96fpWvOyqr8ls=;
 b=CfeFNTsFDqbF0wXNyUyK+FnpzVf+3E+4Pvy/H7OsutkgC3GYMh71VLFqIg3ILmcZIg
 4DIPiQK2gBphkN0ydf5vb7faZB+hOIZHB3UxhnvwbEnQ3FCj5xjiYitg/zzyZ53+5WEs
 K/Ve9DNPax9oe2IRSCBUkcRFwa+HtkBsjQiwl5QagB/4BmIDIjTVDu/EJ7YdJSs7NtXI
 iOygGjVVBoSGHRmtD7mQ+0p0jzmEblFQCE+FtUh/ECA8sxDM5iU1bkokJAaiMqDXsCUy
 c6GpkjV635aMSAYfhvFLCtPkqu2P6Vu33Wmb04Ed34EC21gh1JmnNQoxvOCRDE9O9TxP
 2Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702968128; x=1703572928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSeXWF3JK1MBTamzTQqVoPrjkM2nLy96fpWvOyqr8ls=;
 b=oqakGD5Sf4+kbf6iqC1T4ywVKwb9CNxImbr3uXnTaAi2SvRftsYpYWigcJzwoAXLry
 zPnUYcZLglxOpXnq3rj2r46/QfxtBnPNrcklUqofSAdpQ/NI8Z86ymjencZD7MaiwdEF
 umm3C00DvablwC7r+wndN9jjKmHUkjaVWBAykPcqswdBFJtNEo4VaMB4Q7w87QjOzWbS
 ELwSWTK9x+5MpclElcSV5ALPQI7fzUwKz3V4CZBw7+DVxGwzUeGI6KAS2p8QXE6zWjHk
 BrIdidXr4I16REQiQzQJvMPOvaKrk5yZ2+LceDzTPLVhdz6X97TDoknUV3JuNJbFZTrD
 9KPw==
X-Gm-Message-State: AOJu0YyWd5eUr0+kLDGHCCrNWAj6y/6GPlDD14leICA3ozrGMFkEMi7Z
 1aTqt6rkldMTr5q3EfkkIMeIz4++yNdNRP4fL+r+7R5LdActWLAjSI/685yec5k=
X-Google-Smtp-Source: AGHT+IFlg0Xi+lY2QNemUzuedjNiaxavuRoACSoSc9FNInVEQINJtqolBTL3hBQjVBj4dybY9AZvfjoYMMaaPRxKbX4=
X-Received: by 2002:a17:907:7634:b0:a23:49c4:3e89 with SMTP id
 jy20-20020a170907763400b00a2349c43e89mr512319ejc.10.1702968127573; Mon, 18
 Dec 2023 22:42:07 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-8-hao.xiang@bytedance.com> <87h6koh1is.fsf@suse.de>
In-Reply-To: <87h6koh1is.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 18 Dec 2023 22:41:56 -0800
Message-ID: <CAAYibXhX1Rw++m47SgOtd3B1zC3fOGCqBuMRTMihPJgm=ZQF1A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 07/20] util/dsa: Implement DSA device
 start and stop logic.
To: Fabiano Rosas <farosas@suse.de>
Cc: peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com, 
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62f.google.com
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

On Mon, Dec 11, 2023 at 1:28=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > * DSA device open and close.
> > * DSA group contains multiple DSA devices.
> > * DSA group configure/start/stop/clean.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> > ---
> >  include/qemu/dsa.h |  49 +++++++
> >  util/dsa.c         | 338 +++++++++++++++++++++++++++++++++++++++++++++
> >  util/meson.build   |   1 +
> >  3 files changed, 388 insertions(+)
> >  create mode 100644 include/qemu/dsa.h
> >  create mode 100644 util/dsa.c
> >
> > diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> > new file mode 100644
> > index 0000000000..30246b507e
> > --- /dev/null
> > +++ b/include/qemu/dsa.h
> > @@ -0,0 +1,49 @@
> > +#ifndef QEMU_DSA_H
> > +#define QEMU_DSA_H
> > +
> > +#include "qemu/thread.h"
> > +#include "qemu/queue.h"
> > +
> > +#ifdef CONFIG_DSA_OPT
> > +
> > +#pragma GCC push_options
> > +#pragma GCC target("enqcmd")
> > +
> > +#include <linux/idxd.h>
> > +#include "x86intrin.h"
> > +
> > +#endif
> > +
> > +/**
> > + * @brief Initializes DSA devices.
> > + *
> > + * @param dsa_parameter A list of DSA device path from migration param=
eter.
>
> This code seems pretty generic, let's decouple this doc from migration.
>
> > + * @return int Zero if successful, otherwise non zero.
> > + */
> > +int dsa_init(const char *dsa_parameter);
> > +
> > +/**
> > + * @brief Start logic to enable using DSA.
> > + */
> > +void dsa_start(void);
> > +
> > +/**
> > + * @brief Stop logic to clean up DSA by halting the device group and c=
leaning up
> > + * the completion thread.
>
> "Stop the device group and the completion thread"
>
> The mention of "clean/cleaning up" makes this confusing because of
> dsa_cleanup() below.

Fixed.

>
> > + */
> > +void dsa_stop(void);
> > +
> > +/**
> > + * @brief Clean up system resources created for DSA offloading.
> > + *        This function is called during QEMU process teardown.
>
> This is not called during QEMU process teardown. It's called at the end
> of migration AFAICS. Maybe just leave this sentence out.

Fixed.

>
> > + */
> > +void dsa_cleanup(void);
> > +
> > +/**
> > + * @brief Check if DSA is running.
> > + *
> > + * @return True if DSA is running, otherwise false.
> > + */
> > +bool dsa_is_running(void);
> > +
> > +#endif
> > \ No newline at end of file
> > diff --git a/util/dsa.c b/util/dsa.c
> > new file mode 100644
> > index 0000000000..8edaa892ec
> > --- /dev/null
> > +++ b/util/dsa.c
> > @@ -0,0 +1,338 @@
> > +/*
> > + * Use Intel Data Streaming Accelerator to offload certain background
> > + * operations.
> > + *
> > + * Copyright (c) 2023 Hao Xiang <hao.xiang@bytedance.com>
> > + *                    Bryan Zhang <bryan.zhang@bytedance.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/queue.h"
> > +#include "qemu/memalign.h"
> > +#include "qemu/lockable.h"
> > +#include "qemu/cutils.h"
> > +#include "qemu/dsa.h"
> > +#include "qemu/bswap.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/rcu.h"
> > +
> > +#ifdef CONFIG_DSA_OPT
> > +
> > +#pragma GCC push_options
> > +#pragma GCC target("enqcmd")
> > +
> > +#include <linux/idxd.h>
> > +#include "x86intrin.h"
> > +
> > +#define DSA_WQ_SIZE 4096
> > +#define MAX_DSA_DEVICES 16
> > +
> > +typedef QSIMPLEQ_HEAD(dsa_task_queue, buffer_zero_batch_task) dsa_task=
_queue;
> > +
> > +struct dsa_device {
> > +    void *work_queue;
> > +};
> > +
> > +struct dsa_device_group {
> > +    struct dsa_device *dsa_devices;
> > +    int num_dsa_devices;
> > +    uint32_t index;
> > +    bool running;
> > +    QemuMutex task_queue_lock;
> > +    QemuCond task_queue_cond;
> > +    dsa_task_queue task_queue;
> > +};
> > +
> > +uint64_t max_retry_count;
> > +static struct dsa_device_group dsa_group;
> > +
> > +
> > +/**
> > + * @brief This function opens a DSA device's work queue and
> > + *        maps the DSA device memory into the current process.
> > + *
> > + * @param dsa_wq_path A pointer to the DSA device work queue's file pa=
th.
> > + * @return A pointer to the mapped memory.
> > + */
> > +static void *
> > +map_dsa_device(const char *dsa_wq_path)
> > +{
> > +    void *dsa_device;
> > +    int fd;
> > +
> > +    fd =3D open(dsa_wq_path, O_RDWR);
> > +    if (fd < 0) {
> > +        fprintf(stderr, "open %s failed with errno =3D %d.\n",
> > +                dsa_wq_path, errno);
>
> Use error_report and error_setg* for these. Throughout the series.

All converted to using error_report.

>
> > +        return MAP_FAILED;
> > +    }
> > +    dsa_device =3D mmap(NULL, DSA_WQ_SIZE, PROT_WRITE,
> > +                      MAP_SHARED | MAP_POPULATE, fd, 0);
> > +    close(fd);
> > +    if (dsa_device =3D=3D MAP_FAILED) {
> > +        fprintf(stderr, "mmap failed with errno =3D %d.\n", errno);
> > +        return MAP_FAILED;
> > +    }
> > +    return dsa_device;
> > +}
> > +
> > +/**
> > + * @brief Initializes a DSA device structure.
> > + *
> > + * @param instance A pointer to the DSA device.
> > + * @param work_queue  A pointer to the DSA work queue.
> > + */
> > +static void
> > +dsa_device_init(struct dsa_device *instance,
> > +                void *dsa_work_queue)
> > +{
> > +    instance->work_queue =3D dsa_work_queue;
> > +}
> > +
> > +/**
> > + * @brief Cleans up a DSA device structure.
> > + *
> > + * @param instance A pointer to the DSA device to cleanup.
> > + */
> > +static void
> > +dsa_device_cleanup(struct dsa_device *instance)
> > +{
> > +    if (instance->work_queue !=3D MAP_FAILED) {
> > +        munmap(instance->work_queue, DSA_WQ_SIZE);
> > +    }
> > +}
> > +
> > +/**
> > + * @brief Initializes a DSA device group.
> > + *
> > + * @param group A pointer to the DSA device group.
> > + * @param num_dsa_devices The number of DSA devices this group will ha=
ve.
> > + *
> > + * @return Zero if successful, non-zero otherwise.
> > + */
> > +static int
> > +dsa_device_group_init(struct dsa_device_group *group,
> > +                      const char *dsa_parameter)
>
> The documentation doesn't match the signature. This happens in other
> places as well, please review all of them.
>
Fixed all cases.

> > +{
> > +    if (dsa_parameter =3D=3D NULL || strlen(dsa_parameter) =3D=3D 0) {
> > +        return 0;
> > +    }
> > +
> > +    int ret =3D 0;
> > +    char *local_dsa_parameter =3D g_strdup(dsa_parameter);
> > +    const char *dsa_path[MAX_DSA_DEVICES];
> > +    int num_dsa_devices =3D 0;
> > +    char delim[2] =3D " ";
>
> So we're using space separated strings. Let's document this in this file
> and also on the migration parameter documentation.

Fixed.

>
> > +
> > +    char *current_dsa_path =3D strtok(local_dsa_parameter, delim);
> > +
> > +    while (current_dsa_path !=3D NULL) {
> > +        dsa_path[num_dsa_devices++] =3D current_dsa_path;
> > +        if (num_dsa_devices =3D=3D MAX_DSA_DEVICES) {
> > +            break;
> > +        }
> > +        current_dsa_path =3D strtok(NULL, delim);
> > +    }
> > +
> > +    group->dsa_devices =3D
> > +        malloc(sizeof(struct dsa_device) * num_dsa_devices);
>
> Use g_new0() here.

Converted to use g_new0 and g_free accordingly.

>
> > +    group->num_dsa_devices =3D num_dsa_devices;
> > +    group->index =3D 0;
> > +
> > +    group->running =3D false;
> > +    qemu_mutex_init(&group->task_queue_lock);
> > +    qemu_cond_init(&group->task_queue_cond);
> > +    QSIMPLEQ_INIT(&group->task_queue);
> > +
> > +    void *dsa_wq =3D MAP_FAILED;
> > +    for (int i =3D 0; i < num_dsa_devices; i++) {
> > +        dsa_wq =3D map_dsa_device(dsa_path[i]);
> > +        if (dsa_wq =3D=3D MAP_FAILED) {
> > +            fprintf(stderr, "map_dsa_device failed MAP_FAILED, "
> > +                    "using simulation.\n");
>
> What does "using simulation" means? And how are doing it by returning -1
> from this function?

* "using simulation" was a copy and paste mistake. Removed that.
* -1 is an error code and will be propagated from
dsa_device_group_init to dsa_init and eventually to
multifd_load_setup/multifd_save_setup.
multifd_load_setup/multifd_save_setup now checks the return code from
dsa_init and aborts the migration if dsa_init fails.

>
> > +            ret =3D -1;
>
> What about the memory for group->dsa_devices in the failure case? We
> should either free it here or make sure the client code calls the
> cleanup routines.

In the failure case, dsa_device_group_cleanup will free the
group->dsa_devices memory allocation. dsa_device_group_cleanup is
called by dsa_cleanup. multifd_load_cleanup/multifd_save_cleanup will
call the cleanup routines.

>
> > +            goto exit;
> > +        }
> > +        dsa_device_init(&dsa_group.dsa_devices[i], dsa_wq);
> > +    }
> > +
> > +exit:
> > +    g_free(local_dsa_parameter);
> > +    return ret;
> > +}
> > +
> > +/**
> > + * @brief Starts a DSA device group.
> > + *
> > + * @param group A pointer to the DSA device group.
> > + * @param dsa_path An array of DSA device path.
> > + * @param num_dsa_devices The number of DSA devices in the device grou=
p.
> > + */
> > +static void
> > +dsa_device_group_start(struct dsa_device_group *group)
> > +{
> > +    group->running =3D true;
> > +}
> > +
> > +/**
> > + * @brief Stops a DSA device group.
> > + *
> > + * @param group A pointer to the DSA device group.
> > + */
> > +__attribute__((unused))
> > +static void
> > +dsa_device_group_stop(struct dsa_device_group *group)
> > +{
> > +    group->running =3D false;
> > +}
> > +
> > +/**
> > + * @brief Cleans up a DSA device group.
> > + *
> > + * @param group A pointer to the DSA device group.
> > + */
> > +static void
> > +dsa_device_group_cleanup(struct dsa_device_group *group)
> > +{
> > +    if (!group->dsa_devices) {
> > +        return;
> > +    }
> > +    for (int i =3D 0; i < group->num_dsa_devices; i++) {
> > +        dsa_device_cleanup(&group->dsa_devices[i]);
> > +    }
> > +    free(group->dsa_devices);
> > +    group->dsa_devices =3D NULL;
> > +
> > +    qemu_mutex_destroy(&group->task_queue_lock);
> > +    qemu_cond_destroy(&group->task_queue_cond);
> > +}
> > +
> > +/**
> > + * @brief Returns the next available DSA device in the group.
> > + *
> > + * @param group A pointer to the DSA device group.
> > + *
> > + * @return struct dsa_device* A pointer to the next available DSA devi=
ce
> > + *         in the group.
> > + */
> > +__attribute__((unused))
> > +static struct dsa_device *
> > +dsa_device_group_get_next_device(struct dsa_device_group *group)
> > +{
> > +    if (group->num_dsa_devices =3D=3D 0) {
> > +        return NULL;
> > +    }
> > +    uint32_t current =3D qatomic_fetch_inc(&group->index);
>
> The name "index" alone feels a bit opaque. Is there a more
> representative name we could give it?

I renamed it to device_allocator_index and added a comment to explain the f=
ield.

>
> > +    current %=3D group->num_dsa_devices;
> > +    return &group->dsa_devices[current];
> > +}
> > +
> > +/**
> > + * @brief Check if DSA is running.
> > + *
> > + * @return True if DSA is running, otherwise false.
> > + */
> > +bool dsa_is_running(void)
> > +{
> > +    return false;
> > +}
> > +
> > +static void
> > +dsa_globals_init(void)
> > +{
> > +    max_retry_count =3D UINT64_MAX;
> > +}
> > +
> > +/**
> > + * @brief Initializes DSA devices.
> > + *
> > + * @param dsa_parameter A list of DSA device path from migration param=
eter.
> > + * @return int Zero if successful, otherwise non zero.
> > + */
> > +int dsa_init(const char *dsa_parameter)
> > +{
> > +    dsa_globals_init();
> > +
> > +    return dsa_device_group_init(&dsa_group, dsa_parameter);
> > +}
> > +
> > +/**
> > + * @brief Start logic to enable using DSA.
> > + *
> > + */
> > +void dsa_start(void)
> > +{
> > +    if (dsa_group.num_dsa_devices =3D=3D 0) {
> > +        return;
> > +    }
> > +    if (dsa_group.running) {
> > +        return;
> > +    }
> > +    dsa_device_group_start(&dsa_group);
> > +}
> > +
> > +/**
> > + * @brief Stop logic to clean up DSA by halting the device group and c=
leaning up
> > + * the completion thread.
> > + *
> > + */
> > +void dsa_stop(void)
> > +{
> > +    struct dsa_device_group *group =3D &dsa_group;
> > +
> > +    if (!group->running) {
> > +        return;
> > +    }
> > +}
> > +
> > +/**
> > + * @brief Clean up system resources created for DSA offloading.
> > + *        This function is called during QEMU process teardown.
> > + *
> > + */
> > +void dsa_cleanup(void)
> > +{
> > +    dsa_stop();
> > +    dsa_device_group_cleanup(&dsa_group);
> > +}
> > +
> > +#else
> > +
> > +bool dsa_is_running(void)
> > +{
> > +    return false;
> > +}
> > +
> > +int dsa_init(const char *dsa_parameter)
> > +{
> > +    fprintf(stderr, "Intel Data Streaming Accelerator is not supported=
 "
> > +                    "on this platform.\n");
> > +    return -1;
>
> Nothing checks this later in the series and we end up trying to start a
> migration when we shouldn't. Fixing the configure step would already
> stop this happening, but make sure you check this anyway and abort the
> migration.

multifd_load_setup/multifd_save_setup now checks the return code from
dsa_init and aborts the migration if dsa_init fails. The
non-CONFIG_DSA_OPT version of dsa_init should really just be a no-op.
Changed that.

>
> > +}
> > +
> > +void dsa_start(void) {}
> > +
> > +void dsa_stop(void) {}
> > +
> > +void dsa_cleanup(void) {}
> > +
> > +#endif
>
> These could all be in the header.

The function definitions are already in dsa.h Do you mean moving the
function implementations to the header as well?

>
> > +
> > diff --git a/util/meson.build b/util/meson.build
> > index c2322ef6e7..f7277c5e9b 100644
> > --- a/util/meson.build
> > +++ b/util/meson.build
> > @@ -85,6 +85,7 @@ if have_block or have_ga
> >  endif
> >  if have_block
> >    util_ss.add(files('aio-wait.c'))
> > +  util_ss.add(files('dsa.c'))
>
> I find it clearer to add the file conditionally under CONFIG_DSA_OPT
> here and remove the ifdef from the C file. I'm not sure if we have any
> guidelines for this, so up to you.
>
> >    util_ss.add(files('buffer.c'))
> >    util_ss.add(files('bufferiszero.c'))
> >    util_ss.add(files('hbitmap.c'))

