Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAAA7B3BB2
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:01:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKc6-0004ng-29; Fri, 29 Sep 2023 17:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKbq-0004jH-IX
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:01:21 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKbn-0007un-VZ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:01:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c5db4925f9so8564935ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696021270; x=1696626070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wpPpxUGqm3x0OyAOtt8qSgmj/yXD+t72o+6kJ1uWQsU=;
 b=fwAcffXK/NQSh+2VEUvZN30lvbXiLlbUA5SapeT+2fU2rYfmAWw99vusBxpTIi80VP
 XVict4rPh/466U7tZu/1rrz/5Ly9a2h0EwGdFeXpw8QmMioW4DYZh9ZHNTD7sRzBtBHn
 Ouc0tfNF+ek5/D8wkRMCeD/PFBwMvYZYnmO7uFeWi7gPG/ZY73w+59EL3aH4lml3j6Ka
 X/GOFPdkFh29dw98mSHoEmxJ3DILP93T5NOoXE5fg/N7HUoB1wQnFDe8LYdXxrPkOx+H
 Bt+oErwH6X4pmorD9rASGTDaENR4x4qmcGrZHhbgBEbuzdBCVBerWHGpqrBu1i2ebZSa
 oCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696021270; x=1696626070;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wpPpxUGqm3x0OyAOtt8qSgmj/yXD+t72o+6kJ1uWQsU=;
 b=Ar4+3zfyD0o2daKCvXrPHGANK+jGs/MZovQdlUHUZ/ZR6lYB3MrqBGEXswI9ZUx+yo
 eE3p59DINEFIrzU9PqsVjhKOdWGH5rWsfJrpR5gVeSXgi1NW5js/hAoCX0mf7wFCkuTO
 qf9TDfXJX1KfLy5pGRnXGk8b6M39WoUQ1UOzqBHBOmnuNyOoK3yaAcSuh8jzeFUtd2BH
 U4m5ya0g/N5ppMrh3d9m+JgOil4RGD+B/Vha/LL+jrGTh285y6Mhx3LU2R7LnEzzcRjb
 bgts+NmGRXk7Q5ZnrDwljyp+jWHMfezPrRReHdj4fuvLvlI+nATn/fckyokOSCLRO8HH
 Y67g==
X-Gm-Message-State: AOJu0Yw+UXkGBiCGPtlexROxobxEmxQpEqfj7yyHBeUr4DEy3SCBu0xU
 a80AKBgelcvPqf8WMLSzVK2zziLd19cys8RfcSc=
X-Google-Smtp-Source: AGHT+IFGpr3NQSjIIuttGYDbyIupxCQY5mwSeHwgo6MSYJki1Mt9yp2f3Jsy85tNEXE4X/CLzMWRmA==
X-Received: by 2002:a17:902:e851:b0:1c6:e1d:8be0 with SMTP id
 t17-20020a170902e85100b001c60e1d8be0mr8711587plg.2.1696021269860; 
 Fri, 29 Sep 2023 14:01:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a17090330d200b001c6052152fdsm12845061plc.50.2023.09.29.14.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:01:09 -0700 (PDT)
Message-ID: <7207d64f-7bb2-4f39-6062-e74010a56553@linaro.org>
Date: Fri, 29 Sep 2023 14:01:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 02/22] hw/intc/apic: Pass CPU using QOM link property
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> QOM objects shouldn't access each other internals fields
> except using the QOM API.
> 
> Declare the 'cpu' and 'base-addr' properties, set them
> using object_property_set_link() and qdev_prop_set_uint32()
> respectively.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/intc/apic_common.c    |  2 ++
>   target/i386/cpu-sysemu.c | 11 ++++++-----
>   2 files changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

