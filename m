Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF2CA543AD
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Mar 2025 08:29:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5ev-0003IO-4o; Thu, 06 Mar 2025 02:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq5em-0003E9-2R
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq5eg-0002wc-2k
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741246108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7Mos7lA4bAnI8g6uFhU4PaNkakA8j/isPVVRDneAMMk=;
 b=Q5c8KR3R8Yn3V02sSpokDphEmdAbVNBrl8u6I/bax+cpLKyZotRURkKW+xKQHG4lwlB2AU
 6fr4+24Se8vPBcwjq8BBoXYWpb0q2AN9ZNz955A1nxgT1BBIa/9w/u1jEglgqeX+G3Z15j
 sjDIP1xfBtJY+sSVwI7uVfMyMyx9UEg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-qYAuhQfANhOiPhAlgcyP4A-1; Thu, 06 Mar 2025 02:28:22 -0500
X-MC-Unique: qYAuhQfANhOiPhAlgcyP4A-1
X-Mimecast-MFC-AGG-ID: qYAuhQfANhOiPhAlgcyP4A_1741246101
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3910876fce0so209720f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 23:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741246101; x=1741850901;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Mos7lA4bAnI8g6uFhU4PaNkakA8j/isPVVRDneAMMk=;
 b=kgUS85DeDWI6xCCI3SQIx8tUmBCC37BMZvJ7fdV3b7njWZiTDbS1BWmXCjR3ONtgl+
 PHZ134R7tXpqDxzt31reUQDe0E2Ofqpkb0OoWeiRH6AmfgOh9P7WmlWM3dLUVnNKLNKL
 Z1FmjhXOwcPDRVpPr6scn0x3/e3w4SxGkFvXBAVhWMJz+p+sOrGbsA9d+Pp/P1GtkL65
 USBuSNUnQdpJJqPE4TQkuIg1kVPBqQgWpXgCMrO8TbMeek5WKBCFd+kYJ2Wec8aLzsxj
 gC/xvJfTYjB/Y6CDmSI/UJThkg3tKenMhWNHDulyQ6zzIRP+Oh52/lZYDtGcycRRLXuW
 LQZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaTQZ3SLIBQNojOvrvoU18UBbMg2TYWuvVs7kOomyqIGtz2tW1NpzMdncGd2sh7NehVKtS/pn0MEQH@nongnu.org
X-Gm-Message-State: AOJu0Yys5HHFnZvoixRzbLBFH7PoapEVHhXB5EGDf4I9CUw59As2JCy3
 JS1nBB7nkKi8I9FCsluDjK90WrIOrtw2x+lFV9SZ1KVfw667weEQgtQwPUAQ8CX5d0cpM2VsedV
 RX5YT25RIcJJK109rYrL7RhYMFIfBFJ9DeBFbLBxQs1ek21C8HftoWVseY/ED
X-Gm-Gg: ASbGnctn96BNW1Gqq3iVU/8lQjZjqni6xSisqurTd2C5fYLTrAUh1eImTaLsqN0lVSi
 2mVC+O73qKaziiGAD8wfqx418xSkx8NoZo7u/V02m55QuyPMuA2/YtPT3cN8xfAsD0S7TWJFsp+
 hS2I0JycgK3oXpkMgWh+Q+oIXpk7UlrHA6qCENF8XmdryJH7zIE51WgP9wKvY4uWolD+6GbpV+o
 eg9yFpitdS9btRou04y9gVzQ/D8J9TvUrvG4HFY3KVdK0UipuHVbauRmR9I8I0ic3HhEaMbO/QI
 ZhfQRVkY6nbWCOojWflpNqDa0a2B/cQ3r7s4a3Q9AhXu3p4=
X-Received: by 2002:a5d:5f4d:0:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-3911f726fb3mr4366686f8f.7.1741246101394; 
 Wed, 05 Mar 2025 23:28:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5/6RutygN7vz8kZSxuGx4EoAQF5Toy5kKT6SPa4ACnfn+2I+Ief+fGoJMSs7vRQ+9QHDaYA==
X-Received: by 2002:a5d:5f4d:0:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-3911f726fb3mr4366669f8f.7.1741246100967; 
 Wed, 05 Mar 2025 23:28:20 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103035sm1063733f8f.88.2025.03.05.23.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 23:28:20 -0800 (PST)
Message-ID: <195b3558-3cb7-4a14-b9ee-5ba11ad0d333@redhat.com>
Date: Thu, 6 Mar 2025 08:28:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/18] qemu: Introduce legacy_binary_is_big_endian()
 helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-11-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250305153929.43687-11-philmd@linaro.org>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05/03/2025 16.39, Philippe Mathieu-Daudé wrote:
> Introduce legacy_binary_endianness() to return the endianness
> of a legacy binary, and legacy_binary_is_big_endian() being
> equivalent of compile time TARGET_BIG_ENDIAN definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/legacy_binary_info.h |  8 ++++++
>   legacy_binary_info.c              | 43 +++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)

We already have target_words_bigendian() ... why do we need yet another 
function?

  Thomas


