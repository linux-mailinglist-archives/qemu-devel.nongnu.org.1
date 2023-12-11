Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A89E80DD18
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:29:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnpg-0003Xz-Eq; Mon, 11 Dec 2023 16:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rCnpe-0003P4-8o
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:28:54 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rCnpb-0007AW-G2
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:28:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 191321FBBF;
 Mon, 11 Dec 2023 21:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702330128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfGx1iEf7FL9A8oVHSRCkTkB14BTR95AILK4GhgCieQ=;
 b=0Yq1ecAA4Pmu9Nsts7h3n7+Cww3XPEVLn6jLHWUa//JB3LoWobWiZfV9YHmA8PFlW6VJSF
 T1y4BnMAA99s8jyraw/lnnXZGzoVa+jnS3IlJR4JkjcAHmSuFwscOpQZ7MBf4DEHCvtxpN
 9WnR0iuKeMNWs91TN07YYG+4cYpn5oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702330128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfGx1iEf7FL9A8oVHSRCkTkB14BTR95AILK4GhgCieQ=;
 b=8nyHli98olIFYxOplo8QLdrKbQr5ydmd5QCbSv+dawP1zz/MS3xlPUyFQ8OgiWs0VpEDy1
 OPDNZgfdHdELY9DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702330127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfGx1iEf7FL9A8oVHSRCkTkB14BTR95AILK4GhgCieQ=;
 b=mpUwRD/J5+2KzmFSx1yBL8N/zFewJW+5QMT/wEc/f6HlIAy6KDClGThVWoAKZwX2uiod6O
 NLozTz5mpN94UnQAtS5pfPqF2vRNkKYze+jXB6Ka6n7yVyBpCp1hpNzhSYzrJuZ3pjs8m1
 bNSuv111fNpqFvoGL8PIuLS68CUlkx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702330127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfGx1iEf7FL9A8oVHSRCkTkB14BTR95AILK4GhgCieQ=;
 b=UwWzB0WJemE/ymEBJExtvxMnPFGku7KhzyuM7RUZrqdLuFhiq90JZ14AR5cd8+haeZthWw
 feeKMdLMzLSJAWBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D5E6133DE;
 Mon, 11 Dec 2023 21:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a0pcDQ5/d2UYKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Dec 2023 21:28:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peter.maydell@linaro.org,
 quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v2 07/20] util/dsa: Implement DSA device start and stop
 logic.
