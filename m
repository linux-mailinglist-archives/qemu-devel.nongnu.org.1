Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF9B705626
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 20:40:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyza6-0003oX-0c; Tue, 16 May 2023 14:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1pyzZu-0003o7-6f
 for qemu-devel@nongnu.org; Tue, 16 May 2023 14:39:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1pyzZs-0004hL-0k
 for qemu-devel@nongnu.org; Tue, 16 May 2023 14:39:17 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-50bc5197d33so26405281a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684262347; x=1686854347;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lQwG7N5SBjVne0znY0zBTPAIW9qiGGv9hg0jq2FD/4=;
 b=NF6/Zhh2B6aIuK6gylxzl1gKPN2eSl9NLd8Xob05Vv5I3AiTwGnnKg7IsFm3+Cz9oF
 m3NkY5ryNMH+FLlz12qw2oInxl3vFE2CchUJ1apjSvWdLqF0bJnE9L66icLG+2ITvfpx
 tRDJi4xUITkkgG3nhYgV5pEYLfCeAkr/Gno4E6mVM+VWI9hy1jbuuplSIGaL9zogFbdM
 I7V0Y+z8ju0vqH0tHmgUVHuI78x1qeomAxLclGv00qimw2BrEWm9cJA3QLWd5Jr1GgAe
 sHArqROI22vBgXzO2meD2X2p4c6i3NswG30l01kLkDiwtkXuKr/LmpEeU0vhilzP1MyZ
 Zaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684262347; x=1686854347;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8lQwG7N5SBjVne0znY0zBTPAIW9qiGGv9hg0jq2FD/4=;
 b=ZdLGMhAXvStD9poo/rXuQHycsXVq+4lgdGB/NoZEmI3XzyYi0obnxWmqK4OlUD20j6
 Gq7T+oAzpO/K2MeUe1LR5GXS/lVPLuWAtG3stogn2voGlA5HunOBKb7TDDxpRR1iLuyi
 kHfj2IrjwMXx5kt5qf4YmCxIi9ER+F+YjSwNWVh+PasGDzxDEAMImPm9q/lWZIYO4no/
 ahIHt2qs3w2zZJaOVJwBb5zj1z91bZs2DOcWe3WN0Ggcxtr+uXYiFyZvTVxyHmPUvS24
 G0Z+YCBUs3zzIWo3QR0Q8ot6HYtiOZnXPl12df/uwF01mgsd+vYqSFwBTQqIAZPe7WIZ
 DNuQ==
X-Gm-Message-State: AC+VfDxREL7KYOr0vDiCQeI7bIKLxKjyo5+1KkW1He/HujAohHvmOQsd
 q4LT0X9SHu6DMYqjLbv1J4KXQx0Sm9c=
X-Google-Smtp-Source: ACHHUZ5xE+C+NDvofO6RnMz9eZlhg+jwDqLltNj2Odhat/J/9EzwpX7SAHucCQzds91qlp0MuvRG8w==
X-Received: by 2002:a05:6402:783:b0:50b:c6c9:2146 with SMTP id
 d3-20020a056402078300b0050bc6c92146mr57305edy.24.1684262347367; 
 Tue, 16 May 2023 11:39:07 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 u24-20020a056402111800b0050bc4eb9846sm8445064edv.1.2023.05.16.11.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 11:39:06 -0700 (PDT)
Date: Tue, 16 May 2023 18:37:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
CC: kraxel@redhat.com,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] gtk: add gl-area support on win32
In-Reply-To: <20230515132527.1026064-1-marcandre.lureau@redhat.com>
References: <20230515132527.1026064-1-marcandre.lureau@redhat.com>
Message-ID: <FA87AB3F-F3F6-4FA9-9376-0D54FF8F6B1E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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



Am 15=2E Mai 2023 13:25:27 UTC schrieb marcandre=2Elureau@redhat=2Ecom:
>From: Marc-Andr=C3=A9 Lureau <marcandre=2Elureau@redhat=2Ecom>
>
>On Windows, we don't use the low-level GBM/EGL helpers (no dmabuf etc),
>we can turn on GL area support for the rest of rendering=2E
>
>(fwiw, GDK backend may be either WGL or EGL)
>
>Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre=2Elureau@redhat=2Ecom>

Works for me on Windows 11 host, today's msys2, and OpenGL desktop effects=
 working inside, so:

Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>
>---
> ui/gtk=2Ec | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/ui/gtk=2Ec b/ui/gtk=2Ec
>index f16e0f8dee=2E=2E0a39b1935b 100644
>--- a/ui/gtk=2Ec
>+++ b/ui/gtk=2Ec
>@@ -2445,6 +2445,12 @@ static void early_gtk_display_init(DisplayOptions =
*opts)
>             gtk_use_gl_area =3D true;
>             gtk_gl_area_init();
>         } else
>+#endif
>+#if defined(GDK_WINDOWING_WIN32)
>+        if (GDK_IS_WIN32_DISPLAY(gdk_display_get_default())) {
>+            gtk_use_gl_area =3D true;
>+            gtk_gl_area_init();
>+        } else
> #endif
>         {
> #ifdef CONFIG_X11

