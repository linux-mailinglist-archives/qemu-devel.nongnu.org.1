Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD88573F500
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 08:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE2cS-00013Q-Bk; Tue, 27 Jun 2023 02:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE2cQ-000134-EB
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE2cP-0004Pm-06
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687848964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QsIUKaCmvN9NltOg+X5q0IH1iCVUdH+kPCho75Ry2so=;
 b=WalYDP3OZ+qqsKSJZC3+MQ2U7+uRrochOk3jTpmPpa2EJxDSSU+SZ+KJ4fbhWN73Ch9xFR
 YsPF2pESV++oosq892JwJqsYTfKuiMhp+cAfDyIBTWp1UfkTAvG403pN+O54w2iqo5ATNW
 MQntM0Tp3DO+DEFTZpCrqEDwMLAlXPg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-H0YdZwZMMbikdTLVsiJLVQ-1; Tue, 27 Jun 2023 02:56:03 -0400
X-MC-Unique: H0YdZwZMMbikdTLVsiJLVQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-766b225954aso172897185a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 23:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687848962; x=1690440962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QsIUKaCmvN9NltOg+X5q0IH1iCVUdH+kPCho75Ry2so=;
 b=IfXVzO94IHR4dA6DeBX8YeQBjhE6uJ3ZkqXyGUgkPfJtg/RZDoUx82quzDY5AZuWCN
 s367hPls7PtGqCtkwNc2R8UCRYd1QuvxxfwCwwIwNfCrKaAywpOUlBKUKQ+iBpmGW23v
 f8knwwq5+PA41cJbcv+7FzTFREHJfK0wVa7mp23BGEV3Vb//nijswi66fN7UatUiLkTx
 dG13HS3C0VSAVA1m8+TRgcFQ0ttfVSrm80lCFJDWHsXgLmFunqUZ0DKYTzEkI7YQ+7S0
 74rWGMNhQS0vO0y36JhDSHFvJDFVyzxW98QIOb3ZRxTmvgnynz8l6NpOKT6vZdLvaSve
 PzeA==
X-Gm-Message-State: AC+VfDxOW5oXlo9uZXsEE50Qu4csRn1Yryn54lRLMOVmZMeyVGUhkUPt
 xr0UVaa27VMw/r3231Uvo+Ya7u5/ixsmfgeMxQ5CoVNBJZHOvsZMAQEM59yMUJKMUFpjhROTYCF
 nh8DEjNLUgNMjMdw=
X-Received: by 2002:a05:620a:4144:b0:765:740f:4897 with SMTP id
 k4-20020a05620a414400b00765740f4897mr10028123qko.64.1687848962566; 
 Mon, 26 Jun 2023 23:56:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ712CX1BGwqCiUuT5fQEOQkz9i0snpmB6xkzjYsbtXTuP3x0sP4pPM8WC2fQ6gOp1Rx75nAPA==
X-Received: by 2002:a05:620a:4144:b0:765:740f:4897 with SMTP id
 k4-20020a05620a414400b00765740f4897mr10028113qko.64.1687848962324; 
 Mon, 26 Jun 2023 23:56:02 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-172.web.vodafone.de.
 [109.43.179.172]) by smtp.gmail.com with ESMTPSA id
 z22-20020ae9c116000000b0075c9e048b19sm3615421qki.29.2023.06.26.23.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 23:56:01 -0700 (PDT)
Message-ID: <c103e9e4-7487-5cff-ce36-52e48d9c936f@redhat.com>
Date: Tue, 27 Jun 2023 08:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] pc-bios/s390-ccw: Move the stack array into start.S
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mrezanin@redhat.com,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230626132138.87668-1-thuth@redhat.com>
 <20230626132138.87668-4-thuth@redhat.com>
 <a807476d-fe97-3c05-32d2-371b0a82b92a@linux.ibm.com>
 <a7ebe361-6b16-2af9-0dfe-ae2e06b6a819@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <a7ebe361-6b16-2af9-0dfe-ae2e06b6a819@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/06/2023 17.25, Richard Henderson wrote:
> On 6/26/23 16:54, Christian Borntraeger wrote:
>>
>> Am 26.06.23 um 15:21 schrieb Thomas Huth:
>>
>>> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
>>> index 29b0a9ece0..47ef6e8aa8 100644
>>> --- a/pc-bios/s390-ccw/start.S
>>> +++ b/pc-bios/s390-ccw/start.S
>>> @@ -120,3 +120,8 @@ external_new_mask:
>>>       .quad   0x0000000180000000
>>>   io_new_mask:
>>>       .quad   0x0000000180000000
>>> +
>>> +.bss
>>> +
>>> +    .align  16
>>> +    .lcomm  stack,STACK_SIZE
>>
>> IIRC, the ELF ABI defines the stack to be 8 byte aligned, but 16 certainly 
>> does not hurt.
> 
> This doesn't do what you think it does.
> 
> .lcomm produces a COMMON symbol, which is merged with .bss at link time.  
> Thus the .align does nothing.  Even switching to .bss section does nothing 
> here.
> 
> You want
> 
> .bss
>      .align 16
> stack:
>      .space    STACK_SIZE
>      .size    stack, STACK_SIZE

Oh, thanks! I'll fix it in v2.

  Thomas