In-Reply-To: <20231114054032.1192027-8-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-8-hao.xiang@bytedance.com>
Date: Mon, 11 Dec 2023 18:28:43 -0300
Message-ID: <87h6koh1is.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.30
Authentication-Results: smtp-out2.suse.de;
	none
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> * DSA device open and close.
> * DSA group contains multiple DSA devices.
> * DSA group configure/start/stop/clean.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> ---
>  include/qemu/dsa.h |  49 +++++++
>  util/dsa.c         | 338 +++++++++++++++++++++++++++++++++++++++++++++
>  util/meson.build   |   1 +
>  3 files changed, 388 insertions(+)
>  create mode 100644 include/qemu/dsa.h
>  create mode 100644 util/dsa.c
>
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> new file mode 100644
> index 0000000000..30246b507e
> --- /dev/null
> +++ b/include/qemu/dsa.h
> @@ -0,0 +1,49 @@
> +#ifndef QEMU_DSA_H
> +#define QEMU_DSA_H
> +
> +#include "qemu/thread.h"
> +#include "qemu/queue.h"
> +
> +#ifdef CONFIG_DSA_OPT
> +
> +#pragma GCC push_options
> +#pragma GCC target("enqcmd")
> +
> +#include <linux/idxd.h>
> +#include "x86intrin.h"
> +
> +#endif
> +
> +/**
> + * @brief Initializes DSA devices.
> + *
> + * @param dsa_parameter A list of DSA device path from migration parameter.

This code seems pretty generic, let's decouple this doc from migration.

> + * @return int Zero if successful, otherwise non zero.
> + */
> +int dsa_init(const char *dsa_parameter);
> +
> +/**
> + * @brief Start logic to enable using DSA.
> + */
> +void dsa_start(void);
> +
> +/**
> + * @brief Stop logic to clean up DSA by halting the device group and cleaning up
> + * the completion thread.

"Stop the device group and the completion thread"

The mention of "clean/cleaning up" makes this confusing because of
dsa_cleanup() below.

> + */
> +void dsa_stop(void);
> +
> +/**
> + * @brief Clean up system resources created for DSA offloading.
> + *        This function is called during QEMU process teardown.

This is not called during QEMU process teardown. It's called at the end
of migration AFAICS. Maybe just leave this sentence out.

> + */
> +void dsa_cleanup(void);
> +
> +/**
> + * @brief Check if DSA is running.
> + *
> + * @return True if DSA is running, otherwise false.
> + */
> +bool dsa_is_running(void);
> +
> +#endif
> \ No newline at end of file
> diff --git a/util/dsa.c b/util/dsa.c
> new file mode 100644
> index 0000000000..8edaa892ec
> --- /dev/null
> +++ b/util/dsa.c
> @@ -0,0 +1,338 @@
> +/*
> + * Use Intel Data Streaming Accelerator to offload certain background
> + * operations.
> + *
> + * Copyright (c) 2023 Hao Xiang <hao.xiang@bytedance.com>
> + *                    Bryan Zhang <bryan.zhang@bytedance.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/queue.h"
> +#include "qemu/memalign.h"
> +#include "qemu/lockable.h"
> +#include "qemu/cutils.h"
> +#include "qemu/dsa.h"
> +#include "qemu/bswap.h"
> +#include "qemu/error-report.h"
> +#include "qemu/rcu.h"
> +
> +#ifdef CONFIG_DSA_OPT
> +
> +#pragma GCC push_options
> +#pragma GCC target("enqcmd")
> +
> +#include <linux/idxd.h>
> +#include "x86intrin.h"
> +
> +#define DSA_WQ_SIZE 4096
> +#define MAX_DSA_DEVICES 16
> +
> +typedef QSIMPLEQ_HEAD(dsa_task_queue, buffer_zero_batch_task) dsa_task_queue;
> +
> +struct dsa_device {
> +    void *work_queue;
> +};
> +
> +struct dsa_device_group {
> +    struct dsa_device *dsa_devices;
> +    int num_dsa_devices;
> +    uint32_t index;
> +    bool running;
> +    QemuMutex task_queue_lock;
> +    QemuCond task_queue_cond;
> +    dsa_task_queue task_queue;
> +};
> +
> +uint64_t max_retry_count;
> +static struct dsa_device_group dsa_group;
> +
> +
> +/**
> + * @brief This function opens a DSA device's work queue and
> + *        maps the DSA device memory into the current process.
> + *
> + * @param dsa_wq_path A pointer to the DSA device work queue's file path.
> + * @return A pointer to the mapped memory.
> + */
> +static void *
> +map_dsa_device(const char *dsa_wq_path)
> +{
> +    void *dsa_device;
> +    int fd;
> +
> +    fd = open(dsa_wq_path, O_RDWR);
> +    if (fd < 0) {
> +        fprintf(stderr, "open %s failed with errno = %d.\n",
> +                dsa_wq_path, errno);

Use error_report and error_setg* for these. Throughout the series.

> +        return MAP_FAILED;
> +    }
> +    dsa_device = mmap(NULL, DSA_WQ_SIZE, PROT_WRITE,
> +                      MAP_SHARED | MAP_POPULATE, fd, 0);
> +    close(fd);
> +    if (dsa_device == MAP_FAILED) {
> +        fprintf(stderr, "mmap failed with errno = %d.\n", errno);
> +        return MAP_FAILED;
> +    }
> +    return dsa_device;
> +}
> +
> +/**
> + * @brief Initializes a DSA device structure.
> + *
> + * @param instance A pointer to the DSA device.
> + * @param work_queue  A pointer to the DSA work queue.
> + */
> +static void
> +dsa_device_init(struct dsa_device *instance,
> +                void *dsa_work_queue)
> +{
> +    instance->work_queue = dsa_work_queue;
> +}
> +
> +/**
> + * @brief Cleans up a DSA device structure.
> + *
> + * @param instance A pointer to the DSA device to cleanup.
> + */
> +static void
> +dsa_device_cleanup(struct dsa_device *instance)
> +{
> +    if (instance->work_queue != MAP_FAILED) {
> +        munmap(instance->work_queue, DSA_WQ_SIZE);
> +    }
> +}
> +
> +/**
> + * @brief Initializes a DSA device group.
> + *
> + * @param group A pointer to the DSA device group.
> + * @param num_dsa_devices The number of DSA devices this group will have.
> + *
> + * @return Zero if successful, non-zero otherwise.
> + */
> +static int
> +dsa_device_group_init(struct dsa_device_group *group,
> +                      const char *dsa_parameter)

