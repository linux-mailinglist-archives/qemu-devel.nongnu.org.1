Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A027F78486D
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYVCK-0003wO-7h; Tue, 22 Aug 2023 13:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYVCH-0003vg-OP
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:29:41 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYVCF-0007nx-JJ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:29:41 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6bcac140aaaso3710990a34.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692725378; x=1693330178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lOSaxhtBnBz/dJyvMUDjD3b5ehKYenH5v3B0R0PeJLA=;
 b=PGUhei3Tx+hoOK4RpKpitdyx0jqD4X6Y9UTaOCG5XgQmtWF3a5wCDRe79wB86bD6/Y
 P0wE3B4aWNyWdKN3WU4fKcoOCEeU8Ey4+nUl+5N4neoTh8TR9LzrNi0CN1Ehkg/75gK1
 AgB722rIk5WdGCwgYFIrYHfHH10oqryC26pFDR0JNa00KOdFWqb3Aw/BVhJaEo3qQb3H
 tzdjw4LearPuwoWCmzW6bIXtYGYmT0W+f2f4bft1Lb9BBtVXtsjnxtNm0YiwkNdcsK6j
 HnbCt4+Xgo9xMegkNlT6e/jFzt3Wri6EKa9y1pXQmKSDbLf08P8U9GDLDowe9G0FdlWt
 9MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692725378; x=1693330178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lOSaxhtBnBz/dJyvMUDjD3b5ehKYenH5v3B0R0PeJLA=;
 b=WmxHLMV/H0Gm9ycNzeLtk0+vEyO2/yMeIglGqdZCQwVszCN5mVhGxxFjIXFEgZ4JgQ
 V4Yw4Ad0I59C32dB+qD5M5DAcYAiiPQt0HF8gSjTAqqKsGpA7gk6i/GNhY1sYaUm5n9H
 k6y7qrtidUbbcUBCfHWp1gRODCDni6ergv79AcjoK2VkF9GF0D7KysODaXq8xpDFbcb/
 NA/iM/sg6WOJVf+mic+JssJQ+HWxRf72agw4Evu8SxtX7lVKppiz+Z1217OpjVooG0Pn
 /LEFbtg9nAv+5SlL36mZ6BWKx6v9lHE6d/hCfGMVmRP8NcZas+sGjFiXRQWYlmtgIQYJ
 MK9w==
X-Gm-Message-State: AOJu0Yx2vorZv04kpN77DnD0fIf9+9iRIR2E+usyKiFFerak/3TT4dZL
 JgwNlnMHZLmlOVcc9zvhnhhUjw==
X-Google-Smtp-Source: AGHT+IGYGy5+64WU8xN7iqBtLKoI5F7HPWylAkf7aTT9tpvfcweIVmmf+pPsQU8uqNeWamDNkT83/A==
X-Received: by 2002:a05:6870:1689:b0:1b7:38d1:6f98 with SMTP id
 j9-20020a056870168900b001b738d16f98mr12964809oae.38.1692725378195; 
 Tue, 22 Aug 2023 10:29:38 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 k125-20020a636f83000000b005641bbe783bsm8114796pgc.11.2023.08.22.10.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 10:29:37 -0700 (PDT)
Message-ID: <408ba512-b15c-5284-8598-6653293a8f51@linaro.org>
Date: Tue, 22 Aug 2023 10:29:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] tcg/tcg-op: Document bswap16() byte pattern
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-2-philmd@linaro.org>
 <c538a498-05e4-23ed-328e-7355436f6c7a@linaro.org>
 <09f4ba68-e7f3-8a90-e996-e475b760c64a@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <09f4ba68-e7f3-8a90-e996-e475b760c64a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 10:22, Philippe Mathieu-Daudé wrote:
>          } else {
>              tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. (IZ=0) */
>                                              /*       .ab. (IZ=1) */
>          }
> 
>          tcg_gen_or_i32(ret, t0, t1);        /* ret = ..ba (IZ=1 or OZ=1) */
>                                              /*     = ssba (OS=1)         */
>                                              /*     = xxba (no flag)      */

Clearer with xaba for no flag?

Otherwise it looks ok.


r~

