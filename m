Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 104EA78584A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 14:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnOX-0000mR-Bx; Wed, 23 Aug 2023 08:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYnOU-0000mG-PZ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:55:30 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYnOT-0000L7-Cw
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:55:30 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99c4923195dso725601866b.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692795327; x=1693400127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+BxjLoz127FrN/Wahd0HQj97PwidyQCBRMITIH+8tIo=;
 b=QVNKmlbrwL4MJivWtciNnpsfontvxI50s4qs3QABYF490R2IAgFg1gp3MWGxJ7wLQq
 1tIYrUvW/+5bOwC5DC/ouXBjhoAsyVpQsnDm7gZwyakN8mkx2OlceqE4qRmcM/r7aCsM
 Oi7Fnjrr3N/1tJhYd7NmSTHnpLc9VsX6lHh5gNLYrWFAN/wlEBipGsTIFYUzcuMlcIyd
 jhFWJ9+WfPbh0zq38X43QUD6tMt97ClTNpLApJvh/e99/2L1OfDKET7srLJG30Knz4DI
 OhAsAcgGiJ75ba+gTnPoubKWdFLHRf0b1xeS8k9xKw146/Lgk5IP8dKKJmCsOGN/RyW0
 m2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692795327; x=1693400127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+BxjLoz127FrN/Wahd0HQj97PwidyQCBRMITIH+8tIo=;
 b=JDm+Sx7hg5kusrucuQz+aq7Bg7itDtCHeOqMBJguRs9RYpTI5HxjbKgahGuVWjry4C
 BcJOO0uw4t4HIoPF/WHvTHAefogSr7nAh7qsh7X+ehrF28mocPfGcp411a4asDtbU1GN
 XEVF2TQq8IkROvisxFCPdDyUyisoawu9D4rxD1mZfWtrbZOmAr6cPI4PCKy/dwxWZvqD
 OW0bVVKwF6F+CY3LTIKVUe4yPr+XxGFkuXjxXi6jHjfR9YAIbc4/0zGjn3qSC012C40u
 12iN+YqtqEsoJZAnSt+7ovkIkco1a/Z+tD8b1HolxJjLwIcjSI3uK9ES5vu4HMU0piKi
 l2oA==
X-Gm-Message-State: AOJu0Yzy2Zk7sVzqwzqLJPaGCpRrQNwXjgykaU5sypCc7fFjb/TLkMhy
 FvdqW9lEbmoA929kRkyiInTq3g==
X-Google-Smtp-Source: AGHT+IE3NGSBP81Z1C7BB3AL0Hfd1F55SvG/EIVwHBlDLWBo2E19yPyDhr6nfIyt33FaVeT0osZL1Q==
X-Received: by 2002:a17:907:2c62:b0:991:d727:6977 with SMTP id
 ib2-20020a1709072c6200b00991d7276977mr9162792ejc.38.1692795327311; 
 Wed, 23 Aug 2023 05:55:27 -0700 (PDT)
Received: from [192.168.69.115] (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 b7-20020a170906d10700b00992d122af63sm9760691ejz.89.2023.08.23.05.55.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 05:55:26 -0700 (PDT)
Message-ID: <a7a6017d-8d0f-3899-9a88-4104e7f2431f@linaro.org>
Date: Wed, 23 Aug 2023 14:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 02/10] linux-user: Exit not abort in die_with_backtrace
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
 <20230823051615.1297706-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823051615.1297706-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 23/8/23 07:16, Richard Henderson wrote:
> This line is supposed to be unreachable, but if we're going to
> have it at all, SIGABRT via abort() is subject to the same signal
> peril that created this function in the first place.
> 
> We can _exit immediately without peril.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/signal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


