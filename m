Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAEC774FB0
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 02:05:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTWgE-0005iN-6H; Tue, 08 Aug 2023 20:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWgD-0005iF-29
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 20:04:01 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWgB-0002W3-Bh
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 20:04:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686f8614ce5so6171638b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 17:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691539437; x=1692144237;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RA2y+GwOqnY3JuI7mIPdxzQhJfjYR+5p4SJ6Z1vE04A=;
 b=zEwzycZxW8bDV9eMrnlEB88xpD7RJHC2mjPqIESBRlZiKnkWxWj25wQxixDWE2BECf
 ZBHUrbIhMnp+prGAY0qvaE6LBeZ6u1haet5SupAlygZHKq3lHN2q+i2/y/SrSZNGtdm+
 zovSSkwqv9uftFsZcV2996cYyW90DKod/j6Rt8SEsMq6eg8vyqZZ9k5MZQSRtboJ1eTo
 rAFhkXzf+sT0Xb3kx3EJZvt5Nudh5VJ21hF4d1xRVuvtUTmylvAAU4R0svBCWtNtu520
 btqi3GoywnCOlPQ/vxcuSR5fRPsDjlwU39mngXQC356SC1m5mDr1O+htJp5SZqk6FDAX
 phfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691539437; x=1692144237;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RA2y+GwOqnY3JuI7mIPdxzQhJfjYR+5p4SJ6Z1vE04A=;
 b=BaOI7Kx4lR81Wo8h09474RTXTbTrfphCF01hhVvHV0qeRfFf7qTLviAUjxUrGMkoy/
 umRIv+vGpHwgX3rNmuc/0bAs7jOiQG3gWsaVDvKQRzH2rpdI7actktwe3B9WqHrriVDl
 8ZxHhP6QAQF+AOdk9C2ba+Fb+oqYeTzLVG+B0RhOYWGkApKGC+1uxJVJ63sbMvO/za+A
 lc//Wd3UdRLZkM/+Ugl/LHIP8SXmTjQ4GDBQXyN8F7GaUZZM3+OOsXtE04HSqHaGkJ63
 881g8SWMYvsZfrBG4mDu2b0IgHV7ll5NX924IvPH/YBYAswIHP6+H2yl4vzFgyYalkq/
 8IYA==
X-Gm-Message-State: AOJu0YygVwSpc8Du3Ll7E8EsNvEgl1oLqZDG8zNXUUJLoJEll0EmfquJ
 2T+jO32pcps0YrlKiX48/akvvt8GgeNO+Jt1VhY=
X-Google-Smtp-Source: AGHT+IGuwuBd6RijE+rQIbYaYpH2ZTdYkcoh/Z5OF6n74kmS2MX45HsGMKK0xTodEgVBhXA5PSGdpQ==
X-Received: by 2002:a05:6a00:190e:b0:687:2be1:e2f6 with SMTP id
 y14-20020a056a00190e00b006872be1e2f6mr1355484pfi.16.1691539437652; 
 Tue, 08 Aug 2023 17:03:57 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 y9-20020aa78049000000b00640dbbd7830sm8929708pfm.18.2023.08.08.17.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 17:03:57 -0700 (PDT)
Message-ID: <e871da82-dcaf-b7da-d299-99e8911d1e9b@linaro.org>
Date: Tue, 8 Aug 2023 17:03:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/9] Replace remaining target_ulong in system-mode accel
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
References: <20230807155706.9580-1-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807155706.9580-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/7/23 08:56, Anton Johansson wrote:
> This patchset replaces the remaining uses of target_ulong in the accel/
> directory.  Specifically, the address type of a few kvm/hvf functions
> is widened to vaddr, and the address type of the cpu_[st|ld]*()
> functions is changed to abi_ptr (which is re-typedef'd to vaddr in
> system mode).
> 
> As a starting point, my goal is to be able to build cputlb.c once for
> system mode, and this is a step in that direction by reducing the
> target-dependence of accel/.
> 
> * Changes in v2:
>      - Removed explicit target_ulong casts from 3rd and 4th patches.

Queued to for 8.2.


r~

