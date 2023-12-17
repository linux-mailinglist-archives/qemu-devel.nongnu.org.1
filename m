Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C029D815DC7
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 07:40:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEknq-00006f-JV; Sun, 17 Dec 2023 01:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEknp-00006D-7h
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:39:05 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEknn-0007E1-9x
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:39:04 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d6d48354ccso1684b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 22:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702795141; x=1703399941;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0vxGw3rXw36x5NlIc+T8jtNHfvkNgPAmfhWUwI0b7ks=;
 b=zYRhHYLeOZuJVcK9zWYKhrQGiZ29Jp4TZzsd85lmSKngyCjrPHJeXgY4IevK+OdF0L
 mGekXxKGUZkoLS2FSTLQEez8+7VcFBMHw3J/y5ELUTA1NQaGkkTyg9U+v7YLp6I3EMHH
 5hpOVdYTcIQXQcedAcvTcBXSCECMvAaLiVGV+hGJoA4BRGV6PJQaIu6nNtkN4cE3N9Xw
 WL83oSU7pIsw7VpmSRzgIXI6BC2ximokQDH19b8Gi8Q5a4hkharstmddt8ijDdaV7B2q
 Kn9czbNxIISPaGIxcB21kTOJtDdlo8NyGR21BnpPGOC9UvR2pcuJc1Xg7WTOFOzaerPV
 kbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702795141; x=1703399941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0vxGw3rXw36x5NlIc+T8jtNHfvkNgPAmfhWUwI0b7ks=;
 b=aGetAQyiQwFKURrEv/QP/ynW/M0zWvOmsHpP4Ulhsnn6LIfId0eSndzOMt7FCf7fZ2
 VkAlUbITixEb30am7HxexZM9DPT5vIxl2bC3bObpLjhKQBP8JBi01BCGF7sFvx1xTV0t
 XCurPRkRsFt0spXHaiCKJEwMNc1KKxQrYc5f8gmH1H+vhIt9GhzaHv+l/EHVpnJbfv+Z
 /Djn48GByZj/2WFqaSgPtK64C/iu/cb0yx98yjaoZ2Qnu+EzGxNwPalEe06u4caapOsh
 t5HmbAraeXc7GEgjfiLB2gjq1aMYr8xgrhVttv91rdo77PU36u+Gr6F+KX3GS6k2e6XJ
 cm3w==
X-Gm-Message-State: AOJu0YyIi4aApasZvq+qbXtV1GZUwnM4wx0T3wQwqjtFYQeRv1g4Ey2A
 CJr5B87RcrCPDIeg4MK7sZoTQw==
X-Google-Smtp-Source: AGHT+IFDLjN9jddEcenvOvFmC3eoBVlqBBFtxWFZd4BMOV328+KiJgeQkBPQ66MnFRUXG5bQxqfZdg==
X-Received: by 2002:a17:902:7787:b0:1d0:c986:8ac9 with SMTP id
 o7-20020a170902778700b001d0c9868ac9mr6525353pll.22.1702795141478; 
 Sat, 16 Dec 2023 22:39:01 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a17090322d000b001d09c5424d4sm16695577plg.297.2023.12.16.22.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 22:39:01 -0800 (PST)
Message-ID: <c196096c-171f-40de-8ab5-22fc89fe2856@daynix.com>
Date: Sun, 17 Dec 2023 15:38:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vl: Print display options for -display help
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231214-help-v1-1-23823ac5a023@daynix.com>
 <9443821d-5eff-46e6-be69-707cca9cd0d0@linaro.org>
 <8f8d3317-c28b-3985-89d7-0fbd1ce4b56e@eik.bme.hu>
 <2d1689ea-b0d8-4c74-8101-b90ad626f2a9@daynix.com>
 <d1687e5a-a60e-fda8-5e8c-1ab9adf0e775@eik.bme.hu>
 <ZXxMow-5UGOSgWo1@redhat.com>
 <73d44b18-51e9-23b5-2013-d1cd21b083e7@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <73d44b18-51e9-23b5-2013-d1cd21b083e7@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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

On 2023/12/15 22:07, BALATON Zoltan wrote:
> On Fri, 15 Dec 2023, Daniel P. Berrangé wrote:
>> On Fri, Dec 15, 2023 at 01:43:37PM +0100, BALATON Zoltan wrote:
>>> On Fri, 15 Dec 2023, Akihiko Odaki wrote:
>>>> On 2023/12/14 22:00, BALATON Zoltan wrote:
>>>>>> So we go from:
>>>>>>
>>>>>> $ ./qemu-system-aarch64 -display help
>>>>>> Available display backend types:
>>>>>> none
>>>>>> gtk
>>>>>> sdl
>>>>>> curses
>>>>>> cocoa
>>>>>> dbus
>>>>>>
>>>>>> to:
>>>>>>
>>>>>> $ ./qemu-system-aarch64 -display help
>>>>>> -display 
>>>>>> sdl[,gl=on|core|es|off][,grab-mod=<mod>][,show-cursor=on|off]
>>>>>>            [,window-close=on|off]
>>>>>> -display gtk[,full-screen=on|off][,gl=on|off][,grab-on-hover=on|off]
>>>>>>            
>>>>>> [,show-tabs=on|off][,show-cursor=on|off][,window-close=on|off]
>>>>>>            [,show-menubar=on|off]
>>>>>> -display vnc=<display>[,<optargs>]
>>>>>> -display curses[,charset=<encoding>]
>>>>>> -display cocoa[,full-grab=on|off][,swap-opt-cmd=on|off]
>>>>>> -display dbus[,addr=<dbusaddr>]
>>>>>>             [,gl=on|core|es|off][,rendernode=<file>]
>>>>>> -display cocoa[,show-cursor=on|off][,left-command-key=on|off]
>>>>>> -display none
>>>>>>                select display backend type
>>>>>>                The default display is equivalent to
>>>>>>                "-display gtk"
>>>>>>
>>>>>> The latter is indeed more helpful.
>>>>>
>>>>> It is more helpful but maybe a bit overwhelming. Would it be
>>>>> possible to only print the options with -display cocoa,help similar
>>>>> to how -device help lists devices and -device sm501,help lists
>>>>> options for one device? Adding info about default to -display help
>>>>> is really helpful though (that could also be marked with (default)
>>>>> like in -machine help.
>>>>
>>>> It's copied from what qemu-system-aarch64 -h outputs. At least it's 
>>>> less
>>>> overwhelming than qemu-system-aarch64 -h.
>>>
>>> This changes what -display help does so if some script depends on 
>>> that it
>>> may not be a good idea. Since the same info is already in -help maybe 
>>> this
>>> change to add that to -display help as well is not the best solution 
>>> so I'd
>>> say drop this patch and leave it as it is for now.
>>
>> We consider help output to be only for humans.
>>
>> No scripts should ever be parsing any QEMU output, as we provide
>> QMP for automated detection/querying of features.
>>
>> IOW, if some script is parsing help output we are fine to break
>> them if it improves QEMU's output for humans in a justiable way.
> 
> OK fair enough. I'd still like some more consitency with -cpu help and 
> -machine help and -device help which all list avalable options and then 
> can take help for further help for individual items where applicable. So 
> it would be better if -display and -audio could behave the same. (Are 
> there any other options that might be missing this?)
> 
> Out of curiousicy what's the way to query available display backends for 
> programs by QMP then?

There is no method available as far as I know. All of these quirks are 
caused by the design of the display infrastructure not integrated well 
with QOM.

