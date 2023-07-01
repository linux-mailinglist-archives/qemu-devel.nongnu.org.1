Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC537447E0
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 10:06:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFVaq-0004mZ-IS; Sat, 01 Jul 2023 04:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFVan-0004mR-J8
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 04:04:29 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFVal-0005Tf-BI
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 04:04:28 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3141140f51bso3301441f8f.1
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688198665; x=1690790665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mnQm1fLk6Q4XgO8XTCim0MXfCTCFNNONdqxneRlwoWQ=;
 b=NBCmKnTwGH3g/MSLbKRyaSi/tj/jKXZNN+P3vg/lY7UE+U+tcw9uvKa6XrvgFfa5bZ
 +fgRWsFsW98kk0PSoIrU66bo8grS9xv4+YWH6A0JW1DHisfIYAEQazjKq8q0uEFoFc5C
 uP5Lt34WCzwTrzIZxbakndKDCYAy40270EWIgPRFHy/m6FrKv51NWeiuNEe7VN60J0is
 jSileweC0dMbSSM4Pypi0onUi/zZK6svw3xvN8nnck6x0OgDtTZLQUNxj0x/xzlX4nmS
 D9b5ld2DtTXbk7xdJ+iw18FVKdUE9K+i9l+Tt/e2/HEKJmRafCqvCPcufGXUBmR1AYRt
 Va7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688198665; x=1690790665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mnQm1fLk6Q4XgO8XTCim0MXfCTCFNNONdqxneRlwoWQ=;
 b=a91aIvxnXLJKqP2NrqPwUaxVtWbElym70SvrOLgmcDIPzwAN36C/O0JLlEGzIjLu3E
 KQSLkm0/icL0JBj8g06N1OW7FF8H9UuzCccWwozeaDQsRwUSwROyx7gGDXTVmzbJ2WLb
 wo7dDH7DuPfpBcJsE8aXD4auBm+2xYcH0l6P6zzwVdq2WNDrG8ZmWw66shqhzyPNkJSq
 r9PhFZqJmE8EMDiHKLTf+FYSJ3jg4leBhEHeOPNQfjKHGO5lPRUBGcYxVznLgX/rlqUF
 +KQwWYwyMVpspCZcvUftVzKExrP7yJPDBZzhTbLeILqYQnlMBhdVVM5jjZHG78Xc8iWE
 8o8g==
X-Gm-Message-State: ABy/qLaNDb6h0jZntz9CNS56q0iO8hcMTS3ijw6CZddBNkX+JtvOzjvG
 1tsUPgXWvh6dmaOpl3UZVZ/Z+w==
X-Google-Smtp-Source: APBJJlEVZBIwxA3sPKNyA2ks27zhUmuilZdRB9Fw8RkKeyLTWtX7HjerbyrNPDUm1YAjqgoNHF92wA==
X-Received: by 2002:adf:f8c2:0:b0:313:eec6:77a1 with SMTP id
 f2-20020adff8c2000000b00313eec677a1mr3715356wrq.71.1688198665186; 
 Sat, 01 Jul 2023 01:04:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.169.251])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a5d6250000000b003068f5cca8csm20188642wrv.94.2023.07.01.01.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 01:04:24 -0700 (PDT)
Message-ID: <0fe923ff-920c-f2ed-fb2b-e8f6d938da86@linaro.org>
Date: Sat, 1 Jul 2023 10:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] audio: dbus requires pixman
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230630214156.2181558-1-marcandre.lureau@redhat.com>
 <efd6705a-893d-7c6d-c3eb-264928b055b3@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <efd6705a-893d-7c6d-c3eb-264928b055b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 1/7/23 08:28, Richard Henderson wrote:
> On 6/30/23 23:41, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau<marcandre.lureau@redhat.com>
>>
>> Commit commit 6cc5a615 ("ui/dbus: win32 support") has broken audio/dbus
>> compilation when pixman is not included.
>>
>> Fixes:https://gitlab.com/qemu-project/qemu/-/issues/1739
>>
>> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
>> ---
>>   audio/meson.build | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Queued to tcg-next, per request.

While this happens to fix the build, I think the proper fix is
different, see:
https://lore.kernel.org/qemu-devel/20230630234839.14716-1-philmd@linaro.org/


