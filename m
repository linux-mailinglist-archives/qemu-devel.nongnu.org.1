Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A978782905
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:29:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY40p-0000SG-Uk; Mon, 21 Aug 2023 08:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY40k-0000Rx-Jy
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:27:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY40i-0001uX-Ae
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:27:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so30753215e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692620871; x=1693225671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c5AsHork1Kqem5QnDyAcfdk2jG4gWf2y0zaLNmFXP3s=;
 b=f2GpCajC5ovl2VizaeFvfaszmpOHkT30IO+l1DfSzjsIUnVIw4UPqIWkQxWgk/B6Rj
 ZYflbJRA2P3PwU68mG9HLcEhLs+6Q04ifV0OfFIrcpAul7xzpJjqfqo0kEuKv4anVWOL
 1zzytSCURfB6C0iP4i+B97YT/FhIQgOdxhds1EvKrB9VEVwu9blT5iHr9GxjXvEuwivh
 b0y8Wv7IYJnOmFwAXEGZlbK1cFlyMtIqQ/chPP4w0uW+nqzNxuk8odEFa9mwLHRv81Au
 fHIPzphG6OhlaZf8Y8TflmRsOOWqUf/AYREQgOHyCPy4geHNrrt8Ix2eUZxI30XJxTeP
 8RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692620871; x=1693225671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c5AsHork1Kqem5QnDyAcfdk2jG4gWf2y0zaLNmFXP3s=;
 b=IN5D6wlhuRpgRnkMYHUYzCgvw7L0AX0MrihPBHn2E6n9G4yBzL6X9Qd3cQaa+wmUYI
 UEIaRZbtcNB1HrxgR9g1Cs7j/v6A9zsH8ZCHr0gShhoXddSpL9CwFK7UYox+Sl/BYoM8
 MXSPMM/Gz4pp5xsFuQKeBvq5UUG6n29mlMkjSEqQ5DqqoQ20jLzJoVdIe1SC3mKYgsbm
 e1sH/qvSHKKzyMQOTsEX4j695a2zomAN2cNB7tcT3GGc2ifItEyHwrbj++uRI2i7DLvP
 Wjr4y2Khk/mHy0av5wSBqCRh2HBDTwjGdzi/SMCnHxLx+PZn0IgeLegIKlwbhLrpKe/T
 qTXw==
X-Gm-Message-State: AOJu0YwujE/Bb/ZyRk9v13fiyLVXv6CdfzhTfCpqhlweZ2MLb+DCYf8Y
 mU1i9j3vxVzQBXeILaX+bskFlQ==
X-Google-Smtp-Source: AGHT+IHzCiscUzRrsWGycPCEdZ2qeNyO+Y+hplEmYMRw1wtkAdOydUYqyuR8/ms8D0/+Iek5gcdXmg==
X-Received: by 2002:a1c:4b09:0:b0:3fe:d1b9:7ea8 with SMTP id
 y9-20020a1c4b09000000b003fed1b97ea8mr5104675wma.28.1692620871140; 
 Mon, 21 Aug 2023 05:27:51 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 20-20020a05600c025400b003fbb1a9586esm16058721wmj.15.2023.08.21.05.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 05:27:50 -0700 (PDT)
Message-ID: <5b109694-7694-9fb1-91ba-637089268c92@linaro.org>
Date: Mon, 21 Aug 2023 14:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 14/18] target/arm: Use clmul_64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230819010218.192706-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 19/8/23 03:02, Richard Henderson wrote:
> Use generic routine for 64-bit carry-less multiply.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/vec_helper.c | 22 ++++------------------
>   1 file changed, 4 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


