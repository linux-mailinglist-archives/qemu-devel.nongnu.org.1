Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F7C714738
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 11:43:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ZOe-0006QT-8k; Mon, 29 May 2023 05:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3ZOZ-0006QC-Be; Mon, 29 May 2023 05:42:31 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3ZOT-0000pw-RB; Mon, 29 May 2023 05:42:31 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-19e82ae057eso2266278fac.3; 
 Mon, 29 May 2023 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685353343; x=1687945343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ljgba1ctfD1nt6nt7vG9eTZqBHW0bi/pqH0uzbVYLTA=;
 b=VtEm093iqysIJf0WhTY+BfTEmkSCENPXpCDLdvQZJYlyrOShfHsXW0RNvo8Fb9EpEq
 3uMPJyzViKh1YI8OvNtISpDR4yQH4FikkkoT3Qo+neMXnevkwQfGNMtv14hFmPUocKjv
 icb63XXSHKHh/sSbAwheebD2Ao1sOxod575oqRnHdF0tiI6QfVQnEJi/hS64LW/5O3P1
 27wgw/lrSRHEdOKc78ZW5fykc5SnkBaa2zqhsmMynweH2sdUuBPYudNth5HqXQwUQohc
 5jU9fAUdTB7zPThkgbhPh0MOdF7q2RhLhDArGCN9i/2wpHq44bg95L3rYfUkNYhzr7tY
 2sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685353343; x=1687945343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ljgba1ctfD1nt6nt7vG9eTZqBHW0bi/pqH0uzbVYLTA=;
 b=YsprWlMLpV5YSvrdSO67D4SQlBBCk1eBhOD6vwCbmJSbk9T+5/RM/1AB3A3PY2jZ52
 aT1l0HOnHGnL1XcoIOcN0WFxPu62SS1kHpSOO7xgLF5w4BOcMxoFciggJZUkw8dUg8E8
 ZGYaSDqM+FOx5QPLv9ZcTrSwFuwengaFGOP0u2rFcmslX76df/4o2EVz8UZ1EtQEpMcM
 wWGIhpv8uZqOOdThB0IJ3dJk+wbqZneXZ9MnbvGMSYgQ+7ll5Z7oyndesZDB7+QKwsCL
 epxXLoT0wz0jWXV4IdnKx84eBZQTbTgaN6Vuqe3GGjsR0wpicS75QLUnQH0kwmR1C2yJ
 o9ZQ==
X-Gm-Message-State: AC+VfDxAmR2s55Af2d8KS+PcPG4E2aoVX7nlr7AWAauSgq8UmZT007T1
 k6z5ByeGzAHu1PVRAw6qDG0=
X-Google-Smtp-Source: ACHHUZ4ioQgQ8bgffhRurEVpUeX5yJnQOcVPWYMmq9tJhxwB0m33TBfjfNsdBvyWDaqIGBv2w/tylA==
X-Received: by 2002:a05:6870:5b03:b0:184:7ef3:80f4 with SMTP id
 ds3-20020a0568705b0300b001847ef380f4mr4218809oab.10.1685353343167; 
 Mon, 29 May 2023 02:42:23 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 v52-20020a056870957400b001968dd2e1fesm4483221oal.3.2023.05.29.02.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 02:42:22 -0700 (PDT)
Message-ID: <a45164d6-2720-20a8-996e-08abc38e92fc@gmail.com>
Date: Mon, 29 May 2023 06:42:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 00/10] ppc queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Bernhard Beschow <shentey@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
 <2ccafb44-d09a-e71c-005b-9a36f128b275@tls.msk.ru>
Content-Language: en-US
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <2ccafb44-d09a-e71c-005b-9a36f128b275@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.093,
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



On 5/28/23 14:36, Michael Tokarev wrote:
> 28.05.2023 19:49, Daniel Henrique Barboza wrote:
>>
>>    https://gitlab.com/danielhb/qemu.git tags/pull-ppc-20230528
>>
>> ppc patch queue for 2023-05-28:
>>
>> This queue includes several assorted fixes for PowerPC SPR
>> emulation, a change in the default Pegasos2 CPU, the addition
>> of AIL mode 3 for spapr, a PIC->CPU interrupt fix for prep and
>> performance enhancements in fpu_helper.c.
> 
>  From the patch description, it looks like the following changes
> are suitable for -stable:
> 
> 01/10 target/ppc: Fix fallback to MFSS for MFFS* instructions on pre 3.0 ISAs
> 02/10 target/ppc: Fix width of some 32-bit SPRs
> 03/10 target/ppc: Alignment faults do not set DSISR in ISA v3.0 onward
> 05/10 hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
> 
> Or are these not important for -stable?  Or maybe there are other changes
> which should be picked too?

Patch 1 and perhaps 5 is stable material, and by "stable material" I'm
interpreting as "bug fixes for issues that were detected in the field
by users and predates the current release"

Let me know if this is the right approach or not.

> 
> Please add "Cc: qemu-stable@nongnu.org" tag for the future patches which
> needs to be backported to previous/stable version of qemu.

I'll keep that in mind next time. Thanks,


Daniel

> 
> Thanks!
> 
> /mjt
>> ---------------------------------------------------------------
>> Alexander Bulekov (1):
>>        pnv_lpc: disable reentrancy detection for lpc-hc
>>
>> BALATON Zoltan (1):
>>        ppc/pegasos2: Change default CPU to 7457
>>
>> Bernhard Beschow (1):
>>        hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
>>
>> Nicholas Piggin (5):
>>        target/ppc: Fix width of some 32-bit SPRs
>>        target/ppc: Alignment faults do not set DSISR in ISA v3.0 onward
>>        spapr: Add SPAPR_CAP_AIL_MODE_3 for AIL mode 3 support for H_SET_MODE hcall
>>        target/ppc: Use SMT4 small core chip type in POWER9/10 PVRs
>>        target/ppc: Add POWER9 DD2.2 model
>>
>> Richard Henderson (1):
>>        target/ppc: Merge COMPUTE_CLASS and COMPUTE_FPRF
>>
>> Richard Purdie (1):
>>        target/ppc: Fix fallback to MFSS for MFFS* instructions on pre 3.0 ISAs
>>
> 

