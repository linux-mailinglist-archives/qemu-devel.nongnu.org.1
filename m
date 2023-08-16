Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C177E845
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKuY-0006IQ-Lz; Wed, 16 Aug 2023 14:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKuV-0005cY-Pe
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:06:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKuT-00021m-Ey
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:06:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-688779ffcfdso1262210b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209180; x=1692813980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kr6OEGyEUg6tKM5Qya4f+83QCVC2P5dyGu3tCXBUk+M=;
 b=qNMQwzzlw3IpXxAX5aID6ON43iw9Mp08RQiospWLooYQsHPkoNUKETDQ9Lc3it6XU8
 GtkzlsN7FGR2XZgv0kpsZxGRzvrkoWqeruuEUsyc3Pn8YwtkxscPBcf5Ow7R1merJrd+
 xLzsK8l4WAR3ibW3Gm3+d7iclx50//BhTuYkVKsXo9LlUN30iiI8d/XJDlfgaKho0P5W
 91A4K4hrKP8Sdd9p6ogRYp5yQRJJ+cm2+hwS8CdgCGroQWRSjcV1WMcmW4zZuMb4m5A7
 m4SCNeZ9gq9nyC76DY4GOQn0645aD/XLpVyVzB+RiahgHisEAXiLSn7+/VbXOpgzE/dZ
 jshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209180; x=1692813980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kr6OEGyEUg6tKM5Qya4f+83QCVC2P5dyGu3tCXBUk+M=;
 b=X6Pk9Un+YqKGPSXOB5KEBRuXrG1ya6ov42WHSZzqHuy8EkmOWAdjNm238vHO77PBH6
 o8lnMo8sQlZNsbo6gkwOWys2LR9N3h0reiZyRFjy4oyteammNq+FZywItJ7b2yELrF5V
 pVoya5wecu07+ZNq7E1T2UK1+JqYs1g/Wld7v/koqgmt8Zdj5iJZ8xpQtLuDge5I5nWZ
 d4USaeJeygyAgkB5tsgEkyr5dxMXXPFBzDgrBFTuOzAOzB1FrSCbxsT/gInv6eEdAdNn
 jiRl0qrgGgNZCrTNcfsOY8l6SetHE5/Qhc0DwOU12iiyQW5rATPMCpzR20DAKyhr3Qhy
 TxGw==
X-Gm-Message-State: AOJu0Ywr1SZhngeKJY7Ta0JIuZZd+jTcIk8lg3XV2QAAzKao6nlfiD1W
 Dma4EiVGp4gVGieQFbqcNqM7Hw==
X-Google-Smtp-Source: AGHT+IEjprZbNF7DMBGU4lQ6xc6WTje+WKnSRWZlQbOQid0w59x+JX5iupmN8LcINMgX/UveTDWNog==
X-Received: by 2002:a05:6a00:2305:b0:688:47b1:a892 with SMTP id
 h5-20020a056a00230500b0068847b1a892mr2774268pfh.17.1692209179850; 
 Wed, 16 Aug 2023 11:06:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a064:e3f9:a812:973b?
 ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm11321440pff.86.2023.08.16.11.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 11:06:19 -0700 (PDT)
Message-ID: <b4f33770-a12a-b28e-7a9b-757164f6dc91@linaro.org>
Date: Wed, 16 Aug 2023 11:06:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/15] linux-user: Implement VDSOs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20230811165052.161080-1-richard.henderson@linaro.org>
 <87350mt0eo.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87350mt0eo.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 8/14/23 02:52, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> It's time for another round on implementing the VDSO for linux-user.
>> We are now seeing applications built that absolutely require it,
>> and have no fallback for the VDSO to be absent.
> 
> Something broke configure for me:
> 
>    ../../configure --disable-docs --disable-system
> 
> 
> Gave:
> 
>    Dependency glib-2.0 found: YES 2.74.6 (overridden)
>    Program indent found: NO
> 
>    ../../linux-user/hppa/meson.build:7:0: ERROR: File vdso.so does not exist.
> 
>    A full log can be found at /home/alex/lsrc/qemu.git/builds/user/meson-logs/meson-log.txt
>    FAILED: build.ninja
>    /home/alex/lsrc/qemu.git/builds/user/pyvenv/bin/meson --internal regenerate /home/alex/lsrc/qemu.git /home/alex/lsrc/qemu.git/builds/user
>    ninja: error: rebuilding 'build.ninja': subcommand failed
>    make: Nothing to be done for 'all'.
> 
> Will there be linux-user targets that never support vdso?
> 

Something must have gone wrong with the email, or patch apply, because that file should 
definitely exist.  I have just sent a v4.  If that breaks too, let me know but then please 
just pull from my branch.


r~

