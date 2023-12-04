Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A3E803534
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 14:40:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA9Ad-0003FN-MI; Mon, 04 Dec 2023 08:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rA9Ab-0003Eo-Ho
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 08:39:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rA9AZ-00017F-JP
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 08:39:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c09dfa03cso12705675e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 05:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701697170; x=1702301970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KNiiB/nkc8fPnbYnD22Z2pcXQ0p5rRxtBOk4RbeREGQ=;
 b=Y2/zvb37yKioMOBgtS2Zu7gSI6xWv2Ouuq0r4dKbiCS6Lz804bFrc2TpMht8TBu/CB
 1utA9rQwXzAh2y+fGoNgeuIgsQX/opXJyq0kw3OuAoJa3F0IoZqwKdGI86Axsf9LwQ4/
 m5TuNwn4Z3lZ54TJFDrFZZulqF0cC8fJ9sZ7kV/L268Vc1G4DTkCybLMz9mcAB02F0y4
 fNs3wHAAmPeyG/F6Ahm7qjPa3+mSdrCtpg7qksuEGS+5zCmZ2z0stQOK51E+X3oOqxJu
 59/YNgqpmDhxEucqAX0gD8VZzH7H0T9N/l02vuvwwD36FyuNNceoJSIbicP8xPQeYUe5
 AInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701697170; x=1702301970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KNiiB/nkc8fPnbYnD22Z2pcXQ0p5rRxtBOk4RbeREGQ=;
 b=bcDcT46t+SN2RnbZYMsVguqgCI0bHGmNUS65D3ISsdP2ueiZwuAAMDlimYbIHsVuwJ
 84uIpYaOqMYYe0MegA1pv2STJWWfGZ+m23DvN9FM4sqUKb9SDwN1IY2JHa5C6InTYp5P
 vM65HvS8yprZmEYjKygKBkNWvywFY0zoVog8t0L2nOmCtUlWMHSAkCE8Cw8TWLjBlQZ4
 KyHSKt2vGHLmduvcfGelJIgWZe0RpplZgcJxAOTs3FcwWYHfTNwxzOUTzvcOXDjHO7LR
 3AYGZTDiwNgnWOfvXDDrRYGbmspUPmfUUX5rj4199q/9JL2re1O0v2/kDPIEFY+Sm14+
 gw0A==
X-Gm-Message-State: AOJu0YxtY/NW2PcAfx8yD6HBY4p6fAhuo9k/Hm1sYWXJFFSGi0Z1mp6x
 XjGJDqIKgNZwBVWSrQgrRtiGjw==
X-Google-Smtp-Source: AGHT+IF4S2xXqSirYYjcrosr5hyWpVrAx2Evh6V6y0qOuIx3JQu/XqRqlloBpF7N/48BiadoDJF7hQ==
X-Received: by 2002:a05:600c:3b20:b0:40b:5e21:d33b with SMTP id
 m32-20020a05600c3b2000b0040b5e21d33bmr2753844wms.68.1701697169749; 
 Mon, 04 Dec 2023 05:39:29 -0800 (PST)
Received: from [192.168.69.100] ([176.176.140.35])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a05600c4e8f00b0040b3632e993sm18707878wmq.46.2023.12.04.05.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 05:39:27 -0800 (PST)
Message-ID: <4f149724-37f6-4e7f-95ef-61e3d4f0c3f8@linaro.org>
Date: Mon, 4 Dec 2023 14:39:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user: Fix openat() emulation to not modify atime
Content-Language: en-US
To: Shu-Chun Weng <scw@google.com>, Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, Jonah Petri
 <jonah@petri.us>, Edoardo Spadolini <edoardo.spadolini@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20231201032140.2470599-1-scw@google.com>
 <20231201032140.2470599-3-scw@google.com>
 <63d6f19a-ec9b-4397-bf90-95e89a618838@linaro.org>
 <CAF3nBxjGBtGnKr3m9soohGDPB9z+C7SkJt00FQOucYQNQUqCxw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAF3nBxjGBtGnKr3m9soohGDPB9z+C7SkJt00FQOucYQNQUqCxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Laurent, Helge, Richard,

