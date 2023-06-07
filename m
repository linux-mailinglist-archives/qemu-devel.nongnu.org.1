Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C52725D03
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 13:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6rH0-0000Px-9g; Wed, 07 Jun 2023 07:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1q6rGr-0000Oo-LF
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 07:24:09 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1q6rGp-00010I-UB
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 07:24:09 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-33b3cfb9495so3861605ab.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 04:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686137043; x=1688729043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g0lBxN6hkvz0CiqkbFaYmydtuozSABRNTz3PmlNIXks=;
 b=ZBpLkmBPvBdfbREjXrxGIxhobUttEQRGmgoHUEilGt2kOKu1gaGYOrjtBAmWcp/5Ak
 lcn6aze6Mtnmu+V4QjLJgfBSGVke6/OB6ci0OEgWw2PIBYHbkyU1e8pXeQvo5sCyh9Q9
 QX8E5w/DjvGa40zNc2EX1bR5is7sNuxfDhuIwV6XBQEfrYxaRURf58al80o1NlcJcyzO
 E83kAFmNqRhlBTljlPRgx1GjnAOCkQUYtv4flVjWZ6HCqY+niQnRtKinN+6Cwb3VsKL2
 +OsnwX3+Yr1vte8tAZ1XL2Z4AmVMSsPIyXWjBwjVISQX7opwzfflmmvp/94Jy7cvNsdO
 005A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686137043; x=1688729043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g0lBxN6hkvz0CiqkbFaYmydtuozSABRNTz3PmlNIXks=;
 b=koY/VkR0iqCUN5jQFi65HeLmTK1WQktfNbI9/9Q+WOYgQtUClLevHAcPX8gocc2EnY
 C783rqptIMA3QSjgXqd9DXMFk2WI4siaC63JifyZjAre5B610lcwbSrCWU9LhmSBFxMo
 yK/+7sROc9YswI5IlXbmA0yq2MHSBeSNTSDRxyFZciM3UADZ0L/YC+/V/7U+ug4MIk2N
 pAunXUzdIVvEKUK1e1fiycRwUaQsOtDJ/5BsMB+tYOri1yp2PTarM4EUsgsEE5C302kz
 QYIqkKLuQ1zrneENJu3hyLDyO+BbeR75UDaUSG5MHogWjd39K3VhrV+PJF9Am7qHgNyw
 tCnQ==
X-Gm-Message-State: AC+VfDy9O3KXLw+5orrYbYDwL3bapZQUdORvjbtTgL1nDpKJ6ab+qMlS
 SemAIb3M1+PAxltIubFkAsY=
X-Google-Smtp-Source: ACHHUZ4y+NJ2ICLZQptAASNXn9OrEYTnwNYuTUwr7tolzjmE9s/sG6TReYKB6JumP3n/tcqPPG4zSQ==
X-Received: by 2002:a92:d98b:0:b0:33b:3486:8402 with SMTP id
 r11-20020a92d98b000000b0033b34868402mr7682785iln.7.1686137043624; 
 Wed, 07 Jun 2023 04:24:03 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c19-20020aa78e13000000b0064fde7ae1ffsm8330309pfr.38.2023.06.07.04.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 04:24:03 -0700 (PDT)
Message-ID: <48b15972-ed25-0adc-2d18-910504673bbd@gmail.com>
Date: Wed, 7 Jun 2023 20:24:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ui/sdl2: Support multiple OpenGL-enabled windows
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
References: <20230607091244.55270-1-quic_acaggian@quicinc.com>
 <CAMxuvaw88g9RPp_Om2Z9dJSmsrFMZ9ieKx8uJmSNgfsOYyQvSQ@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <CAMxuvaw88g9RPp_Om2Z9dJSmsrFMZ9ieKx8uJmSNgfsOYyQvSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/06/07 19:29, Marc-André Lureau wrote:
> Hi Antonio
> 
> On Wed, Jun 7, 2023 at 1:13 PM Antonio Caggiano 
> <quic_acaggian@quicinc.com <mailto:quic_acaggian@quicinc.com>> wrote:
> 
>     Multiple graphics devices can be defined with an associated OpenGL
>     enabled SDL console, hence make sure to not destroy their shaders and
>     windows.

I guess you meant multiple graphics devices can be associated to an 
OpenGL-enabled console and a switch event from a device destroys the 
shared state, but I don't see anything that associates multiple devices 
to a single console.

> 
>     Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com
>     <mailto:quic_acaggian@quicinc.com>>
>     ---
>       ui/sdl2-gl.c | 2 +-
>       1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
>     index bbfa70eac3..795fb1afc9 100644
>     --- a/ui/sdl2-gl.c
>     +++ b/ui/sdl2-gl.c
>     @@ -89,7 +89,7 @@ void sdl2_gl_switch(DisplayChangeListener *dcl,
> 
>           scon->surface = new_surface;
> 
>     -    if (is_placeholder(new_surface) &&
>     qemu_console_get_index(dcl->con)) {
>     +    if (is_placeholder(new_surface) && !scon->opengl) {
>               qemu_gl_fini_shader(scon->gls);
>               scon->gls = NULL;
>               sdl2_window_destroy(scon);
> 
> 
> This was introduced in commit c821a58ee7003c2a0567dddaee33c2a5ae71c404 
> by Akihiko.
> 
> Why should the window visibility behaviour be different whether it uses 
> opengl or not ?
> 
> If you are fixing a GL/shader crash, maybe it needs to be done differently.
> 
> thanks
> 
It does not make sense to check scon->opengl here; it should be always 
true when this function is called.

The condition qemu_console_get_index(dcl->con) should not be removed 
either. This keeps the first console persistent and makes sure the user 
can always interact with QEMU with the GUI SDL2 provides.

Regards,
Akihiko Odaki

