Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 665D0A6E043
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Mar 2025 17:54:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twl3W-0002ee-IE; Mon, 24 Mar 2025 12:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twl3K-0002e1-7F
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twl3I-0002YP-Hk
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742835206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WepY6q6oXMcoCNCLJv5T5aMJnYqaoyFli1CBptZcuMk=;
 b=bigQ3//slU6fGbZtHKxVmWY56pjJiKD9RjOQvPeMQNZvAV7aCAW0nWw4uzwepEfE693s6a
 sXqxI2viNjBVHLewPeeTLT6SMD3aUSKXVrFUBxivTkNv8bUvOxbL1NXbtaFrH/ff/ohTPc
 zNbrnzSVpwC1Tb1E971YctdIY7IL0yY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-B-hdZDJeM_-fRWXC99cDQA-1; Mon, 24 Mar 2025 12:53:21 -0400
X-MC-Unique: B-hdZDJeM_-fRWXC99cDQA-1
X-Mimecast-MFC-AGG-ID: B-hdZDJeM_-fRWXC99cDQA_1742835200
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d025a52c2so34638595e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 09:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742835200; x=1743440000;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WepY6q6oXMcoCNCLJv5T5aMJnYqaoyFli1CBptZcuMk=;
 b=qF7Srz0rSBBX3DsXAvaxi5MNAb18odEhEU0ePsyktYZYfVKPlC8NZAT+483Ig/JzMp
 3c8F8hW9dKBxu1MYxOvv4DcXGNmopmbC0WNnJi60Eh5XxzbkLSI72mt4irrA4l+1XtF2
 pR7zygKa41yl27mdRa8xzUTRlWx+EL0J1AH8Avlx6J5lcd2MTGLEG99v1xqLLhfBco9x
 RFPE5U0EMiMt3P4LW4eLq1C2OpA/xOgL4CayLSI+MS1xDjy0VHv8z3zEk4kTRpGca4d7
 bhrzQl7trpDifBdE8sgcj9aoms2Li5scqdinSf/M9CkHVf3Vv2cxKzxgJzuOxqI9rFhK
 l1jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4P2dPC1kJfdQ2xjBlobWxndfMbPrg2pY2G0NSL3gppVXsavbZ6PbIhpokU+CCgQ4FqfDJEj3ik/Dj@nongnu.org
X-Gm-Message-State: AOJu0YxTlOb6ajGt2Vqgup6ytJBgFsZq5MMkzl0nU2HKyMyJZm+xEWoE
 OUHrbbPOipXxdwXREqL9+RGqilBEs5Ja1Smu+1ZsnZlePJB86dNep1L4s4s3K6jeEz0PIj4Cuq0
 cyuy0lSWdiSbijTpL0XDym5dY2Uro6EYWKyQLni9LTlAOwId83QHP
X-Gm-Gg: ASbGncsnT2y2z+JomRxAehRTXrxNXIjysv+RmOVKp6XczmGuqNMTnK8sotorZc76v9O
 5il8n5glAch6lHlzZPGh9pAbWK7FXG0SczvmdeL8AyPRK+wwqoErH6GKFqjThURAXL6jsR+z0W0
 X9HmWJdUWaDf2Q+8qJIVHCiu7Z7tzWKmVZfP+hblS7X1WZJNpwHBtdbs2+0P44B1FKFt38AZYIM
 Alh+ihsBdakmwKBoWRuyDrBa6ssMhpx3fT+aSipeS6oxNlz5h+8U+kEs2FSEu3cC8rwDGrBvjiF
 aVxdTo8gJTo+759T4Dxqy0A2SwqVDJ29XBAP5G6XPw==
X-Received: by 2002:a05:6000:178d:b0:391:2c0c:126b with SMTP id
 ffacd0b85a97d-3997f909b3amr9472886f8f.23.1742835200154; 
 Mon, 24 Mar 2025 09:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIoOLVUK85mXyMIe7k6aaT8ANw1V8zfUvljllH9qKFIAxvK8WK0pFS8jPTy1ImESoVu4pK4Q==
X-Received: by 2002:a05:6000:178d:b0:391:2c0c:126b with SMTP id
 ffacd0b85a97d-3997f909b3amr9472858f8f.23.1742835199703; 
 Mon, 24 Mar 2025 09:53:19 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-2.web.vodafone.de. [109.42.50.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fcea400sm127102205e9.2.2025.03.24.09.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 09:53:19 -0700 (PDT)
Message-ID: <ea5e8d28-0520-4426-85dd-425d7c07ad95@redhat.com>
Date: Mon, 24 Mar 2025 17:53:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 5/6] target/sparc: Register CPUClass:list_cpus
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250323224035.34698-1-philmd@linaro.org>
 <20250323224035.34698-6-philmd@linaro.org>
 <8115b7be-03b8-4d08-8f7e-9d316f11e082@redhat.com>
 <029362ad-1408-4f12-9fa3-e51d9bfaf56a@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <029362ad-1408-4f12-9fa3-e51d9bfaf56a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/03/2025 17.32, Philippe Mathieu-Daudé wrote:
> On 24/3/25 10:30, Thomas Huth wrote:
>> On 23/03/2025 23.40, Philippe Mathieu-Daudé wrote:
>>> Register sparc_cpu_list() as CPUClass:list_cpus callback
>>> and remove the cpu_list definition.
>>
>> Copy-n-paste error in both, subject and patch description: This should be 
>> about s390x, not sparc.
> 
> Oh oops.
> 
>>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>>> index 5b7992deda6..1aac967a0ce 100644
>>> --- a/target/s390x/cpu.h
>>> +++ b/target/s390x/cpu.h
>>> @@ -902,7 +902,6 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
>>>   /* cpu_models.c */
>>>   void s390_cpu_list(void);
>>
>> Don't you want to remove the prototype here, too? (and make the function 
>> static in the .c file)
> 
> s390_set_qemu_cpu_model is defined in cpu_models.c,
> while CPUClass in cpu.c.

Oh, right! So maybe you could move the prototype into cpu_models.h instead?

  Thomas


