Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B28C4823091
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 16:31:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL3Cn-0001ZO-BH; Wed, 03 Jan 2024 10:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL3CS-0001Xp-C7
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 10:30:34 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL3CQ-0001mg-JX
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 10:30:31 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-556ab8b85e3so1024812a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 07:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704295828; x=1704900628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LIL18qUP6ckuz9AcaoRHtDVLYtv6sZ0B6c54LkqKaSg=;
 b=kCFWnTgyke3Y/RjTJOzaumUVuH6dbGm2l5vSYlC3Z/KYh73lCX1RRrWU2KgEtNHJIs
 XhDjk8IqueO0FSXXL0/UYJ9hfYjQZXmyLq7l05f5ZaQ3Zq3cYyumCdiF7ZA3UGEH61cH
 VzuoL+cmO+IPVaFofb05Tb4f+VaiCCCpt4iaeBq8l/ueTBtABlHIGjkKRMU5mwBhceFt
 5MXSRlnTFx4S8p/HcETIeHA1pvU/mrxxPsCfWVkX0XfHeFs77wmH4QkN2ul+n3StUI9V
 cJevc1w3D80iE/d/6AxynVlXalC7SbcrTEYvR2bhxhq9+dvMRYRjgGLMwfN0gGbEM/Iy
 SMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704295828; x=1704900628;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LIL18qUP6ckuz9AcaoRHtDVLYtv6sZ0B6c54LkqKaSg=;
 b=X01DFOWFjg2hLhDN9B8K0aUmWkPzV2CKU2kBaNL9mPjZAIQj1jD2TbzPL8fxQMoPKT
 SBSbgIE44zPRWp/zC6aFdtxWBlm7WoqfICSPFQ/jUOPtw04bqOyRAHlCxZAUSWKpXnRx
 sJrR9mZDQeUDpieqkFyXJfG2cfzwVaa4w87TmIpjxDh5AaWUTe3WROn9HKjQoYEbaeun
 2wktE1jK4I8QivqigOogC/V+fu33BUehBEqZEkFuYQ3l7/HmhioG4BRh107Fik1wc5Kr
 q4RCa3uoS61Oaljv8C/hXoTvP1IyWRMHNgi7jqfO2FvtXWfpWYyQFAiy2YF6Vv4iIw0U
 RYcw==
X-Gm-Message-State: AOJu0YxWamPYzbebryD2aGY/I0mjT2mvMqGDeiVMZHCnef54an3UJwXZ
 8LKjOeypBVNR1mMnH+p0uEs3kFgBUnKY0g==
X-Google-Smtp-Source: AGHT+IHLZTS6UzMtDLjxCq4ua18LFJ2N4t/EV3KW7BV9B98x5MIsgxo8Fb0DUmh1i+EYschGekDNrA==
X-Received: by 2002:a50:8e19:0:b0:555:9bd7:a4f0 with SMTP id
 25-20020a508e19000000b005559bd7a4f0mr1191313edw.36.1704295828570; 
 Wed, 03 Jan 2024 07:30:28 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 o20-20020aa7c7d4000000b0055537e76e94sm10524871eds.57.2024.01.03.07.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 07:30:28 -0800 (PST)
Message-ID: <c18d1c5c-f69b-41c7-918f-b425c8ba3529@linaro.org>
Date: Wed, 3 Jan 2024 16:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/33] softmmu/physmem: Remove qemu_host_page_size
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240102015808.132373-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 2/1/24 02:57, Richard Henderson wrote:
> Use qemu_real_host_page_size() instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/physmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



