Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E12AB78FBE9
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:49:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc1i0-0004gs-2L; Fri, 01 Sep 2023 06:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc1hr-0004eM-D6
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:48:51 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc1ho-0001tt-Un
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:48:51 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5009d4a4897so3372697e87.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693565327; x=1694170127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yu1K7yLr0vuZhrCIPlP3az7X2h6Z4lm1oYc+i6mvM5o=;
 b=n/arY63BqCjY1etuG/iY1t8QL2ZvAYnREsIcrlgXDI5QQGQWkqxFcYJC54V4axyMDx
 LJb5mAE3tpa4fy2ekTT+/ohfx48xR8/Pb4EaIThoSqPW1Em+SpXpzLA1QLps4PnYQPFt
 5BilVJuWJYZfc16JzdvzTs3bUv0daEq8mcrXnOQ6gIVPO/R8lmeaaaoC6gaFW+NQ5t5e
 Js4QNbxoSunNH3Z0kqml+TKzQivgK/V5ZTn+ZP3eKtKnQ5vHEnubwqeUIijvXQFmOabe
 m+U3YBmDROnuunPlDReBK04nWoJTIgjf2qxkh6zq7P3atgRfOuxc5PMc+hKCiBdfZB3u
 BgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693565327; x=1694170127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yu1K7yLr0vuZhrCIPlP3az7X2h6Z4lm1oYc+i6mvM5o=;
 b=VcCeU2BoKVkuOU1pSzEAuYySEU22p33PVsqBwGwf4T7OKINBQXpMuryq2rEPCa2/fB
 rUjnoafHZj/AGZpjlvNIvRP3hqE3VqEYnjwzHn93lFn63bm6PByNrf22bK+piOvn+G4S
 gZS9kn1IZqGcRPjG3+OBBZAScVBW51ZC3KxS7E0McjjJ+1LZrweXD8L60il+HL0ttSUV
 T3X6JwqC83umxQvgQA4Gp//cf14+cZLQGLoZUxOu4Q7DJHY+3sxjJS1Fa1t91SVM1bfv
 HfrK0VbfPjP0r1LckjRdt7OJgkiMJsxwT5vsT2AZ7rTbBDU+ednaw1gQHYnWvmgfcuLq
 w0eQ==
X-Gm-Message-State: AOJu0YzRKTdU+dWnOG3x4aubWl6kYX4nOVrJIpzilNRxF9mCrl0cuj6b
 x7B653O6ju4oaiyeWPL1QBBWBw==
X-Google-Smtp-Source: AGHT+IFNyeZbXIbKu/IKkL9XjCVy8c3W/Jj9xWIkOaGnZZ/6OC5ZyE6OHezuAGOcE/GN9OHVmJwC9w==
X-Received: by 2002:a19:5010:0:b0:4f8:4245:ed57 with SMTP id
 e16-20020a195010000000b004f84245ed57mr1252288lfb.35.1693565327346; 
 Fri, 01 Sep 2023 03:48:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.220])
 by smtp.gmail.com with ESMTPSA id
 x18-20020aa7d6d2000000b0052718577668sm1910122edr.11.2023.09.01.03.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 03:48:46 -0700 (PDT)
Message-ID: <adbb7fc5-1e25-131b-b6dd-da782d46528c@linaro.org>
Date: Fri, 1 Sep 2023 12:48:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] dbus: Properly dispose touch/mouse dbus objects
Content-Language: en-US
To: Bilal Elmoussaoui <belmouss@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230901103020.86915-1-belmouss@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901103020.86915-1-belmouss@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

Hi Bilal,

Fixes: 142ca628a7 ("ui: add a D-Bus display backend")
Fixes: de9f844ce2 ("ui/dbus: Expose a touch device interface")

See 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line

   Your patches must include a Signed-off-by: line. This is a
   hard requirement because it’s how you say “I’m legally okay
   to contribute this and happy for it to go into QEMU”.

On 1/9/23 12:30, Bilal Elmoussaoui wrote:
> ---
>   ui/dbus-console.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index e19774f985..36f7349585 100644
> --- a/ui/dbus-console.c
> +++ b/ui/dbus-console.c
> @@ -150,6 +150,8 @@ dbus_display_console_dispose(GObject *object)
>       DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
>   
>       unregister_displaychangelistener(&ddc->dcl);
> +    g_clear_object(&ddc->iface_touch);
> +    g_clear_object(&ddc->iface_mouse);
>       g_clear_object(&ddc->iface_kbd);
>       g_clear_object(&ddc->iface);
>       g_clear_pointer(&ddc->listeners, g_hash_table_unref);


