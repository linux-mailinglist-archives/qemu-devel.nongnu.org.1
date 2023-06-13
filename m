Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B25172D66D
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 02:29:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8rtb-0002N0-Kw; Mon, 12 Jun 2023 20:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q8rta-0002Mr-AB
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 20:28:26 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q8rtY-00054H-FK
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 20:28:26 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9745baf7c13so726117866b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 17:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686616101; x=1689208101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5cz7zT9c60jvEttog5Czy5/uKyAQY1BXcqDRbeoQQe0=;
 b=cBz0I8toyvZPrhwD/oUIP2vpR2VGTFXirdjw61E69vKlKvG7R/U0oiSYccXk2Ig2O+
 OzQnBkcUiXl1HKKyEdwAqFFVIg1qspS2v3Hdu5oVOXBswlZZb3y9QG9hquSTeiGf9ZLB
 XaeoXwyyIp4vAW13BqhG6x9AjayR2XXl7Kv+9LwSnAYMWFctsZbRrB1uBaGWDZYpDWyK
 4QqTqYii0NvIeOUZ/JPQz0jPfdgSw7qJPW3yCsRKxxukXR0EI52eXQl9E7IrnNpp7Xim
 eJowVIN3IC+WkkS6Gd+4WjS2aKE7NsDlnW2stl/hNxxNR04a+DqxoHXOYKSdjZwLA4gy
 tsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686616101; x=1689208101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5cz7zT9c60jvEttog5Czy5/uKyAQY1BXcqDRbeoQQe0=;
 b=BtQU7/ygvX0ANR62YuxQVWzA7rmrfrrV3Kl/DC7oKKD0EGx9fxl1+EhBe/72LYYLwz
 OlslXtjeSMz2znF8L2WPxvmYAOMhFOepq+zManipSGriWjgzDKf2HdNBjw90jY9xCQOt
 V2QFXh0WhfoYepOTgnctDthHkvhW8qfws7AhbQENs1ulWK5H1q+LgjielaVOBoWdOvSB
 U9mlXyIqEcvBSZSa551jbFy+SYE6f43OUOtTu8bWmXKbJwpGAB6MoZcr4Xy4EDiAwQIe
 TlPEqeneMZ5A9TKrUkVi7o8BI8wagHOodmMxmsfu/GvKv33zWNvwGYt1TaNLT8Xqh3IX
 /bHA==
X-Gm-Message-State: AC+VfDzjFUpaXtqkN+zUT6XhouexNW+XXdx1tczMPtUOj+pF5Ua1Br6n
 l5QUXloxQr0dYt/OfZ8u0uHgZI4zTcDCrQ6X4LUOynTo
X-Google-Smtp-Source: ACHHUZ7v44syJR1tjIAKheEvUlbbdnbBO+05cAFxq9suYD4cgqadfYiryjzxRIlsPI3JbVYa3AGZYg==
X-Received: by 2002:a17:907:968d:b0:978:6e73:e69b with SMTP id
 hd13-20020a170907968d00b009786e73e69bmr10900869ejc.38.1686616100832; 
 Mon, 12 Jun 2023 17:28:20 -0700 (PDT)
Received: from [10.61.102.188] ([46.189.28.45])
 by smtp.gmail.com with ESMTPSA id
 m10-20020aa7c2ca000000b005184165f1fasm1627246edp.5.2023.06.12.17.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 17:28:20 -0700 (PDT)
Message-ID: <7aa0d48c-9848-fb77-33e7-09dcb8ad27c0@daynix.com>
Date: Tue, 13 Jun 2023 09:28:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] sdl2: Check if window exists before updating it
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Antonio Caggiano <quic_acaggian@quicinc.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230608145512.25970-1-akihiko.odaki@daynix.com>
 <CAJ+F1CKZ4h8r-G9UoWnawWSxGNfoCQqzd7hxMWWRJJ=bJ875JQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAJ+F1CKZ4h8r-G9UoWnawWSxGNfoCQqzd7hxMWWRJJ=bJ875JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/06/12 18:00, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jun 8, 2023 at 4:56 PM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     A console does not have a window if the surface is a placeholder and
>     the console is not the first one. sdl2 cannot update the texture in
>     such a case.
> 
>     Add a proper check for window existence. Such a check is only necessary
>     for the "gl" implementation as the "2d" implementation checks for the
>     texture, which is set only if a window exists.
> 
>     Fixes: c821a58ee7 ("ui/console: Pass placeholder surface to displays")
>     Reported-by: Antonio Caggiano <quic_acaggian@quicinc.com
>     <mailto:quic_acaggian@quicinc.com>>
>     Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
> 
> 
> 
> Unless I am mistaken, this is fixed in git already:
> commit b3a654d82ecf276b59a67b2fd688e11a0d8a0064
> Author: Marc-André Lureau <marcandre.lureau@redhat.com 
> <mailto:marcandre.lureau@redhat.com>>
> Date:   Thu May 11 11:42:17 2023 +0400
> 
>      ui/sdl2: fix surface_gl_update_texture: Assertion 'gls' failed
> 
> thanks
> 
>     ---
>       ui/sdl2-gl.c | 4 ++++
>       1 file changed, 4 insertions(+)
> 
>     diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
>     index 39cab8cde7..bbfa70eac3 100644
>     --- a/ui/sdl2-gl.c
>     +++ b/ui/sdl2-gl.c
>     @@ -67,6 +67,10 @@ void sdl2_gl_update(DisplayChangeListener *dcl,
> 
>           assert(scon->opengl);
> 
>     +    if (!scon->real_window) {
>     +        return;
>     +    }
>     +
>           SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>           surface_gl_update_texture(scon->gls, scon->surface, x, y, w, h);
>           scon->updates++;
>     -- 
>     2.40.1
> 
> 
> 
> 
> -- 
> Marc-André Lureau

I overlooked it. You are right. It is identical and there is no need for 
additional patch.

Regards,
Akihiko Odaki

