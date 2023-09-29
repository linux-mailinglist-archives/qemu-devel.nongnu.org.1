Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD37B3BC3
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:05:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKfM-0000cX-A1; Fri, 29 Sep 2023 17:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKfK-0000c8-JI
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:04:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKfE-0000Dl-RL
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:04:50 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-692a885f129so10525895b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696021482; x=1696626282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KEdrggW5CuTbP2wmqG6pgjiGPU3+gh+gwuGxvhwWvPs=;
 b=l87gQa8OGQXTfltJDEuWEhCrpQx8JLan3y+wmBHTAuE+9M8oaPjW73RgmnZ35NW545
 9QDYALP4ZYVQEazZZRBmCst7Y7cMwODmMKo1t76MrfJhyv5csAKiBLyVymPNlCPkGqLe
 dtJTOP70ZenjaXWDmo2TgFiq7wOLVpGfS0ClFRPkmoo0FQboYCEg2H87SL7NaYdnviK/
 cDYFJ62aXeljmdZPNxq5SCGW7LCghpmzo1aJORk2YHCpf0ul1zmms0+yRtgXtopq+tLs
 fb0AHLJEWqnoESlP4n3+RJMlV3mH7LC+ekze/NSiGA90ct53zsk+KziZyX3lMu4bWKDq
 pNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696021482; x=1696626282;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KEdrggW5CuTbP2wmqG6pgjiGPU3+gh+gwuGxvhwWvPs=;
 b=Jju6guGyigjo7Nt+kNw8RdGosuTpjrc1FHpFNNMXCNG/rigg/bRlu5eSdUuzmn6WhH
 DIkmCo8bSAJgr0LGZJjvMY9ha2Rd0Pn3r5S7gcPxHG/etepsIlWhGdqn955FkuBh2pip
 FCLIFImJ+K2DK8X5pihaqL2NYxhZM3+1McZoVmxeYm1K/ANtjw+IIKOHSyOJslIg1ar2
 q38GqaZMOE7N/Ah/hc11eFN/XbIhTem4RWnCz2STsQORRRPrzjC8Lncw2xa4aTzEcH3G
 RxtbIWvtDpJ/k3j4DJTaATU2zzQhEWhmClzBKmIRbq5Y9BqSXnjRyVD+M6OVquIjrFh5
 LYtg==
X-Gm-Message-State: AOJu0YwS8kzvB4y5Qvi0N40KCJgoDyFdVberBxdViYbdvKQnWfZMT4Kd
 G5beGpitb6f6p4r1UjksRveAnOHLACeGLGAGpkY=
X-Google-Smtp-Source: AGHT+IEbd16udBvz4VJS8hQcFn7ISMGJEiO0gVDi+0mMiaphwjFUuWuoBVP+ALg6hFwcvDYW9UICMw==
X-Received: by 2002:a05:6a00:15c7:b0:68f:da2a:6370 with SMTP id
 o7-20020a056a0015c700b0068fda2a6370mr6501603pfu.13.1696021482292; 
 Fri, 29 Sep 2023 14:04:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 u10-20020aa7848a000000b0069343e474bcsm3829366pfn.104.2023.09.29.14.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:04:41 -0700 (PDT)
Message-ID: <cacc0e21-5cdb-93e9-bbaa-9093555637de@linaro.org>
Date: Fri, 29 Sep 2023 14:04:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 05/22] exec/cpu: Call qemu_init_vcpu() once in
 cpu_common_realize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> qemu_init_vcpu() is called in each ${target}_cpu_realize() before
> the call to parent_realize(), which is cpu_common_realizefn().
> Call it once there.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/core/cpu-common.c    | 3 +++
>   target/alpha/cpu.c      | 2 --
>   target/arm/cpu.c        | 2 --
>   target/avr/cpu.c        | 1 -
>   target/cris/cpu.c       | 2 --
>   target/hexagon/cpu.c    | 1 -
>   target/hppa/cpu.c       | 1 -
>   target/i386/cpu.c       | 4 +---
>   target/loongarch/cpu.c  | 2 --
>   target/m68k/cpu.c       | 2 --
>   target/microblaze/cpu.c | 2 --
>   target/mips/cpu.c       | 2 --
>   target/nios2/cpu.c      | 1 -
>   target/openrisc/cpu.c   | 2 --
>   target/ppc/cpu_init.c   | 1 -
>   target/riscv/cpu.c      | 2 --
>   target/rx/cpu.c         | 2 --
>   target/s390x/cpu.c      | 1 -
>   target/sh4/cpu.c        | 2 --
>   target/sparc/cpu.c      | 2 --
>   target/tricore/cpu.c    | 1 -
>   target/xtensa/cpu.c     | 2 --
>   22 files changed, 4 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

