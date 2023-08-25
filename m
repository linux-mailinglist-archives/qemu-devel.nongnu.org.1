Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7FC7880A2
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:10:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZQxP-0004Bg-MZ; Fri, 25 Aug 2023 03:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZQxA-0004B3-Pl
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:09:56 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZQx7-0001LE-C1
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:09:56 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce529fdso928091a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692947391; x=1693552191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BE+jqnivCDTQWInIylniJfpMeWgD4PvJ7i0k0HlILsQ=;
 b=so1EJwPd1iB6ki6UVWv/TiVMI0fOXgJMXBP0dqmeGSXzwsa7drnd90boejY805Opr/
 C0TMmGQ5zJNJUjfbfllJhe/U0mMMwBgeYv8XE1GXtd/beTPMhh8ifaCb58qxxCU4qTPQ
 4dZnYUwMRVeXKhuN3D6BOivUP3gTuvPefppOC210A9ZI8ddY2esl7YDfSfieZaym6dSL
 Qn9Ki1OBx2u4zwJiOZuaaRlIXkfYhfWP68UoaRZq3Jcd27ughdveGsu87W90SLqOHSnj
 qf1tE3/jWuStEP3q9rhHjqxd9TXRb6OpuHnVIObcoKZhu1uO/MRJ1nHOy3hr9qItuhBU
 cMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692947391; x=1693552191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BE+jqnivCDTQWInIylniJfpMeWgD4PvJ7i0k0HlILsQ=;
 b=QOt90GEJVoG8JMpztElKk6UdzFnGHzj22JmUfkdi+zT2+eDIdvChqB4ym5PLXpZ070
 4IOZVNvGXyqvxbZGhP2ef7/bHfbYzSaE/lVcaUevh/uwgggZMmVHbRQXjfZjPg67sApb
 /Zsn+98DcKK6XcxGGc7XEKXScpq2Ohc1pCdtkSH4CnYXLZKlDXSEzD9ZfPcO5zRRilId
 5fmWEa+c9SHCSx6oKimGw7hCXzd2mKZXWaiEuAiG6Hzijy6BoTOtGRy9PPtPnxw4TIhT
 DCRD2nke2vMXKl2MHhhm9BFLsNw98ZpSFJWbQJEvCj1rBg3ra0o1IhglhQzFzButnpGZ
 x2Jg==
X-Gm-Message-State: AOJu0Yyw5ZaWjp6aI0jifRcFvtfX6+Mhp59O1rovURoR2G9ZQIqSvIFk
 Yo+nj4EMheTx4jdYzqeGBTDbxw==
X-Google-Smtp-Source: AGHT+IFfQLYHUyGXwj4ZapRO5l69kyCSZatAegytxPgF0y35vxlM1ujXT68175yo/3NdvmooyaLJGg==
X-Received: by 2002:a05:6402:3447:b0:523:1004:1ca0 with SMTP id
 l7-20020a056402344700b0052310041ca0mr16366594edc.5.1692947391466; 
 Fri, 25 Aug 2023 00:09:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a056402124500b005222c6fb512sm686200edw.1.2023.08.25.00.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:09:51 -0700 (PDT)
Message-ID: <21af41fe-6fe3-7449-c61d-5571abe3ce03@linaro.org>
Date: Fri, 25 Aug 2023 09:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/5] target/hppa: Add priviledge to MMU index conversion
 helpers
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20230824210434.151971-1-deller@kernel.org>
 <20230824210434.151971-3-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824210434.151971-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 24/8/23 23:04, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Add two macros which convert priviledge level to/from MMU index:
> 
> - PRIV_TO_MMU_IDX(priv)
>      returns the MMU index for the given priviledge level
> 
> - MMU_IDX_TO_PRIV(mmu_idx)
>      returns the corresponding priviledge level for this MMU index
> 
> The introduction of those macros make the code easier to read and
> will help to improve performance in follow-up patch.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/cpu.h       | 5 ++++-
>   target/hppa/translate.c | 9 +++++----
>   2 files changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


