Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B870DD2F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RjA-0005ID-EA; Tue, 23 May 2023 09:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Rj7-0005I3-M2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:06:57 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Rj6-00016a-1k
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:06:57 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-25376483f66so3598021a91.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684847214; x=1687439214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bd2q2kUn/yW3l2Iye9+GaqXLtxlBnvcKADELKNty56I=;
 b=AWFo4OuvbeiDr2KXRalYroVAi5ix/rlZSAL9RTvqrvVK2dF029SLR7PMeAE15dkEUP
 QZXibBNxzRNrP5zkmdheTm8To5EOaDxLighD3j8+6IFhqjU9Tn2c4NWjpFpaTf4Ii5Yr
 2hnCBILuv7srUX1TWALtGXy5xTUuIgGZTM9WK7sVFvW1EnOm8zMCojzskM3Djwq7khEN
 DAP37p+9bbYZFCwsjmWbcfblvKb//hnOfKVV0ydysENbkwwGvyzl+r2/VyeJ/pVACz5D
 UTamlPuxQciRA1KZ4UMiDUyVA/Qw6pk11hnJBx5RPZLDCvHVPwQMW1LmFMbB7itVOWPW
 HqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684847214; x=1687439214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bd2q2kUn/yW3l2Iye9+GaqXLtxlBnvcKADELKNty56I=;
 b=aH0LTh8UmUL+a6ae3sBUHp4PkCu5kyTlBPUl2eJkH2Iw/nbPXyLh64tqc86WaoGo0c
 j3YVoUqfABCzpQeNif2X6OOD2mexZY7Ftx9dt+f0Ajug3GyKitk21k7vfjoAgHrjJdt8
 yr+cnT0jxlHHSO2l69EWH0As9nMST17dG0O4xVXY8K/l9YAkxv6HYM0FH0WenjZ/9sWZ
 bDODq9eH9/G54E+dRZfMTn+AkR7aT5y3OTq/0KV1anq2FVTVIHKOw48Czv8psmghreDC
 rm2FwEsYhmcHNrvS9GYYhrfwLC42Cd00B/JxGWu4PxVRHHT4wblIJhCbs9TD54WQEnhI
 i7qA==
X-Gm-Message-State: AC+VfDwv7XvDO5ygT82IgP1O2FVLUdbTwQOtQo1ANiK3CV8xqqmoxkJq
 eh/THF/k4MaSiHr+2y56+bWUFA==
X-Google-Smtp-Source: ACHHUZ7iwggZ7brZoOpP9D6K3uXSAA8IQLFcDqGpbl2+7rPqvpuAd7w02I7YqtInkrisMLx13OAnvA==
X-Received: by 2002:a17:90b:1050:b0:24e:507:7408 with SMTP id
 gq16-20020a17090b105000b0024e05077408mr12731893pjb.37.1684847214008; 
 Tue, 23 May 2023 06:06:54 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a17090a6e4400b0025271247ab8sm5657904pjm.11.2023.05.23.06.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 06:06:53 -0700 (PDT)
Message-ID: <b87ddce3-a8cd-a725-7b7e-434ebfdba67f@linaro.org>
Date: Tue, 23 May 2023 06:06:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] Add loop over docker info
Content-Language: en-US
To: Camilla Conte <cconte@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com
References: <20230522174153.46801-1-cconte@redhat.com>
 <20230522174153.46801-4-cconte@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230522174153.46801-4-cconte@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 5/22/23 10:41, Camilla Conte wrote:
> +    - until docker info; do sleep 1; done

How long are you expecting this to have to wait?
Less than 5 seconds?


r~

