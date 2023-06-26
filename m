Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E94A273D929
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:09:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhH4-0000gB-Pa; Mon, 26 Jun 2023 04:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhH2-0000bt-Gn
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:08:36 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhGz-00085i-OL
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:08:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f9189228bcso27291795e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687766912; x=1690358912;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XxgZupHl1qk3DwTusQScDzxDu5O+Mxr9SiRPdpVUlJs=;
 b=xbLqXZLmG05VDXLo0nTcn3rnhHLU/5TaRIEmdh7DDWVTRvQ9OHkc+nDNrjz/qHG4Kr
 wX8nZDDVeiYNHHnxWGfsWuB2a2FWZMvXMvmaOyVho9BMwxPHV8aWsKyBx3b1xI4xWlqA
 FA+CmOESuM71yHc2IX384A4Ta5ZfaNvpW8wcf7HLOfQnslzrnwsEEzScmT3Vo5C+yVDX
 6u9cY1admZ7AqF5/7L9dnG1lkhWr4ZtRIM4Qo1QkZAGVcnefr7Bod0LSECwOsqqytMzi
 UJGGTPsQzsgHKYpr0UIGjgmmuSc0ptXhaHPhICxl4UCh4eiaCk9EOhEhPFss7q9VEvjl
 fsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687766912; x=1690358912;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XxgZupHl1qk3DwTusQScDzxDu5O+Mxr9SiRPdpVUlJs=;
 b=BtwJJ6vKEDOMoxqdxs9fSe7Cos4Vx8ac0vMLp63y/nBR9awoBKpwLbUAezNTFUUUzz
 Zjh1pP2e5HxZnXFaOqYpSgoUqdqGFI3INfjHShMIRpIu19y2engvytBo0wLxCakAgr+1
 /axl16F/OmtWWCDATDAhvZJ1QgtY1YV4rPjhcCPPHP2y7NaaWhPtUCO8MwPAogMTztHI
 w9ZZik5rOjM+Kt1v8dVxI6Tt1Y6fPEo5XmCwHe85k8oO5AaaqcNnu9p4O1P1eeArJPT1
 feCAWpCmcAFThzK0o/2hrD4Rp5zqpowavJ7J2MGR9quMxyr5IQm0mg1hX28cxUoiAFAe
 Xh7g==
X-Gm-Message-State: AC+VfDxmhBdrPGKdQbQr5V6j9ID9xiQJazaYP54vUwNN6WyqLj6Rd2Zu
 4fOMGXD5aWVThqa3aezyF31O1Q==
X-Google-Smtp-Source: ACHHUZ4Ebk33Hk75zOMtQ8+kbLAaOI+FjO6Tz6c/dmbOW3O+lYAJcCzj1RZL0Bn6f6lKtKLifPHY/g==
X-Received: by 2002:a7b:ce8f:0:b0:3fa:78df:1ca6 with SMTP id
 q15-20020a7bce8f000000b003fa78df1ca6mr6497915wmj.26.1687766911874; 
 Mon, 26 Jun 2023 01:08:31 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a05600c214400b003fa95890484sm2404349wml.20.2023.06.26.01.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:08:31 -0700 (PDT)
Message-ID: <2c8b114c-ba4f-268f-1075-35c6dfc8dd73@linaro.org>
Date: Mon, 26 Jun 2023 10:08:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 12/26] tests/lcitool: update to latest version
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 14:20, Alex Bennée wrote:
> We need this for the riscv64 and gcc-native mappings. As the older
> alpine release has been dropped from the mappings we also need to bump
> the version of alpine we use.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/alpine.docker | 4 ++--
>   tests/lcitool/libvirt-ci               | 2 +-
>   tests/lcitool/refresh                  | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

