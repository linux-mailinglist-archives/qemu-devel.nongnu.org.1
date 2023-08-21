Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0E3782427
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:08:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXz1m-00029j-CB; Mon, 21 Aug 2023 03:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz1W-00028m-Pk
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:08:28 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz1T-0007R4-VF
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:08:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-319779f0347so2656858f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692601702; x=1693206502;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9knjLtmAt5vI9QemaqrmT5l3jD50hUdFduo3U+j3lu4=;
 b=hPyqBcDeLV3dwIMG459+sUI3YDGv2UDFfzgS0RP8+MHBLCD5+c+GqVtzYjGbF+elLz
 7LPyRDLkNDB8UAh+Pac+HojBQ9l2MFGgKlylZWO220Vrd2Ck5PBDzHoJ0oq+TnfHl5r7
 laJovqOVHUSAAHVcGpBBzTD5kwYPLsjf/xGZCUeSY9Yr6Dk12o5zpX5O7/A14rNETmqU
 +8ArpOFprNDyggfCNs+DVodO/G6pVpoT8DHB0Oyuzm0qK/2B+UzamxPXKkEBdmJNgB+J
 nnI79bP7YYEtV0YdhMqZuBNBn58Dxc3G5WS8p1sre46bfLhOTIyHt+f2TGqEef8rdMhR
 0wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692601702; x=1693206502;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9knjLtmAt5vI9QemaqrmT5l3jD50hUdFduo3U+j3lu4=;
 b=QnQfF9dgNJMEJvAxtrTMxIED29fc+3rBp7Q84nN3tdfEXMCMT04Y3ghR5EVlX8fm8V
 XrriSd7gdPx7AvFafB47sMAluBTSG/8hvKH4estYOq75oc6n+n3RlMGKU3U9erFKsgiM
 PCfM0+bpgWIz6Wo2W1NeDqYuRts8ABt7ilkY25OY6tiAd+5rmkzcIYOpvBH0OGxRjoBx
 bUa93u85rdd4L5CzPRSaGrE5FfWs4xd/boTPlK53HTqzZbNZk1bPACxScxcW7k/Hn8Au
 L3Kw/I5tiAQNfwM8IlJ2bWj+KY5xTcQet6JWmmkM+WmqDqlUfY2WSOyolDoGAtnJrZCa
 j03w==
X-Gm-Message-State: AOJu0YywdegunxR5BKRwkhvqa4nuBH7Udp4OmplbztAZzIUxNO1oSRFK
 KGrfs8L90J4fX8PS7kNc6j73cxEA6l5xxYQhBX0=
X-Google-Smtp-Source: AGHT+IG2O0X/0tnkIqaEqTciigmtsr0L9dn0XAq9uaroVGWwTibbraEEyokH7fTLfpjzfYn90OZAgg==
X-Received: by 2002:a5d:4107:0:b0:317:67bf:3387 with SMTP id
 l7-20020a5d4107000000b0031767bf3387mr4543656wrp.60.1692601702425; 
 Mon, 21 Aug 2023 00:08:22 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 x8-20020a5d4448000000b0031432f1528csm11411004wrr.45.2023.08.21.00.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:08:22 -0700 (PDT)
Message-ID: <9584d325-a35f-9697-9557-2b0942e1d17d@linaro.org>
Date: Mon, 21 Aug 2023 09:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 09/33] linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230818171227.141728-1-richard.henderson@linaro.org>
 <20230818171227.141728-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818171227.141728-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 18/8/23 19:12, Richard Henderson wrote:
> We already have qemu_real_host_page_size() in a local variable.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


