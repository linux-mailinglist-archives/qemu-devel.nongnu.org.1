Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B10708447
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeyt-00082x-Mn; Thu, 18 May 2023 10:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzeyr-00081n-FL
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:51:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzeyp-0004Ld-L5
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:51:49 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d293746e0so317842b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684421506; x=1687013506;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwn8MptXNXgqSG/8dysX2UF4t5Gh6nt+JEUkNm4s8Yc=;
 b=r7iYq3rP7i3FRn2wU++S3asAx57BiCiXM2N3YWu1TulLSmR+jI9C2ceSXescs7lZ5N
 dm5AMoqeSiXWipR4qb9OL724ImxXTlU868sgsjAtJwFRhu1Qzrk5XT3qMaps33CWHTKl
 0YE/rqdGUnZKaNSvFE/iF6dGBv62150eYOfp25o1qszloeSYVeCAyUVfrOkKJvWSRAsO
 t6A8G4m9iG4GUv7NO+rFA5N2fCxXxwx1XI/QitWkkzjCCrggZ1T+AG3+5WumjNYS3X/z
 bGcrfQWamnvyPcvov2a3S2txGfyXnHDl/VrXCkewkDQRsxXyueauXcljuSPSezP5PHP2
 68Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684421506; x=1687013506;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwn8MptXNXgqSG/8dysX2UF4t5Gh6nt+JEUkNm4s8Yc=;
 b=BIh3hn7hycMS/XrfemSwcP6g+5kMC4hP3JBe7l7TJT8ls5Y0WKSdJJktHg7T6NGeKj
 C6JVO5VpHJYV1G/G5z1dGydP4xsSPAkjSJsJb3ovOQQl3pzqgmCxQ1oK+EaVlpj7AsC9
 qd0JRkzBvZMrjUoNt+KtTYUT/mGnhBQ6UbXjzgE377s5E73pN2Oy2vkGPRcIBUardNnX
 PxLEwAjqAJ/Y1IPlBwYEaG7IENtezeq1BHZ/4GKyDLMIaqQzaP2B/cEQGzzAA1MQzCHG
 Ovkg3AozaM87Wupc4XzFg8I2TYtc8bCrgL4sH7li/4ebwMALuek1QU2SEOAuMDOhaXGZ
 17KQ==
X-Gm-Message-State: AC+VfDz9rU+LiauHmH0hX0fZi8YrWMGKalHNZyJpVgQT87hdRftObzOz
 2QgDvaf0eT3UxI+xlNAdBNozbV873hW4UK//ffA=
X-Google-Smtp-Source: ACHHUZ5LYgOI3WtS7R+ObLjvdeMMHrn88x1kXAN979aC5bmWVZPuV8Bnw29kio4fLHx1WEVRAFKMJA==
X-Received: by 2002:a05:6a20:431d:b0:104:3c82:38c0 with SMTP id
 h29-20020a056a20431d00b001043c8238c0mr2745076pzk.41.1684421506173; 
 Thu, 18 May 2023 07:51:46 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 u14-20020aa7848e000000b0064aea45b040sm1429062pfn.168.2023.05.18.07.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 07:51:45 -0700 (PDT)
Message-ID: <8a9a7fa9-ada4-f793-804b-8bef1bc07457@linaro.org>
Date: Thu, 18 May 2023 07:51:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/29] target-arm queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230518125107.146421-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 05:50, Peter Maydell wrote:
> Hi; this mostly contains the first slice of A64 decodetree
> patches, plus some other minor pieces. It also has the
> enablement of MTE for KVM guests.
> 
> thanks
> -- PMM
> 
> The following changes since commit d27e7c359330ba7020bdbed7ed2316cb4cf6ffc1:
> 
>    qapi/parser: Drop two bad type hints for now (2023-05-17 10:18:33 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20230518
> 
> for you to fetch changes up to 91608e2a44f36e79cb83f863b8a7bb57d2c98061:
> 
>    docs: Convert u2f.txt to rST (2023-05-18 11:40:32 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Fix vd == vm overlap in sve_ldff1_z
>   * Add support for MTE with KVM guests
>   * Add RAZ/WI handling for DBGDTR[TX|RX]
>   * Start of conversion of A64 decoder to decodetree
>   * Saturate L2CTLR_EL1 core count field rather than overflowing
>   * vexpress: Avoid trivial memory leak of 'flashalias'
>   * sbsa-ref: switch default cpu core to Neoverse-N1
>   * sbsa-ref: use Bochs graphics card instead of VGA
>   * MAINTAINERS: Add Marcin Juszkiewicz to sbsa-ref reviewer list
>   * docs: Convert u2f.txt to rST

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


