Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 606597E2C49
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:49:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04df-0003qT-0b; Mon, 06 Nov 2023 13:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r04dc-0003nL-Ms
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:47:52 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r04dM-0000J7-UA
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:47:52 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso707087966b.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296455; x=1699901255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n4ldzn/9iGWsmxppAPCOS96w+ygAzAk837VlHlSBl/A=;
 b=eL88zuT1/dIKBgyh6LV2xQaZ2kDoNYRIvetgqoPLEcsNN9azMlkVl+mEjxi8FB+Ep1
 V6G3hX7CA1QEESVYnF+zvNpRc1M87hG9lnj14DMww0m8HXHqfbxiv/No9+NhEyfTT7gv
 AhkAoqZSASutgPL8G7rMVQhj/BtLdItazQLRCQ3bL44IEmleJ5EhGEi5g55a8xF1cF+k
 xkdC8tLhGeKJZTxg5iNHoE95BBFz880eSRPT6pAvtUhwaZEiZLV/eSwYkYJFEESo69Ko
 dBru10/mhl54z3GZNyY+ANnFeGMY/GzknqOuBshn7QT7PzurQsZSU2iqjSI8SwouUhbj
 NdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296455; x=1699901255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n4ldzn/9iGWsmxppAPCOS96w+ygAzAk837VlHlSBl/A=;
 b=FqyByJ7r0//Ftpg8pTzy479HSUZL5vRc6tJafwAXcvR4yKVbgN+ls1ue8/+S/CAkuV
 gedHCOaixJRsImhQSuH5cVCfsNReCF7e3xke6YygeNBGo0cjAeVo42C55BiksGiipPqr
 LSNqirKAkAdMWcrsgWjF2bXIkbxcB+xDi2EhZHjwBzYW7Qdnc0dXw5HaxxZtxJfI41HV
 OM5Jk2FWGYoQNUYWz+bCBheOPbsOGReFxzDcB5E9VLbtmKRZveosddgwvyELMlKTr5Z6
 3+A3BimuwN/jJuQVsuubxpqhQPa1G8Xp1D+4lHbqAuSNii11e+CLJ2FOmEIYr7AkZArw
 umBQ==
X-Gm-Message-State: AOJu0YwYrutFUHDjDx+KGxbIqYAUcntUNPdQimcUQfoTKAaIWm7+p9yk
 k6IdKMKSReq0xDiaD+kqKHrgEnji52ofYQIjkj4=
X-Google-Smtp-Source: AGHT+IExmOKLGLAy5B0vCgMqYLh7YGVrbA+XSLKwulS1xbmq6UUq1BgXZdV7Cw5VocLftTVzFHhB2w==
X-Received: by 2002:a17:906:6a09:b0:9d8:78f2:7e9a with SMTP id
 qw9-20020a1709066a0900b009d878f27e9amr12293527ejc.14.1699296454824; 
 Mon, 06 Nov 2023 10:47:34 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a1709060b4800b009ddc65c18dfsm129956ejg.100.2023.11.06.10.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 10:47:34 -0800 (PST)
Message-ID: <2702e5ce-101b-fd0a-7f1a-62f76a952b7c@linaro.org>
Date: Mon, 6 Nov 2023 19:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 07/35] tcg: Add TCGConst argument to
 tcg_target_const_match
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-3.085, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/10/23 21:44, Richard Henderson wrote:
> Fill the new argument from any condition within the opcode.
> Not yet used within any backend.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 34 ++++++++++++++++++++++++++++++--
>   tcg/aarch64/tcg-target.c.inc     |  3 ++-
>   tcg/arm/tcg-target.c.inc         |  3 ++-
>   tcg/i386/tcg-target.c.inc        |  3 ++-
>   tcg/loongarch64/tcg-target.c.inc |  3 ++-
>   tcg/mips/tcg-target.c.inc        |  3 ++-
>   tcg/ppc/tcg-target.c.inc         |  3 ++-
>   tcg/riscv/tcg-target.c.inc       |  3 ++-
>   tcg/s390x/tcg-target.c.inc       |  3 ++-
>   tcg/sparc64/tcg-target.c.inc     |  3 ++-
>   tcg/tci/tcg-target.c.inc         |  3 ++-
>   11 files changed, 52 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


