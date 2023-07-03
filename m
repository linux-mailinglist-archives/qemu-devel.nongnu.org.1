Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D46474585C
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGFrr-0007Kl-8S; Mon, 03 Jul 2023 05:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGFro-0007KF-C1
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:29:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGFrm-00067I-Mp
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:29:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso26158695e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688376545; x=1690968545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xIR6T4kv1EqY1vkBXopO2ferhPEnbZlPJUE8SmOPw1g=;
 b=bAgdxJKpmQx9GzBUCPD1Ty+wTbjBAxSYmyVUXMlQ4X1WZdlP2ZjaIX6mHFrVl93kXE
 j2OnDIcXhc19fnJWBnCoDWpAT0aUkKvtK+UZJEB/UwWpx6evYoTuRIKrQi6Xz2cN8kw0
 XOAIXEjcdV4rbPz/FP5N8fpdEShJ2R+U/2Ok31vJx7Tk3gCH17FfmPLfVIlSp94yeT/y
 uxfJzsDm7i6VLINuBSLHqcdb4CH1Ik35pF9nwwcOhPAvN3LteFU9KZrerQwUKlMM8myr
 B5io6FmNwC1og6WIKVtBttGCBnqM/MIWifwmVzKKe87ybu349JlPVpAxpeOdFQd+YdzT
 k5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688376545; x=1690968545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xIR6T4kv1EqY1vkBXopO2ferhPEnbZlPJUE8SmOPw1g=;
 b=PO73s1FfPNhoRO3nDl9xMgQ6La4eD555W9EMdIOmRCYYc3w8UfD+rCNOesOslGHjIJ
 fObI32Mro3sTRG6D+2IweBBjDr5WaArCalcIxhc+tOqpHx7UHXCHYS/NGF4X0vn8KL/h
 F6+i4K24WcpE3c5WuTI0i58s/mil2pkKIKrDb1ZqsoUAmIEjJ7KC3Y8naCWTZStXPpX3
 VZQU5JU/9tE7pfA1D+oUQV/b1JQ1OI6wiVNyv+vWHYa8nYxO2efKrdyQtJU9FnhNaacv
 tF0kYARM2i7ojIQnU/Jg6ZzozYhGMUPgLw5TqLoCYHcXH8pMp+SBEl/kEMV/1JsRAVsZ
 bBiw==
X-Gm-Message-State: AC+VfDzAIbrqieULoJJAjjmdiQxZmoPYKYfLEUFKqucE0ro5OuFYoLDy
 EzMsOboMwfd1A2t+W3TxuBjSnw==
X-Google-Smtp-Source: ACHHUZ7pyT4VlH8PEyX+cpwbgXSuPRXydX7U2aGi78ieRoQI84GjvRnLNKrI0zW/CGw2C5nHSmjWhg==
X-Received: by 2002:a7b:cc85:0:b0:3fb:8284:35b0 with SMTP id
 p5-20020a7bcc85000000b003fb828435b0mr7406404wma.30.1688376545098; 
 Mon, 03 Jul 2023 02:29:05 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 o23-20020a05600c379700b003fae92e7a8dsm20221869wmr.27.2023.07.03.02.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 02:29:04 -0700 (PDT)
Message-ID: <f36e408e-3254-4336-2cee-e0f1a3db0696@linaro.org>
Date: Mon, 3 Jul 2023 11:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ui: Link dbus-display with pixman again
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>, Frederic Bezies <fredbezies@gmail.com>
References: <20230630234839.14716-1-philmd@linaro.org>
 <CAJ+F1CKfx2i3fcikH_LujYGWmF56gyaECHqwPjwKoZqbHZsw9w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAJ+F1CKfx2i3fcikH_LujYGWmF56gyaECHqwPjwKoZqbHZsw9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 7/3/23 11:21, Marc-André Lureau wrote:
> Hi
> 
> On Sat, Jul 1, 2023 at 1:49 AM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     Since its introduction in commit 142ca628a7 ("ui: add a D-Bus
>     display backend"), dbus_display1 depends on pixman.
>     Unfortunatly the refactor commit 1222070e77 ("meson: ensure
>     dbus-display generated code is built before other units")
>     dropped that dependency. Recently commit 6cc5a6159a ("ui/dbus:
>     win32 support") expose this problem:
> 
>        In file included from include/ui/console.h:4,
>                         from ui/dbus.h:31,
>                         from ../audio/dbusaudio.c:36:
>        include/ui/qemu-pixman.h:12:10: fatal error: pixman.h: No such file or directory
>           12 | #include <pixman.h>
>              |          ^~~~~~~~~~
> 
>     Restore the missing dependency on pixman.
> 
> 
> I fail to understand how this would help.  dbus-display1 unit is pure GIO/GDBus code, no 
> pixman involved. The derived library dependency is then used to build and link the dbus 
> ui/ module.

meson dependencies

>     -  dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
>     +  dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies:
>     [gio, pixman])

like so, also include the set of -Iinclude-path-options to use when building the items 
that use it.  Therefore, for the moment, Phil is correct.

While dbus-display1 might not use pixman itself, ui/dbus.h certainly does.
Perhaps the usage in ui/dbus.h is the greater mistake.


r~

