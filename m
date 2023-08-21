Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 905727823B0
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyMd-0005Yp-I2; Mon, 21 Aug 2023 02:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyMZ-0005YW-Nc
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:26:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyMU-0007t2-7f
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:26:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fef4b063a7so215745e9.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 23:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692599160; x=1693203960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1LjCYZOaNbe4p8bAQ6lKcPt90MMQV1bGtuapUowMtG4=;
 b=N2DQR+dNWPBJmDA9yYhHnDUPg27qkTZnOYgA1bjLOC+cElFq20aSj24hAYehGnTab/
 WRkeSCsxxzXtFm3iRY7tcKJUbV1AY+hlYkJWxCW+8m+p/acUNyczoh4EiHXUrEeUFIih
 s5jHAIgIDeslt2QTrReRbWUCCoNlHLDLFrX0H67UQxFSj2eCdGMbnO7Az7nNpKvqUyke
 /LAJk1Ay9Er9quZodSwjlEr7R8iZLB/2yh9fjtsYoz9nOVSAM4LqN1jl7wTAb1zB59aL
 LcEHhsEeStklNFis9RmATO1daqp2Stc0Ng31qGgedCAoyZ+g3EYA+ZDfLyiz/WENucSG
 DaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692599160; x=1693203960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1LjCYZOaNbe4p8bAQ6lKcPt90MMQV1bGtuapUowMtG4=;
 b=JiIF9dOLfcxHpo6VAwpMLjkfwQ67f5GAaQ56BpCX2F541PniztZlHkrRpyVN915F6d
 iy6P1SFfonwb0eflZuN2fqxefC67ODISS++Y+y+uGwsdev5SQPW3F2OEeD797RBaiqLx
 ec3tPBvBB6EyTZ8eOAH9wDE4XtBhuWyTsIF7gK6MsQ2PrK7w1JZx7dy4we7iuaeHrBX5
 HvQjUfCaeNComWlUOPMm+4gSkhIczWFzaxU7y6gjTg2Ag/dKhozx+BDLoM2zhb+iKH1w
 JA3n37E+KIA619MyYJ50kWrTXFrw1TGQmYvWPNwmIa6vQn1g3Gu6KAuQxNil34VnSaf+
 xBVg==
X-Gm-Message-State: AOJu0YwloUa35uAxKj5LBSDBtTsu+Z1twcbsMoU9H+zmgwi1UqBiEd1q
 ddNshacdMKAS937YFrvOa9QWAg==
X-Google-Smtp-Source: AGHT+IEpVxTeYnpx0NuwNL1mz4UTQcFYARflic+Ia4goMqlpeM+DeBH8DM90Bv9/tMfiXSy8gwAIRQ==
X-Received: by 2002:a1c:7214:0:b0:3fe:9a6:f44 with SMTP id
 n20-20020a1c7214000000b003fe09a60f44mr4474060wmc.32.1692599160280; 
 Sun, 20 Aug 2023 23:26:00 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 a22-20020a05600c225600b003fed8e12d62sm9276169wmm.27.2023.08.20.23.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 23:25:59 -0700 (PDT)
Message-ID: <9a2bd4f2-6c8e-7241-9521-338911558f0e@linaro.org>
Date: Mon, 21 Aug 2023 08:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/4] linux-user: Move shmat and shmdt implementations to
 mmap.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, imp@bsdimp.com, kariem.taha2.7@gmail.com
References: <20230820204408.327348-1-richard.henderson@linaro.org>
 <20230820204408.327348-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230820204408.327348-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 20/8/23 22:44, Richard Henderson wrote:
> Rename from do_* to target_*.  Fix some minor checkpatch errors.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/user-mmap.h |   4 ++
>   linux-user/mmap.c      | 138 +++++++++++++++++++++++++++++++++++++++
>   linux-user/syscall.c   | 143 ++---------------------------------------
>   3 files changed, 146 insertions(+), 139 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


