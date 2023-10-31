Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B887A7DD67A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:03:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyy-0005BO-9F; Tue, 31 Oct 2023 15:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxtys-0004t5-Ux
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:51 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxtyD-0006Cp-Hb
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so16263595ad.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698778795; x=1699383595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aen/Wq6t6Uqky7PRziuag420pllaMNiYFb9lBfAknxM=;
 b=CvUxaHvDO+aGq91zyJEJVyZWKKHtCjB2ToSdnQ9yjZNxEcs+eCS9c3zpC9jWEBUdTv
 BbApKNP4n4nJ9i/dsy69tNdL8T2BWODjK3OXs8cvEVIR6whsn8AQXc22GTVf938f+b5w
 ODKN1nvXRttTyzDY0HMUuV+2+HZ3I87dBHuedQREwM/nvMJiE+E4vlxZzyLWZMMxh+48
 ooppYWuNG47HM0UzyzHvVVbzdcVxvSyyjJos+vxaPvP2SNfvt+pqg8eh1iSzYifv135+
 5p5E5/+kNFbD/Ln7sxIfx8Sla+lwO68pUoSHPCm6FD75mYAbFWPzLJ+xN6gXfsRDLR87
 JqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698778795; x=1699383595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aen/Wq6t6Uqky7PRziuag420pllaMNiYFb9lBfAknxM=;
 b=lfso6YzPWAslYwXg1QC52s03KS51dpGqpkd65F7fDVHNtKYlXI6FEaIDLq58j36ssu
 KV5bLqwXzLI3Esss6i0hT4MSsn9ZaB8tI7GCGDcsQBefmx6XVgCDaeQChbxk0b+9c90k
 74AU+d71K6rK38sCoQrGL6/5GeTFXTTGEEvRv3b2EZbduagP7djAbP+D6wP8dqFDRvcP
 7vBgosGIYOsORZgQEJRYMxvBKV9SylaFgaiqf5DuX21lJengZjemrzyhG1lL8QsHxXzx
 2Vy9SZKLfDkiAj4Jm55VQH/z0PIwj5ZsqVtRDy34jJMPyuMPNh77tbQ9RelcoQpawiY1
 LE5Q==
X-Gm-Message-State: AOJu0YyrWSSXyr0++17xd5I880n7NXiSNdCaG5LcgdDbx2gdmuu6pNFH
 ZPWFOPCmjeM4D+BFhfbxn5YmXg==
X-Google-Smtp-Source: AGHT+IHIXIM9DOEG6eDn4uxynlLIUtHzYlr9EbLcyQglsNTovD9jNacyEtVHTkpqP7TmN4gfejdkQg==
X-Received: by 2002:a17:903:246:b0:1ca:2743:bf79 with SMTP id
 j6-20020a170903024600b001ca2743bf79mr17502836plh.39.1698778795097; 
 Tue, 31 Oct 2023 11:59:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a170902eac600b001cc50146b43sm1641825pld.202.2023.10.31.11.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 11:59:54 -0700 (PDT)
Message-ID: <1c4e36a3-8092-4cec-a2fd-aea4a84a1ed6@linaro.org>
Date: Tue, 31 Oct 2023 11:59:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Correctly propagate stage 1 BTI guarded bit
 in a two-stage walk
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20231031173723.26582-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231031173723.26582-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/31/23 10:37, Peter Maydell wrote:
> In a two-stage translation, the result of the BTI guarded bit should
> be the guarded bit from the first stage of translation, as there is
> no BTI guard information in stage two.  Our code tried to do this,
> but got it wrong, because we currently have two fields where the GP
> bit information might live (ARMCacheAttrs::guarded and
> CPUTLBEntryFull::extra::arm::guarded), and we were storing the GP bit
> in the latter during the stage 1 walk but trying to copy the former
> in combine_cacheattrs().
> 
> Remove the duplicated storage, and always use the field in
> CPUTLBEntryFull; correctly propagate the stage 1 value to the output
> in get_phys_addr_twostage().
> 
> Note for stable backports: in v8.0 and earlier the field is named
> result->f.guarded, not result->f.extra.arm.guarded.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1950
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 1 -
>   target/arm/ptw.c       | 7 +++++--
>   2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

