Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A87F363B
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:40:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Vef-00047m-3L; Tue, 21 Nov 2023 13:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5Vea-00047L-Du
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 13:39:21 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5VeY-0005Fq-Bj
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 13:39:20 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cf669b711fso15109555ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 10:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700591957; x=1701196757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixkzMv4Ldn41DeWXjO/cFLuj6yD+a3sJ+OcGKtoffm8=;
 b=A1uYoJG91+JRjnJ//bWOZoSaIRrBWrsivbpbecZ78D+N4dVxHKpvEj73yeyR9buQvf
 u94A7vVAY0ttEHQGHF4L3IuhzloT0MkDds5vhwe2dgAXoqi2Y/5+h9s3EccyxVzi0Ykl
 +DbHkhuWF075cf0kuMTOaUJEknjHs2Xapca8wXkZ62vruCXRVVGI+ZDTnWJAq6mrewnr
 2kPL0KOFg3rJ4BNj5mn0gwK2fon+pibc/KarlPsJ0I+7gtMOKwN62ocuLqwo5ZJ088bG
 phup8uGQpbxsuv9rmO070eMF3mncjCOQmVLz3QjQGRTzu7xuAbSpxbKnS8NY/n5Umzep
 7Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700591957; x=1701196757;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixkzMv4Ldn41DeWXjO/cFLuj6yD+a3sJ+OcGKtoffm8=;
 b=vp5Frf6zFRxyQ9iou91VBf42Pa2mSBEIlpkneb/wcHQKpR0ZJcD7Fvvwml6T5jiwqA
 SoNBXES5dBqC2SM4lbuU4dkHT0BdeI+kdukHaFMZpOANN5943DpRlYWeIh3J1iCXyHp3
 eewXz0++eXHJx93bCimBfnF3jP86oGlzONevOCrpkwXcrOwoiqK8HkkwLeR3nTBlyOoL
 VWQr7T4VHrBgRmINlVwGvyOnTZ5kmd2JDQkxOdOQaitNDR/GfS6p6QxygmAKTfF+NdMo
 enWrC3+k8651fPP083cClGXEpMNFNlt2O1YHGb49uQ5f26uOmBb/jkIRQ84p8eKMw2Ms
 OocA==
X-Gm-Message-State: AOJu0Yz5V+znBk5YBpUMNrHRHFRSvYnuHTSlM6ZDW9ezX4Ff0i4WO4Xn
 +h8F2hkBPuu3NROc8p2LrxTHqw==
X-Google-Smtp-Source: AGHT+IG5FmJHohX2WnhaVasLjQWBMXlti7sNrbrjaeQKHa4BU599z6w/gzHLbgXt39YsC93u0WfIpQ==
X-Received: by 2002:a17:902:d4c4:b0:1cf:69ac:4c1e with SMTP id
 o4-20020a170902d4c400b001cf69ac4c1emr4571804plg.17.1700591956682; 
 Tue, 21 Nov 2023 10:39:16 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170902d34900b001cc3098c9f8sm1042722plk.275.2023.11.21.10.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 10:39:16 -0800 (PST)
Message-ID: <8b3fe672-d7cb-46d0-87d6-2c89a0d3f272@linaro.org>
Date: Tue, 21 Nov 2023 12:39:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't implement *32_EL2 registers when EL1 is
 AArch64 only
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231121144605.3980419-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231121144605.3980419-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 08:46, Peter Maydell wrote:
> The system registers DBGVCR32_EL2, FPEXC32_EL2, DACR32_EL2 and
> IFSR32_EL2 are present only to allow an AArch64 EL2 or EL3 to read
> and write the contents of an AArch32-only system register.  The
> architecture requires that they are present only when EL1 can be
> AArch32, but we implement them unconditionally.  This was OK when all
> our CPUs supported AArch32 EL1, but we have quite a lot of CPU models
> now which only support AArch64 at EL1:
>   a64fx
>   cortex-a76
>   cortex-a710
>   neoverse-n1
>   neoverse-n2
>   neoverse-v1
> 
> Only define these registers for CPUs which allow AArch32 EL1.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I happened to notice this reading through the Arm ARM recently.  This
> is technically a bug, but you'll only notice it if you deliberately
> look at what should be an unimplemented register to see if it UNDEFs,
> so I don't think it's worth either putting in 8.2 or backporting to
> stable.
> ---
>   target/arm/debug_helper.c | 23 +++++++++++++++--------
>   target/arm/helper.c       | 35 +++++++++++++++++++++--------------
>   2 files changed, 36 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

