Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA64C7566B1
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:42:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPQt-0008By-NM; Mon, 17 Jul 2023 10:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLPQr-0008Bj-NE
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:42:37 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLPQq-0008VD-3D
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:42:37 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1b06da65bdbso3437276fac.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689604954; x=1692196954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yK6pHY4XgWRV/PmE7dIILMGsbNt+/S4Zj7YKoey/tGA=;
 b=ZZloRA9xpd0x8bXqrmHKXuHBMnY9QoSXROF0tssKfd8grPw7yPqWfnjIPsFM1iOpb7
 ze2fY81/lpr5YGOiPX/tmX6ptJAb6AXYwsOJJQTMwUFW/d7Vl99wjiKN4i5woeyTyExo
 R+u71/MIAe1yoRp3P/s8JVXRDWcdCp2hWngf9eYrmRIejyNT8dfn/6LtLd76WPUu3v7R
 usdlViyaJVVwogcJ0nWJW3Y7XxRqbSZsejU+I39UGPWFvGsEV8hKjP/uFinDRWsL4bw3
 HJiQ9wd5g0j0ami/Z0bF/aZRoMquXnmbwIKCdcGUkSikDU0kjBEA01X356/Ggt6eCxga
 Mmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689604954; x=1692196954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yK6pHY4XgWRV/PmE7dIILMGsbNt+/S4Zj7YKoey/tGA=;
 b=KRPdi5ZWYusF/6+Lyy7XNT1tC20t0/8W4kNQLADIy05eNtpRndzlljPpSW+IL/H361
 ukEPfsf97DHTn5ae6Kf3hFLalgLYrbefb301ZKDu40Iz+oh53+/0LN+waBsCmD2e61Jc
 wJ+v0gFP65K8P3Y5Nt1lYaT7n6WrMefFxD9VjitwZe5vgnyOnf6Skkq/CWuQF/HetayC
 VKcIQZIUmutLs5j+j4RJsWBlqwGrjPpb9+To91ZcnSYbMMVH+bjKsgtsOhiw8EyVzSde
 h9oQSwPEfG/Ua0R3H83pTIXfnshh1bLXM6sXQqZed+oiVjj5xJrQEH4L5WEbPD+2/J5F
 mrKw==
X-Gm-Message-State: ABy/qLZWuiA8R/gZNY0M+llmULG1wIfr02bEaVEWw8rjgh+qCkt5AU9c
 CgPkLL4nxqDHXwe5/dAvq0Rz5A==
X-Google-Smtp-Source: APBJJlGiKPvyR6LQeoALQBG2f0woopfx8w1NsDJF/c2Yq0AKhvg9OSfZzjMuX+XQjHTLZdESkOwapg==
X-Received: by 2002:a05:6870:c0c5:b0:1b0:25b4:4b7a with SMTP id
 e5-20020a056870c0c500b001b025b44b7amr11762292oad.51.1689604954383; 
 Mon, 17 Jul 2023 07:42:34 -0700 (PDT)
Received: from [192.168.224.227] ([172.58.109.253])
 by smtp.gmail.com with ESMTPSA id
 ef24-20020a0568701a9800b001aaa093932bsm7183778oab.11.2023.07.17.07.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 07:42:33 -0700 (PDT)
Message-ID: <90ee6305-42d5-b045-c854-669521155160@linaro.org>
Date: Mon, 17 Jul 2023 15:42:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 20/47] linux-user: Make sure initial brk(0) is page-aligned
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
 <20230715135317.7219-21-richard.henderson@linaro.org>
 <5a2a1941-2e8d-7ebc-b808-d91d27a69f1a@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5a2a1941-2e8d-7ebc-b808-d91d27a69f1a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/16/23 19:15, Michael Tokarev wrote:
> 15.07.2023 16:52, Richard Henderson wrote:
>> From: Andreas Schwab <schwab@suse.de>
>>
>> Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>> Message-Id: <mvmpm55qnno.fsf@suse.de>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This smells like a stable-8.0 material.  Please let me know if it is not.

Yep.


r~


