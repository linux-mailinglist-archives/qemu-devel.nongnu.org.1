Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341BB1CA31
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Aug 2025 18:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhSb-0000xw-Jy; Wed, 06 Aug 2025 12:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujgCJ-0001Jx-LB
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujgCI-0001Mb-0Q
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754494617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X1OfTK+xp6uoBKk7dbSzEQQ9dnkclv0FGtzOH68TVpI=;
 b=EHVQTPE8ulacwmyjS+AHfQ/v4OI2LBGK/niAp7s3w1zWJWGFydG7kDoHRMf3mQcRvlDAvt
 zQaLESWupRjDoaq1LRIvmPNTFw5RZyK2Iq91apVuTzADOa+RaKEthU84nHpZYHjEIzKuKR
 ESMu+K+5JbOGmhEgGRAvU7Dy0Gm7z8s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-xWP6QtfINlK2pt1gg6qqLA-1; Wed, 06 Aug 2025 11:36:55 -0400
X-MC-Unique: xWP6QtfINlK2pt1gg6qqLA-1
X-Mimecast-MFC-AGG-ID: xWP6QtfINlK2pt1gg6qqLA_1754494614
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b7889c8d2bso3016152f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754494614; x=1755099414;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X1OfTK+xp6uoBKk7dbSzEQQ9dnkclv0FGtzOH68TVpI=;
 b=O7zGlIbHddq06z4d3BtjGn4xnAd6WchU8DbJBinUrSBzWlyBwIqEvSOL2JUJS+suYT
 Z27jEkFjWAqjyA9lnwrR+5Yq86ymK5SOmvtjAcu25dWsknHC6aiR5vSJq+XxZ/6KqNPx
 oYEor2KEigIjV/2aiyI8Ah1Meea2kbm96gCXM3Ln6IAanrYlDF7LU8YA9Xc83PZe5bl1
 C8R4LGhl0A1bwuq7YP960F7aG/lmUhmq8D7XPpHI53djm1aWl0JfCBzW2oDiPdrYLBGU
 vhNOFJ9ITTamEaSa//KVULuc3cYo5j92W1oXF80OJrBXJCsPhYRZDw6XIcPbLhqPJTF5
 ZaVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV68kPFM9JxJw/VliQBerMNjt2/57M5VW+9KYueP/GUob2fS6CVTItVpSr3C/s86+E8wL4O0SGLaQ9w@nongnu.org
X-Gm-Message-State: AOJu0YxybyJgyFeGOw9QfAQQUQbypgpP0+ygsO0omw5WXflMKCqfqwKZ
 XayTIlsqP39acxkQjlV6kx+fRV/1wrWITNgKuoDXVOXsbcbii/c2BCQ0qs8BrTRY1WR0lBWWrUS
 Ij93l05IyivDxwyXbaX5lzhAAy+QCg4ENrzW0yCJuti7tEcmq1UR538mq5qeYJJJv
X-Gm-Gg: ASbGncvMqCqUreFFY6RsCvkIg/PQc5hUqKM+I0Klr9s2ChcIZWyvbWa/B8EAtt+dOiL
 NEayUtYd4JVjf13Z3+djssUrdHo8FiuVkUWbSp+0WUTgXT6J7tjFrOwgQzEm8iHwlTLU1JEdUGa
 NNld+LUTmow4AarRbFxLz3a+/jkLeQoD1/9qzHm9afGVuV3K2qbJ/5rkWxxkkJtDRpknb7IHiBP
 mMUeEo86Z3gSWwmoNfE/+4mZgFTpZBwYyuhf962SSxDqScWwV+zDx2R5JxRZe/9igiAygcWZ9fO
 xmtj90xOsh7OrjZA0RlmgFzSPRmRVvYZdWxEPoPgjw4nLezkp17MO6HU1y4owiI6/CQoUSPj8sp
 tpZoGDU0kQAF9PZIhbIUG7+Qj7qJGdYzCCdfVgK2WGGg5ECofIt68pqfoR3tZonxJTw==
X-Received: by 2002:a05:6000:2003:b0:3b8:d0bb:754d with SMTP id
 ffacd0b85a97d-3b8f41d3e78mr2746080f8f.37.1754494613600; 
 Wed, 06 Aug 2025 08:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJBRnmx36yMkuMovK02H/FDLnXVexJSqFOgXqEw/YwAdXAPzWamzYKoKdrUCJKWosaOyMdaw==
X-Received: by 2002:a05:6000:2003:b0:3b8:d0bb:754d with SMTP id
 ffacd0b85a97d-3b8f41d3e78mr2746060f8f.37.1754494613126; 
 Wed, 06 Aug 2025 08:36:53 -0700 (PDT)
Received: from ?IPV6:2a01:cb01:833:e4a9:b423:d450:c87f:f1f0?
 (2a01cb010833e4a9b423d450c87ff1f0.ipv6.abo.wanadoo.fr.
 [2a01:cb01:833:e4a9:b423:d450:c87f:f1f0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4530a8sm23462951f8f.38.2025.08.06.08.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 08:36:52 -0700 (PDT)
Message-ID: <e3b520ca-4b67-4880-82f0-c464f9182b67@redhat.com>
Date: Wed, 6 Aug 2025 17:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2 3/4] vfio: Remove 'vfio-platform'
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250731121947.1346927-1-clg@redhat.com>
 <20250731121947.1346927-4-clg@redhat.com>
 <3841525e-eef9-4cf3-a7b5-b7cc11e9d702@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <3841525e-eef9-4cf3-a7b5-b7cc11e9d702@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Eric,

On 8/6/25 16:52, Eric Auger wrote:
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -38,7 +38,6 @@
>>   #include "hw/arm/primecell.h"
>>   #include "hw/arm/virt.h"
>>   #include "hw/block/flash.h"
>> -#include "hw/vfio/vfio-platform.h"
> removal of this header causes the compilation to fail.
> #include "system/system.h" needs to be added

yes. I sent this patch separately :

   https://lore.kernel.org/qemu-devel/20250731144019.1403591-1-clg@redhat.com/

but it needs a v2 to address other files which have a similar
issue. I will resend the whole when the QEMU 10.2 cycle opens.

Thanks,

C.


