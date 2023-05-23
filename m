Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 395DC70D8DB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 11:23:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1OE9-0004wi-6k; Tue, 23 May 2023 05:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1q1OE6-0004wF-KW
 for qemu-devel@nongnu.org; Tue, 23 May 2023 05:22:42 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1q1OE4-0004P5-FL
 for qemu-devel@nongnu.org; Tue, 23 May 2023 05:22:42 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-50db91640d3so988497a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684833758; x=1687425758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4S8pldpibBh6DpWnAxWT02FpLOoHqMReAhp6gE8fv04=;
 b=k5YnBdhEH2woffFry5P5BFnqgWj8f1BeaETaAJ88vH0BRPtIwoAv7btiMCfBfbwtOE
 wpGdvw0WoocglC6Vp/mPlVmv+rc/jmoiJ2n7/69Y/oa0PPNv7cJFFkZDh2oCRvhZ6/FM
 2nX7iuAr5GlG++OzsRMyaDRCJRMkzP/H4Pk+hZP2Blwztu/n6WodTPutjkd9tdzemKSb
 5FAwRbfFl2RLUIVI65n8YzlHaTBL4tQ2mdYVmJrk+3ONw8+iI6x9YkCSG/nh1MZfvuX2
 xldfVjEC7GUqDvQVK/yYE4JgWa3zcBIbnuvaReromowMiF90N4L0OcVisX56ceqDcjK9
 5zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684833758; x=1687425758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4S8pldpibBh6DpWnAxWT02FpLOoHqMReAhp6gE8fv04=;
 b=iIl1jxk51kEc9+h74NJHhuRAjaHyxJKI3ZcPCpeNWqCEQSa/vYbxquvvwC39lcEA1e
 ohxs6Dw61TsesyT1TWZu5fN/HB9rJGI3aodBZN4UjMXFrlC6nhAQS/5Yk598U9sXGfKX
 LlZkcSovPpcHwLbhUXcWH9ZoK8r8vp8CcKcI3LQrBHRjS2QZfJ4YkNUCz2dja00nradI
 UmTCSK/HSj8ls+BGZdRn9fkV5HPFbO6picl0EQG8wlSXpjmKnoaii8Mwcsv+MhXeYW16
 Q/6cPB7pIWhD6e70Bo6eqrFu6Yfe/4O0T/nSMz70v+eJH3W1JREbZgr7XLmCxF+TucGA
 HwLQ==
X-Gm-Message-State: AC+VfDxzJ51ZQy/cSkYY5aCSQio0TxUGafyt839GUKqrvx7T/jsWHHw6
 VvxswkZqf9gbmWUiaXtpBOKsj/MKHB7MapmqPcI=
X-Google-Smtp-Source: ACHHUZ5m2rAOwSsLfO4HH+h13efRf8dkyWhwnyWvEnIL3W739w4OtVD1efGzCGgKHCNDynQIJujMQ0JtA5/2LPmW3IM=
X-Received: by 2002:aa7:d6d8:0:b0:510:d6f5:3970 with SMTP id
 x24-20020aa7d6d8000000b00510d6f53970mr11220804edr.32.1684833758282; Tue, 23
 May 2023 02:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230511074217.4171842-1-marcandre.lureau@redhat.com>
In-Reply-To: <20230511074217.4171842-1-marcandre.lureau@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 23 May 2023 17:22:26 +0800
Message-ID: <CAEUhbmVkMpOgrxJAtOAFOjC7TdZ_KRWHeUFabiqxkd6swV3B8g@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: fix surface_gl_update_texture: Assertion 'gls'
 failed
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ed1-x535.google.com
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

On Thu, May 11, 2023 at 3:43=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Before sdl2_gl_update() is called, sdl2_gl_switch() may decide to
> destroy the console window and its associated shaders.
>
> Fixes:
> https://gitlab.com/qemu-project/qemu/-/issues/1644

This should be:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1644

>
> Fixes: commit c84ab0a5 ("ui/console: optionally update after gfx switch")

This should be:

Fixes: c84ab0a500a8 ("ui/console: optionally update after gfx switch")

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/sdl2-gl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index b36ba6415a..cc83c98349 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -67,6 +67,10 @@ void sdl2_gl_update(DisplayChangeListener *dcl,
>
>      assert(scon->opengl);
>
> +    if (!scon->real_window) {
> +        return;
> +    }
> +
>      SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>      surface_gl_update_texture(scon->gls, scon->surface, x, y, w, h);
>      scon->updates++;
> --

Testing this patch with the "-device virtio-gpu-pci -display
sdl,gl=3Don" command line, the assertion mentioned in
https://gitlab.com/qemu-project/qemu/-/issues/1644 is fixed.

Tested-by: Bin Meng <bin.meng@windriver.com>

Regards,
Bin

