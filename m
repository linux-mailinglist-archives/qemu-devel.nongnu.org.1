Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A077A15A
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 19:23:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUsJ5-0002c4-3r; Sat, 12 Aug 2023 13:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUsJ3-0002av-79
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 13:21:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUsJ0-0005s4-Lj
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 13:21:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bda51aa6bdso15375565ad.2
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691860897; x=1692465697;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qgGV57KQZlsGuw7nOMq3rUWdVKpJCr3aEv1Ya80Jna4=;
 b=og5s3SpllX6zV8B7cxgLlmiVR8Hp7F5rw+jKBo720yUPawYj17boLjt95XFLW7ivxD
 VfSxABq5TyKrMZSfKTuvMAW+8MZeeH6s6GcAjJdvmBITj5b1C5nkBRk3NzhxrwgrkYFV
 z+YheJKmRY3RvVRKW9KLd6tikdY3Xv6UKRps7TSNuRsPQu6eyIMpJsFwlUQHSLnTGUtQ
 gs7/iUthPWiHj6mjoJLHDkJe0y+InlOREvCpunn9Bc7o9rbSJcFkg+il558QY4tdE+py
 HRMNJ/cqtRl49a4YOX/9TaCyuX57DAE+J5N4/LLS1M8jjt8nAxwFwv01LGbMCxRzKgBW
 JPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691860897; x=1692465697;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgGV57KQZlsGuw7nOMq3rUWdVKpJCr3aEv1Ya80Jna4=;
 b=d7cEmF9KxiluhqJdk1+ge0VJi/0d7FSrcNH2qflmgRrbsal2FZFmRGzNA7jlt91p29
 jP5pNTgVym1uRIkjQvv5gX/L/JQmLSI8QjsJ8Cc0PGj0kGSpZ/2oWlVjTlfWrhj0OF70
 EWDDq3v9DUgtTxjKcDqsJHHJmOvoeOvblGbEjaTAPbTIvEMzl3VWB1UrGYhmrIaCSnjE
 qkzT57x/WHYydEw6Ms/YldHf+L7lEc5Hgfk4w0vA0w1vtyl+WWHoYBMzjcPGrf2WWWxM
 h6R5EJdxHpDrZNrf+m7ooHyCks3plDDhRSBb3VHJKkaicH+YOp9ZwfOSzxib1SbrLob+
 nCiw==
X-Gm-Message-State: AOJu0YxHDoFkl9qMDF4bib8tFVj8GdI9y6y6FdTJNQ7LbFmSyJ8U5jyd
 vJiu9otPscKQ6bDMmxSPP8SUmg==
X-Google-Smtp-Source: AGHT+IF/ka1nn6iWasDDqklnimtouNg1lxrdjhHY+9XPk4JgAWc306PEILwwouZMoI2iJ6vI6a6WoQ==
X-Received: by 2002:a17:902:d352:b0:1b8:a812:7bc2 with SMTP id
 l18-20020a170902d35200b001b8a8127bc2mr4457207plk.8.1691860896715; 
 Sat, 12 Aug 2023 10:21:36 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a229:715e:62f0:756f?
 ([2602:47:d483:7301:a229:715e:62f0:756f])
 by smtp.gmail.com with ESMTPSA id
 jh3-20020a170903328300b001b866472e8dsm6145738plb.241.2023.08.12.10.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Aug 2023 10:21:36 -0700 (PDT)
Message-ID: <3264dbe3-0c33-742c-5c5c-beedb57f5e84@linaro.org>
Date: Sat, 12 Aug 2023 10:21:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 20/24] tcg/i386: Add cf parameter to tcg_out_cmp
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-21-richard.henderson@linaro.org>
 <CAFEAcA-N-QWQXcHgMNnXTr+Bmf7fhdSKYQwS-kkWGdR+UHvT-Q@mail.gmail.com>
 <CAFEAcA9xsPHOeorJvjfO7mrpX_TfYHMNcMHi3dyt41+CktyXsg@mail.gmail.com>
 <6a116d10-5e01-30f8-fbd6-30c062fcccc5@linaro.org>
Content-Language: en-US
In-Reply-To: <6a116d10-5e01-30f8-fbd6-30c062fcccc5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/11/23 08:06, Richard Henderson wrote:
> Basically, test sets SZ flags, where cmp sets SZCO.  I want to add an optimizaton using C, 
> so "cmp 0,x" should not be silently replaced by "test x,x".

This patch can be dropped entirely.

TEST clears C (which cmp vs 0 would also do).  I was mis-remembering INC/DEC which leave C 
unchanged and thus uninitialized wrt the current operation.


r~


