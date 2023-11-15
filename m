Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB27EBA96
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:31:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33ne-0000CX-M8; Tue, 14 Nov 2023 19:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33nc-0000CN-RN
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:30:32 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33na-0005VR-92
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:30:31 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-280200949c3so4998439a91.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700008228; x=1700613028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VWw1lvG6UJTWCvs34l4HpZx/F+x8Hwr0AM4inSzmYd4=;
 b=eI1dE50Z0K2qKZkoKMUbL8IKFbMC7oVpjnbLPb3MsBcr90L+io5FlHGxews3hRNGwj
 WkFSqJCKiIZeDtQAXGa2a6twd1hYixdE8tvCr+b4coO12N2c4G84eQvDk2PYmUaSCk93
 HEIwkm76UNoB3KrUJNyLbv8GxfvuJ7lTSbZf6l/VF9EvHVnH0bsopuh2x/0XKKRsxN8h
 7e6poQbhY4acE4p4w/X/lAvy66ZFNuLf2pF2Fet1yCG9hHzbBvExWUEcDIbkxaFqgVbJ
 oiRTQN0P3Q51mQxmMyTYwUKipNrZJ9JkC0hZdQpN+gunicPKfi+xfsAdNkfeHX3b5NfC
 PIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700008228; x=1700613028;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VWw1lvG6UJTWCvs34l4HpZx/F+x8Hwr0AM4inSzmYd4=;
 b=aOdt0gVKHcRexDwwebYlY4R3GuQlgJcaxA29bulN3l3zR1ZroOXfMfkgXEGNtTAUBl
 QNu5cVd9+3pWmMdR0RcAgLVa0yF58bBwceFMcHMZYl4Y7us5WiI5HEQa68wP2V+D1TbB
 5wapVxtjiQ7dqfnqcytiFFWcTNRMXRALRV2ziYCsC2wd/vg6wKAPoMOzkPhOqKHvdSyE
 xs1MxqccJORke3vst/yBYfGJmWd19zTGdI/pZJPTNWoADTGmYgiecqfbuXOQ3zCpuX0T
 WAKHqBEF+WMuKVlgXWiIP6hIEcJzy0Mgx6GCwpejrZXrEr8Tl1jl3icOFrSF3hHWMtrm
 8NmQ==
X-Gm-Message-State: AOJu0YzwbTxtT/A+VppQ8VtG/nyx0avcqigUyhxkZycge9iwTCcO7jhn
 51cUjI+RthV7bek3RseTy5u1KA==
X-Google-Smtp-Source: AGHT+IEG5Y00Aam6iNYy+otFK0dPuqKrIOYL7tZGY01rO2z33kAM9ez3NTIM8bo3VDQ0Mpe4j15gAQ==
X-Received: by 2002:a17:90b:4b90:b0:27f:fc2f:4831 with SMTP id
 lr16-20020a17090b4b9000b0027ffc2f4831mr10295628pjb.13.1700008228632; 
 Tue, 14 Nov 2023 16:30:28 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jd13-20020a170903260d00b001cc29b5c324sm6268555plb.203.2023.11.14.16.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:30:28 -0800 (PST)
Message-ID: <41f94bfe-0825-421a-a75b-8d4e014370ce@linaro.org>
Date: Tue, 14 Nov 2023 16:30:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/31] cpu: Call object_class_dynamic_cast() once in
 cpu_class_by_name()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-4-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-4-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> For all targets, the CPU class returned from CPUClass::class_by_name()
> and object_class_dynamic_cast(oc, CPU_RESOLVING_TYPE) need to be
> compatible. Lets apply the check in cpu_class_by_name() for once,
> instead of having the check in CPUClass::class_by_name() for individual
> target.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/core/cpu-common.c   | 8 +++++---
>   target/alpha/cpu.c     | 3 ---
>   target/arm/cpu.c       | 4 +---
>   target/avr/cpu.c       | 8 +-------
>   target/cris/cpu.c      | 4 +---
>   target/hexagon/cpu.c   | 4 +---
>   target/hppa/cpu.c      | 7 +------
>   target/loongarch/cpu.c | 8 +-------
>   target/m68k/cpu.c      | 4 +---
>   target/openrisc/cpu.c  | 4 +---
>   target/riscv/cpu.c     | 4 +---
>   target/tricore/cpu.c   | 4 +---
>   target/xtensa/cpu.c    | 4 +---
>   13 files changed, 16 insertions(+), 50 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

