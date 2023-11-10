Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D27E7E7E31
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:41:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1VU0-0005ew-9L; Fri, 10 Nov 2023 12:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1VTy-0005eH-Ah
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:39:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1VTw-0004uZ-PR
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:39:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso17449275e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 09:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699637986; x=1700242786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hv8fPPn//PmhRBA88xam+Q80QI/jxHSgtImXRtKtCZo=;
 b=SBn7xF2Yp69T6F5nc6bCXHHWO/8E8ynAbLA52Ey5AhfqSEOn2QItTBIWUJ3/Xu2vlE
 z7NaGfGoN38XKovIm62xTOST9OVjUs67D2RdqBpxdV36hWbhpu/LOkWnOmubPV8cJ66M
 bCSYYG8mD+nEVvNkNJrFDcfKu0P/2FjzxTrLQ1u5n1rJz5GQhlYVZHmNmWDOanGxvkYe
 qadM/JVqM1lMzFNnXglyjgHsvFZR7+/jzlREJSe4w89d5mZa74vbdUCrleZDgLEqqdW2
 c9d+uyHwgig/KiLNW9bQirwv6ATb9C7el057rpZTwzyLUrMYB9mPtie0Q1QbhIQfssxd
 BhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699637986; x=1700242786;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hv8fPPn//PmhRBA88xam+Q80QI/jxHSgtImXRtKtCZo=;
 b=rU8mTDh5U6BPsiyplBwXzvTIH9ZDSA90zPUERaRE641591BgBtBuu9ZvXFn4YrRyiM
 oslAPeuq9B7yoInXhjDugVj2kwnJZP5HycZOx2AUyRsdj1/ZSCh1TIT9+bDxC2sO5lvA
 mioVJOf23V4/Gz16VMj+7ksqtJzJtKYYW6CnMnbOf0/supoXJvH8Us7yKeQxPli0kQE5
 r7ErNO5uwdgb7sGO0EkH0oHbtfuvUvpigmbXaaGPXbk7NxyrF7jrBqGtQDYUnKQPyzEj
 qizMtjg7La0wfM2BkBz/wZseBywTr+CBc26zJ8jw5+VLbeWBMOSGoRl7sB8+1G+FH7Q6
 aBAQ==
X-Gm-Message-State: AOJu0YwWJXvv2+fJkCxV1sKfsUHHP7jmEmXXVOcVyDsL2/a/UkwavE8I
 vGO3u4qMyxxMZBPvW38XIWoiD1oTqg+x4NRksdM=
X-Google-Smtp-Source: AGHT+IE98lhC585Xxzd7H5iADZ8EhGnZk/65jLzQpNQeOsHq99yAvFvSkbuKbStyO/nRPHE0RA/s8Q==
X-Received: by 2002:a05:600c:444a:b0:407:8e85:899f with SMTP id
 v10-20020a05600c444a00b004078e85899fmr48767wmn.16.1699637986484; 
 Fri, 10 Nov 2023 09:39:46 -0800 (PST)
Received: from [192.168.69.115] ([176.187.194.109])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a05600c1c8900b00407752bd834sm5806367wms.1.2023.11.10.09.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 09:39:46 -0800 (PST)
Message-ID: <02750def-f4bd-48bc-b3b2-ade4cfa343eb@linaro.org>
Date: Fri, 10 Nov 2023 18:39:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Correct MTE tag checking for reverse-copy MOPS
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231110162546.2192512-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231110162546.2192512-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 10/11/23 17:25, Peter Maydell wrote:
> When we are doing a FEAT_MOPS copy that must be performed backwards,
> we call mte_mops_probe_rev(), passing it the address of the last byte
> in the region we are probing.  However, allocation_tag_mem_probe()
> wants the address of the first byte to get the tag memory for.
> Because we passed it (ptr, size) we could incorrectly trip the
> allocation_tag_mem_probe() check for "does this access run across to
> the following page", and if that following page happened not to be
> valid then we would assert.
> 
> We know we will always be only dealing with a single page because the
> code that calls mte_mops_probe_rev() ensures that.  We could make
> mte_mops_probe_rev() pass 'ptr - (size - 1)' to
> allocation_tag_mem_probe(), but then we would have to adjust the
> returned 'mem' pointer to get back to the tag RAM for the last byte
> of the region.  It's simpler to just pass in a size of 1 byte,
> because we know that allocation_tag_mem_probe() in pure-probe
> single-page mode doesn't care about the size.
> 
> Fixes: 69c51dc3723b ("target/arm: Implement MTE tag-checking functions for FEAT_MOPS copies")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


