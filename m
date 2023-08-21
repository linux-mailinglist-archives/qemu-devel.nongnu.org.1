Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B57782426
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:07:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXz0M-0001PP-HR; Mon, 21 Aug 2023 03:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz0F-0001No-Vd
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:07:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz0C-0007Kj-6Y
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:07:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso2724035f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692601621; x=1693206421;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yNEIf8ZGeq8miO4Wm0Cped+6Q7rVDUb6vBkbeGg/PT4=;
 b=paOJtDiMn72Q3Wj4R2AnJeBJsc5MYDRd0b/D+iI/nSjoBzltBShKXK5ltMS7Eudkyo
 s8iIOZsDD7B/XBjGlZPosjMIEOo/sj2SUazecobXAhv8h3Q/U56S3B3caHdBT2uP9tnD
 AklLCzdRX7Fdy8hDvp5fK0RtrGNKY8SRmhWOq6ruUNuuMjP1klsDgH1GTLLGYpgQHdSh
 QYRu3MUqc/a59wHJhiC4yLlemwya0JC9RYg6F6kCtaNqhO+Hp5KRQ2+uMs/fOTImc/Uy
 0/UiQz0uzyF0UBNv9f9Iu3D7IWRiRVZK5p/BUe/9ORDUy4Qziaamo0bNfvdDCNcZK7DZ
 rOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692601621; x=1693206421;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yNEIf8ZGeq8miO4Wm0Cped+6Q7rVDUb6vBkbeGg/PT4=;
 b=jQ+pId8FNsbV0OYseUUUCuWwHvrtkQRHZZY+LsrpBadlwSYGE2qTm6CsWqBmB0+bhI
 K71renol0ACGnPItZlRr88GakKxkSuGffblMUjEMcMuahaQZu2IrWJmY0zP2cBjPsrZ0
 NZzB+UCOe7WP38IU+r7pmhl+z70HxINnWQ/rml3HgqLJKXR3GD7LeBdnKzIS/gLdWlIJ
 Q8s6yRYE4z7fOuPEERHLuQToibeaeqMB3F7o4Y03uLB26AZR6sm4GqVchZfOZHSvwmqv
 oH+hcMcdxwujx8Iqdal3pfPbTrXvRUP1lVacb8WgQSlezo3/zoyOgo7TVKP8nPSWYYng
 psiw==
X-Gm-Message-State: AOJu0YxBvQ0Qj4bFxXNx6SgwHI64xzvfMuiBWvoyhMKl4/NHOdul86Yu
 VJroBDqyJe0gSeAYe1r3D8fRjg==
X-Google-Smtp-Source: AGHT+IEEIqtUH83sUO13iwbMUSMkZBDR37qIy7LpP5iYMWrRN4smJM2I66v/LBF7f+8gYmG1rxM98w==
X-Received: by 2002:a5d:6409:0:b0:319:70b3:d51a with SMTP id
 z9-20020a5d6409000000b0031970b3d51amr4107042wru.7.1692601621608; 
 Mon, 21 Aug 2023 00:07:01 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 q1-20020a056000136100b003180027d67asm11276003wrz.19.2023.08.21.00.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:07:01 -0700 (PDT)
Message-ID: <71f5dff5-28bc-2a40-97f7-25169fdfe714@linaro.org>
Date: Mon, 21 Aug 2023 09:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 32/33] target/ppc: Enable TARGET_PAGE_BITS_VARY for
 user-only
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230818171227.141728-1-richard.henderson@linaro.org>
 <20230818171227.141728-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818171227.141728-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 18/8/23 19:12, Richard Henderson wrote:
> Since ppc binaries are generally built for multiple
> page sizes, it is trivial to allow the page size to vary.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/cpu-param.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


