Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6705C7A07D5
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgndf-0005N7-6N; Thu, 14 Sep 2023 10:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgndU-0005JZ-9B
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:48:04 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgndS-0002CQ-Io
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:48:04 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52f3ba561d9so2376545a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694702881; x=1695307681; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bqF8iIoYFYK7s1B1+SoPgteb1pSYbvT9WlndtwZfOCI=;
 b=HbzjZnuGTmYL8WW1e2LyDPgRUW05HH//tUd2fJWfUusHzMbtws0hT6bx6XdHEly2Zz
 zQVh8LHve9Ykw4otyV/9bE2DtEiA5mgdfgW2j4LB12qx5TDZs6XkQ38+zRIEv1CABgkx
 NzwlwIoWcrU1nSkZJxuwKjvX02ScJ61jao0kTD4QnZ0vKb6r916nZsb18tHq9Ph4wk88
 gFHzpOR/7Rz5cWDCSSghiL2/q0u0Xjf1reFKpS50RRbrJ9SNqLa+FvWEXFF3lGIsJwAG
 /puT88itOMIGlNobcWKieqCILkWMj8LB+7sRtaHGqDxQ19b+wRcougc3ZsSEsmQNtvqD
 2tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694702881; x=1695307681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bqF8iIoYFYK7s1B1+SoPgteb1pSYbvT9WlndtwZfOCI=;
 b=YgVddeoaYclhc2/K5BJsERUaFb53c34Gn9TW4LlFWl502gvnsjUXOJdPrHssIOKCcX
 BtpMnTLtzRzuxZmc0jqL9AoJatdqinOsjJXIcc3q2oeBokRbQ1L5eLvtDu+rnXF8WZ7L
 phM1FupGUajcPxzUdfZM+2QVkhtkMnh5gQXe30PsUlW4ZiVWrTeZFxfS120H3p6UxyyJ
 kzQEu5dF015mTbFT9IGo/hCPCyGn94boOWuNXAB5pwG3jXPp1zwN6/b6tAh45m2LVhPP
 WQfSZcAhc6U9fW1EHOR3gRfWDQx/PJN7yWNt0N3/3mu0MHeyIsYeNL1CLl3KO9qm2GQZ
 pgVw==
X-Gm-Message-State: AOJu0YzEHb0NOfVG+E9I7bwf934ZYCrvf5+yaaz5FFTitQ8dGdFWuEYz
 6uwbtEA3eWPAFNy1o9swDmHgJFR9M3XMAoUTD6T/Lw==
X-Google-Smtp-Source: AGHT+IF4SD3qfQcnj+drM1ce7z9qyFgZqvZI9JPOBTqKUJh0HGwyOi5QesewjL3QKCM/6zdsUBOShHSMyL/l1b1bm7Y=
X-Received: by 2002:a05:6402:2695:b0:52e:4789:bee2 with SMTP id
 w21-20020a056402269500b0052e4789bee2mr3111043edd.6.1694702881046; Thu, 14 Sep
 2023 07:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230907181628.1594401-1-stefanha@redhat.com>
 <20230907181628.1594401-5-stefanha@redhat.com>
In-Reply-To: <20230907181628.1594401-5-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2023 15:47:41 +0100
Message-ID: <CAFEAcA_iusT008ZHtB-Q=a-aCFCOMoHiKfrhmPpNGWwGa720UA@mail.gmail.com>
Subject: Re: [PULL 4/5] hw/ufs: Support for UFS logical unit
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>, 
 Hanna Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 7 Sept 2023 at 19:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Jeuk Kim <jeuk20.kim@samsung.com>
>
> This commit adds support for ufs logical unit.
> The LU handles processing for the SCSI command,
> unit descriptor query request.
>
> This commit enables the UFS device to process
> IO requests.
>
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: beacc504376ab6a14b1a3830bb3c69382cf6aebc.1693980783.git.jeuk20.kim@gmail.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Hi; Coverity points out a NULL pointer dereference issue in
this code (CID 1519043):


> +static void ufs_lu_realize(SCSIDevice *dev, Error **errp)
> +{
> +    UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
> +    BusState *s = qdev_get_parent_bus(&dev->qdev);
> +    UfsHc *u = UFS(s->parent);
> +    AioContext *ctx = NULL;
> +    uint64_t nb_sectors, nb_blocks;
> +
> +    if (!ufs_lu_check_constraints(lu, errp)) {
> +        return;
> +    }
> +
> +    if (lu->qdev.conf.blk) {

Here we check whether lu->qdev.conf.blk is non-NULL, implying
that it can be NULL at this point...

> +        ctx = blk_get_aio_context(lu->qdev.conf.blk);
> +        aio_context_acquire(ctx);
> +        if (!blkconf_blocksizes(&lu->qdev.conf, errp)) {
> +            goto out;
> +        }
> +    }
> +    lu->qdev.blocksize = UFS_BLOCK_SIZE;
> +    blk_get_geometry(lu->qdev.conf.blk, &nb_sectors);

...but here we pass it to blk_get_geometry(), which will
unconditionally dereference it, and crashes if it is NULL.

Either the NULL check above is unnecessary, or else this
bit of the code needs to do something else for NULL.

> +    nb_blocks = nb_sectors / (lu->qdev.blocksize / BDRV_SECTOR_SIZE);
> +    if (nb_blocks > UINT32_MAX) {
> +        nb_blocks = UINT32_MAX;
> +    }
> +    lu->qdev.max_lba = nb_blocks;
> +    lu->qdev.type = TYPE_DISK;
> +
> +    ufs_init_lu(lu);
> +    if (!ufs_add_lu(u, lu, errp)) {
> +        goto out;
> +    }
> +
> +    ufs_lu_brdv_init(lu, errp);
> +out:
> +    if (ctx) {
> +        aio_context_release(ctx);
> +    }
> +}

thanks
-- PMM

