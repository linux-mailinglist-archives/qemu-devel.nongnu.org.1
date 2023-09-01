Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9672E78FF32
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:29:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc58H-0008Lk-HH; Fri, 01 Sep 2023 10:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc58F-0008Kz-4b
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:28:19 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc58C-0004Ai-Ss
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:28:18 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so58611a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693578495; x=1694183295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ib9DWaGi508QjpjnVnCTBsHEnjsMVtZTYxOscEQvaNA=;
 b=qObMpJLU0wr/AeAyUHjFmgnDrZX9ItPRyPaQKjScTmERYLBV7izrOLrIlcsFUb5Qkl
 iVR37hYl4jiq/epi0xIM0Io0Zk/bde5VVbsBsugXDUZz+BDNWjnIL6k32hx6yVtr/8/J
 z85YKdiNKL7Vco8mc3g9YBMcCEH6bvQoETE/GRyDOY4fyKCX6hqWXb3LAb2et01ZrA/R
 cTRiFJjdIiVO+jHEa1RSgfiXsXOsrXAONB3V9xr3jFE1WkU/RXulYsF5KY2okGYOkwi1
 c0z0VRzf+/RNnOA+1fdQp+8esND3y4vLKkcaLizlW3jX3GugBgPyFJB/2Yk28iyt/urs
 UkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693578495; x=1694183295;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ib9DWaGi508QjpjnVnCTBsHEnjsMVtZTYxOscEQvaNA=;
 b=ZnRvtYlRIKnq0AeIHk/vR4h6dRrG40N1wngsWO/M3pFqveXlLP7dr+V3pNHC/cggp2
 /LWYlDGp7WHZ8ZXAyO5qZf8d0WzK0eeouXZSnlxeKjq0AlslzJ2ZqaPGN6al7yBsHwC8
 0h62+hz61UmBLkweGs+GVw6r/yupAa1q2TjuM6Q8a7d/7M5mpbBRsMcmnHcvLnCNs+QT
 H0f3qCRjSHtNyMrAejcvkD/YuQZhSpPJ2qGp3R7H4QHJfNnwtNbmQrPB7NVSPjAclrDj
 04ZGBq9MDiXof4IZ7CJxVhOnrghPPApBfrkcOQsnXj7sQLZ5R2s/pmtPNjqe9e00qDX+
 mZDA==
X-Gm-Message-State: AOJu0YyMK/jGzhcLMaze2VzHRzIv3vDqUF5GU6X06L/d7FuUbSmaG8P9
 s8cJivn1ILlMwrd/bKSqSdhqnQ==
X-Google-Smtp-Source: AGHT+IE1dijZ9iz1ospmyEq8I7bNJNkl00WxVQV4XZLUsF0bkqyGB/4PSW17QUi9M1DijlvpILdCeA==
X-Received: by 2002:a17:907:7f29:b0:9a5:ae8a:6e0b with SMTP id
 qf41-20020a1709077f2900b009a5ae8a6e0bmr7192612ejc.24.1693578495042; 
 Fri, 01 Sep 2023 07:28:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.220])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a170906914800b00992f2befcbcsm2034271ejw.180.2023.09.01.07.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 07:28:14 -0700 (PDT)
Message-ID: <a0683cdc-9e90-f115-d477-8adf4682d4ee@linaro.org>
Date: Fri, 1 Sep 2023 16:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] dbus: Properly dispose touch/mouse dbus objects
Content-Language: en-US
To: Bilal Elmoussaoui <belmouss@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230901124507.94087-1-belmouss@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901124507.94087-1-belmouss@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 1/9/23 14:45, Bilal Elmoussaoui wrote:

Fixes: 142ca628a7 ("ui: add a D-Bus display backend")
Fixes: de9f844ce2 ("ui/dbus: Expose a touch device interface")

> Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
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


