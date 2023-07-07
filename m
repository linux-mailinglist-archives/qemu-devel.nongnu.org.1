Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83A74ABDE
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 09:25:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHfpl-0006rt-2x; Fri, 07 Jul 2023 03:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHfpV-0006rd-C7; Fri, 07 Jul 2023 03:24:37 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHfpT-0001DJ-Ql; Fri, 07 Jul 2023 03:24:37 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1a1fa977667so1586875fac.1; 
 Fri, 07 Jul 2023 00:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688714674; x=1691306674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+v0c7jqXEaSQ8/CKVRHuIXi+OHiePF56yDcM+f6NjZM=;
 b=E1NVjUDE64Ygtts87T9i3RTHMYDqbMyGpllu1wNHIkXaPUPz6q+GJmUGircGAE2R76
 0og8tT5c77NmqhB7Pzb+xESN3oVar2S4kBnwM/hLKJLHsh6KS5k5moX8TcITs7Rz/5/S
 gl41CRfjFvYYPL7FdnZi2UMg1ehYn3/h9zIb0jbSd3qRWWdj5i5yD9cu85eO4twaunJW
 l7HTYAeXo34LhuZ9Z9Tr4/QLTAJL9/rnppE2/7khUrW6o23Xj2Nh4sGQGnTyEU/02tFu
 56GECAPS7UwZO9EoQwSqhH+wK+SV8xU/PxQioQx0Z+Qth+ItP3r6NcoKh7DCVlkuEnRU
 OH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688714674; x=1691306674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+v0c7jqXEaSQ8/CKVRHuIXi+OHiePF56yDcM+f6NjZM=;
 b=Tp4YRo0TWrFBn4CZzLsTJN98ff/79JTZXLlO8U9zWQr6LGOkmWihQl35EaGYM0vdr6
 5BF71dvgNtTsXf0Ihe1D9DltZqh7zm7ZDiF34SvNAxtUSmSHXlpxBwCJD2rSZw8xXzt2
 EsEhWPnQ82V6Rk8or1VDJ/kyDV56dsQkMakQQEdveZu3oaIkt7yFtpmt9fwKzbyWwFaZ
 d+oCUJgjVF8y2BpDH0OLxAx5Tnijh/6g0lkGLR20HanknY4cFhFtM4w5H9TCoNC6fHm4
 KF6yrUvzR7jsICSgKv6fbbiijw+eIhmxyAX42bHvdJJ/wyMyxr70df003VX68jXReQZO
 1Izg==
X-Gm-Message-State: ABy/qLYpR2QlwZSNddeBloEzu93oZGV7wBOM/2695su+OU4DCHzgQMK+
 Jxiwf92kLbKQxULWpIQ0RhlnoPgBCOU=
X-Google-Smtp-Source: APBJJlG21NBgnNX/iX/+YLsmS5eeUnw49hto47HXkhql9DP+A1alLI5t6H51qpFjQyekrU7bu/H2jw==
X-Received: by 2002:a05:6870:c89d:b0:19f:aee0:e169 with SMTP id
 er29-20020a056870c89d00b0019faee0e169mr5470904oab.30.1688714674188; 
 Fri, 07 Jul 2023 00:24:34 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 c6-20020a056870b28600b001aa02b7bfabsm1527682oao.33.2023.07.07.00.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 00:24:33 -0700 (PDT)
Message-ID: <bf8cc98d-662b-c4ce-2837-a70c79b0e5e6@gmail.com>
Date: Fri, 7 Jul 2023 04:24:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/6] target/ppc: Few cleanups in kvm_ppc.h
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230627115124.19632-1-philmd@linaro.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230627115124.19632-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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

Phil,

I queued all patches to ppc-next. I fixed up patch 3 to not move the cpu_list
macro as Greg suggested. If you're strongly attached to it let me know and
I'll remove it from the queue.

Greg, feel free to send your R-b in patch 3 if patch 3 with this change pleases
you.


Daniel

On 6/27/23 08:51, Philippe Mathieu-Daudé wrote:
> PPC specific changes of a bigger KVM cleanup, remove "kvm_ppc.h"
> from user emulation. Mostly trivial IMO.
> 
> Philippe Mathieu-Daudé (6):
>    target/ppc: Have 'kvm_ppc.h' include 'sysemu/kvm.h'
>    target/ppc: Reorder #ifdef'ry in kvm_ppc.h
>    target/ppc: Move CPU QOM definitions to cpu-qom.h
>    target/ppc: Define TYPE_HOST_POWERPC_CPU in cpu-qom.h
>    target/ppc: Restrict 'kvm_ppc.h' to sysemu in cpu_init.c
>    target/ppc: Remove pointless checks of CONFIG_USER_ONLY in 'kvm_ppc.h'
> 
>   target/ppc/cpu-qom.h  |  7 +++++
>   target/ppc/cpu.h      |  6 ----
>   target/ppc/kvm_ppc.h  | 70 ++++++++++++++++++-------------------------
>   target/ppc/cpu_init.c |  2 +-
>   4 files changed, 37 insertions(+), 48 deletions(-)
> 