The documentation doesn't match the signature. This happens in other
places as well, please review all of them.

> +{
> +    if (dsa_parameter == NULL || strlen(dsa_parameter) == 0) {
> +        return 0;
> +    }
> +
> +    int ret = 0;
> +    char *local_dsa_parameter = g_strdup(dsa_parameter);
> +    const char *dsa_path[MAX_DSA_DEVICES];
> +    int num_dsa_devices = 0;
> +    char delim[2] = " ";

So we're using space separated strings. Let's document this in this file
and also on the migration parameter documentation.

> +
> +    char *current_dsa_path = strtok(local_dsa_parameter, delim);
> +
> +    while (current_dsa_path != NULL) {
> +        dsa_path[num_dsa_devices++] = current_dsa_path;
> +        if (num_dsa_devices == MAX_DSA_DEVICES) {
> +            break;
> +        }
> +        current_dsa_path = strtok(NULL, delim);
> +    }
> +
> +    group->dsa_devices =
> +        malloc(sizeof(struct dsa_device) * num_dsa_devices);

Use g_new0() here.

> +    group->num_dsa_devices = num_dsa_devices;
> +    group->index = 0;
> +
> +    group->running = false;
> +    qemu_mutex_init(&group->task_queue_lock);
> +    qemu_cond_init(&group->task_queue_cond);
> +    QSIMPLEQ_INIT(&group->task_queue);
> +
> +    void *dsa_wq = MAP_FAILED;
> +    for (int i = 0; i < num_dsa_devices; i++) {
> +        dsa_wq = map_dsa_device(dsa_path[i]);
> +        if (dsa_wq == MAP_FAILED) {
> +            fprintf(stderr, "map_dsa_device failed MAP_FAILED, "
> +                    "using simulation.\n");

What does "using simulation" means? And how are doing it by returning -1
from this function?

> +            ret = -1;

What about the memory for group->dsa_devices in the failure case? We
should either free it here or make sure the client code calls the
cleanup routines.

> +            goto exit;
> +        }
> +        dsa_device_init(&dsa_group.dsa_devices[i], dsa_wq);
> +    }
> +
> +exit:
> +    g_free(local_dsa_parameter);
> +    return ret;
> +}
> +
> +/**
> + * @brief Starts a DSA device group.
> + *
> + * @param group A pointer to the DSA device group.
> + * @param dsa_path An array of DSA device path.
> + * @param num_dsa_devices The number of DSA devices in the device group.
> + */
> +static void
> +dsa_device_group_start(struct dsa_device_group *group)
> +{
> +    group->running = true;
> +}
> +
> +/**
> + * @brief Stops a DSA device group.
> + *
> + * @param group A pointer to the DSA device group.
> + */
> +__attribute__((unused))
> +static void
> +dsa_device_group_stop(struct dsa_device_group *group)
> +{
> +    group->running = false;
> +}
> +
> +/**
> + * @brief Cleans up a DSA device group.
> + *
> + * @param group A pointer to the DSA device group.
> + */
> +static void
> +dsa_device_group_cleanup(struct dsa_device_group *group)
> +{
> +    if (!group->dsa_devices) {
> +        return;
> +    }
> +    for (int i = 0; i < group->num_dsa_devices; i++) {
> +        dsa_device_cleanup(&group->dsa_devices[i]);
> +    }
> +    free(group->dsa_devices);
> +    group->dsa_devices = NULL;
> +
> +    qemu_mutex_destroy(&group->task_queue_lock);
> +    qemu_cond_destroy(&group->task_queue_cond);
> +}
> +
> +/**
> + * @brief Returns the next available DSA device in the group.
> + *
> + * @param group A pointer to the DSA device group.
> + *
> + * @return struct dsa_device* A pointer to the next available DSA device
> + *         in the group.
> + */
> +__attribute__((unused))
> +static struct dsa_device *
> +dsa_device_group_get_next_device(struct dsa_device_group *group)
> +{
> +    if (group->num_dsa_devices == 0) {
> +        return NULL;
> +    }
> +    uint32_t current = qatomic_fetch_inc(&group->index);

The name "index" alone feels a bit opaque. Is there a more
representative name we could give it?

> +    current %= group->num_dsa_devices;
> +    return &group->dsa_devices[current];
> +}
> +
> +/**
> + * @brief Check if DSA is running.
> + *
> + * @return True if DSA is running, otherwise false.
> + */
> +bool dsa_is_running(void)
> +{
> +    return false;
> +}
> +
> +static void
> +dsa_globals_init(void)
> +{
> +    max_retry_count = UINT64_MAX;
> +}
> +
> +/**
> + * @brief Initializes DSA devices.
> + *
> + * @param dsa_parameter A list of DSA device path from migration parameter.
> + * @return int Zero if successful, otherwise non zero.
> + */
> +int dsa_init(const char *dsa_parameter)
> +{
> +    dsa_globals_init();
> +
> +    return dsa_device_group_init(&dsa_group, dsa_parameter);
> +}
> +
> +/**
> + * @brief Start logic to enable using DSA.
> + *
> + */
> +void dsa_start(void)
> +{
> +    if (dsa_group.num_dsa_devices == 0) {
> +        return;
> +    }
> +    if (dsa_group.running) {
> +        return;
> +    }
> +    dsa_device_group_start(&dsa_group);
> +}
> +
> +/**
> + * @brief Stop logic to clean up DSA by halting the device group and cleaning up
> + * the completion thread.
> + *
> + */
> +void dsa_stop(void)
> +{
> +    struct dsa_device_group *group = &dsa_group;
> +
> +    if (!group->running) {
> +        return;
> +    }
> +}
> +
> +/**
> + * @brief Clean up system resources created for DSA offloading.
> + *        This function is called during QEMU process teardown.
> + *
> + */
> +void dsa_cleanup(void)
> +{
> +    dsa_stop();
> +    dsa_device_group_cleanup(&dsa_group);
> +}
> +
> +#else
> +
> +bool dsa_is_running(void)
> +{
> +    return false;
> +}
> +
> +int dsa_init(const char *dsa_parameter)
> +{
> +    fprintf(stderr, "Intel Data Streaming Accelerator is not supported "
> +                    "on this platform.\n");
> +    return -1;

Nothing checks this later in the series and we end up trying to start a
migration when we shouldn't. Fixing the configure step would already
stop this happening, but make sure you check this anyway and abort the
migration.

> +}
> +
> +void dsa_start(void) {}
> +
> +void dsa_stop(void) {}
> +
> +void dsa_cleanup(void) {}
> +
> +#endif

These could all be in the header.

> +
> diff --git a/util/meson.build b/util/meson.build
> index c2322ef6e7..f7277c5e9b 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -85,6 +85,7 @@ if have_block or have_ga
>  endif
>  if have_block
>    util_ss.add(files('aio-wait.c'))
> +  util_ss.add(files('dsa.c'))

I find it clearer to add the file conditionally under CONFIG_DSA_OPT
here and remove the ifdef from the C file. I'm not sure if we have any
guidelines for this, so up to you.

>    util_ss.add(files('buffer.c'))
>    util_ss.add(files('bufferiszero.c'))
>    util_ss.add(files('hbitmap.c'))