On 1/12/23 19:51, Shu-Chun Weng wrote:
> On Fri, Dec 1, 2023 at 4:42 AM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     Hi Shu-Chun,
> 
>     On 1/12/23 04:21, Shu-Chun Weng wrote:
>      > Commit b8002058 strengthened openat()'s /proc detection by calling
>      > realpath(3) on the given path, which allows various paths and
>     symlinks
>      > that points to the /proc file system to be intercepted correctly.
>      >
>      > Using realpath(3), though, has a side effect that it reads the
>     symlinks
>      > along the way, and thus changes their atime. The results in the
>      > following code snippet already get ~now instead of the real atime:
>      >
>      >    int fd = open("/path/to/a/symlink", O_PATH | O_NOFOLLOW);
>      >    struct stat st;
>      >    fstat(fd, st);
>      >    return st.st_atime;
>      >
>      > This change opens a path that doesn't appear to be part of /proc
>      > directly and checks the destination of /proc/self/fd/n to
>     determine if
>      > it actually refers to a file in /proc.
>      >
>      > Neither this nor the existing code works with symlinks or
>     indirect paths
>      > (e.g.  /tmp/../proc/self/exe) that points to /proc/self/exe
>     because it
>      > is itself a symlink, and both realpath(3) and /proc/self/fd/n will
>      > resolve into the location of QEMU.
> 
>     Does this fix any of the following issues?
>     https://gitlab.com/qemu-project/qemu/-/issues/829
>     <https://gitlab.com/qemu-project/qemu/-/issues/829>
> 
> 
> Not this one -- this is purely in the logic of util/path.c, which we do 
> see and carry an internal patch. It's quite a behavior change so we 
> never upstreamed it.
> 
>     https://gitlab.com/qemu-project/qemu/-/issues/927
>     <https://gitlab.com/qemu-project/qemu/-/issues/927>
> 
> 
> No, either. This patch only touches the path handling, not how files are 
> opened.
> 
>     https://gitlab.com/qemu-project/qemu/-/issues/2004
>     <https://gitlab.com/qemu-project/qemu/-/issues/2004>
> 
> 
> Yes! Though I don't have a toolchain for HPPA or any of the 
> architectures intercepting /proc/cpuinfo handy, I hacked the condition 
> and confirmed that on 7.1 and 8.2, test.c as attached in the bug prints 
> out the host cpuinfo while with this patch, it prints out the content 
> generated by `open_cpuinfo()`.
> 
> 
> 
>      > Signed-off-by: Shu-Chun Weng <scw@google.com <mailto:scw@google.com>>
> 
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2004 
> <https://gitlab.com/qemu-project/qemu/-/issues/2004>

Do we need to merge this for 8.2?

> 
>      > ---
>      >   linux-user/syscall.c | 42
>     +++++++++++++++++++++++++++++++++---------
>      >   1 file changed, 33 insertions(+), 9 deletions(-)
> 
> 
> On Fri, Dec 1, 2023 at 9:09 AM Helge Deller <deller@gmx.de 
> <mailto:deller@gmx.de>> wrote:
> 
>     On 12/1/23 04:21, Shu-Chun Weng wrote:
>      > Commit b8002058 strengthened openat()'s /proc detection by calling
>      > realpath(3) on the given path, which allows various paths and
>     symlinks
>      > that points to the /proc file system to be intercepted correctly.
>      >
>      > Using realpath(3), though, has a side effect that it reads the
>     symlinks
>      > along the way, and thus changes their atime.
> 
>     Ah, ok. I didn't thought of that side effect when I came up with the
>     patch.
>     Does the updated atimes trigger some real case issue ?
> 
> 
> We have an internal library shimming the underlying filesystem that uses 
> the `open(O_PATH|O_NOFOLLOW)`+`fstat()` pattern for all file stats. 
> Checking symlink atime is in one of the unittests, though I don't know 
> if production ever uses it.
> 
> 
>     Helge
> 


