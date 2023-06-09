Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D8A72A206
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:20:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ghf-0002jF-GN; Fri, 09 Jun 2023 14:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7ghd-0002im-8Z
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:19:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7ghb-0002AC-RA
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:19:13 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b2439e9004so8655695ad.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686334750; x=1688926750;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vj9qLPTAFB5HpMrexujty68fWg2vGI4QLTTfk+cGxg8=;
 b=iRziXdzW75n/iV0y/+4ZytZf8+oNfM5ZIcYGEjWJOs9iWoc/cEtwkdf3+ugw+lzNG+
 HipeH/vGIKEO66eyzrfsW84hnDdBKTHcvGjJ9+rXjiAu55PY2vVVG4TFAhucrXsmXRsZ
 /vbq9VXy+5UeECynIcRSsT5lqrMUzhRrqFCNE/Fm2XjRrorQn5IGJa7nN6v/OzTKqD90
 8qQVxvqhSGbmNC/90+mgj4CwQiPQKplveSCBbuAb99pZCIpktiWFAKqItB1tLsC1mALT
 CY/DfSKBJEKj4J9HT+zGWKzlTWmxoBaj4kfLri9y6RvHkCNR9qHHyQ4r72FIcqzaKoSQ
 CA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686334750; x=1688926750;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vj9qLPTAFB5HpMrexujty68fWg2vGI4QLTTfk+cGxg8=;
 b=Dx3mFzE5Tk5nTFNJZ0ye26PIOeGmNxqldhsPxSnAkUEhno49NqJpKuTRFmMuGS5NUi
 HxNmwgZrjrLn2MLxEZu6afOR3gEThUtaQjh4cXZRg4kRdp8xPDH0GQskKjh7WRBO3xxx
 eZ5YACVvsLz0Mb61Mc+POrF14SEACPcIet3Ah+65E0T087w4QzFJoiEPU+pBjwSYFEXA
 ZyUaaX8G7xTre47HhCSRQ+n6nLd3XQNshqCT0QX+4cpJ/KCa48FUT1F2KbgBy/vla2fe
 cnKj6zYtrksxObUcUy72UCDONCvZojD+uMRbw6jpamVOzgpGWsKmHSo8C0IJ5EfEeiVi
 Gnnw==
X-Gm-Message-State: AC+VfDys1CuDYCx12ZmpvmeEXWiYnAHDnSGL5JjSqHox831XP76FgRXD
 xdbY9yWWEmro/WW+2HPCVF+T2Q==
X-Google-Smtp-Source: ACHHUZ7aXQDoR9x5AD7GiyXkcDH509EKV0jl4j5l5WDCBkUyRXaWPOd0cDmA3wY4evGIkvonqB/22A==
X-Received: by 2002:a17:902:e5d0:b0:1a6:b23c:3bf2 with SMTP id
 u16-20020a170902e5d000b001a6b23c3bf2mr2357187plf.10.1686334749807; 
 Fri, 09 Jun 2023 11:19:09 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 jc22-20020a17090325d600b001a6f7744a27sm3586141plb.87.2023.06.09.11.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 11:19:09 -0700 (PDT)
Message-ID: <a54137e1-d34f-32b0-78ed-c05b0d33e428@linaro.org>
Date: Fri, 9 Jun 2023 11:19:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/22] target/arm/tcg: Expose some iwmmxt methods in
 'translate.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
> Expose a few methods and variables before extracting iwmmxt
> code from translate.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/translate.h | 6 ++++++
>   target/arm/tcg/translate.c | 8 ++++----
>   2 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

