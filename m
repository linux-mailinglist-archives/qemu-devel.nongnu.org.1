Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2297E36FF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 09:56:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0HsV-0006Sb-3S; Tue, 07 Nov 2023 03:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0HsS-0006SA-TE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:56:04 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0HsQ-0004SO-CB
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:56:04 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9dd3f4a0f5aso572164866b.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 00:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699347359; x=1699952159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VdLS1L9g8U7YsTng9QsY7udpU5AFcdSDVg/04htJqlM=;
 b=jEXKnJTPgO/R+YzRYvxYBshjr83JTaYU380qlTxLqdDVcM3Thpx7apWMcrtf5WJG4M
 1hAtWcN/KRcWA/M9D03fWwJdzNNnFIBY/Oi54Z2T61ZJ6Pqg0wIyfiz8yLeArlhpJEBY
 RvEBMuXM/sCkntDdcUyhH6AKScO+ft+IcboRA7HyVd1P9hc8X0B2dCWtsnRU+eFbFyLn
 yW2QFiBT2IgAy35LzcUlbj2cUFlGsyy/BR95dRypDEaOas/EsF7wfYVhCLa9NTTOhljf
 II1YAsaq7+ZuKqhprT8lI7UTjPxou7D/u+UKlOMY8VdCMn8xiP9mBwijod/bC0xoiJNH
 BvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699347359; x=1699952159;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VdLS1L9g8U7YsTng9QsY7udpU5AFcdSDVg/04htJqlM=;
 b=S+i1ofKGE08K1vJPVH8Ne6E2RSsJMckBm1CPr7/hpuBAL//k6YcaJHIyw8ciMLHv8f
 /zEDU2L53avM1VAD2N8s36FX0CriS7A3gHdivEMTTEFW2Mjr+jDZ+SAR9HsMefxQl1ze
 Y9VzZwReUSX2p9rf8c/s2B2rJZ8sizwwwbTQzv4rdSPS4wtGwmGVa2p1RxJinyNZYr+L
 1W5cY3WWwbT8UrfPR2WUWxOTUU7cp2ty841drvWUH7zbu6z66n9EBGUUsU+89udFofLQ
 BbXUC+E5Mf8w9G+m25m/8A4PU9xS8o4affknSkF9Zi8torYsJ/A4yuNpknI6NROcJJj6
 Kctw==
X-Gm-Message-State: AOJu0YyqlDli+Zn+9hHirhgLt0q0itKAUHn7vCsedR8iaiBUgMWXIgPJ
 D4xhi2DSQsP3yT5q4DvdYnwVKw==
X-Google-Smtp-Source: AGHT+IEukGkTRhFlj+7DkDKO9qWFKIE2/azLJFXcH/rfDIJGh1Mh8P0EYSC1m5U/p82E/KRodfVIAQ==
X-Received: by 2002:a17:907:7b9f:b0:9c2:a072:78bf with SMTP id
 ne31-20020a1709077b9f00b009c2a07278bfmr17708312ejc.26.1699347359175; 
 Tue, 07 Nov 2023 00:55:59 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 gs13-20020a170906f18d00b0099bccb03eadsm776159ejb.205.2023.11.07.00.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 00:55:58 -0800 (PST)
Message-ID: <16217b00-d400-4ec0-a544-8b02c8e5839b@linaro.org>
Date: Tue, 7 Nov 2023 09:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dump:Add close fd on error return to avoid resource leak
Content-Language: en-US
To: Zongmin Zhou <min_halo@163.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Zongmin Zhou <zhouzongmin@kylinos.cn>
References: <20231107024417.585475-1-min_halo@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107024417.585475-1-min_halo@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 7/11/23 03:44, Zongmin Zhou wrote:
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>

Reported-by: Coverity CID 1523842 (RESOURCE_LEAK)
Fixes: e6549197f7 ("dump: Add command interface for kdump-raw formats")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   dump/dump.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/dump/dump.c b/dump/dump.c
> index 1c304cadfd..ad5294e853 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -2160,6 +2160,7 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
>           return;
>       }
>       if (kdump_raw && lseek(fd, 0, SEEK_CUR) == (off_t) -1) {
> +        close(fd);
>           error_setg(errp, "kdump-raw formats require a seekable file");
>           return;
>       }


