Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A1E80CEAB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 15:50:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rChaa-0004CT-Cw; Mon, 11 Dec 2023 09:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rChaY-0004C2-DX; Mon, 11 Dec 2023 09:48:54 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rChaW-0002Dm-Ni; Mon, 11 Dec 2023 09:48:54 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1fb40253680so3154049fac.0; 
 Mon, 11 Dec 2023 06:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702306130; x=1702910930; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p7skq2DwBXynv1FCgqXoI7xtYx2ryMZBtvBq+I6+rrM=;
 b=LyKRiWu26+qhB6bRLvPRpDVlkt2JvGYU/zQrJKgh/PS2DOTHAldKGk4okLgVSATAt+
 CgNka8KN3F9fR/XXrYpc6I5VDL6t0dfJJavnNumMhvHOqUxcf5YwAM1cn+jJdxpcH1KP
 GFHEI0owyiXmWD+0NVShfnIHC9y68pgF9sWKAdLrnYvEpc6RzSnWeZWoREQwuA0k17wC
 lJlHNDQ00LT1Xl21TICuh6XtvKkjSAP6ImHey/rCbniDyxKmox9HwDJbeeD/O+dWW22Z
 6U/+GR0hG+KUtlUzG/OZT9kGUz0VY/axcODpuacPWxTdmvqrAjaAA1DRiNm9Nx4febo4
 MPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702306130; x=1702910930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p7skq2DwBXynv1FCgqXoI7xtYx2ryMZBtvBq+I6+rrM=;
 b=oOWN0ylxCCAoi0qv1RgPAxYDjjHeBkPYbf5OACvAxsVLijCLrh4q+bsWpVHbS8DQwP
 TgFy2DTZ7TxpN4PMgLQBzpa0X6XA88pZg+RsLdMN3uV/x9MESIZsx9vKZDq6xzJr0I3I
 LV1QZgw5fknJ4yOHUZRekXAWQBLTuP+FKOYtl3tTCtLv22RyjGHVokMhpQt/EGNUV6zA
 48pU7lxygvnd3VPRFDNP8DGR3ar2SEpuYgsjF5HzzlXbVeI5n4hqMHHS6lumfUbQ6waj
 jyMqeWeW378c+ZDRLKGgtwA33ABAk5/3OpNncaBpSf/PtHFdY9jjOZxmxhh7ui2jfz64
 XZzw==
X-Gm-Message-State: AOJu0YxtvB5l++eNPKpW8q+fD1U/PFVOU61kUxKnYJggUjaupJTb9OOs
 g/2J84jCA61GUBSyWmNwcGfmiGdcY8MUvaUiScqfCbHdx60=
X-Google-Smtp-Source: AGHT+IGG9+J1Ou/jd3qadshRbBJ/Wp2eKOi/gbRqkQGqDcKBV5sQGzBrbtB5uyoenJd4kWmin0VbIxWxQLXhGJ7RXpY=
X-Received: by 2002:a05:6870:7027:b0:1fa:a802:5f0d with SMTP id
 u39-20020a056870702700b001faa8025f0dmr4427223oae.35.1702306130239; Mon, 11
 Dec 2023 06:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20231208124352.30295-1-kwolf@redhat.com>
In-Reply-To: <20231208124352.30295-1-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 Dec 2023 09:48:38 -0500
Message-ID: <CAJSP0QVtEu4gPUi0yf3LTqvA3JbUx-STQGE5LoV+GSpZ=unK+w@mail.gmail.com>
Subject: Re: [PATCH for-8.2] block: Fix AioContext locking in
 qmp_block_resize()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 8 Dec 2023 at 07:44, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The AioContext must be unlocked before calling blk_co_unref(), because
> it takes the AioContext lock internally in blk_unref_bh(), which is
> scheduled in the main thread. If we don't unlock, the AioContext is
> locked twice and nested event loops such as in bdrv_graph_wrlock() will
> deadlock.
>
> Cc: qemu-stable@nongnu.org
> Fixes: https://issues.redhat.com/browse/RHEL-15965
> Fixes: 0c7d204f50c382c6baac8c94bd57af4a022b3888
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

From IRC:

09:40 < stefanha> kwolf: "[PATCH for-8.2] block: Fix AioContext
locking in qmp_block_resize()" fixes QEMU 8.1 bug and is not a
regression?
09:41 < stefanha> I'm trying to understand the nature of the issue and
whether to roll an -rc4 tomorrow and delay the QEMU 8.2 release by a
week.
09:41 < kwolf> stefanha: Looks like it, yes
09:41 < kwolf> stefanha: Probably not worth an -rc4 on its own if
there are no other fixes
09:42 < stefanha> Okay, thanks. If nothing else comes up by tomorrow I
will tag v8.2.0 (final) and we can merge this immediately when the
development window and -stable tree opens.

>
> diff --git a/blockdev.c b/blockdev.c
> index 4c1177e8db..c91f49e7b6 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2400,8 +2400,9 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
>
>      bdrv_co_lock(bs);
>      bdrv_drained_end(bs);
> -    blk_co_unref(blk);
>      bdrv_co_unlock(bs);
> +
> +    blk_co_unref(blk);
>  }
>
>  void qmp_block_stream(const char *job_id, const char *device,
> --
> 2.43.0
>
>

