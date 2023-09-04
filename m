Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6705D7917A9
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:57:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd98j-00025D-Ts; Mon, 04 Sep 2023 08:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd98h-00024L-Ja
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:57:11 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd98f-0001Lt-7F
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:57:11 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fe27849e6aso2203964e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693832226; x=1694437026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EIFk4asiXVbZjDtNRoSWvsSRIvli9XzizwBjE/hbJ/o=;
 b=vC1NPEHzIS9R43DrMhlhlQ4CAiZt3+lyFbVAZEUo7XdzOWIAerI7lTgTYA6qsvySy1
 GMqn1V2j1TkqI9Ffuen/HyRpqMMwcQJSX15H09X4wXUADFFr3j52op5lCUkb0QdQn4Q6
 vUmV1MLripx3zGHGD8Jlkk67PsRM4ACXN62TW/K9ilFiNgqscsM7ktNlYAh6s8yiXmg1
 GhgRgqHYrf0IUtOcaYWFeI/5skezlQPiFXXEd6ZXTSmchT0Xy3E/0aiTs4n2hBiKhge2
 qDOGtM9qO9hlViefEEP3oEiFmO5kciw/ZuAQvWAp9PtA6r2rkPHtHZvmUvb8p003blwE
 dCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693832226; x=1694437026;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EIFk4asiXVbZjDtNRoSWvsSRIvli9XzizwBjE/hbJ/o=;
 b=awLf/WEyYtR6m4EEKNmuZb8GD/PHAjYLyDv0+siuMnL5+46mycM9sOqr+yXAI6yNBG
 GdgAHrRzJEKGJZMAe6kmtMYaW6/Uypw6NTOSuJ1B9PJt1uO85UeT82gmmhFCkMJGzFfI
 GCk4WDjPun5rpjaxUTRzKipTh2ww/9QyWKcHso6nlSJFsopJGGyaaS4pI0pVtgYLnPij
 4iVv3CYSkt2f0W1c5id0r++NqQ+ICvGCBa9/ub2x2sS1wLCSNFzSo/9QNA8Hl8kqLeU1
 qilG4mvQP50OrvUz/B3P9W9MGL6K/rz1rPId5CPPxM8SQhxtpObya9ddZnv4/58ntSXg
 vBVQ==
X-Gm-Message-State: AOJu0YyGYhCRAPLSmhvWrFuK6WGGa3ue+a/RlayxfleI15RpYgrzbaWT
 IJAwsRHHklDo63gENnF5kmpl/w==
X-Google-Smtp-Source: AGHT+IHEVEZFxmSoAJ7lRJFSYNZ5E0R0z53DmQrZ70CLBvqO0bmKhSD8SG9PqkLZIIm7i530w+6oOA==
X-Received: by 2002:a05:6512:23a0:b0:500:ac0b:8d58 with SMTP id
 c32-20020a05651223a000b00500ac0b8d58mr7889454lfv.18.1693832226231; 
 Mon, 04 Sep 2023 05:57:06 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 r2-20020aa7c142000000b00522828d438csm5838886edp.7.2023.09.04.05.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 05:57:05 -0700 (PDT)
Message-ID: <056c8c4a-5d51-0cd3-39ac-364a36dbc3b4@linaro.org>
Date: Mon, 4 Sep 2023 14:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 10/11] net/eth: Clean up local variable shadowing
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>
References: <20230831225607.30829-1-philmd@linaro.org>
 <20230831225607.30829-11-philmd@linaro.org>
 <17caf9c8-94af-4bbc-9b48-142606b319dc@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <17caf9c8-94af-4bbc-9b48-142606b319dc@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 1/9/23 09:07, Akihiko Odaki wrote:
> On 2023/09/01 7:56, Philippe Mathieu-Daudé wrote:
>> Fix:
>>
>>    net/eth.c:435:20: error: declaration shadows a local variable 
>> [-Werror,-Wshadow]
>>              size_t input_size = iov_size(pkt, pkt_frags);
>>                     ^
>>    net/eth.c:413:16: note: previous declaration is here
>>          size_t input_size = iov_size(pkt, pkt_frags);
>>                 ^
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   net/eth.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/eth.c b/net/eth.c
>> index 649e66bb1f..cf030eed7b 100644
>> --- a/net/eth.c
>> +++ b/net/eth.c
>> @@ -432,7 +432,7 @@ _eth_get_rss_ex_src_addr(const struct iovec *pkt, 
>> int pkt_frags,
>>           }
>>           if (opthdr.type == IP6_OPT_HOME) {
>> -            size_t input_size = iov_size(pkt, pkt_frags);
>> +            input_size = iov_size(pkt, pkt_frags);
> 
> You can just remove this statement.

Clever eh, thanks!

