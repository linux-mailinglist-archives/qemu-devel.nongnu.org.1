Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E978A75E161
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 12:27:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNWIB-00010Z-K6; Sun, 23 Jul 2023 06:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNWH5-00008B-Q7
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 06:25:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNWH2-00027T-CO
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 06:25:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fd18b1d924so25215085e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690107908; x=1690712708;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YxY36NOADPqaOYhhk6ngsMwJtVzS0Ybl+eCyW2my0tM=;
 b=iOxfd2c43d/q9wqcw925c503B4GiLUh4KPdVd0aX84+2wzL0Pyg9qXx8RfbkaxaTaa
 WFGHW2mBjzxdvOEjUraKuSlUMq4/nFhdQ74/enUuVw2eyqtKcuwUtSnTER2EVdSQNJMS
 Y9VVkd9WGtzF7DcfKdftMC73ovwsCQzYzOotrv9h+xiXQdnOqdUW3hPn4+/YVmX4PAww
 x9JkkqcL9AMeveSmm5i17iHet+SWFmO+aACam/y/PXgxQNAgapfLB+9zvl/MEltpNsDM
 FIeI/7AIp5d3aABMLIa8IaK7U2vmSdUphqEgf07UqD5ogE6ZTw7gHrIKshkJIGUURj90
 Tz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690107908; x=1690712708;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YxY36NOADPqaOYhhk6ngsMwJtVzS0Ybl+eCyW2my0tM=;
 b=NKopyatIqtKJwMmNQ2mF8VVCRxi81P2vwXAOpOHAMVbxoF88LldgRWXNljvLREO4np
 tvkX5RpUCTbWFBRbfWVfQCKf7EqR7KgbdraZrUDwOXDD0ifiAQOb9IEvVAAfYjjnJVN+
 AAZb9/IEDqNfeNNh06vd2oZWnaF5Tmn5B/VWCQ0ufAGiNzTXAp1iYTJqELx43vAevO8F
 kNiBpdn9yZjbu+ZllSS3pDlqe+U2gyqNgn7kXM4HUUMISQIohkJn/eQHXjxv05VirCA1
 oIJ7ppPCJEdZcYrLBn39n3y6DWSL4vyGIEK8fFMYX7slHnK+H2EGK/YgR/pFLARYfKE1
 PoZw==
X-Gm-Message-State: ABy/qLZO/MwcNu4XYpgfMPZnvL2v2wTem01Z8Nsl59CSKnTCl+JUvSpy
 QzsP6qtb5uT7PYyz608+M1cM4Q==
X-Google-Smtp-Source: APBJJlHpm7se6U0nrbOIKt2tvT8mgcNSbkPLKfH69dTxWDiUPb2x+RjM/uCpsYiW+ZOBQQ7+l31wtQ==
X-Received: by 2002:a05:600c:2198:b0:3fd:30f1:94fd with SMTP id
 e24-20020a05600c219800b003fd30f194fdmr1436106wme.26.1690107908283; 
 Sun, 23 Jul 2023 03:25:08 -0700 (PDT)
Received: from [172.20.6.117]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a7bc010000000b003fbe36a4ce6sm10193994wmb.10.2023.07.23.03.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 03:25:07 -0700 (PDT)
Message-ID: <557e0d94-a11e-f42c-213a-4260cfa66beb@linaro.org>
Date: Sun, 23 Jul 2023 11:25:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/14] target/arm/ptw: Pass ptw into get_phys_addr_pmsa*()
 and get_phys_addr_disabled()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/14/23 16:46, Peter Maydell wrote:
> In commit 6d2654ffacea813916176 we created the S1Translate struct and
> used it to plumb through various arguments that we were previously
> passing one-at-a-time to get_phys_addr_v5(), get_phys_addr_v6(), and
> get_phys_addr_lpae().  Extend that pattern to get_phys_addr_pmsav5(),
> get_phys_addr_pmsav7(), get_phys_addr_pmsav8() and
> get_phys_addr_disabled(), so that all the get_phys_addr_* functions
> we call from get_phys_addr_nogpc() take the S1Translate struct rather
> than the mmu_idx and is_secure bool.
> 
> (This refactoring is a prelude to having the called functions look
> at ptw->is_space rather than using an is_secure boolean.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 57 ++++++++++++++++++++++++++++++------------------
>   1 file changed, 36 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

