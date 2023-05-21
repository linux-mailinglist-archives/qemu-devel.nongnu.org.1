Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578B70AD98
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:29:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0hEl-0000aw-Lm; Sun, 21 May 2023 07:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0hEk-0000ac-6D
 for qemu-devel@nongnu.org; Sun, 21 May 2023 07:28:30 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0hEi-0007Ls-LN
 for qemu-devel@nongnu.org; Sun, 21 May 2023 07:28:29 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-307a8386946so3087510f8f.2
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 04:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684668505; x=1687260505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DeJ12vt/u8SonFoAcwj8dAeS0KwWMz1XvHMrYeLsLbg=;
 b=Gs0y2NR/yhCPkQ/VfkAA6hxs/cXPGPkIQG2sM8+kRAJMxhZFjK98z4LQnLGYzhtmvn
 W66DwkN+F6HmWy4DAQNmya7ett0g+7wLjZRDfpSDI8XlTpMpvxaGaoqzReU8cztn2jlH
 qgLeq7s0uJ2ohB+BD4ci9vg2++Qzi/UPYCgwpPObBuzbpdn/TNPFRDMeQ5V96GFpk0x1
 YQjEJKqbW33PiKfI/yVy2kgPd61UAkvigbazvD2QzGyCO/wi81tzkyIjWrRP7nV+wyfN
 qULp+kSELNIIOOrnORIihK8UBVbRgimewKcSTI1x/LQbB3FMRcp79jBzQaOxEk9cx4fZ
 0jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684668505; x=1687260505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DeJ12vt/u8SonFoAcwj8dAeS0KwWMz1XvHMrYeLsLbg=;
 b=Ma7bKP/OmETg6LywPjnk1n1kBzJmtcfvS5wwR/d0oTbT+IMFzipAOkn413iKdndwyR
 wll81exEHUM0N707q/4jM4UtLwRES+OW8eMHEjCIkDzyKy3FJ6HpNE2Sia5cMY8r61La
 PYsTBO2OD/W7dfD+QzC3rUcNTqdQ2qtvg/5bNMcLa72vneYXWcGCF82PNfzPx1ZZi2+U
 fLSHAQg62djOLiIhOHqxuwZTnUt9HH7JzdtqgHyH56ESW+EELjcR4PdWDD3mpr23dbn2
 0mjRMbhE8u8jlOVp6K9LBbEJL71BglM0X2PXUo1vXIHJ071AaUF+DnD+dYkgDzdBtX6I
 Ne2w==
X-Gm-Message-State: AC+VfDzBRwXWKl2gRVH4+8A5l0yWLTf6Bq2gb17DnL1U7RDNI6YkPNqS
 +jTUPznuLDArlnsvlAJwSexBEP+6RoXZNcnRsN0=
X-Google-Smtp-Source: ACHHUZ5Zrx6D7UpAmiRj/fEqCp7kxub+gDfVVKyBRhboct4q5hCsH8UzNS81S8bY9tQk/2UcA+TJNA==
X-Received: by 2002:a5d:514f:0:b0:307:41a1:a125 with SMTP id
 u15-20020a5d514f000000b0030741a1a125mr5865864wrt.12.1684668504972; 
 Sun, 21 May 2023 04:28:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.152.177])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a1c7403000000b003f42d3111b8sm4937511wmc.30.2023.05.21.04.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 04:28:24 -0700 (PDT)
Message-ID: <b51a6df0-b53b-c6dc-b496-0c320aad463d@linaro.org>
Date: Sun, 21 May 2023 13:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 02/27] util: Add cpuinfo-i386.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230520162634.3991009-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 20/5/23 18:26, Richard Henderson wrote:
> Add cpuinfo.h for i386 and x86_64, and the initialization
> for that in util/.  Populate that with a slightly altered
> copy of the tcg host probing code.  Other uses of cpuid.h
> will be adjusted one patch at a time.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/i386/host/cpuinfo.h   | 38 ++++++++++++
>   host/include/x86_64/host/cpuinfo.h |  1 +
>   util/cpuinfo-i386.c                | 97 ++++++++++++++++++++++++++++++
>   util/meson.build                   |  4 ++
>   4 files changed, 140 insertions(+)
>   create mode 100644 host/include/i386/host/cpuinfo.h
>   create mode 100644 host/include/x86_64/host/cpuinfo.h
>   create mode 100644 util/cpuinfo-i386.c

Missing F: entry in MAINTAINERS file. We probably need new sections.

