Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E318D7C87C9
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:25:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJ62-0001ut-Ra; Fri, 13 Oct 2023 10:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJ5z-0001u8-9O
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:24:55 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJ5w-00076Z-OX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:24:54 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c735473d1aso16666725ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697207090; x=1697811890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+l+XAcsgc56uZlRuqhBDRJ02kBsAAwghVzW9ysqxWmk=;
 b=XT3RERmhdPKBqM8lAqqs6aUXIG0N+E5WjNVyZmRPnXHa7M4mNTmE+qLMOqeoV5rDzH
 GE60Mcc0x6ccag+1FnoxjVziXLtsrcaPn0fxlLxGb5YvHRIra2K2iXXmLlCVB9fiFm8B
 m0JyohB/MzjZzo2hocp56USq3l07iA+KuPIGMHK319ZYhKCX1HPIrwCac7+3gqFLgUMx
 OfnMEzIv6KH9ORGlTqFEm7G0bTsqdY2hPLDAsWuqLrDx0t6mI+QQyd/9UIFykovwjDYA
 DVdmJJ5yxZ9h363WHswyyZaGLY35NHQDpkTE+AFipkxG+bOm3wIQNBCH3Ngo6tHFX7u4
 5bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697207090; x=1697811890;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+l+XAcsgc56uZlRuqhBDRJ02kBsAAwghVzW9ysqxWmk=;
 b=UkPn8vZHHFS/0a/e3A/npzX7tVoLy5l5BMnK29X078BY9M+GleH3JEYu/tH6CnZ3IV
 Kf0lZVmiPFRo1TBEtdFdhUmLCzvvJKg0neAkicxU9IfS+x44oHA8dUeKr83EHUPIGBRs
 GVPi9PkQRYQvF2bsj60Q7ze6HVry3aVfxtT7rz/QXRaH9TDcKx4xFN9WXSsJ3sUkbj5R
 HYrFpTaOy2Fqr+ckDLoaKC7WYUSsSLKs/h+oOjjibiFhbpV+7YvwqFoO07n9bWB7hLI5
 WBB7Ji1j7BRC90mca7aRWaL8jynIUmMApgray4N+3WRVggY5ikefOtQQjUzPBTGjKn4U
 dlCw==
X-Gm-Message-State: AOJu0Yx7VtA/MI1kRfun2pQL8RSxxwHuUeYSoasfAdKj4B3mnBpjGAPA
 hIeiz+qE0noVjpkKNb7GD1ltySV03LIRZdGuApQ=
X-Google-Smtp-Source: AGHT+IHeUhgzB8TyESLQ4ayr3flEJHCriNdgJwy9Ai3kmkRGopPNjsR2j7wIlkXi7056XrhVLKnpXw==
X-Received: by 2002:a17:902:f807:b0:1c9:e774:58d4 with SMTP id
 ix7-20020a170902f80700b001c9e77458d4mr3251622plb.37.1697207090276; 
 Fri, 13 Oct 2023 07:24:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jf9-20020a170903268900b001c898328289sm3944417plb.158.2023.10.13.07.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:24:49 -0700 (PDT)
Message-ID: <d87da02a-77dd-4ed4-9079-2ac2f34bbe14@linaro.org>
Date: Fri, 13 Oct 2023 07:24:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] target: Unify QOM style
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013140116.255-1-philmd@linaro.org>
 <20231013140116.255-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013140116.255-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/13/23 07:01, Philippe Mathieu-Daudé wrote:
> Enforce the style described by commit 067109a11c ("docs/devel:
> mention the spacing requirement for QOM"):
> 
>    The first declaration of a storage or class structure should
>    always be the parent and leave a visual space between that
>    declaration and the new code. It is also useful to separate
>    backing for properties (options driven by the user) and internal
>    state to make navigation easier.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

