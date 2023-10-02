Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE507B534C
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnI5n-0006Xl-GI; Mon, 02 Oct 2023 08:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnI5j-0006XH-T5
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:32:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnI5i-0001T5-A3
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:32:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so168667595e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696249920; x=1696854720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cTWGFVavZxh7PssogSsuxHBwHAgLRCFhfA74ZbvKP/Q=;
 b=bvgmm9JcxWp7/Gt+audOfdz18HR6h/K3YW2uGnewPtaEF9mqxbqaVwb3o9AEjBsicz
 ey83I+TnbQuJLFCcrF28qBAxsWPwRomZynPve5jhwZR0Jkf/BS3kwFSgF6hLS1krzCch
 KriIrmaPdvrA1uRzcDnrJJGwipd65cLJcSOxO1M7UttPLKEz0/wkVmwAlg4SGtXWpTHH
 oxqg81qxyTGHu3uZ6NDXD231EA/1kSv5n/kqR6Hyvn/hUpHG1Z8bkIB+osbV04vN9j5i
 np2pS7qcKX0q6LA/OWVamNgU2zQ6PwDAPLjf0PFg208JO7LIQ0Q8ZI60zOfoSoEpIMSt
 x6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696249920; x=1696854720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cTWGFVavZxh7PssogSsuxHBwHAgLRCFhfA74ZbvKP/Q=;
 b=e6RlUOL3RSkdoB85jYoZwQk4huZos8vf5cblivMXug3FJpbcrEg+4menzsFXxgvmze
 ITHJzEvzPVJPJJBqy/nb2wQnXwO/Lv9Uu4RO4EA/2DVs9LgadedFQeF3c1AFoRuaeTuR
 u9LCBHF/x3LWLINIYxO4d5R8rt/fypAtMvXcDMjLf8ohkePULQhOLGKL75oGuN6yzM9U
 n3mbH4EgO/meTYM3NilckuVrA+f4r+LX3TgydgkJUJwuhHsoqe4sgokVXpi+4GXRfNzq
 B7w8+nU3wg49xVKQj7/A7p99ODHkuhoI++7lLpk9m/Fxg12BlNmZgDCl7ekdgu1HlNUI
 Sg2w==
X-Gm-Message-State: AOJu0Yxoy3szb/tz1I3lZO872KEIEbpCae9aHaR16d8q3yLvZZ7CJ8ZF
 gJMfFbVzwA9rpsu1v3tq4+ODFg==
X-Google-Smtp-Source: AGHT+IGJL9JWBBcbMWzt4BYp5rShVRqe44gmwWQhVYxa4K10/H15fp40L+P8WUeJrdWNgYCJsKZrRg==
X-Received: by 2002:a7b:c851:0:b0:405:3252:fe2 with SMTP id
 c17-20020a7bc851000000b0040532520fe2mr9560364wml.14.1696249920533; 
 Mon, 02 Oct 2023 05:32:00 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 9-20020a05600c234900b00401d8181f8bsm7187191wmq.25.2023.10.02.05.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 05:32:00 -0700 (PDT)
Message-ID: <478a9f2b-e8ac-6078-f1dd-78c01137c25e@linaro.org>
Date: Mon, 2 Oct 2023 14:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add g364fb and ds1225y to the Jazz section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20230929140938.396565-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230929140938.396565-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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

On 29/9/23 16:09, Thomas Huth wrote:
> These devices are only used by the Jazz machine, so they
> should be listed in the corresponding section in MAINTAINERS.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>



