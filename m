Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5E79495BA
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Aug 2024 18:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbNES-000454-FY; Tue, 06 Aug 2024 12:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sbNEH-0003zM-Ch
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sbNEF-0007nx-1n
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722962402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1Jl/wmdif6aFGOyhppRJD2D5MbqV4PONHXdSrt1eiR4=;
 b=YUB9Ry3ymAQVXQNuqqPgbk6BooEQ14n0xUWJpqbodw4aTiK/cgCw+jOWtwMyPuLfsae4QC
 X0tSbaUNHC1/R/wW69/s0OWItzbHEH1nwdB8EVdpBfdIeyoYnDUloRX9klqI7G2Ym93LSh
 iJ61LL/zuW1yCU/Pq9WEm2rA2OkNBPE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-BUjHnOhnMiKxFutMFa7uPw-1; Tue, 06 Aug 2024 12:40:01 -0400
X-MC-Unique: BUjHnOhnMiKxFutMFa7uPw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36878581685so559803f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 09:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722962400; x=1723567200;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1Jl/wmdif6aFGOyhppRJD2D5MbqV4PONHXdSrt1eiR4=;
 b=czEmF45eWUaU6ojW77LXyzTwCOmpwOifS5HbodTzsAs3srvHMitaFtR/JMIzjj8lZk
 9YOdlwvsQmmn6HFEf2VEgKeOQ3aO1YKyjdfDlxFWMUhKma31pZX3JvZq8ueUpZ3FQ8UG
 23qRwDVGmH4WdVgxwTmQNqmFQFBNbB8omDZlyGy0okynVkNhCl7SMN1tFuknp1YlUZgO
 AvurjrGcMpsUrctZze/IcKdhSELl6wX4/XPTqjGOw0YSI1PmxEnCMWYQ66V2aF2/q/GI
 1A1Z9tg4T7Oij3kTG2zILLt2jhwzmc5h/CUq3LuWvjCowrRmkdxIEDr8RyydTOj0IGaw
 28rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUJYi+RClgLMfABaARPwF5NEB5v28e20iwEn0dAGGUMkQDot2BCdli8e/nBk5DyuJp1lIdbeYICeh7zd+zOLeJRI+fzTI=
X-Gm-Message-State: AOJu0Yxsx+CzFYqWloj/EKA4d1qMRq0p/HYyNOpJaaPQtR5o8IRzZxI9
 W0OCBkSx7BRwJjm94lq/qDd/OUshMcguL9gX+yvAJLjXNZpiSR8MktOjpxZA8ucNpWBXCScPpUa
 Etzpr1bOqtAvpMnTRVEyR0yLZujJjN5yZLRfMpfCL8x82jQ1QYY64
X-Received: by 2002:a05:6000:1faf:b0:367:8f81:f9fc with SMTP id
 ffacd0b85a97d-36bbc1c1b09mr11605946f8f.50.1722962399790; 
 Tue, 06 Aug 2024 09:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJYUkQVU816/gDbqek7kHm96br6XE2bwQvIubFF0ih9n0aF+ktzYNcv0qRO29qjO98Jnl2Sg==
X-Received: by 2002:a05:6000:1faf:b0:367:8f81:f9fc with SMTP id
 ffacd0b85a97d-36bbc1c1b09mr11605930f8f.50.1722962399317; 
 Tue, 06 Aug 2024 09:39:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af?
 (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de.
 [2003:cb:c73f:8500:f83c:3602:5300:88af])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36be1daa030sm5080648f8f.114.2024.08.06.09.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 09:39:58 -0700 (PDT)
Message-ID: <39475af7-9090-4304-80c1-fb08c7360e83@redhat.com>
Date: Tue, 6 Aug 2024 18:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] reset: Use ResetType for qemu_devices_reset() and
 MachineClass->reset()
To: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-2-jmarcin@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240806160756.182524-2-jmarcin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 06.08.24 18:07, Juraj Marcin wrote:
> Currently, both qemu_devices_reset() and MachineClass->reset() use
> ShutdownCause for the reason of the reset. However, the Resettable
> interface uses ResetState, so ShutdownCause needs to be translated to
> ResetType somewhere. Translating it qemu_devices_reset() makes adding
> new reset types harder, as they cannot always be matched to a single
> ShutdownCause here, and devices may need to check the ResetType to
> determine what to reset and if to reset at all.
> 
> This patch moves this translation up in the call stack to
> qemu_system_reset() and updates all MachineClass children to use the
> ResetType instead.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---

[...]

>   
>   static void mps2tz_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/core/reset.c b/hw/core/reset.c
> index 58dfc8db3d..60c9c66d81 100644
> --- a/hw/core/reset.c
> +++ b/hw/core/reset.c
> @@ -25,8 +25,8 @@
>   
>   #include "qemu/osdep.h"
>   #include "sysemu/reset.h"
> -#include "hw/resettable.h"
>   #include "hw/core/resetcontainer.h"
> +#include "hw/resettable.h"

Curious, is that change really required?

Apart from that LGTM!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


