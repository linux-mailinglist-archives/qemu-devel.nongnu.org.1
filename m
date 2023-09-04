Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C40791BA4
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:30:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCT5-0005Pb-Ey; Mon, 04 Sep 2023 12:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCSV-0004VJ-78
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:29:52 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCSQ-0002Wn-OL
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:29:50 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99de884ad25so252743366b.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844985; x=1694449785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NrnqPN7398ty7yLv/sczqA06bZUMw0IUliFG9AigZvE=;
 b=FmRE3eH2KFpWiokgzvAk77PYYwQZQNy07SF5jglpmnj7DLIEWNe4+4FUo84KJK/L5G
 +vcqniDcx2X2iGZN5P5ADkHNHfPVeeJey/IZbnO14T4zEBcXW5waqe8OkMDLIXplfRNK
 GM7eUNZJduq0G+z5yeoI4uawZYaSF43iRVTPMFxD1QZAFBn43cvVjLtQ/UxvwW81SLZj
 JE35GzlH1nFDGbc7ywLK4ZD61QI3tBqZsLAHOByYCAHHxARsFJI0NO3ImRfWMubnbcRF
 j+OlUUSKVoKrNJPqfScZAjZ3q8NMMQf6na8bjPWSPll2z9oBmZJiPVuOVTAqFAXP/lAu
 qoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844985; x=1694449785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NrnqPN7398ty7yLv/sczqA06bZUMw0IUliFG9AigZvE=;
 b=gnJvpo40pG7/yez4hNZSv8NS3OVjV4yL9Qx0r0DjKyIUpCZla75udgP4dC64pi+tOa
 9lvCDn8cjD7w6UweXdxT2/ONhALa1MQ2Ki83s+quc1Dz6rvorTUasBe7aUFDwNd1beKH
 bRg42eLLj0tuSuKB5miNT4/J8VVbvdW7nUGaIRAaK8I0I/9FYTIKjzJMfFYJ26k31nni
 zFgHv8MtmADJJgVwyYZHVqhHiLrZBoKkYsVDJ7lJjXuTSx2FlAn0uYoR4uPUuqpyx1re
 +TWS6Doqg45nMs5RYhB5ICTVCb4Sv7A4OEMxFRUxWs0yYIgTJfg8D+qhl2jDzfHZnE5b
 nfpQ==
X-Gm-Message-State: AOJu0Yx9wxt71JZnRo5zm5YvQTK+8XHKatk8akZ6f9xiHzuj6C24N44q
 2blz4wSabNx6yUsKfU8y/iljqg==
X-Google-Smtp-Source: AGHT+IF4qQteS/d6G4FMN42N7lxsnnhf7mz5o9mwEqQ+TR3IKbVbXkUcu2b4rXKbDxOQbNsFeEwcyg==
X-Received: by 2002:a17:906:189:b0:9a2:1df2:8e08 with SMTP id
 9-20020a170906018900b009a21df28e08mr7542096ejb.45.1693844984917; 
 Mon, 04 Sep 2023 09:29:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 ov22-20020a170906fc1600b00992c92af6f4sm6489916ejb.144.2023.09.04.09.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 09:29:44 -0700 (PDT)
Message-ID: <81b122d8-6653-f293-45cf-7e68762e7dd4@linaro.org>
Date: Mon, 4 Sep 2023 18:29:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 16/22] crypto/cipher-gnutls.c: Clean up local variable
 shadowing
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-17-philmd@linaro.org> <ZPYFfwYj6YgSf6Nb@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZPYFfwYj6YgSf6Nb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 4/9/23 18:27, Daniel P. Berrangé wrote:
> On Mon, Sep 04, 2023 at 06:12:28PM +0200, Philippe Mathieu-Daudé wrote:
>> Fix:
>>
>>    In file included from crypto/cipher.c:140:
>>    crypto/cipher-gnutls.c.inc: In function ‘qcrypto_gnutls_cipher_encrypt’:
>>    crypto/cipher-gnutls.c.inc:116:17: warning: declaration of ‘err’ shadows a previous local [-Wshadow=compatible-local]
>>      116 |             int err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
>>          |                 ^~~
>>    crypto/cipher-gnutls.c.inc:94:9: note: shadowed declaration is here
>>       94 |     int err;
>>          |         ^~~
>>         ---
>>
>>    crypto/cipher-gnutls.c.inc: In function ‘qcrypto_gnutls_cipher_decrypt’:
>>    crypto/cipher-gnutls.c.inc:177:17: warning: declaration of ‘err’ shadows a previous local [-Wshadow=compatible-local]
>>      177 |             int err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
>>          |                 ^~~
>>    crypto/cipher-gnutls.c.inc:154:9: note: shadowed declaration is here
>>      154 |     int err;
>>          |         ^~~
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   crypto/cipher-gnutls.c.inc | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> and if you want to include it in general pull request

Sure,

> Acked-by: Daniel P. Berrangé <berrange@redhat.com>

Thank you!


