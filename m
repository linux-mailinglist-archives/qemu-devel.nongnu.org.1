Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B83E814717
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:37:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6UR-0003g9-Cz; Fri, 15 Dec 2023 06:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6UP-0003fw-I5
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:36:21 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6UN-0004Hc-Hg
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:36:21 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d331f12f45so1494845ad.2
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702640178; x=1703244978;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uzfTls9G4DkUMvo2Bd4fs1I3pyIRazCBv0I1jH4KEyI=;
 b=DCwylS4C35SBM8EzlHNoc1gv+/8EKspKAUG+JXh/kuKIA5NGVfQMMAH6VKVWUqOJ9/
 VkkyFJfe0gITsWcmlYr7RLulugmJR4fqHXx92C07A6RaGqPZaiiYxADTQju9RyRp4nNx
 YNH1lvillac60Sn9aJDPKgYCmRKg/9bkIKXaJal2AdTOlnd85OrfitvRPueIuxtfuvgm
 M99HxeindwrSS5m/Q/fZ5NgGtlK00QYc5t7l/OKrwtAlY8CDPv3UI9Tga97/9+K2IzZ5
 k0gnSlqxwVAesiCXFVgil2x8k9MFmKNucgoAcYSw08JfxUFHYXZ0SzQ1e77qZ4S/xYSf
 LXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702640178; x=1703244978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uzfTls9G4DkUMvo2Bd4fs1I3pyIRazCBv0I1jH4KEyI=;
 b=hLiae7CMIDhM+T4B00D9fG0BRD632doqAyxcJKxg1L+i1fqYB5iknUvW0R6Y1k7JKh
 UoDZb+Ava5EoMAXNWu57O8FDfmRzgjrgGj3reD9CaXZKOfKpfG2f0Ycv86/nRw8CCEF9
 b2cLKZELI+ZfiFMgXk0yWoaiOIOf/DXqWDobk/V+jnsWc+vXjF1YZj0sfDo5WqlGnHmJ
 F41P70Nt5tA8DS7mI2+RxL2jc0f1PLOSWiRjUTc5LBd60PVJZQ2IKyHy+rAYffsGgbLq
 hI3Ja/B1i2AHXRvA/R+hu4jT4J2k5lcwlDrVJE2n/8VRDEegRzmKW94V+f0vyJ0mQSwK
 Cedg==
X-Gm-Message-State: AOJu0YyYSxZDpsY0EO5fLBWj+zzx1oT19dj8LyAKXgZjybJyGA+93JsJ
 jstIbJGE7h9lNB/ub1EDhgKigw==
X-Google-Smtp-Source: AGHT+IEg8WhtgT76vwNrSNKhBnE0yqWtmIyo3OK7aOYa2TNJk8kkQai9XyHjJ3+vqPJr3ORzCQNH4g==
X-Received: by 2002:a17:902:a58b:b0:1d0:8d57:482 with SMTP id
 az11-20020a170902a58b00b001d08d570482mr5932080plb.50.1702640177971; 
 Fri, 15 Dec 2023 03:36:17 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a170902a70d00b001c726147a46sm14010791plq.234.2023.12.15.03.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:36:17 -0800 (PST)
Message-ID: <2d1689ea-b0d8-4c74-8101-b90ad626f2a9@daynix.com>
Date: Fri, 15 Dec 2023 20:36:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vl: Print display options for -display help
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231214-help-v1-1-23823ac5a023@daynix.com>
 <9443821d-5eff-46e6-be69-707cca9cd0d0@linaro.org>
 <8f8d3317-c28b-3985-89d7-0fbd1ce4b56e@eik.bme.hu>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8f8d3317-c28b-3985-89d7-0fbd1ce4b56e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/14 22:00, BALATON Zoltan wrote:
> On Thu, 14 Dec 2023, Philippe Mathieu-Daudé wrote:
>> Hi Akihiko,
>>
>> On 14/12/23 07:47, Akihiko Odaki wrote:
>>> -display lists display backends, but does not tell their options.
>>> Use the help messages from qemu-options.def, which include the list of
>>> options.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   include/ui/console.h |  1 -
>>>   system/vl.c          | 11 ++++++-----
>>>   ui/console.c         | 20 --------------------
>>>   3 files changed, 6 insertions(+), 26 deletions(-)
>>
>>
>>> diff --git a/ui/console.c b/ui/console.c
>>> index 7db921e3b7d6..6aee5e9a7ffb 100644
>>> --- a/ui/console.c
>>> +++ b/ui/console.c
>>> @@ -1691,23 +1691,3 @@ const char *qemu_display_get_vc(DisplayOptions 
>>> *opts)
>>>       }
>>>       return vc;
>>>   }
>>> -
>>> -void qemu_display_help(void)
>>> -{
>>> -    int idx;
>>> -
>>> -    printf("Available display backend types:\n");
>>> -    printf("none\n");
>>> -    for (idx = DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
>>> -        if (!dpys[idx]) {
>>> -            Error *local_err = NULL;
>>> -            int rv = ui_module_load(DisplayType_str(idx), &local_err);
>>> -            if (rv < 0) {
>>> -                error_report_err(local_err);
>>> -            }
>>> -        }
>>> -        if (dpys[idx]) {
>>> -            printf("%s\n",  DisplayType_str(dpys[idx]->type));
>>
>> Is the "qapi/qapi-commands-ui.h" header still necessary?
>>
>>> -        }
>>> -    }
>>> -}
>>
>> So we go from:
>>
>> $ ./qemu-system-aarch64 -display help
>> Available display backend types:
>> none
>> gtk
>> sdl
>> curses
>> cocoa
>> dbus
>>
>> to:
>>
>> $ ./qemu-system-aarch64 -display help
>> -display sdl[,gl=on|core|es|off][,grab-mod=<mod>][,show-cursor=on|off]
>>            [,window-close=on|off]
>> -display gtk[,full-screen=on|off][,gl=on|off][,grab-on-hover=on|off]
>>            [,show-tabs=on|off][,show-cursor=on|off][,window-close=on|off]
>>            [,show-menubar=on|off]
>> -display vnc=<display>[,<optargs>]
>> -display curses[,charset=<encoding>]
>> -display cocoa[,full-grab=on|off][,swap-opt-cmd=on|off]
>> -display dbus[,addr=<dbusaddr>]
>>             [,gl=on|core|es|off][,rendernode=<file>]
>> -display cocoa[,show-cursor=on|off][,left-command-key=on|off]
>> -display none
>>                select display backend type
>>                The default display is equivalent to
>>                "-display gtk"
>>
>> The latter is indeed more helpful.
> 
> It is more helpful but maybe a bit overwhelming. Would it be possible to 
> only print the options with -display cocoa,help similar to how -device 
> help lists devices and -device sm501,help lists options for one device? 
> Adding info about default to -display help is really helpful though 
> (that could also be marked with (default) like in -machine help.

It's copied from what qemu-system-aarch64 -h outputs. At least it's less 
overwhelming than qemu-system-aarch64 -h.

> 
> I'm not complaining, thanks for taking care of this so quickly but if 
> it's not too difficult to add separate -display cocoa,help and not list 
> options in -display help maybe that would be better and more consistent 
> with other help options.

Yes, that will require some major refactoring so I'm not going to do 
that for now.

