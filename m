Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 510FA774F94
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 01:53:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTWVd-00039q-Gu; Tue, 08 Aug 2023 19:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWVb-0002wh-0m
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:53:03 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWVZ-0000ow-Fx
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:53:02 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-564d6aa9abdso268696a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691538780; x=1692143580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NroxWFCBOz+Ul+yt8wKSwhGFkFspsFyllf4amsJ18Qw=;
 b=hZ9rdIFnodJd0sY42dk5G5C1BFXjrCuRHe3hd7cCFkqLkSqPie9HKixakF/xm0XxBQ
 R898M8mqLKJdk509a2+7VEZFrCEW53LVO5ktmE5z+y3P2/iHY74qU0Yr3uq/o872OfsC
 4VPlr/IvgP528uiUIGsVeiVtq/uFo4qcmkLNpH0p/Ozk7MMPdiHof/s6U4cRafNi1HkI
 zaoPicCm8fPPlno2kdCLSse6g2Gu9gbWOLziAcBRnygcYOGdus8AC81NSXtISI1KOT+y
 +H2v7tMASxO+etw4OuxXz67+rf7Kka0/vpUFEmuIkIgfDboN7lUlmOrPQIjzzzTkgfii
 aTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691538780; x=1692143580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NroxWFCBOz+Ul+yt8wKSwhGFkFspsFyllf4amsJ18Qw=;
 b=Ptq7fu7eH8QEAybdA6Im5ri8mjbqu7osfcAR3BKI4WqZkovllBYp6WA7CNCMfL8bj/
 N7Qa4I8u5/OLSX1OTWOICapAN4NY85W2++a5O57kCnbE21JkB2D/5qpqbC8UYgGB1bDU
 y9yCI1mm/fMeaJixWRn4QbDAALtwcwmyCp4RKkwsbYC+eRC52a7rMDTSr0swMa8b3Irf
 KqfkCsstCkFBZryFoPn3YG+SkDeBO3diP32F6vPNO8b2mrrpFOEcO6Ff2TG073Hz5Qs2
 /HKMBsyl+kRyKbHO6dTdK28LqeVmZqmU1FokLNqQTO+nW8xQ+CJKPfIeJ/bDuo6Bbx2p
 o5Og==
X-Gm-Message-State: AOJu0Yyb5kTE/r0pKbKy6IYvlvz/onRZzdjk0gTHL5v2myNqzcoiOikf
 tUeLkK+QXs6MgvPDx9BT7W+uJw==
X-Google-Smtp-Source: AGHT+IEoeKvaZYcQRqnhU5PrzM0L6yG7HyAHw8R0hfT7K+JhUFhJ85AhTSbgIpj3kw3733AqH2vaBw==
X-Received: by 2002:a17:90b:1b46:b0:268:808:8e82 with SMTP id
 nv6-20020a17090b1b4600b0026808088e82mr1604928pjb.1.1691538780006; 
 Tue, 08 Aug 2023 16:53:00 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a17090a029600b002639c4f81cesm120737pja.3.2023.08.08.16.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 16:52:59 -0700 (PDT)
Message-ID: <6ffc52a2-446f-e963-4307-9d57225686ae@linaro.org>
Date: Tue, 8 Aug 2023 16:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/9] target: Use vaddr for
 hvf_arch_[insert|remove]_hw_breakpoint
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230807155706.9580-1-anjo@rev.ng>
 <20230807155706.9580-5-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807155706.9580-5-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 08:57, Anton Johansson wrote:
> Changes the signature of the target-defined functions for
> inserting/removing hvf hw breakpoints. The address and length arguments
> are now of vaddr type, which both matches the type used internally in
> accel/hvf/hvf-all.c and makes the api target-agnostic.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/sysemu/hvf.h  | 6 ++----
>   target/arm/hvf/hvf.c  | 4 ++--
>   target/i386/hvf/hvf.c | 4 ++--
>   3 files changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

