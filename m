Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7824C79178B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:48:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8za-0004LB-SJ; Mon, 04 Sep 2023 08:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qd8zW-0004E9-Ve
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:47:43 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qd8zU-0005uy-C6
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:47:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso5067165ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693831658; x=1694436458;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jRuxEtyHzFFQHe/1AevhiBwG9/mjKjOTFo3lfGHrDRE=;
 b=GFkHS1JowEEBvq7MerEyptdsNitIePZRfU+2Odi8fPF87L7X3UxNfTdUG3PYQHGvDq
 t/ZB/uAvUableuNz3b/bSEsqHVhCERPHZ+oCub3H5wuApPDYiFNLxOLP4f1fBAlAHTin
 vbRlcZhGZf013pGXDcHE1026g20fKFQtuyrk92y117CHfhiF8TMp9GNgQkb12NQiStRm
 M+Y3zvzf5y1A2ltbRgw4NgC5DMfJC2LzOF8LpG5hkl9+5x6+Dlc3qoaoDI1OERopBQKv
 o74S74Jz2RDsSw0PS/eKmXLlpu9pCj+EJbRFbM8RY7FqOulQGS/DMKYYTHQ8oQyYsoKI
 ngrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831658; x=1694436458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jRuxEtyHzFFQHe/1AevhiBwG9/mjKjOTFo3lfGHrDRE=;
 b=fOhPn/y1HcXABDlS2ScINZN6q689Xg5Iv7RUGoTPSbBDjmFXSQwtfBmwZwIi3MXTrw
 29w0i3QjO1rupKGH6MOGtK8fHNWE6IGwwIEu4jp1i8MgvM9pLGXuGnbKvbvlSxGB+IdL
 0odQYP/paFSvgGc5RFsYQQrJQfzhakDKXOveNc4JmOGL9aeaI1P8+nVWgmPTFwIjslj5
 l7YzsZnLGDV0S/RSemxZIen3woRxmuLEOYCmCJlMHM2j4zDZP4wAJx1y624u/JI4FRQQ
 ehNHfbAsKnCH8GQ0/oYzI2I9E67DbhWZQxcgF9u6t9hWserPx4yuQrUm/hzi5hzhPSas
 5ujw==
X-Gm-Message-State: AOJu0Yytc/pO9sMx+lSiqMfn8uUosNHad8ZvTVjDEwnDwwtbHt3tXXMR
 rkaDvh7BcbYwqrSSo8SOvu0ACQ==
X-Google-Smtp-Source: AGHT+IE5m19IgSBe9qH2ApBznXWaZyaFO75aIq70d9Cg64YY9dVDRC26aQ6YnftBUB3uOf1wqj/fTQ==
X-Received: by 2002:a17:902:f807:b0:1b8:78e:7c1 with SMTP id
 ix7-20020a170902f80700b001b8078e07c1mr8064337plb.51.1693831658634; 
 Mon, 04 Sep 2023 05:47:38 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 4-20020a170902e9c400b001b86dd825e7sm7534881plk.108.2023.09.04.05.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 05:47:38 -0700 (PDT)
Message-ID: <6a702e51-8372-45ba-81dc-aa2e426863ce@daynix.com>
Date: Mon, 4 Sep 2023 21:47:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/67] ui/vc: remove kby_put_keysym() and update function
 calls
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-46-marcandre.lureau@redhat.com>
 <96a49f28-d92c-4910-9f24-b031212ccfc2@daynix.com>
 <CAJ+F1CLCeOgjpS9Wm-V7xNg9QcP8TFcWz86_f9uxsLFpRREQsw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAJ+F1CLCeOgjpS9Wm-V7xNg9QcP8TFcWz86_f9uxsLFpRREQsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/09/04 21:42, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Aug 31, 2023 at 12:59 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/08/30 18:38, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> The function calls to `kbd_put_keysym` have been updated to now call
