Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D008812BB9
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 10:30:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDi1p-00017R-Eg; Thu, 14 Dec 2023 04:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDi1o-00017C-4q
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 04:29:12 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDi1m-00067y-Gl
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 04:29:11 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a1f6433bc1eso77280066b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702546148; x=1703150948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GmJdc2azy10lm1fOidq4LATaw711vTxbANnDkUTSX58=;
 b=WGt6KswX/LcNA/v+mzXUxvnmj2zyZya05P85wOAK/BMYmDTJo2wzLadIAVD+gC1pa+
 DF1/qnS0NVVq3cgcRE66gZ+262tHBvLU3353kG7Ki9iwYfepYd5oID5IVGV8UuKA9mFI
 T/Awzt49GvIi7O87fnMHUfG+ealgOiFSu1CNgwtL354OMyR1eXhd14C90pk5BJdIVQip
 /uSCygouNMv5U5ieCemJfzhhdnbVaVZdMQkuzkLYmBJKGwpQpBfFhJCZwKDJL9i7Fo5g
 9GK4d3wPDiLj+ygd1rKo4qxdEH4eo+EdnX5W57iOidI9tb5Jb7x9ztbqAZ+mxzYzUl/C
 M7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702546148; x=1703150948;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GmJdc2azy10lm1fOidq4LATaw711vTxbANnDkUTSX58=;
 b=k+0/L79O2ce9BWuN/sWZOqYoW/qM6tVMuQ1ohEBqSeDeNJMrq4y/VLqNylOBTTOsa4
 nl7qbUNg8cLEdT3xK/9e4427bLOHT29kOuCbZ9USdPhke3iLzon+HOd+sX0OAm8rL/iZ
 Xh+lusfbfT0Hz+adNyiMrvWZJ6MnhZHYaPUW5eNYscUat/tkHFAOEz5T5n8ZeQRmBCFh
 OcAnun6/IFChkNow0fGPu+MBM2ie9wtEi2ocYYJ7fHEl5E1X9lCEUJqMf95ubG/2vA/l
 HYqO4G8q4jANhOyS+g+psO/1aR4xlHR8xC2DcRzXvKTveaMKdqBuhXFLaUA2xh+9pZSq
 mLOg==
X-Gm-Message-State: AOJu0YwHlHHcxutKAMpTh77Qtk1UvZCR9cB2cCm2VBMm2RxXB2Yj4ggd
 6GS4rde/UZa37l0FvDmD6zF4cQ==
X-Google-Smtp-Source: AGHT+IEzDl+c4HRd4LnXKLt9i9kDCg/30jfmuhHbjlMMVOZ1JR7c0FwlqyGrzGHizneqgl6/x5cafQ==
X-Received: by 2002:a17:906:220b:b0:a00:ab1a:c81 with SMTP id
 s11-20020a170906220b00b00a00ab1a0c81mr892344ejs.22.1702546148057; 
 Thu, 14 Dec 2023 01:29:08 -0800 (PST)
Received: from [192.168.199.175] ([93.23.249.68])
 by smtp.gmail.com with ESMTPSA id
 qo14-20020a170907874e00b00a1f6737be65sm8831209ejc.82.2023.12.14.01.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 01:29:07 -0800 (PST)
Message-ID: <9443821d-5eff-46e6-be69-707cca9cd0d0@linaro.org>
Date: Thu, 14 Dec 2023 10:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vl: Print display options for -display help
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
References: <20231214-help-v1-1-23823ac5a023@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231214-help-v1-1-23823ac5a023@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Hi Akihiko,

On 14/12/23 07:47, Akihiko Odaki wrote:
> -display lists display backends, but does not tell their options.
> Use the help messages from qemu-options.def, which include the list of
> options.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/ui/console.h |  1 -
>   system/vl.c          | 11 ++++++-----
>   ui/console.c         | 20 --------------------
>   3 files changed, 6 insertions(+), 26 deletions(-)


> diff --git a/ui/console.c b/ui/console.c
> index 7db921e3b7d6..6aee5e9a7ffb 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1691,23 +1691,3 @@ const char *qemu_display_get_vc(DisplayOptions *opts)
>       }
>       return vc;
>   }
> -
> -void qemu_display_help(void)
> -{
> -    int idx;
> -
> -    printf("Available display backend types:\n");
> -    printf("none\n");
> -    for (idx = DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
> -        if (!dpys[idx]) {
> -            Error *local_err = NULL;
> -            int rv = ui_module_load(DisplayType_str(idx), &local_err);
> -            if (rv < 0) {
> -                error_report_err(local_err);
> -            }
> -        }
> -        if (dpys[idx]) {
> -            printf("%s\n",  DisplayType_str(dpys[idx]->type));

Is the "qapi/qapi-commands-ui.h" header still necessary?

> -        }
> -    }
> -}

So we go from:

$ ./qemu-system-aarch64 -display help
Available display backend types:
none
gtk
sdl
curses
cocoa
dbus

to:

$ ./qemu-system-aarch64 -display help
-display sdl[,gl=on|core|es|off][,grab-mod=<mod>][,show-cursor=on|off]
             [,window-close=on|off]
-display gtk[,full-screen=on|off][,gl=on|off][,grab-on-hover=on|off]
             [,show-tabs=on|off][,show-cursor=on|off][,window-close=on|off]
             [,show-menubar=on|off]
-display vnc=<display>[,<optargs>]
-display curses[,charset=<encoding>]
-display cocoa[,full-grab=on|off][,swap-opt-cmd=on|off]
-display dbus[,addr=<dbusaddr>]
              [,gl=on|core|es|off][,rendernode=<file>]
-display cocoa[,show-cursor=on|off][,left-command-key=on|off]
-display none
                 select display backend type
                 The default display is equivalent to
                 "-display gtk"

The latter is indeed more helpful.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


