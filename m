Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA53D78757B
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:35:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDHS-0001pv-Sj; Thu, 24 Aug 2023 12:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZDHR-0001pl-Lv
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:33:57 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZDHN-0007It-Sr
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:33:55 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52a40cf952dso130204a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692894830; x=1693499630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m7MCdoA/Sw+ao0XXJ5JVG6jnb6akatdZTJnGZTxkQGU=;
 b=kIIBdfbRlwQcjoz7LHfcBbpMW2TUZwgVeamTaJw1wG+VrMhNIcCsRD/pdNRsaBYzQI
 U/jhxVF5zJkEBPFRobfrrFhpQAMStbdUUJo2a9tHw1NAflXbcYO7wN7MrltTWbwwM0K4
 06uBnY++NgQj3e92gDKrBZp3YHTn1uBu7IzbU7k11XMcGVVQ5u3d2mmlYfVtKl9YjcuI
 GDM+PffObhWIgBSnjpIBv9YJ4CE1WAgri6rCMRfwwaCd78ksbP+qJIV0n+sVp6JfOcpg
 3NEAtZt517/qJpGgjsnmAb+vXOz5XW1cuLFHv4Ur3y5hgQfz3+RxC0OdWQZlicsl373n
 SrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692894830; x=1693499630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m7MCdoA/Sw+ao0XXJ5JVG6jnb6akatdZTJnGZTxkQGU=;
 b=emktCxRdI43stnsiFCX5NBEWGnglt+Eo9iru8jXrjN64rDe267nfcBrm72Sz5k2HrR
 Ioy0WbUqH70plf0dprfmnkesLyfXQMJYlMHDjdqs7D8I/T2c4vyYGX1tVVfVj/OT+l/V
 vhQq6p2BGhI9k1/jMhqQ3iofjGdDHb7n9xB1mE4YYMFPvV63lTZywtsQWZqUMNO/YGWo
 n7B0m2byq+HVX2Rgwk6LhFapPtja5FSyQ/s99YkZEYHYxCBLxoeLFXVffTjNFIFQDqR5
 hw99Abc66NWemLgxbpZHGFZI51uJ+jEA13MqZ9Inf1z9A5VFr3GbtTv2v44m56aQ+UEl
 STRA==
X-Gm-Message-State: AOJu0YzL+KEFFS+lWV1EaN/5WPa2FPYlplMG4FUII0wofD/xseJONSMN
 rpIH2m+seow8ouk4Dtsg8jNDoKBQuD7+2GwQfslbk24sx/zJ3Ax9
X-Google-Smtp-Source: AGHT+IGQ5FV7E0qS+4CX88SUsvf9GkO11DlfW20/xtrhVY00zIJMFs7Jo28ZD4wCHos0sbYtstuZ7xCmX3Lke5jpl5o=
X-Received: by 2002:a05:6402:3447:b0:523:1004:1ca0 with SMTP id
 l7-20020a056402344700b0052310041ca0mr15003317edc.5.1692894829911; Thu, 24 Aug
 2023 09:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230824140839.391585-1-frolov@swemel.ru>
In-Reply-To: <20230824140839.391585-1-frolov@swemel.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 17:33:39 +0100
Message-ID: <CAFEAcA-vbBOq12sKH6M2rH1shmZqowQ1jF3WdE9JbDUsy+G8VQ@mail.gmail.com>
Subject: Re: [PATCH] fix leaks found wtih fuzzing
To: Dmitry Frolov <frolov@swemel.ru>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 24 Aug 2023 at 17:28, Dmitry Frolov <frolov@swemel.ru> wrote:
>
> Fuzzing causes thousands of identical crashes with message:
> "AddressSanitizer: 3744 byte(s) leaked in 1 allocation(s)"
>
> Fixes: 060ab76356 ("gtk: don't exit early in case gtk init fails")
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  ui/gtk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 8ba41c8f13..996ca7949d 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -2358,6 +2358,10 @@ static gboolean gtkinit;
>
>  static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>  {
> +    if (!gtkinit) {
> +        fprintf(stderr, "gtk initialization failed\n");
> +        exit(1);
> +    }
>      VirtualConsole *vc;

This breaks our rule against having variable declarations
in the middle of code blocks. The variable declarations
need to come first, before this code.

More generally, I don't understand why this change is
necessary. If gtkinit is false, we're going to call
exit(), which will clean up all our allocations. The
specific allocation of the GtkDisplayState can hardly
be the only one that we still have allocated and
are relying on the cleanup-on-exit for.

>      GtkDisplayState *s = g_malloc0(sizeof(*s));
> @@ -2365,10 +2369,6 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>      GtkIconTheme *theme;
>      char *dir;
>
> -    if (!gtkinit) {
> -        fprintf(stderr, "gtk initialization failed\n");
> -        exit(1);
> -    }
>      assert(opts->type == DISPLAY_TYPE_GTK);
>      s->opts = opts;

thanks
-- PMM

