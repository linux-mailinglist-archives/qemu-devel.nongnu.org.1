Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F699782381
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:17:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyDi-0000vZ-10; Mon, 21 Aug 2023 02:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyDc-0000uB-AC
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:16:53 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyDa-0005xS-3L
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:16:52 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5007c8308c3so1182856e87.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692598608; x=1693203408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QJG/bVctaB73SZ3XBbD+fwKH4Wsku5szXDUxPVYYZ4Q=;
 b=F6lqVZTShxkUofHHv+mTe4An4ih0uuDOdi02I6IMxr3HymxpykcLQ3GDGxdoLkPR4x
 rs/PpzPYbvnuxqNTtwSVHvS2aMc1mYTpbedBS9alQ1tYogEz3gPgfqFM+sqbwSTd2iUg
 vZL0+1z5GSxAq8S/UiSzAHd4fjlnlDsas4xXhHxhqiiB2n6uiNexOmSSOGk32+6f4f6J
 eONsaHSYMcfBAXOn08yF//uk5QaYfR4ofMW1GgNn/fW7d3td857E/k+WTQVtZHikjzPT
 P3lUUofbODbjSFnuZpfXl5KXgYYeKmgyzX8z55el5+j7xsILdJgWwAW3WBSK0T0UhMLl
 IKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692598608; x=1693203408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QJG/bVctaB73SZ3XBbD+fwKH4Wsku5szXDUxPVYYZ4Q=;
 b=U7GdYzdqriPTll2WgR5msEUs7EhIfGYQ7BMkO3TwVQaGVulIb020n6b83ocTnhGok9
 PbSdJv8JUcEsiQp5H0lO7Xp2IWifmXiI8wwQmCDT5ET3cIUSze+FQfVnK3mBNTwXxV/g
 zhanLFJw5wKJf/OgmOJ436Fs+LOs3WbOwU29tbFto/Is3vFoCOruld6MFu5dTQS/aLLl
 IWjSt4GAdVsjtKdV0qvvcBk3WAC1mlZcUCwO2ClAsgOnqLoe9gRe0dC9BiMUdziqy+cA
 lpsr/oh7gWtBIs66DROzef6VtQZdp23uLboyv2cIEjFcV7IugKqtljVi2+Gqq+USVtlO
 i3Vw==
X-Gm-Message-State: AOJu0YydvOSXzbIRzzKTljvklYC27YWKNNAcWhWKxmb7LlynvdcfD9xv
 nMcQpRAHaeFF3m81K5hY+gc6U844e/DUBqmgnG8=
X-Google-Smtp-Source: AGHT+IGR/U3nAlT/lzgmgrbrSv+ixQMiiA8oHyRkqESlYGiYIGgzBrgnKDhqrctNkmlagy3uRvUDuw==
X-Received: by 2002:ac2:4985:0:b0:4f9:51ac:41eb with SMTP id
 f5-20020ac24985000000b004f951ac41ebmr3133790lfl.16.1692598607664; 
 Sun, 20 Aug 2023 23:16:47 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 p20-20020a1c7414000000b003fa8dbb7b5dsm11477231wmc.25.2023.08.20.23.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 23:16:46 -0700 (PDT)
Message-ID: <39c0089d-36f9-aae0-e9b5-9a64979773c5@linaro.org>
Date: Mon, 21 Aug 2023 08:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] softfloat: Handle m68k extended precision denormals
 properly
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
References: <20230821003237.376935-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230821003237.376935-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 21/8/23 02:32, Richard Henderson wrote:
> Motorola treats denormals with explicit integer bit set as
> having unbiased exponent 0, unlike Intel which treats it as
> having unbiased exponent 1 (like all other IEEE formats).
> 
> Add a flag on FloatFmt to differentiate the behaviour.
> 
> Reported-by: Keith Packard <keithp@keithp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c                |  9 +++++-
>   tests/tcg/m68k/denormal.c      | 53 ++++++++++++++++++++++++++++++++++
>   fpu/softfloat-parts.c.inc      |  5 ++--
>   tests/tcg/m68k/Makefile.target |  2 +-
>   4 files changed, 65 insertions(+), 4 deletions(-)
>   create mode 100644 tests/tcg/m68k/denormal.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


