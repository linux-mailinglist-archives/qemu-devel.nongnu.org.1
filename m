Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5BA78D72F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:42:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNKS-0003b0-6f; Wed, 30 Aug 2023 11:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbNKQ-0003ah-4W
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:41:58 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbNKN-0003ba-H7
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:41:57 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31ae6bf91a9so4797506f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693410113; x=1694014913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QxfGAdTzhPoM8rqSZw3PBdFh3zDuXtKednbBpy+kykY=;
 b=G2NsmxgUmNSnQTLbS8lP0uPVgMx4EVLo7mOc86VL+TKyoh9ngq9ue1exD/e2iJT5S7
 QecPd8N0UDIB96X+Ndx7nVnrtf7R43d/lb0adJboY6iPeRqL/NsrKGyliv1WYfmF6R1k
 fTgofsaMgrKdCv35Q+iplRmtJpQbiVWB2gSQvh9SW62eLGLMIkz4gSdvNzaQE3IyxBgx
 dV1gMA+ohYz0Fw7QlJSc4qbQ/woJ7lJ3NX+RKzMtI865htlNHznkL/PiNuPR8RFBuvoo
 7YvFBRTTxpYfDMSLcmGtk1usvW9AmOAFLklMX4q0l/cYFuZHy6iPi5/nHI7fRjMlILEO
 Aqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693410113; x=1694014913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QxfGAdTzhPoM8rqSZw3PBdFh3zDuXtKednbBpy+kykY=;
 b=LbmRBT3UpxpwEwZjMGjAZ+Nk1aJj334L/MRtADFgoAPBb1UxZMWtCJGeYmztfwDbuf
 ti5CVgWTLPdLzdlnG64o+kMaFPN1fubgAZMnzsTTpEp5L/z7dsQvaTobi4Xcs62Fog/5
 Skek6liBqLkAuOsKBqkSOrcT6ioQH6QZQ7/WVylywl2QuXtSra3HpYPuYlSxYjnsrSQj
 JIYD1qCsv2NZJ0hOgEVgMRrNl2nBvXTK6WscsH7BzXUJ3DqhadJY7oYHLhuMhT3K/GXB
 YfMP18rtBa51ml+d/ShFTPEZfGbGvyXOsFe5R1LYB8Sq0aI9Qd6L8Zk6s4Sb6jCdqmB8
 84/w==
X-Gm-Message-State: AOJu0YxzFhJbFkTaxIScp7XNWB2DHxZf0Q835EuYfSHsIvxPF5v45mNT
 iLD+24/SJtro9KHJRKCIEMEEKg==
X-Google-Smtp-Source: AGHT+IEDUUDThb98yy18zcDlRanXmQranNJkisBLirL3KaAyEWHx7EtR2yHPfqmIpBscY2L7JstHNQ==
X-Received: by 2002:a5d:4f8f:0:b0:314:36f0:2214 with SMTP id
 d15-20020a5d4f8f000000b0031436f02214mr1806914wru.6.1693410113637; 
 Wed, 30 Aug 2023 08:41:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 y1-20020adff6c1000000b00317e77106dbsm16801854wrp.48.2023.08.30.08.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:41:53 -0700 (PDT)
Message-ID: <67a794e5-4208-b413-c274-03bad36e3c24@linaro.org>
Date: Wed, 30 Aug 2023 17:41:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_46/67=5d_ui/vc=3a_rename_kbd=5fput_?=
 =?UTF-8?Q?=e2=86=92_qemu=5ftext=5fconsole_functions?=
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-47-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-47-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> They are QemuTextConsole functions, let's make it clear.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h |  6 ++---
>   ui/console.c         | 10 ++++----
>   ui/curses.c          |  2 +-
>   ui/gtk.c             |  6 ++---
>   ui/sdl2-input.c      |  4 ++--
>   ui/sdl2.c            |  2 +-
>   ui/vnc.c             | 54 ++++++++++++++++++++++----------------------
>   ui/cocoa.m           |  2 +-
>   8 files changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 9c362f0e87..26d63d17a2 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -112,9 +112,9 @@ bool qemu_mouse_set(int index, Error **errp);
>   #define QEMU_KEY_CTRL_PAGEUP     0xe406
>   #define QEMU_KEY_CTRL_PAGEDOWN   0xe407
>   
> -void kbd_put_keysym_console(QemuTextConsole *s, int keysym);
> -bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl);
> -void kbd_put_string_console(QemuTextConsole *s, const char *str, int len);
> +void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym);
> +bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl);
> +void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len);


> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 9eb4da7713..8b97319587 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -784,7 +784,7 @@ - (void) handleMonitorInput:(NSEvent *)event
>       }
>   
>       if (keysym) {
> -        kbd_put_keysym_console(NULL, keysym);
> +        qemu_text_console_keysym(NULL, keysym);
>       }
>   }
>   

../../ui/cocoa.m:787:9: error: call to undeclared function 
'qemu_text_console_keysym'; ISO C99 and later do not support implicit 
function declarations [-Wimplicit-function-declaration]
         qemu_text_console_keysym(NULL, keysym);
         ^

I can compile using:

-- >8 --
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 8b97319587..b886db7510 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -784,7 +784,7 @@ - (void) handleMonitorInput:(NSEvent *)event
      }

      if (keysym) {
-        qemu_text_console_keysym(NULL, keysym);
+        qemu_text_console_put_keysym(NULL, keysym);
      }
  }

---

