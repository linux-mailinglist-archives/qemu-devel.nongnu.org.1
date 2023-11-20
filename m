Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E97C7F145E
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 14:24:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r54GW-0000jY-MY; Mon, 20 Nov 2023 08:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r54GV-0000j6-3E
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:24:39 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r54GT-0000f6-6a
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:24:38 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3316d09c645so1811128f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 05:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700486675; x=1701091475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AR0LWDdSiuGc77jYCg8UMLWTv5LotfOa7/OQ9nxIszE=;
 b=YomPpXtDvHb20al/syCR3WJgnmgaipm04yD13j91MBJbOvy6Ybq64BIwzw5JIiDP6u
 5RquFziBkc6bGvwinnYQ3qbX8+BG04+n2jvUitTkNr39H1vgB1exHS4C6/KfIzWOFZ2a
 BxlIiIujoHaWp8bU6wzMgsUcZsmrvr+m1FlIn001X3Pm5jdhHBaSCA+ANkvY4Y0EZ9Zg
 VjmcjMuS06kXHV/TA2uPjsLWdHLoQYkpyometiyJrBVfC0y7l97353+2S00AtqsOAZ6s
 QG9GzpNwUWFkuEQszFlNmmm6pahzGVfqcJuMnKOvYLRPHfygFVkuB1cdbU0TQJXcycrJ
 lNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700486675; x=1701091475;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AR0LWDdSiuGc77jYCg8UMLWTv5LotfOa7/OQ9nxIszE=;
 b=XV0xiJKShXax+1J4TBFBC7m0N2H7e4hVEuL2tc8GYWHVx0yHwRRmZ8UplWWxiiWr6q
 u6S8+nxwqfjbliUKwMOoBTlvp4pmNPdqWhda/5/GZla0m0V/JG5EBiqPO+uUx5vFLA+I
 CuS4AubQ/zXdXaEq284f2xyWnJfKg5BqT87fSD+nLQHhCbpjZrGw0ThoepO3ySMV9YgV
 ItqdID99R39ZtRHePao4PPjk9yC4+eDGl3ybQiJo2WjW6I764sKpCbBI8+xRQsMEZ6cT
 1JgJnPusmtfDrQ+mb4qHgA31XGz7hLc8ul3ouGdkOunaHkA5AcnduzaPNMuJT2R8kmXR
 PJSw==
X-Gm-Message-State: AOJu0Yyrpk26iUbGDYkUBlhdCdxTTkIch3bBJpSxPJVArgBtAFktrGmS
 Jp3786yZ0NeJCHynU/tkAdRndD5ya+t+LumNDPU=
X-Google-Smtp-Source: AGHT+IGvaE4CE7qrYrHYSTxt2hfo96XDaIBpYqMhLn0dq5qoLJWu5ZP7s0PPYAPka9QwH8mdHjnGzw==
X-Received: by 2002:a5d:5f92:0:b0:331:72f3:d59f with SMTP id
 dr18-20020a5d5f92000000b0033172f3d59fmr6451549wrb.27.1700486675678; 
 Mon, 20 Nov 2023 05:24:35 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d5909000000b0032f9688ea48sm11231397wrd.10.2023.11.20.05.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 05:24:35 -0800 (PST)
Message-ID: <4f4fb8dc-5a7e-402d-a797-3f24aef178fb@linaro.org>
Date: Mon, 20 Nov 2023 14:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: -Wno-error=format-overflow for ubsan
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20231120112329.4149-1-akihiko.odaki@daynix.com>
 <f9aff170-5ec8-4bfb-a100-3d312baedbef@linaro.org>
In-Reply-To: <f9aff170-5ec8-4bfb-a100-3d312baedbef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 20/11/23 14:16, Philippe Mathieu-Daudé wrote:
> Hi Akihiko,
> 
> On 20/11/23 12:23, Akihiko Odaki wrote:
>> ubsan causes wrong -Wformat-overflow warnings as follows:
>>
>> In file included from /usr/include/stdio.h:906,
>>                   from /home/alarm/q/var/qemu/include/qemu/osdep.h:114,
>>                   from ../disas/cris.c:21:
>> In function 'sprintf',
>>      inlined from 'format_dec' at ../disas/cris.c:1737:3,
>>      inlined from 'print_with_operands' at ../disas/cris.c:2477:12,
>>      inlined from 'print_insn_cris_generic.constprop' at 
>> ../disas/cris.c:2690:8:
>> /usr/include/bits/stdio2.h:30:10: warning: null destination pointer 
>> [-Wformat-overflow=]
>>     30 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
>>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     31 |                                   __glibc_objsize (__s), __fmt,
>>        |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     32 |                                   __va_arg_pack ());
>>        |                                   ~~~~~~~~~~~~~~~~~
>>
>> Don't let these errors stop the build.
> 
> Which compiler/version?
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   meson.build | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/meson.build b/meson.build
>> index d7d841e71e..02f1a18080 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -365,7 +365,9 @@ if get_option('sanitizers')
>>     # Detect static linking issue with ubsan - 
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
>>     if cc.links('int main(int argc, char **argv) { return argc + 1; }',
>>                 args: [qemu_ldflags, '-fsanitize=undefined'])
>> -    qemu_cflags = ['-fsanitize=undefined'] + qemu_cflags
>> +    # 87884 – ubsan causes wrong -Wformat-overflow warning
>> +    # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87884

I posted an alternative less intrusive patch, see:
https://lore.kernel.org/all/20231120132222.82138-1-philmd@linaro.org/

>> +    qemu_cflags = ['-fsanitize=undefined', 
>> '-Wno-error=format-overflow'] + qemu_cflags
>>       qemu_ldflags = ['-fsanitize=undefined'] + qemu_ldflags
>>     endif
>>   endif
> 


