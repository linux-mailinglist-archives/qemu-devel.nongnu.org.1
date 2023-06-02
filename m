Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80462720823
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:06:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58D0-0006KI-Ov; Fri, 02 Jun 2023 13:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58Cy-0006Jr-49
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:05:00 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58Cw-0005mO-EM
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:04:59 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f6067a9029so2963794e87.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685725496; x=1688317496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wu2azBPxg/W5OaOvJdveG4CeVN5Md79S1xLApxImbW8=;
 b=OkHufI2RJnSqWe8IUFnLjUbOx6NQTT09ZHsWZME9atTTUhv52es7AkByyoKVBpYz2f
 Bih2nZV2dzlF/Dh00wCWu28Ms9MGmjcCf7IwiszvueXRSSMAibW6zFdIuqJXPjOjNMfb
 gYP2RAiC/yN/ZtbBuywBsynMuHZPuNuMOhSfyIUncJ9YUBvNNS8oHXdQMV56Cjj+nd88
 VzQS/icn5B5tHPsp5VIS6m6bku8evtCRQh5vSAbpSbSv5qm8mrYtAdiW3YEv76tmALOH
 PIT2KMlIF5+mgjc6vHqRr2jpEpKddQFOG4lwX1hQ0GEk4vdnr6xsUQGMcW+29v8EAh9A
 Z3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685725496; x=1688317496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wu2azBPxg/W5OaOvJdveG4CeVN5Md79S1xLApxImbW8=;
 b=GuKvEAcZeXiWrS4d6OwJclHxQAoiNVimJK0jQKlkxkheLIoLskydtiE+rzM4WP2BjD
 8Iv4y/xHwtR1XmjT1p0b31RGO2ocDmxNwdAonZjVa3JnISN3bIgffI8pWzNPTbku1VKk
 SluMORBrvX5kJdcuyOmRY5aIT6cCkNMo9xlurGxU24R2j6FIc+IV0MMd6zSBc6IHLNb5
 qneRvQu1mtpAfs6WmzQH3x700E7qH8bGM3edQZ2OS9/hWFCMcEdYSjBeoEfJER7AMZSb
 Knf5waXKFoTwDyayudD0i5D2dViN+gjmRDgVIOeR6TiZkRxBUjPKTdwVKyZv1h0PxAu7
 5Hdw==
X-Gm-Message-State: AC+VfDwKMJmuUifgeHnLXGT/TgOa9Q2RxRWvhE8lGjuts6Dz1gET7l7b
 Rs5B2/iri76ymjv8bUCJGj74CDBgyAJhyW935syaXQ==
X-Google-Smtp-Source: ACHHUZ4/+Is328T6GvY/de0+LhGAh2taj9LS9Z864mJSiKsGIV0MBo7K7+9+5ciO92BqA8pbIyopI6RRTI2cTIyr9W4=
X-Received: by 2002:a05:6512:40a:b0:4f3:8143:765 with SMTP id
 u10-20020a056512040a00b004f381430765mr1976150lfk.27.1685725496026; Fri, 02
 Jun 2023 10:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210510125340.903323-1-anthony.perard@citrix.com>
 <20210510125340.903323-4-anthony.perard@citrix.com>
In-Reply-To: <20210510125340.903323-4-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2023 18:04:45 +0100
Message-ID: <CAFEAcA-ZxRW-+ttyfZj1hSAZyDbYj6Mbvs=KsG6Sfg6QTdKhrg@mail.gmail.com>
Subject: Re: [PULL 3/3] xen-block: Use specific blockdev driver
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Mon, 10 May 2021 at 13:53, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> ... when a xen-block backend instance is created via xenstore.
>
> Following 8d17adf34f50 ("block: remove support for using "file" driver
> with block/char devices"), using the "file" blockdev driver for
> everything doesn't work anymore, we need to use the "host_device"
> driver when the disk image is a block device and "file" driver when it
> is a regular file.
>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> Acked-by: Paul Durrant <paul@xen.org>
> Message-Id: <20210430163432.468894-1-anthony.perard@citrix.com>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Hi; Coverity points out (CID 1508722) that this introduces a
memory leak in the new error codepath:

> ---
>  hw/block/xen-block.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 83754a4344..674953f1ad 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -728,6 +728,8 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
>      XenBlockDrive *drive = NULL;
>      QDict *file_layer;
>      QDict *driver_layer;
> +    struct stat st;
> +    int rc;
>
>      if (params) {
>          char **v = g_strsplit(params, ":", 2);
> @@ -761,7 +763,17 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
>      file_layer = qdict_new();
>      driver_layer = qdict_new();

You can see here that we allocate file_layer and driver_layer
as new qdict objects...

>
> -    qdict_put_str(file_layer, "driver", "file");
> +    rc = stat(filename, &st);
> +    if (rc) {
> +        error_setg_errno(errp, errno, "Could not stat file '%s'", filename);
> +        goto done;

...but here if the stat() fails we will bail out to
the 'done' label, and the code there does not dereference
these qdicts, so they will leak.

The easy fix is to move the two calls to qdict_new() to
below this if() rather than above it.

> +    }
> +    if (S_ISBLK(st.st_mode)) {
> +        qdict_put_str(file_layer, "driver", "host_device");
> +    } else {
> +        qdict_put_str(file_layer, "driver", "file");
> +    }
> +
>      qdict_put_str(file_layer, "filename", filename);
>      g_free(filename);

thanks
-- PMM

