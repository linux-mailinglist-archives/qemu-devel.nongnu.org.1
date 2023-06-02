Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5863720AC1
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:03:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Bv8-0007na-L2; Fri, 02 Jun 2023 17:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Bv6-0007mv-GG
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:02:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Bv4-0005dG-Um
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:02:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6ef9a928fso23720395e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685739765; x=1688331765;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DAt0k+o5/gX6u6huJqkNr0BzF4jJkA1FYLVG0vKNCow=;
 b=rxoFJmO6Cmf4D30ELRZ7p3NwLoX2EdCfIa4HueIqOkTIRAeLK4HIMN5fXEGoW9w5l5
 Tb5gvGWESXx2v0+DsDI7CoT6x50+hq7P1eAV0hKEdPxjbu4k0of0NlKbemvz1NChKJZj
 2zXpfAnIRsZ0b9HAsJSU+ayJ6dhasvhKDUatJ7WZ42k4rLLg4FjqZxJ1Qq3/SpDME3QA
 0qfGACmpRScAcOhHooi5iYfaxzb6iHy7Fit6Lv4a12Xg2cxinXR0XRzx8hOOe6wjnAyH
 Y7ntyaNsD65psz93ZP3PQfZ3rQjvrKglZQtTD1HOa3jRqu8ANCUlbb1XHn+/NFTy6GbN
 F8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685739765; x=1688331765;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DAt0k+o5/gX6u6huJqkNr0BzF4jJkA1FYLVG0vKNCow=;
 b=QxH0WTltzCUCMS0OglJIlXnJaydiSKNR7Fyo3d8P2IUpWWGLJifV2nufPP6ctU7R1j
 Ktf/PJ5tLJOgOqaRVOzmh13U4zsiS60AlJgWBeglsJXbjaBTCkJ7uyfdx8w9rmO3wdT8
 VCEJolyGcfAnzHViwpFX8GbPbCLPJ+M5dNxYtR2/fmvzjGO7zuDxpL6v4C1RNuDdFOJl
 Du1VyW/pBL1UNlOrORLljbw6EpcCGoL8cf4DgjO0RdLMNMlj6aB/nCJjUkn3ssY95ajc
 9LSkonAhClBzxD41m54xGVIetk0Qcg8yEDFZPa3J6jha2qxidAkP/V/SyIl+MEd6mfww
 TLHQ==
X-Gm-Message-State: AC+VfDzTYZmOD/gnpfaHtDjo55BRv2LoXLkhfMtWMcxsNsh3A/Zx9kDm
 AUwVzBIfVGDNDoONRMc4m1qilZC3yqBc824MBFY=
X-Google-Smtp-Source: ACHHUZ6m//oGwAgMkDXcludNHLIkOf4oOOp54YwlhBWalMwFhj0ku/Ij3HCB3+K2WAC01sljJ277Ig==
X-Received: by 2002:a1c:e908:0:b0:3f7:19f9:4c4f with SMTP id
 q8-20020a1ce908000000b003f719f94c4fmr2715422wmc.21.1685739765461; 
 Fri, 02 Jun 2023 14:02:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a5d5144000000b003062b2c5255sm2620938wrt.40.2023.06.02.14.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 14:02:44 -0700 (PDT)
Message-ID: <44f51d3b-8b05-ae23-8703-78708fbbf68d@linaro.org>
Date: Fri, 2 Jun 2023 23:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 39/48] *: Add missing includes of
 exec/translation-block.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-40-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/5/23 06:03, Richard Henderson wrote:
> This had been pulled in via exec/exec-all.h, via exec/translator.h,
> but the include of exec-all.h will be removed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/translate.c   | 1 +
>   target/loongarch/translate.c | 3 +--
>   target/mips/tcg/translate.c  | 1 +
>   3 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