>>> `kbd_put_keysym_console` with a NULL console parameter.
>>>
>>> Like most console functions, NULL argument is now for the active console.
>>>
>>> This will allow to rename the text console functions in a consistent manner.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    include/ui/console.h |  1 -
>>>    ui/console.c         | 14 ++++++------
>>>    ui/curses.c          |  2 +-
>>>    ui/vnc.c             | 54 ++++++++++++++++++++++----------------------
>>>    ui/cocoa.m           |  2 +-
>>>    5 files changed, 36 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/include/ui/console.h b/include/ui/console.h
>>> index 1ccd432b4d..9c362f0e87 100644
>>> --- a/include/ui/console.h
>>> +++ b/include/ui/console.h
>>> @@ -115,7 +115,6 @@ bool qemu_mouse_set(int index, Error **errp);
>>>    void kbd_put_keysym_console(QemuTextConsole *s, int keysym);
>>>    bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl);
>>>    void kbd_put_string_console(QemuTextConsole *s, const char *str, int len);
>>> -void kbd_put_keysym(int keysym);
>>>
>>>    /* Touch devices */
>>>    typedef struct touch_slot {
>>> diff --git a/ui/console.c b/ui/console.c
>>> index a98adbb1b2..6068e02928 100644
>>> --- a/ui/console.c
>>> +++ b/ui/console.c
>>> @@ -1141,6 +1141,13 @@ void kbd_put_keysym_console(QemuTextConsole *s, int keysym)
>>>        int c;
>>>        uint32_t num_free;
>>>
>>> +    if (!s) {
>>> +        if (!QEMU_IS_TEXT_CONSOLE(active_console)) {
>>> +            return;
>>> +        }
>>> +        s = QEMU_TEXT_CONSOLE(active_console);
>>> +    }
>>> +
>>>        switch(keysym) {
>>>        case QEMU_KEY_CTRL_UP:
>>>            console_scroll(s, -1);
>>> @@ -1231,13 +1238,6 @@ void kbd_put_string_console(QemuTextConsole *s, const char *str, int len)
>>>        }
>>>    }
>>>
>>> -void kbd_put_keysym(int keysym)
>>> -{
>>> -    if (QEMU_IS_TEXT_CONSOLE(active_console)) {
>>> -        kbd_put_keysym_console(QEMU_TEXT_CONSOLE(active_console), keysym);
>>> -    }
>>> -}
>>> -
>>>    static void text_console_invalidate(void *opaque)
>>>    {
>>>        QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
>>> diff --git a/ui/curses.c b/ui/curses.c
>>> index de962faa7c..4ddbbae7cd 100644
>>> --- a/ui/curses.c
>>> +++ b/ui/curses.c
>>> @@ -400,7 +400,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
>>>                if (keysym == -1)
>>>                    keysym = chr;
>>>
>>> -            kbd_put_keysym(keysym);
>>> +            kbd_put_keysym_console(NULL, keysym);
>>>            }
>>>        }
>>>    }
>>> diff --git a/ui/vnc.c b/ui/vnc.c
>>> index 92964dcc0c..1fa4456744 100644
>>> --- a/ui/vnc.c
>>> +++ b/ui/vnc.c
>>> @@ -1945,88 +1945,88 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
>>>                case 0xb8:                          /* Right ALT */
>>>                    break;
>>>                case 0xc8:
>>> -                kbd_put_keysym(QEMU_KEY_UP);
>>> +                kbd_put_keysym_console(NULL, QEMU_KEY_UP);
>>
>> vs->vd->dcl.con should be used instead. There may be VNC connections for
>> consoles other than the "active console" and in such a case
>> vs->vd->dcl.con != NULL. Unfortunately it seems that ui/vnc is very
>> buggy in such a situation.
>>
> 
> That's not how the console & VNC server code works. VNC server will
> send the key event to the hw anyway. But if the active_console is
> text/vc, then it also sends (some) of the key events to it. There is
> no "per-client" console either, the console switch is global
> (console_select()).

Actually vnc is capable of binding a VNC server instance to a particular 
console instead of active console controlled by global console_select() 
switch since commit 1d0d59fe29 ("vnc: allow binding servers to qemu 
consoles").

> 
> Anyway, this patch is quite systematic. Further complicated changes
> should be done later. please ack/r-b

I see.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> 
> thanks
> 
> 
> 

