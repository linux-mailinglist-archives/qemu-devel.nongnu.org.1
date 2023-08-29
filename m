Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0C578D024
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:16:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n6-0000sM-AS; Tue, 29 Aug 2023 19:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb475-0001X2-Dd
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:10:56 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb471-0006lf-Nr
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:10:54 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso30287345ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693336247; x=1693941047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6GLgw/BIC3PI7dA1EDeNl4L9V7s8vfn8h7trihwC8B4=;
 b=m/PUsnKHZ2qvuJ8FGsYImbZC3MIRredgSVmfF5zJOvrkD2GTy3/R44gTnRtaAmz4Dj
 kHdm7iodYcuMfjAjPOfWNgDnw8hidXM7My2xuddieeUGj78sLVqpTOzbb0OSyKl4z0G/
 IaLgwvpvPsK9k52Wtvgb7qsrWeU1qnAlVMw+1FSDVxBrqPgz9BJF3yYDfEF9Z/ZXkFpk
 Hrw8IasvrXLu8wWNuANSeCyrBu3vN2gPmHsVI4/qiKumEYdXJ+0XY6UO9gUpwiXiSmaO
 1e9DTGr1hOSuBbym7GpwvorXgjCI5NKSK7xl4F5FccqTcNT5cFef3KlmWIB0iRlZz0kR
 wI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336247; x=1693941047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6GLgw/BIC3PI7dA1EDeNl4L9V7s8vfn8h7trihwC8B4=;
 b=kkWcMCqpBkpLdnByMw76cfzkOati34JRQzc3fTOgD+hY7R1U3qC4eyE/ocSAamqcSm
 W9NInZ30nB1fR1WaZPDU1+TTrYqmLzYqFzk8+zdUJB3Qnvrm2cyN9esic172s5kMWGzn
 3kJe0PGATR0IaBZnFtlKTn03rqEacwp+RUoXbWbOkUVn8C2QMzrRkm9XM86Vr8awrRqZ
 4X7K5RAMdy90BlNvzXoueDwGpD9bM6zJMEt/E/XDi//cWKYKCeczNxLhKBRaMfJp4hFV
 Jl3hbTbQb6Oi0p4zYDFSl4zPvEOWh+vYex1QeWAAR5UElGUZcX8RNkeua8Pw1w3WS3S/
 sA3A==
X-Gm-Message-State: AOJu0YxFEhiIFIRhBcyf3BekWjBB0AGlbi3RmclATcBLV8wL1flR9+S1
 NawNdVtUvTAyqtkRH+FSSiEhEQ==
X-Google-Smtp-Source: AGHT+IEr0/sig/FN5wAturRp27nSaHDXoKdGOczh4nUKTtxD8fmrKl6HfmVNPqEeCIIi2IAT2D9Jig==
X-Received: by 2002:a17:902:7481:b0:1bb:e74b:39ff with SMTP id
 h1-20020a170902748100b001bbe74b39ffmr78555pll.0.1693336247031; 
 Tue, 29 Aug 2023 12:10:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a1709029f8f00b001b898595be7sm9678053plq.291.2023.08.29.12.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:10:46 -0700 (PDT)
Message-ID: <efca03b7-6f90-509b-77bd-396a4a8e7307@linaro.org>
Date: Tue, 29 Aug 2023 12:10:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/32] bsd-user: Implement procctl(2) system call.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-3-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-3-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Implement procctl flags and related structs:
> struct target_procctl_reaper_status
> struct target_procctl_reaper_pidinfo
> struct target_procctl_reaper_pids
> struct target_procctl_reaper_kill
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/syscall_defs.h | 42 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)

Fix subject, to define structures not implement a syscall.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

