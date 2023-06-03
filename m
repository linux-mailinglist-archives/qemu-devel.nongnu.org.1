Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960747213D6
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5b6G-0002iI-Jc; Sat, 03 Jun 2023 19:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5b6E-0002hf-4E
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:55:58 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5b6C-0006zg-LE
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:55:57 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5341737d7aeso3048254a12.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 16:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685836554; x=1688428554;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VO3nn+Efhy/PPxtEp6iGNKsRUpm13QkKsc++JMgiLE4=;
 b=kpYCdV54z6ZAiLHKx/g01q3ZVgB7l0pR1gnCcBUPg0O/lSn5irLP0KJ+xDM2DDzftN
 kTTtxi4VSBc8D34GR7Lm4qpCt2dlFYOVHMvTyYYJtZ29Zl4oqVPRtURpBqBSH7cA5xdk
 f11MiV2797sQJ6LRz9dxKaQhoYdqgsch9ddX+RQ0CiDnYANX8P3VCEj/X2akBvKuajF2
 g4tw21mGahbvVwAeqUyu5yCFWGBZtIea9dU1C5Jy8el2qoAF7cVxGBzbKl4dKaSVXBIO
 ZmqNcWCNNF4oMDmcp1agjAQtFDkQdBXSe3oasZcoMejioDPYgtV95W39zcDM3q36RX6z
 oQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685836554; x=1688428554;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VO3nn+Efhy/PPxtEp6iGNKsRUpm13QkKsc++JMgiLE4=;
 b=NizLZVDHrX+vCWNqjFUBQczbzqyJfOm5T90tzZsC6fcH8tI+9/dh7jsuoFXnLqBfah
 LxCcGtdwx/nzLpGeiS0JN5T7MORHlGYPNbhIAN9YmhASOGuETY3xGsubVBaeCp9h1kQ8
 0xiPq+i1KC8NWApOx86aI+nbTBLR7ONzra23TYwYz5+RCt9aMH2yr6sP0frQqFrf1SlS
 dvNjWE3qcGCub/Nr8XaiK4wzPDhQeHHgZ/+tPc228eVSOyzsUP1y9hZDwlyYRaqLPwq4
 xdr6AXWg7eVChuKduU6auT6tzrDDTFBImcAo6ARABIiNWGmTlCe2cSVl4aDkzHcrbuak
 u1mQ==
X-Gm-Message-State: AC+VfDy79yBS8w9INwGy+Kp676gx61TXITQwURnMyyLuW7gpzSgDYMZn
 /5lkLvjZiD3YIuGUVDgGGfpdTw==
X-Google-Smtp-Source: ACHHUZ7ozIFywbO8gkcV98BFLSGkjjADk9pyj56SFRHHFc0xlJht1vnU2MiZ4VzZjrB4uQfbbDhtdg==
X-Received: by 2002:a17:903:22c9:b0:1ac:4a41:d38d with SMTP id
 y9-20020a17090322c900b001ac4a41d38dmr4206358plg.51.1685836553703; 
 Sat, 03 Jun 2023 16:55:53 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 be4-20020a170902aa0400b001a65fa33e62sm3708851plb.154.2023.06.03.16.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 16:55:53 -0700 (PDT)
Message-ID: <ec22784c-6a0d-f879-a3ad-be34b5d780d0@linaro.org>
Date: Sat, 3 Jun 2023 16:55:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 17/20] target/arm: Convert LDAPR/STLR (imm) to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the instructions in the LDAPR/STLR (unscaled immediate)
> group to decodetree.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  10 +++
>   target/arm/tcg/translate-a64.c | 129 +++++++++++----------------------
>   2 files changed, 54 insertions(+), 85 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

