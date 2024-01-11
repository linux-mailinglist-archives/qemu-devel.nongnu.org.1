Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD7782B6D8
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 22:50:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO2wk-00075S-Ta; Thu, 11 Jan 2024 16:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO2wf-00073Y-AS
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:50:38 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO2wd-0006Z9-Ge
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:50:37 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28c9d424cceso4143602a91.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705009834; x=1705614634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8wyqKy1OgVlZbuu8dYLorg03vyZQERkuHdOKk6iiUQ8=;
 b=kZw+iqQAC1p9/LFvtf1JEp2yNj9sR33tfIbe7PnWZNfXMntMAJSo6OJfprdD4LCOwg
 pKVLOPz87hRpVZOZJQmlyc1i9dyA7gcNJsUGwVXThMbwiMDIofPkP4Nytd99sdn4qkrO
 /iNQeO8NJ4Ou4ywW3uHS5c2CKf70/ax8FJExOG35GP7VGbXLDV9VMeJ/EQFiOrNg0p6A
 0UayMTYgWeePt+XqGBkUnUPUxCwyMZRL+ny3L9mMzxiM4/6+o4HupNCkE/VuzNbOXU5J
 VxPnND1+1C/MB1BlGMQPVKucdUnNLqiWqpENHypkBGqZzc3Mfu6bDzxTZTa7ayj6J4ZJ
 Uu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705009834; x=1705614634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8wyqKy1OgVlZbuu8dYLorg03vyZQERkuHdOKk6iiUQ8=;
 b=jr1UkHnhPBTRFFLJ2pkG4KmsxyybHdHUai35eAVTM+69zhaqL6jpfnDciY1UQ6BJWb
 v1E2vBUvtCFJOe0kZHCyOAEBypo3RfSOXt0y1d8fVLIwipRfHBPB/pWg+nzNYUqoGVn3
 5Fbr+pPEFpBub5lVJOsWY4MvVxL1pnkayVyhZSvTEnEsxT4zp7zqZ5c0z+uDJfHQctnJ
 mQPY0fGz4mj62sASgH7lbPnBtk/2JPX3epNEt8dyKomSkHOvPo7dlZxvBlESQnI5+XaK
 4qmYOtvSbAWMDOtzqcsQvwocHG0RjlF/XA4DWJAyKbV3uLwuUoak1rntQvDHIEO0AD3s
 szcQ==
X-Gm-Message-State: AOJu0Yy5WpbpL0vioNf9DL2fe4WG69Tid0bK242aV1v2t0QHLjbVF0Hi
 KrRGb2d7y9FUUPAFtrVu2E8E3vCaEicwOw==
X-Google-Smtp-Source: AGHT+IExbGH2xqZF7kd1RuYdIaWJQrQFSYgq+E6KOeOeO0qzjmVRkXI6SU8Oqndqf/cpnF5A/rVy7A==
X-Received: by 2002:a17:90a:a88c:b0:28d:5def:7b07 with SMTP id
 h12-20020a17090aa88c00b0028d5def7b07mr719697pjq.32.1705009834197; 
 Thu, 11 Jan 2024 13:50:34 -0800 (PST)
Received: from [192.168.5.64] (ericne.lnk.telstra.net. [203.45.18.161])
 by smtp.gmail.com with ESMTPSA id
 oh15-20020a17090b3a4f00b0028c1a5aafe5sm4336284pjb.14.2024.01.11.13.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 13:50:33 -0800 (PST)
Message-ID: <1d1cc177-e9e1-4c0c-8ce7-ded3490ad145@linaro.org>
Date: Fri, 12 Jan 2024 08:50:30 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Include missing headers to 'tb-jmp-cache.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240111162442.43755-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111162442.43755-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 1/12/24 03:24, Philippe Mathieu-Daudé wrote:
> Due to missing headers, when including "tb-jmp-cache.h" we might get:
> 
>    accel/tcg/tb-jmp-cache.h:21:21: error: field ‘rcu’ has incomplete type
>       21 |     struct rcu_head rcu;
>          |                     ^~~
>    accel/tcg/tb-jmp-cache.h:24:9: error: unknown type name ‘vaddr’
>       24 |         vaddr pc;
>          |         ^~~~~
> 
> Add the missing "qemu/rcu.h" and "exec/cpu-common.h" headers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

> ---
>   accel/tcg/tb-jmp-cache.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
> index bb424c8a05..b13a02e45d 100644
> --- a/accel/tcg/tb-jmp-cache.h
> +++ b/accel/tcg/tb-jmp-cache.h
> @@ -9,6 +9,9 @@
>   #ifndef ACCEL_TCG_TB_JMP_CACHE_H
>   #define ACCEL_TCG_TB_JMP_CACHE_H
>   
> +#include "qemu/rcu.h"
> +#include "exec/cpu-common.h"
> +
>   #define TB_JMP_CACHE_BITS 12
>   #define TB_JMP_CACHE_SIZE (1 << TB_JMP_CACHE_BITS)
>   


