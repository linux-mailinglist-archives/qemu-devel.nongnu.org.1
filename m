Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A0706E4D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:37:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzK9e-0007vu-UQ; Wed, 17 May 2023 12:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzK9d-0007vd-Uj
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzK9c-0006lZ-Fl
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684341451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQ9D3hVcbAwdjhLxKeqWW33C3riLOt5TzrQUpIwpefQ=;
 b=LwJyjbGEYEEibbOuxgsm5d7aqieQmqckNf0QrYRoLLJHT9I299ukWNYdhFRwAr4G00VxbR
 sAqDVS/Yd5IIqbi7mhDOHpgyDk49OL3w1+nNr/PO0Gqt4Et3j39WCyM6B+ttL3SzfisKbQ
 JAR+r1Gz1Flxg7FgI5gF3PaTbpiv97g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-6CJYPa33PZqTIF3URkwnHg-1; Wed, 17 May 2023 12:37:30 -0400
X-MC-Unique: 6CJYPa33PZqTIF3URkwnHg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f41dcf1e28so3989395e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684341448; x=1686933448;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xQ9D3hVcbAwdjhLxKeqWW33C3riLOt5TzrQUpIwpefQ=;
 b=iMMrdQvi8Cdq9tOzBj2LC4hHOwjxrZSZZwWdFLnjhDHFvFfj0ap2zD85BusN7GSIvd
 RsAd5nIJubmYLrsDuXk+VcPBMBRMqvqmwk/7cXeqcRiHsUYSSnbFg5N060TAvVxfBuYA
 PQcwjHlvPaFVVsqsi7MoVLYtOIm23DBgOyF4ub6TeXnK35YGO+9MhTRICiFiiW75Ws3v
 UY+hOn3gYq3umtyeGRudNTWRjjc3nXd6Hzx2DCYU83s079JPYtAlLRnNk8+kTcrv2hdI
 OHPIrbNcIwBr++5/G4WcEKvgsuWhB/340CX4rY3A3rF5TOE1OV6ybLEmzCOz7SzrtVEL
 Qx0w==
X-Gm-Message-State: AC+VfDxNa4iVoSUTVTC+rnOhV5GoZl0k2jtZ8T4PeszlbbrUQSYFT9Cf
 HMUbNIJjlEa0iOBNp9Jxudsp0TWYPzV4ok0ph9+uoIaRmVUQX92bhsuBb7Wym2QsQjAetMZRAWU
 nvga2KM/TJ7Cb1OAzM5V/NPU=
X-Received: by 2002:adf:fac9:0:b0:306:2b81:88e1 with SMTP id
 a9-20020adffac9000000b003062b8188e1mr1232800wrs.0.1684341448449; 
 Wed, 17 May 2023 09:37:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LOhiGcNa/KZFxWeLcKoVnRU1mhR2LgDx5JZdNEoAVorzxFBbV8T9ldRjkfD4az1d+RD8LTg==
X-Received: by 2002:adf:fac9:0:b0:306:2b81:88e1 with SMTP id
 a9-20020adffac9000000b003062b8188e1mr1232785wrs.0.1684341448064; 
 Wed, 17 May 2023 09:37:28 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 u16-20020adff890000000b00307bbbecd29sm3315938wrp.62.2023.05.17.09.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 09:37:27 -0700 (PDT)
Message-ID: <6f7fc901-c504-300b-1c75-c25406825e0d@redhat.com>
Date: Wed, 17 May 2023 18:37:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] softmmu/ioport.c: QOMify MemoryRegionPortioList
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230419151652.362717-1-mark.cave-ayland@ilande.co.uk>
 <20230419151652.362717-3-mark.cave-ayland@ilande.co.uk>
 <2d36555a-b5c6-ac21-c1d3-a8668a05a7eb@linaro.org>
 <eb9774d3-cbbb-b415-4d84-2f36179ea062@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <eb9774d3-cbbb-b415-4d84-2f36179ea062@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/11/23 16:52, Mark Cave-Ayland wrote:
>>>
>>>       /* Copy the sub-list and null-terminate it.  */
>>> -    mrpio = g_malloc0(sizeof(MemoryRegionPortioList));
>>> +    mrpio = MEMORY_REGION_PORTIO_LIST(
>>> +                object_new(TYPE_MEMORY_REGION_PORTIO_LIST));
>>
>> Shouldn't we need to replace the g_free() call by object_unref()
>> in portio_list_destroy()?
> 
> Both the existing g_free() call and replacing it with object_unref() 
> cause QEMU to segfault if you call portio_list_destroy() before the 
> final patch in this series. So in effect we'd end up causing more code 
> churn just to replace one crash with another 😉
> 
> The real fix is in patch 3 which alters the refcounting/ownership in 
> order to solve the underlying issue, which I hope I have described in 
> enough detail in that commit message.

Here I agree with Philippe though, there is a mismatch between new and 
unref that would (for example) cause the finalize method not to be called.

I think this patch should already introduce the instance_finalize 
function that only does "g_free(mrpio->ports);", and include the full 
portio_list_destroy() hunk from patch 3.

Then patch 3 basically focuses on the reparenting trick (including 
adding the object_unref() call in memory_region_portio_list_finalize).

I can do the change myself when applying though.

Paolo


