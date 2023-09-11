Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560DB79A9D4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfiNa-0005Dy-0O; Mon, 11 Sep 2023 10:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfiNW-0005D7-5O
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:59:06 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfiNT-0002DT-TZ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:59:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c136ee106so568207166b.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694444342; x=1695049142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dWtOIp2Om7WB8s48REgkt4ZY4KKN4V8auhbWjN+3ZmA=;
 b=b55Ws8o01WEGQDi5QYEyg/82LSL6136h+7qIPH1NBPKNlexEf/xLQhferZHPZt+R+f
 GSFEdpiBcfjsAmgxU6y1aGlKkk6N2PKx3/c95DIG1i3JCUbXvUcM5wRNS8kRKswjnavG
 PR6kbFpp31tOvMuWki+QD3A2xJEuOKd+Jt4IIet1QmADQeLgZaAPPs9gA9WuqD5Y4GsH
 2BhJ78Ri7iGO64+YsZVzEGk3OwfLZnkozMFcRVE02kZLeSwsmvBRZ6qmqjTOE2uUVA1W
 p9fCEytbxX2I+Q7ZOzqXfiSM3wKNNgK+KfxxC6WtLGAgYo/IyyZ/Wubp+xtIUA9WCrmw
 yXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694444342; x=1695049142;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dWtOIp2Om7WB8s48REgkt4ZY4KKN4V8auhbWjN+3ZmA=;
 b=PNbzbMrzeR+NNgdcbm3TukHNYdypSWBC75jFrUr8QoFSI9BSgk2VkxN9zrbOVQF8hG
 zeR5RnVCNTngKSC3waUif15eOSFWjJNsvcGj7Q7yO6/aQ9xswuEisbKEwVmEXilbsR4r
 8k5bmLvYOR9Onkdcvfl6CT7OxM24wwnaL8C1WuejBhfq0pcJJXkEo6dQ4p/LbEfxyD38
 L2RMnrm7Jn4idxvAgRKmtTFeN3dewlggDPQLWqzrsENdaC3r/Gow5nDiugtvrG27bsye
 y6nHUUoiHheHSL0bWeLSV6QNYoJGHlU1/73jg3+6Auf/BU2GJL5q58BrveoWpNQaOc68
 hpCw==
X-Gm-Message-State: AOJu0YzGw931O5GYaNTTrvRXjn24/YewQt5kF91FVfG25Gd96LjktX0o
 mT8TMZa2GtC+nZQV/wyKjMsdZg==
X-Google-Smtp-Source: AGHT+IGEOxmtusoh/HFgGEVyVSUCex5SMXPrkD83h7TBv6LCOvTKeNUYTsKYU05noZCHaN3ZSQuKSQ==
X-Received: by 2002:a17:906:292a:b0:99d:f6e9:1cf8 with SMTP id
 v10-20020a170906292a00b0099df6e91cf8mr8718028ejd.20.1694444342111; 
 Mon, 11 Sep 2023 07:59:02 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 ke25-20020a17090798f900b0098e422d6758sm5427991ejc.219.2023.09.11.07.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 07:59:01 -0700 (PDT)
Message-ID: <5d042c96-c5f0-bad6-f0b5-90b9e50e59b9@linaro.org>
Date: Mon, 11 Sep 2023 16:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 3/7] linux-user/elfload.c: Add missing arm and arm64 hwcap
 values
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
 <20230911135340.1139553-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230911135340.1139553-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 11/9/23 15:53, Peter Maydell wrote:
> Our lists of Arm 32 and 64 bit hwcap values have lagged behind
> the Linux kernel. Update them to include all the bits defined
> as of upstream Linux git commit a48fa7efaf1161c1 (in the middle
> of the kernel 6.6 dev cycle).
> 
> For 64-bit, we don't yet implement any of the features reported via
> these hwcap bits.  For 32-bit we do in fact already implement them
> all; we'll add the code to set them in a subsequent commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/elfload.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Why can't we import asm/hwcap.h with update-linux-headers.sh?

