Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA735737F15
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:40:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuIw-0000ad-8Y; Wed, 21 Jun 2023 05:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBuIt-0000aU-Pn
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:39:07 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBuIr-0007Qv-Tr
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:39:07 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-510d6b939bfso7761812a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687340343; x=1689932343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A0j0QeWxQtcEmo1FFeDXI8fuNrsZyHNZjxiBBP6LCkY=;
 b=sV3Ot9TaIZ9KKoR3RzVwL0P/jz+mKnU2OH2wsIpdL5aQoJijlEvfMKpoM8TPrVQiee
 j1AB+/jSt9YRrPIehQ8P8An5DM/M/KvQOqpm1OaR+1acfeKgGznEzfS01wDwaXM1MqvG
 yY3vpvVALYJSoY6UCqZS38lCy+ITwTPe+MoNTP9c9ZC4F07bFJzts62QXB3d7/Es3Vug
 Evfk81gzG4Ewncotp5gIrsp8gso8qRDtvkBIolv9JfNNopIlni94IysNX8SdmeCO37VV
 YPAw73N6MFJj+VBuE6BIDRhio10vdDWqGiJ+zPsM24glivwnP28rNLqMhIanqi5UinKZ
 3c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687340343; x=1689932343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A0j0QeWxQtcEmo1FFeDXI8fuNrsZyHNZjxiBBP6LCkY=;
 b=XHKKk6eixZiAhWlXZ67YoDrkg2bitfxRXlE3oQY3u3F6r8+uk6tV82mcpiPx5qyKsG
 54josDcARK6D2TKteeSB5PMioHGdEba1yU3fgmumJo1Idat5VzJR6/dsfav/mGkL/+pY
 r1nD6elhXlpzYQ5/sg/cO5I4kreifWGAnQQv2HxvWkP4XVjxVVK9ioT/YT+y0o/52rW2
 2QbS3IcWBAWxiNyZ/+Ev2d65MmeFdVCMRlfaUUjoNGtWxXdXx4QTlu3RYy0xkyxyZB58
 Bg1cczBBqlY4SjlhJ+yo45pCgyLrhvupf8IM6KS4bPlp28QRFuyVHHWuoCO+t0jw918o
 bKWQ==
X-Gm-Message-State: AC+VfDxi6NzAzrVmY5Tgt6yEJGLUlgdfT+5FuzQCOHH8hd0v3yWRCudR
 BZFfeHOtRF8EguCWTmo1HmdmXqNWiDetiylTMko=
X-Google-Smtp-Source: ACHHUZ7fdgIMmz7hsFz2OS2hmM2gGGsS7sXY13SwAM7cKDR3TN5EdZ+hUTef+7X8PpmMpKJzYIcWOw==
X-Received: by 2002:a17:907:9718:b0:977:d48f:97ad with SMTP id
 jg24-20020a170907971800b00977d48f97admr16546688ejc.75.1687340343494; 
 Wed, 21 Jun 2023 02:39:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a170906594200b00977cad140a8sm2844715ejr.218.2023.06.21.02.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 02:39:03 -0700 (PDT)
Message-ID: <97cace68-b1d3-73f7-fa69-266ea0f36229@linaro.org>
Date: Wed, 21 Jun 2023 11:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "cputlb: Restrict SavedIOTLB to system emulation"
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20230620175712.1331625-1-peter.maydell@linaro.org>
 <5b2bf86d-44fa-35ae-8049-b395d715adcb@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <5b2bf86d-44fa-35ae-8049-b395d715adcb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 21/6/23 07:19, Richard Henderson wrote:
> On 6/20/23 19:57, Peter Maydell wrote:
>> This reverts commit d7ee93e24359703debf4137f4cc632563aa4e8d1.
>>
>> That commit tries to make a field in the CPUState struct not be
>> present when CONFIG_USER_ONLY is set.  Unfortunately, you can't
>> conditionally omit fields in structs like this based on ifdefs that
>> are set per-target.  If you try it, then code in files compiled
>> per-target (where CONFIG_USER_ONLY is or can be set) will disagree
>> about the struct layout with files that are compiled once-only (where
>> this kind of ifdef is never set).

Oops, sorry.

>> This manifests specifically in 'make check-tcg' failing, because code
>> in cpus-common.c that sets up the CPUState::cpu_index field puts it
>> at a different offset from the code in plugins/core.c in
>> qemu_plugin_vcpu_init_hook() which reads the cpu_index field.  The
>> latter then hits an assert because from its point of view every
>> thread has a 0 cpu_index. There might be other weird behaviour too.

Why isn't this covered by CI, and where could we add a such check?

>> Mostly we catch this kind of bug because the CONFIG_whatever is
>> listed in include/exec/poison.h and so the reference to it in
>> build-once source files will then cause a compiler error.
>> Unfortunately CONFIG_USER_ONLY is an exception to that: we have some
>> places where we use it in "safe" ways in headers that will be seen by
>> once-only source files (e.g.  ifdeffing out function prototypes) and
>> it would be a lot of refactoring to be able to get to a position
>> where we could poison it.  This leaves us in a "you have to be
>> careful to walk around the bear trap" situation...
>>
>> Fixes: d7ee93e243597 ("cputlb: Restrict SavedIOTLB to system emulation")
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   include/hw/core/cpu.h | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Ho hum, thanks.  I'll apply this directly.

Thanks both.


