Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68821829E6D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 17:23:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNbLF-00025k-F5; Wed, 10 Jan 2024 11:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNbLD-00025b-TD
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 11:22:07 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNbLC-0005Kj-3c
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 11:22:07 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55783b7b47aso4320741a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 08:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704903724; x=1705508524; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RQbVWWV0iLbOgc1sqt3l1d55SP51d5YX5F/43B21edQ=;
 b=BGqPkcuWcImWtxHnTmDjL+ZVQOZmQjw8XRqEXMgRdFau0KHoDsEUx0c3W9cJJlYfbu
 i9DQcC3sq07ufTbfPUfPS/SUafa9UVkKzYrTa4umqbBVY6J30Oqan0fVFy85XVMGYJC+
 o6auVH/JdJ5MSGOkVkz7/DWM4mAU6xDUpcBMo4fdRKATN3VZYaYWBdiH4id5E2ky9+eP
 A86Gmnr3gAjOBAeeWjwfyNWfx0tS31Q4Wvj8tr7ip4EnyPzNffgBcYq1reATg8YOtVMJ
 HVZEYupkVJBQjXGCC3CeIbxx3/hXVkeJwTwxxUqGL5gjpecWGD1jo/8w2gUmW7nitt1g
 9TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704903724; x=1705508524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RQbVWWV0iLbOgc1sqt3l1d55SP51d5YX5F/43B21edQ=;
 b=QBnz7gUtLqnYrLcOcfVU7ZpyP8jG1pls9CRnZQ32m06oG/zZPpNWCkYxSQUdcl20NF
 2w5IR1EWsW4EnOmvkueKD/JK9+jooOrb6hzJrbdjkkLBNeoBrWebZgHUKDd6bZyBxjko
 7jD6Bk8KeD8vQi6V1R4MMy43ejdg0ctw+gfs4oxYihev3IIZngpwQ7NiDPgoObMKNuJ4
 uTBcoMIIW/Oncs4FTSaGuw/3Z3O7NUlhXub8FkNOwem7uKdp8OKEM4MCxHGzROIYbyJx
 MXZaEjN6BUBRcXMufd0URTQGgi1KWwlIfShum0dK1X47bcMz+3wVWQ2vovDkjQoRQOjn
 YElg==
X-Gm-Message-State: AOJu0YyIYCnQb/f9Eiz0GflfRSc5CKau2ChvxSGT9w9L0AQwGykvJClo
 Ujo6K9BjCvQqd+3NiWSO3DeX67RvcDVrNaxPysBRYHnxKy146NhakfnbHUWZ
X-Google-Smtp-Source: AGHT+IGU7WKhaAnqmxddygqHL5Cv/TDrcW21DzikxPZcRo+vlmplggp/4Cuj+rsed5DlT1IkgjOqis4L3c0NqFdXQi0=
X-Received: by 2002:a05:6402:3cf:b0:557:6d4e:d087 with SMTP id
 t15-20020a05640203cf00b005576d4ed087mr594841edw.77.1704903723947; Wed, 10 Jan
 2024 08:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20240110070808.369516-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240110070808.369516-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jan 2024 16:21:30 +0000
Message-ID: <CAFEAcA9_iDwgGr9n9HeYUGL3=NyJ0=8Vrp9O2P23APzYaiL7FQ@mail.gmail.com>
Subject: Re: [PULL 0/2] qemu-sparc queue 20240110
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 10 Jan 2024 at 07:09, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit 9468484fe904ab4691de6d9c34616667f377ceac:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-01-09 10:32:23 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-20240110
>
> for you to fetch changes up to 995d8348eb3d8ddf24882ed384a5c50eaf3aeae9:
>
>   util/fifo8: Introduce fifo8_peek_buf() (2024-01-10 06:58:50 +0000)
>
> ----------------------------------------------------------------
> qemu-sparc queue
> - introduce fifo8_peek_buf() function
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

