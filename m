Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8DF7A5C8E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiW7H-0005yv-2T; Tue, 19 Sep 2023 04:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qiW7F-0005xs-Nd
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:29:53 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qiW78-0002we-T3
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:29:52 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b962535808so85818711fa.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695112185; x=1695716985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qDL+liQ3QeFZaTTmMVv3KTxwC9/C/AGZC/nYSnEDiyc=;
 b=e/imZOPa188gMGhxmTunLNNjRZh4WuImYFNkxzh43A7/gJ2V/99dkT7gJA8OfpxqTq
 2hYxebUGj4kdeO3moButsBXEVFAd6Kw07P9bMSFEttZe9Vty9jAW5Kth17i3k03ySnag
 GTJMnaHqu3V6PZ34e8kURwyE3XGDrPGWjIttER9NA8MG/HZ3GKOH+Ue19HZMOgJxBNaq
 Ri4yQcTI3UDLQFFhibfl63n0lQT5dQadtdAtlBZXntWh2jmCEp/0MAdn1JI6x1Yaz3vN
 xsLREQeS9vPONB/M1Wm3pGJ6tuoXKL3DTObKzrQFY5x57D13DLg1ooJjFaUkB0/kosg3
 dynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695112185; x=1695716985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qDL+liQ3QeFZaTTmMVv3KTxwC9/C/AGZC/nYSnEDiyc=;
 b=hWEY2/2Wt1up/0Xy1ktOKmxpwToLu6/m9vD9KkERKURg1xNP95M3QouAKk4VDsPWuA
 WDvK/kCEI8G2x/UsCaFCsbHxSBdC8c/ORjUmF9z3hz/nhVrFWsLseW1m9kIQGchp7O60
 ZsDTCvPDEqwrjffJDzKkJkdcX35iOloXjd+vkp7X8PfKRIqTddmKCdMnzuc2z3y0B4J+
 cVnYAjmwh4T5NlHZDzff3GHeY4Ltb60YOGGVBzTV7iUgdBlglkPy4o4zIYSS0ALZVr4q
 40+YV70URyxmUhFb3Gb8AntcaRQfjhMK2o9/TWVqDSD9Efpz9Pef1/jlVly2MhAeOhvX
 EZlw==
X-Gm-Message-State: AOJu0YxFjKLEr4YOVDY4QkHwTWVcRSVUtqxlq0jj/deUftfFHpYT3MQ0
 o1BJ93rpVFiLXAveFPU/8Ly5CQ==
X-Google-Smtp-Source: AGHT+IFu3Br71mwn65MfBLhw23QjNh+3wTCJa+zfHnYS/5yMvLXY1QKuL7u7Z4pdBMtxF+Pe1f0HYA==
X-Received: by 2002:a2e:868a:0:b0:2bc:c830:4cbb with SMTP id
 l10-20020a2e868a000000b002bcc8304cbbmr9248131lji.45.1695112184724; 
 Tue, 19 Sep 2023 01:29:44 -0700 (PDT)
Received: from [172.20.66.192] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 oq8-20020a170906cc8800b0099bc08862b6sm7645532ejb.171.2023.09.19.01.29.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 01:29:44 -0700 (PDT)
Message-ID: <27e2b697-55be-af45-d350-01a85866249f@linaro.org>
Date: Tue, 19 Sep 2023 10:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 00/10] linux-user: Detect and report host crashes
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
 <d2e3266e-dbb8-07a6-07d7-008e788c3862@linaro.org>
 <329a2c4b-9fa9-5e73-aa95-57512d60c1ec@gmx.de>
 <36562fcb-77f2-2a18-acec-47f155decf71@tls.msk.ru>
 <51b980aa-1a80-7565-44d6-8dcba3ead422@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <51b980aa-1a80-7565-44d6-8dcba3ead422@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/18/23 16:05, Helge Deller wrote:
> On 9/12/23 12:34, Michael Tokarev wrote:
>> 12.09.2023 12:45, Helge Deller:
>>
>>> /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/13/../../../../lib64/libc.a(abort.o): in 
>>> function `abort':
>>> (.text.unlikely+0x0): multiple definition of `abort'; 
>>> libqemu-aarch64-linux-user.fa.p/linux-user_signal.c.o:/srv/_build/../../home/cvs/qemu/qemu/linux-user/signal.c:723: first defined here
>>
>> [PATCH v4 03/10] linux-user: Use die_with_signal with abort
>>
>> Sigh.
>>
>> I'd be double-cautious when overriding system functions like this, - it's
>> almost always a bad idea.
> 
> Richard, I'm not sure, but with that change:
> 
> -void abort(void)
> +void  __attribute__((weak)) abort(void)
> 
> it will at least successfully link the binary. Not sure which effects it has,
> but probably not worse than before your patch series...

This won't work, in that it will have no effect, and we continue to have the weird longjmp 
assertion message after stack corruption.

Probably we will have to replace all of the apis that can raise abort at the source level, 
e.g.

void qemu_abort(void) __attribute__((noreturn));
void qemu_abort_msg(const char *) __attribute__((noreturn));

#undef  abort
#define abort       qemu_abort
#undef  assert
#define assert(X)   ...
#undef  g_assert
#define g_assert(X) assert(X)

etc.


r~

