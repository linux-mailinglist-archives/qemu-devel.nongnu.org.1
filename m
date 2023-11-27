Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9977FA2A7
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:30:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7cbl-0005Ho-QH; Mon, 27 Nov 2023 09:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r7cbi-0005Fd-LE; Mon, 27 Nov 2023 09:29:07 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r7cbg-0007z0-WB; Mon, 27 Nov 2023 09:29:06 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b2f4a5ccebso2819289b6e.3; 
 Mon, 27 Nov 2023 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701095343; x=1701700143; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=97tSUV5/uEbpkSN/UEGMiMnKPIDmVp5ssI+Jwshqu9k=;
 b=DQmZCelyJngFzfeRHwOF1OIVLWxwrU3nb/rxfTb8xJaKjalzmB1m9xWyDGWiMMPDcH
 uh+l+Idwu8P0xMS2HYq7vnFuvQ3dn7TA7HyJVx17HYEpOuibNkV+Dv1wETlMAZv211hy
 T5FIxBgNfZCLPKqjP6kbF/RnzmKKq1FveDCw7HYfZeUjiDjIukODOpILKurku0vrarg4
 tppwhNRHjct1OxsRgtqUZsF+3y7KahEv4NedGO0/hfjuYDa4hmTdiWLSY7Co+Gd9cziu
 QRAdmM1vzwgNrcL2Y0tHRuGAoT97k14C4OhLaEKAJIjGHaXrZ+P/85Yk3FdG0wQYHIfU
 b1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701095343; x=1701700143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=97tSUV5/uEbpkSN/UEGMiMnKPIDmVp5ssI+Jwshqu9k=;
 b=N+oASZFbq+j4KKL0zP7/y1ufOsGrxNvrnYPkfwjhn2k3lHigJucUvQWtQ6NOIv0QYP
 pC6vY+kT6KbdkMVlEf2aCuYUKTp8EfSH7lQ3ebul62I8K+EJoDsdRUUoDA633kpPB5mm
 QmGC3FTyPcxKdeGgQd3rMY2gfYw1iHOSGsYCKlfqOFCAG2ZOioYEnRetFRgGRe+qxKDr
 T2PD2BcrCXxH6no2J8uMas54FLbwQs045xV6KfgAX22HySF+huMl5AQEl8dXsAzSLVf3
 TmmAuw3yPCK1c5+S24W9n8r716sanlIt6k/u86tVXDneAfX1oPn5S9xPo41qB+ojmJTG
 A3fg==
X-Gm-Message-State: AOJu0YxrbYB+zV8aYeZvRj/VS6orztM/q0IsC2yB+zpnxQWLgOMLoA4b
 +c5Q2NCjz3LsD9fgq888eShhUv5qXVZoOMRPud0=
X-Google-Smtp-Source: AGHT+IHsGSrlJG3FNISYzJCJECJw/gzgRMaRfTut1r6jahC9LD684tkRq0cusYHkxEUasZPHaoc4nzxQadwxiIK8LIk=
X-Received: by 2002:a05:6808:ec1:b0:3b8:4dd7:b9ca with SMTP id
 q1-20020a0568080ec100b003b84dd7b9camr14895390oiv.39.1701095343048; Mon, 27
 Nov 2023 06:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20231127115755.22846-1-kwolf@redhat.com>
In-Reply-To: <20231127115755.22846-1-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 27 Nov 2023 09:28:50 -0500
Message-ID: <CAJSP0QULo8=i_TzcKGSMKCaRQ+Z=t=LE3i+hPSuwfrv7-3qwoQ@mail.gmail.com>
Subject: Re: [PATCH for-8.2 v2] export/vhost-user-blk: Fix consecutive drains
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x22e.google.com
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

On Mon, 27 Nov 2023 at 06:58, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The vhost-user-blk export implement AioContext switches in its drain
> implementation. This means that on drain_begin, it detaches the server
> from its AioContext and on drain_end, attaches it again and schedules
> the server->co_trip coroutine in the updated AioContext.
>
> However, nothing guarantees that server->co_trip is even safe to be
> scheduled. Not only is it unclear that the coroutine is actually in a
> state where it can be reentered externally without causing problems, but
> with two consecutive drains, it is possible that the scheduled coroutine
> didn't have a chance yet to run and trying to schedule an already
> scheduled coroutine a second time crashes with an assertion failure.
>
> Following the model of NBD, this commit makes the vhost-user-blk export
> shut down server->co_trip during drain so that resuming the export means
> creating and scheduling a new coroutine, which is always safe.
>
> There is one exception: If the drain call didn't poll (for example, this
> happens in the context of bdrv_graph_wrlock()), then the coroutine
> didn't have a chance to shut down. However, in this case the AioContext
> can't have changed; changing the AioContext always involves a polling
> drain. So in this case we can simply assert that the AioContext is
> unchanged and just leave the coroutine running or wake it up if it has
> yielded to wait for the AioContext to be attached again.
>
> Fixes: e1054cd4aad03a493a5d1cded7508f7c348205bf
> Fixes: https://issues.redhat.com/browse/RHEL-1708
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/vhost-user-server.h     |  1 +
>  block/export/vhost-user-blk-server.c |  9 +++++--
>  util/vhost-user-server.c             | 39 ++++++++++++++++++++++------
>  3 files changed, 39 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

