Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3069582FAEB
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 22:43:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrCe-0005Qb-Kc; Tue, 16 Jan 2024 16:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrCd-0005Q0-1G
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:42:35 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrCb-0007By-G8
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:42:34 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a2d6ded84fcso264318566b.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 13:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705441350; x=1706046150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A0agYQIo4Co1b8Qq4/VaiK9WH2WxLlmQ+1qEqiCjpkU=;
 b=ujSBnoZX0ugCgmdtfvTYjRVJODNj72mylKKNr9HQkZ+1f4Drek70K6GJ5X8wsgpVwd
 Klr3gm9r0NP43OAbIUPxpWZV6YQQu8D/GblqVBUH5kxkgjApY3dKyQenZYK6WY6RF7H+
 bzphDQ7fi7hQZHj1tUfbt1P7q54UvYDxMo536tvCPfD7Tfc7qSeudtY+wyvjHrchpQkM
 2RtF7Ft6T6v11tVKf2ETPuxgTgJ/CzuEtAO7JaFq8hBhvr+0t5JiCgxYnqxYCjvvphzi
 E4N0LUpphJ/HwpOAtLJfqRaztLtkaC6bzvrHnP9CjDMnNiE0FJUiauHzkVHYua6GeGOn
 pKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705441350; x=1706046150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A0agYQIo4Co1b8Qq4/VaiK9WH2WxLlmQ+1qEqiCjpkU=;
 b=KoduouowQ9xgjzh3i2uySh+FvhduCqhXdOCYw9Y4PpIMrV2P1AHVlkTLPwKFSvlhYy
 /vt+68ih2tdzqC3+8LlFeiZGUCTdXTGcWwUk2Ec7Xuamm8y9uWHMBkad1IxinVE89jpt
 0kkB/8aBM1ptKzv7pT3bAVUKDfCnwp6xe1GN2mVif/DDtbbEkK/3PzrrR4quskT8Kqyl
 AfsCx2TZ1dxpjsX/vuOdlLbNJfC6DxS1s2ButrE+FXhiCqRo+ARPZCdgiNL4RpxrZbjN
 MzSz4aZt8QNMGw5oRUzuIjU6KU4a5daSh9nJ9GRTxQaaMzAkXQ6KV/VbnQS8J/n8LTXf
 Y7Wg==
X-Gm-Message-State: AOJu0Yz/vJgWOBLTYLK7xnBgI0xV0EJHmlwQdVjumucCX+h3k+bKVHue
 jLCF0/+HiGeFtJJAGklpTE5qYrFSHeD8tUekPDyL3DpkvaE=
X-Google-Smtp-Source: AGHT+IHiH4FNT/r72j+62IRMT2soEtnKThs6Gd3K5GpcO8jGpNFjatOz9oeKNwvxnKYZykianiPJ/g==
X-Received: by 2002:a17:906:3ce1:b0:a2e:6044:68a6 with SMTP id
 d1-20020a1709063ce100b00a2e604468a6mr891179ejh.34.1705441350547; 
 Tue, 16 Jan 2024 13:42:30 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a170906048300b00a2a0212cfe1sm6919928eja.50.2024.01.16.13.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 13:42:30 -0800 (PST)
Message-ID: <163779a5-5390-4075-b282-10f1974d8807@linaro.org>
Date: Tue, 16 Jan 2024 22:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/38] tcg: Introduce TCG_TARGET_HAS_tst
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 10/1/24 23:43, Richard Henderson wrote:
> Define as 0 for all tcg backends.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.h     | 2 ++
>   tcg/arm/tcg-target.h         | 2 ++
>   tcg/i386/tcg-target.h        | 2 ++
>   tcg/loongarch64/tcg-target.h | 2 ++
>   tcg/mips/tcg-target.h        | 2 ++
>   tcg/ppc/tcg-target.h         | 2 ++
>   tcg/riscv/tcg-target.h       | 2 ++
>   tcg/s390x/tcg-target.h       | 2 ++
>   tcg/sparc64/tcg-target.h     | 2 ++
>   tcg/tci/tcg-target.h         | 2 ++
>   10 files changed, 20 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


