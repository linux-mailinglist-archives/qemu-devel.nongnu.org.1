Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2CF7D639C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYTK-0006r6-Tq; Wed, 25 Oct 2023 03:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYTI-0006op-Og
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:38:32 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYTH-0006TM-2Y
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:38:32 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso35026805ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698219509; x=1698824309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WAcEQ1kYDpiW7zdaZz4pLPW4ypXRQDAK83Z0gpZ8TAo=;
 b=S7xNeG5M8B6WPCTtCzj/Y+QsI2r1NlZQlAY/FmCsg2/asTdXLHY9b2bs9KSXdMhh5t
 YAH11MBalJeSKsH+FkWeiCuMvzoZr9N4hTsVE40b8ylHkftK573bmD4KfYyDARiUNfm3
 O3bETKSc8v1DBCKXNroJSUYr4T6EOsxjWUrgTf5FxaGZf+l6a+yj/e8ANXSC/PB+sPBB
 xLrqneb3nRt1ABb1OAwItgyjpxe2kbQfEpdtaSGWB9HYWQjmUkUu72+Y2cwmpNYEXxLU
 /5ghs9xQ3imfOmjW1Bl1PxIHxBI33Vt38/TDY2vR6TJiVDhMdfWSijeZh1nSMNsDZIAq
 TqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698219509; x=1698824309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WAcEQ1kYDpiW7zdaZz4pLPW4ypXRQDAK83Z0gpZ8TAo=;
 b=GyhS+xN+QKMTNsprRrgd2BewEG3agOmPdN+LSrgfDF3BCtEAW+chb5ZvudR3lu7WuR
 D7r4AndLi0pBszNkoCYTB4f1dQETV1zPElRu6rVQxRkzpkN7b3GKaRRQC/eYdzBRTDvt
 oWlao62ky5Ezfb1xPlnTT//8xg0t/mnZoXnv3xXDQDz42cgBzA3DTMWHyIBuPHZz+zYw
 ML2/WeIlhbYmgPiNeWJaL5zL7fUsjTZvk/GeyfFnJ72nVMuuq/XIaakGoTQHAAzrYC90
 geMn2YFbSF0lfXYMoDpowi8QCnFYzQPpRRyeCSjj6Vn0lMd7iVtR0NIi4rbBP4Rn9efT
 9C8g==
X-Gm-Message-State: AOJu0YyRE/4Z/2NKj0IZ4WDRm0JqCV+yi0UN+9IteHdMqFeXcBJqw+H5
 rjHFwZZp/rZOQHQ/rWpVHdrMfg==
X-Google-Smtp-Source: AGHT+IGzKshws3hxziwaAGHBWn+ItDpo1MwMun0eIAtXC4Pyy+ckOp2GQqnSTQgzGU2aVG00oWWbTQ==
X-Received: by 2002:a17:903:493:b0:1c6:2b5e:824e with SMTP id
 jj19-20020a170903049300b001c62b5e824emr10065377plb.28.1698219509151; 
 Wed, 25 Oct 2023 00:38:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ec8400b001c74df14e6fsm8463270plg.284.2023.10.25.00.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 00:38:28 -0700 (PDT)
Message-ID: <e6e8c3f4-809c-47e0-96eb-1ec5a59170f7@linaro.org>
Date: Wed, 25 Oct 2023 00:38:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] target/ppc: Use tcg_gen_sextract_tl
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-10-philmd@linaro.org>
 <b9d9c1a0-5b20-4d33-aaf2-f12097122004@linaro.org>
 <CWHBYSZE3X91.1YCI4JXJ3H2SE@wheely>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CWHBYSZE3X91.1YCI4JXJ3H2SE@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/25/23 00:09, Nicholas Piggin wrote:
>> I'd be tempted to use and+movcond instead of sext+andc.
> 
> That would be simpler / more mechnical following of specification
> in the ISA. Might be better to save that for a later patch though.
> Any downsides for backend generation? On host without cmov?

Probably not enough to worry about.

Virtually all extant hosts do have cmov.  Those that don't have it as part of the ISA *do* 
have it in the TCG backend, implemented as branch over next, for minimal code size.


r~

