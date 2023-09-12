Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6EF79C14B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 02:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfrW8-0007Hu-1R; Mon, 11 Sep 2023 20:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfrW6-0007Hc-IX
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:44:34 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfrW4-0000H3-AW
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:44:34 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6c0f3f24c27so674605a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 17:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694479469; x=1695084269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JDj6F2QGCGRwgb3/P2Jxn6cxLh+sKtMvE8mZjIgL+DM=;
 b=fdQZPcwzEUoiyFUkFfEM3crt0M6mKNISP/F5nzYorKAhWi9Ca5cDUnhvytg7oHjCvC
 RsS00hlGG0U8BVyF60M0Bc475NV5GVu1Q0GEeS+wk41UPDtDkrw3Wys3ji4X//wzh4xv
 IZ/BPnxu9qibz0COP3VC/pfUeV0NgEV4ax95GShQoghKLC6Aa1mh90qHOG//klt9p2Tm
 bktFSKfmj3iZG0K5ST9H/ZYPFgyIKdzgnRGfPs/wP05mh/LEipWg7tZCeYrT7DyXTvW+
 H57MfNclsHVoIDjhAJ28kn38rES8t/L0e65Pndj2sX8sQqvI7GylDkzv3FWiy/IZg4RP
 QhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694479469; x=1695084269;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JDj6F2QGCGRwgb3/P2Jxn6cxLh+sKtMvE8mZjIgL+DM=;
 b=E6gCI/zwZStQ+OSJXBGPz4xuksqmi6wlzivc9/lR9kgDd5vRtpRFh3Ac87oOD/vOVK
 bqbRtz6X8vUznVKt+sW7Lijn6gMIWYlWx96j8RxA4r5/HYoBm8B4ypUhStb/OWKKkbsz
 V6rrqeZdKflutbjeq+nZHccMcut+iVR0+UZdf0UaUVyy4YZjAkDdkXcWF748jzZvInuJ
 szvUEk4SviFccyYIOTTfXh4vHk1QzP31ITaq6irFewqgqEP8LqSmrXh5D8d/N5IFOht7
 7VtssRtRGy9kJI2G4T0en1tFYebK2UKMn7I0bZWY78kGu8H7bGahoefccCL2V+saFKHp
 Qa4w==
X-Gm-Message-State: AOJu0Yz0U9d4uy/deSaUEN7UWx3pj2CD7Yyf/N8cqQd4j0WdwB0D/GJh
 8pZSYWpWGOQCuPG7Ti0hbV5KjQ==
X-Google-Smtp-Source: AGHT+IG4TdgLHJF+WTlyw2BDcwlTqizN6yr1vczG43UiKyspVR/SH3KVMiAl34CLExNztgGEEDaVCA==
X-Received: by 2002:a05:6359:8086:b0:134:c279:c82a with SMTP id
 re6-20020a056359808600b00134c279c82amr8839239rwb.29.1694479469404; 
 Mon, 11 Sep 2023 17:44:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a639854000000b005579f12a238sm2256800pgo.86.2023.09.11.17.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 17:44:28 -0700 (PDT)
Message-ID: <818ac358-dc21-34eb-7c79-e8c254bb2f12@linaro.org>
Date: Mon, 11 Sep 2023 17:44:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/7] target/arm: hwcaps updates, FEAT_HBC
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230911135340.1139553-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/11/23 06:53, Peter Maydell wrote:
> Peter Maydell (6):
>    linux-user/elfload.c: Correct SME feature names reported in cpuinfo
>    linux-user/elfload.c: Add missing arm and arm64 hwcap values
>    linux-user/elfload.c: Report previously missing arm32 hwcaps
>    target/arm: Update AArch64 ID register field definitions
>    target/arm: Update user-mode ID reg mask values
>    target/arm: Implement FEAT_HBC

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

