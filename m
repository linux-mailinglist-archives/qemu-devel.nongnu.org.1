Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70160799137
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 22:46:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeiMN-00037r-3p; Fri, 08 Sep 2023 16:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeiM8-00031u-Dk
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 16:45:32 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeiLt-00054f-8E
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 16:45:32 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c0c6d4d650so20688155ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694205915; x=1694810715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nit6PVV2MFQq/HTG06CnL5wGGirI//SCGqDSbpqVXKQ=;
 b=mfIq6BHUc5KzcDfYxAHGI1WCBgjQvVRHK9zWKgBpcPNFGz+mi196etRxsNxzYJ9hE4
 roXVOFb0CkHkeMOurOajz9PGfjzB9kL0gLqXqa3oL/GOWJDg3M4NtUGM9uZ3SbXa2HJy
 b9AqFFaRW0e5h40JxgEhO9Tis+Xch97Z5kZvIHDIq/rzOrLvrNbGy/gu+5tUtEt3AM4L
 uU6Vd3AFaTf8aN4mvldABVcVrHzgI0GPqbgLMlT+wPbgFnSDxDRRVf9ekPa0aSNK/L3a
 4WbabiXPMxqqGiVyBKxjgN3N3Heqngy7rWvrHXo/Mw1/Yoong5Fz+PcPp/8DbbaDvpaM
 dQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694205915; x=1694810715;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nit6PVV2MFQq/HTG06CnL5wGGirI//SCGqDSbpqVXKQ=;
 b=tkeWsRzdVTs9Nv2QOBjiepny5mrnXsRz4/GDlGPFvT0IjZLuY5bgCIFheyhpzmW0UW
 25UPbDXjQsaBWtSH42fpaG01XfpS0vX2StC5G3OrDOrIQBqLhGSxXOGyBy1IvNx9tW7T
 ahm+0mIgfg13FaorpHfwXYpQ/2GqYGdC3yPR9CyNA1ukVBfLVbEUbCRBKOVX/EObrlMC
 ZP5wxxHgDOI/9xnyCoyFELgjHqYEHn5oDqxHkzlxz+mjKqxxuJRyxCRP81XcpVrihLi2
 J8jVD37rWHdqIYpV0QhKEG43TaOy/6kkkSeTthihKVR06mgxOsa0TQmxI0Y237Ybtft/
 Y60Q==
X-Gm-Message-State: AOJu0YzmIxy0FDURm3ZaU3SDrm92fLsm4kQ3ucLJPKKTdkluwhNRpLik
 xQwj0av3tcy+yV46kW+kDDGueg==
X-Google-Smtp-Source: AGHT+IEA13j7OPf9ol/flz9qefCrKQNm7BD05OKyKGMoZiaBxLu3PJBvqO7ObMCZ3d7ZoKd77HdxWg==
X-Received: by 2002:a17:902:8ec2:b0:1c3:90c7:b99d with SMTP id
 x2-20020a1709028ec200b001c390c7b99dmr1307352plo.41.1694205915222; 
 Fri, 08 Sep 2023 13:45:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a1709027c8c00b001ba066c589dsm1972437pll.137.2023.09.08.13.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 13:45:14 -0700 (PDT)
Message-ID: <0ad4178e-3a94-0944-62be-8f98f03b6136@linaro.org>
Date: Fri, 8 Sep 2023 13:45:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 05/14] target/arm: Pass unpriv bool to
 get_a64_user_mem_index()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/7/23 09:03, Peter Maydell wrote:
> In every place that we call the get_a64_user_mem_index() function
> we do it like this:
>   memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
> Refactor so the caller passes in the bool that says whether they
> want the 'unpriv' or 'normal' mem_index rather than having to
> do the ?: themselves.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I'm about to add another use of this function which would
> otherwise also end up doing this same ?: expression...
> ---
>   target/arm/tcg/translate-a64.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

