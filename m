Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B791E73CF51
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 10:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDL4f-0004SX-F1; Sun, 25 Jun 2023 04:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDL4U-0004S3-Bg
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:26:11 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDL4P-0006ef-Eo
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:26:08 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51d7e8dd118so1823175a12.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687681563; x=1690273563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XDurioBlBW0lnqV7WP6lflm6+GeOPIzqrVoBzfG/Q04=;
 b=U6pbNduIKhJDOCYCCTVkpnzTldttKfQVv/Rsb1iRPcqudkedmskloWkahWaPdLJH2m
 ChJ3qMyASuCiAB2hXMxzDlaXCmmNokJXyKqoI9wxxnkHIQNWNUShBXVi49ISYBzW/Bx6
 3wp6d3zVv4CVNXFEzryxo9nt6dRHDgvcSNbfnmZf8SHkShYTNbJU8MrO78JYmz4Gr27F
 P9iIsVrvlGlZC1LbBsjghIzd40L6sZPPAcRCHapR52h/FmjMgfQkXU+5RRffTNVBfA8D
 sEiuSoLqykLjD7re2+7Nx+kwSP6VdSoNgOVAE30OhgLQ+CEerqEtT3eR/pkdpG4t69sP
 VWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687681563; x=1690273563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XDurioBlBW0lnqV7WP6lflm6+GeOPIzqrVoBzfG/Q04=;
 b=AnhNJ3cgp4Il09Cp7d+bFKcgiK5BaN4jjLQqZz1S08xNOrYYv3xmzv4QJAOPTzMuZT
 UoCf3U1woXLmc7rPwsoGYuPKS93Ukz4XGR4spkXYsyESxMfyAofWmMUS4p+Uc+ndXoP6
 gYY/S0syB9dadHff8gRdTQjS6eUG3TU3k7yCUqJeJYtnLZPlUHXMU5QvgwocXPUpGhhF
 YCmhebST1UBNai7WvtpwaizZoEq04h/3AxeUz8JEIXH0KjuzX2GE/OIIxh/ooZkwVFtW
 VSWNJc6r9m0R5om3CiBTA98L5lYlPYVv4qMP0EMmTyZuGci7JZgKProUwKBaiGhfskWx
 iIEg==
X-Gm-Message-State: AC+VfDxoj4I19YKu5RvitqwaUDiyQusyMNRQEprmoqEZQWoyAE/xa61x
 O13aKuEePcZg8u/w2FhLmPIQalcZ7V5WhRHfV6oL5Q==
X-Google-Smtp-Source: ACHHUZ6KD4o8YzIMalYoMCYjT0A1YjgfiEfKTr76o7Co/k2lTghB9ztRYw4JYnHRfHv94Ofmtq7okw==
X-Received: by 2002:aa7:d0c9:0:b0:51d:7d5a:4426 with SMTP id
 u9-20020aa7d0c9000000b0051d7d5a4426mr2417442edo.22.1687681563126; 
 Sun, 25 Jun 2023 01:26:03 -0700 (PDT)
Received: from [192.168.157.227] ([91.223.100.38])
 by smtp.gmail.com with ESMTPSA id
 b16-20020aa7c6d0000000b0051d7f4f32d6sm1484523eds.96.2023.06.25.01.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 01:26:02 -0700 (PDT)
Message-ID: <e9249b18-ffeb-ce11-1e64-85a2c992b639@linaro.org>
Date: Sun, 25 Jun 2023 10:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/26] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/23/23 14:31, Peter Maydell wrote:
> Hi; here's a target-arm pullreq. Mostly this is RTH's FEAT_RME
> series; there are also a handful of bug fixes including some
> which aren't arm-specific but which it's convenient to include
> here.
> 
> thanks
> -- PMM
> 
> The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a4cb:
> 
>    Merge tag 'q800-for-8.1-pull-request' ofhttps://github.com/vivier/qemu-m68k  into staging (2023-06-22 10:18:32 +0200)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20230623
> 
> for you to fetch changes up to 497fad38979c16b6412388927401e577eba43d26:
> 
>    pc-bios/keymaps: Use the official xkb name for Arabic layout, not the legacy synonym (2023-06-23 11:46:02 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Add (experimental) support for FEAT_RME
>   * host-utils: Avoid using __builtin_subcll on buggy versions of Apple Clang
>   * target/arm: Restructure has_vfp_d32 test
>   * hw/arm/sbsa-ref: add ITS support in SBSA GIC
>   * target/arm: Fix sve predicate store, 8 <= VQ <= 15
>   * pc-bios/keymaps: Use the official xkb name for Arabic layout, not the legacy synonym

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


