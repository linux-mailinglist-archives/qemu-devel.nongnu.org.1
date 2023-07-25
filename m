Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB55F762184
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:37:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMtq-0006AE-2D; Tue, 25 Jul 2023 14:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOMtl-00069I-NJ
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:36:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOMtj-0000Kl-Oz
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:36:41 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-666edfc50deso115991b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690310198; x=1690914998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gZAPlvPWYUTp4z9QljCKilDGvRoinPZYI6o4B5qGstU=;
 b=McfCmZQjB/PFhXCjYPS1gskKIZbowdc0exaQLDidVzuvSizYuRUstUsSqxTL7/q/td
 X1Nhyojmr+pBF+FtbLPg+wk4fbvTAA7ggqcBRwulUJ7j7YFyk5q7146CqjRDZbCBE6O6
 FrL7N4cQengBMQo73KYYB09etHwtOQ2+PC42fcygE9ltjVCBBTNLIgKSnq0BmMepTZSU
 aFfnHQL90daWnAcV41ySdmFUstCi3H+9ZYIasPCx5xyBOZ+yBUZbtojpdFyI1TUTMpt4
 TTBcTjkDTh1ACuUNCRfIn+uzCgpMr0ROby3ZhU21XB/geFCms46DXVgHTUKCIJsddPfv
 Gd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690310198; x=1690914998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gZAPlvPWYUTp4z9QljCKilDGvRoinPZYI6o4B5qGstU=;
 b=jZYLxUKOZebUs45MH75NETqRY5AhAcXCQAdtJ/6k2yAtOQvhVQK6BKoVEiepSPZoxW
 hGX39lKsXP3g1LKNwk2e19FhWe/kwh61M0YHT6sxJzamL+2oPFszMnBQTLtxG4JnzVYR
 Z11GNbwawEo+fjsHdzf8gmolFmJk/yi5YMG1sPwF5y57L42VtaPTk/VBfGUsm3COOqt0
 m3MpuARijxs1nQsVHSNbZB8TxE/2CEUWEqkdwgwIB5dInrjFi1s8B5M6OMRwg9G0lmXF
 zIiFYZwca/GC8mk9RZab2T1z/w8mbAGlHcWfdsTodufEvj2vyqby0abLyPnkAin1s0KN
 X6kw==
X-Gm-Message-State: ABy/qLZerehCZE2KjRO2+SWQwG+ViRccGpzBV6urMTMwTNPt16w08L7Z
 +78/LshL2go9hy+Bbm+o+96sCA==
X-Google-Smtp-Source: APBJJlFxkQCojDOAfcSSxALE3UweTfpCz6k1MXxqmZMYBQs+u2avu5qdhRkdpqvbY8uDNld7IPEtxw==
X-Received: by 2002:a05:6a00:1c83:b0:686:626d:71e with SMTP id
 y3-20020a056a001c8300b00686626d071emr23650pfw.2.1690310197754; 
 Tue, 25 Jul 2023 11:36:37 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:a083:fa5e:b91b:bcc6?
 ([2602:ae:1598:4c01:a083:fa5e:b91b:bcc6])
 by smtp.gmail.com with ESMTPSA id
 b7-20020aa78107000000b0066884d4efdbsm10324514pfi.12.2023.07.25.11.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 11:36:37 -0700 (PDT)
Message-ID: <36445f06-644d-c20d-beff-2dd7a8ac5d79@linaro.org>
Date: Tue, 25 Jul 2023 11:36:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/14] target/arm/ptw: Pass an ARMSecuritySpace to
 arm_hcr_el2_eff_secstate()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-7-peter.maydell@linaro.org>
 <230dd650-846f-7105-7add-43fa2d03dad7@linaro.org>
 <CAFEAcA---QdS2vo3iAivTdBVAtFz5qOaC9Mdy2AhvXWGyaO7BQ@mail.gmail.com>
 <CAFEAcA-za6cJvahgzNMXOZrMhW4REOfZ6HKJh5GwwutJDPmbzA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-za6cJvahgzNMXOZrMhW4REOfZ6HKJh5GwwutJDPmbzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 7/24/23 07:38, Peter Maydell wrote:
>> Does it? HCR_EL2 says "behaves as 0 if EL2 is not enabled in the
>> current Security state". If the current Security state is Root then
>> EL2 isn't enabled (because there's no such thing as EL2 Root), so the
>> function should return 0, shouldn't it?
> 
> I guess there's an argument that what the spec really means is
> "the security state described by the current effective value
> of SCR_EL3.{NSE,NS}" (to steal language from the docs of the
> AT operations), though.

Yes, that's how I read it.


r~

