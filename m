Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9182B7824DC
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzfl-00071z-P8; Mon, 21 Aug 2023 03:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzfc-0006xa-54
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:49:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzfV-0000gh-Ss
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:49:50 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-319e93a1594so2806820f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692604181; x=1693208981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sW7H7hJplbfxZ455YcZyfch8wdEHnmXgE2LXa/0uYBM=;
 b=KGSShZ1vGhVlM/gDtl0EHrjDkrDGIDxR7wB79WSOdMLtq5HwO4oWIRdpzP39JrFgqo
 OpER2sIaA6JUIPcCvD0ig5CS3hc/Z73oQRML9ELzwYBdkJirsID0tszGBz2qlCxiCOpo
 JkKI2aqYdOUV0OTrIPwkOsqx0LrgV2juAkkd6FC/AXJQasyrJ26l8J06zDfQLQN4QL6e
 /dGTFJVOtj4M9aDt6/dpgIk1B+hU7cvahpHpTn7htsesfKwbkl4StEn4T6zfOZO+VlWE
 VgJ4+TySyRMKGHtOjzhi4+0MSQGbMBg8iju2E9avkvbqbVTXxPC0R55y3gMXQNmu7lGH
 AYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692604181; x=1693208981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sW7H7hJplbfxZ455YcZyfch8wdEHnmXgE2LXa/0uYBM=;
 b=Jjh/byk/vmJxYLobQSJVJJgY759hbawkzY9UuxgQ+fNoDEyaGDG5gheizKRInH1mVp
 mhWjFQ9YySaNkQY3wOSzqnKDxjLnhvopyWBe4cByLBUbrG1LcYUtATKa+vRaG0aJdBnV
 JMBmqXod+mLNqOsD6sbl2U1U6U6t/Qa0NvA1yZ8ubAmX5+ixTKMwn5USctpv1fcGWlfP
 NMuMMHAGkYQXsOco6ovoBd+VqgOcO/a0DiRh5LPrej019TcOtAxN5XjByni5wNEn6pFu
 wuDcsDOa2AK/pKbLihBuoBpM7AqjQG6j1s+9w11ubTMGo5LLVPmAgIBI9sxoG2ux4EB4
 APBg==
X-Gm-Message-State: AOJu0YwkSqKEr+cDjzrODtq1vf7ukKsloaZituckwvxI8eZPt5VL/QkV
 zYx+bPLFOqMjbLHn7grh/ku/hg==
X-Google-Smtp-Source: AGHT+IG1m1wvFs9k5Gq4ue0fBv0VLImu8D6ri4m2617LnxlyBou7cUs0gwJJPEcwKQxmFyj8x7FnNQ==
X-Received: by 2002:adf:e5c4:0:b0:317:eee2:6fba with SMTP id
 a4-20020adfe5c4000000b00317eee26fbamr4812211wrn.40.1692604181655; 
 Mon, 21 Aug 2023 00:49:41 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 t4-20020adff604000000b003176aa612b1sm11435488wrp.38.2023.08.21.00.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:49:41 -0700 (PDT)
Message-ID: <b9105b92-64f8-f1c8-43f7-e148cf9d6538@linaro.org>
Date: Mon, 21 Aug 2023 09:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 02/18] target/arm: Use clmul_8* routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230819010218.192706-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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
> Use generic routines for 8-bit carry-less multiply.
> Remove our local version of pmull_h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/vec_internal.h |  5 ----
>   target/arm/tcg/mve_helper.c   |  8 ++----
>   target/arm/tcg/vec_helper.c   | 53 ++++-------------------------------
>   3 files changed, 9 insertions(+), 57 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


