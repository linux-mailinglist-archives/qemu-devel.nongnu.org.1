Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624A802B07
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:50:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0tx-0000ow-Mc; Sun, 03 Dec 2023 23:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0tv-0000mQ-71
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0tt-000421-TH
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHi8jS8/G9/E7Rhvlw38r/XKq7RFES+CoFQhzovYdiY=;
 b=PRCDNO39KEhZfInqDct8t2rgIDUA4yqk7a9vBJnadT4C9HKbt0F37Vipey55H+HnSvDO5B
 0OCY0ca51YFhdLpXS8h1Iv9+vMlfpk+0nf3vZtJQ6mZ1z5JOrVqlJyhZAu/aT7UR9AqQ8f
 y3uZ/6mDdtRIii8/afWR/5ku7HxQfaA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-O0Lfb8LyNXaUcNpxmNrfDw-1; Sun, 03 Dec 2023 23:49:39 -0500
X-MC-Unique: O0Lfb8LyNXaUcNpxmNrfDw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d03d44adcdso30407245ad.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665378; x=1702270178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aHi8jS8/G9/E7Rhvlw38r/XKq7RFES+CoFQhzovYdiY=;
 b=Qvted5x05i+njDoCMDR4rYa0FfiyOJuywHkzosSyanSaCMM0bDvuLxcWE+lOGDC7vJ
 cnk1SghMiANrDY0shjT2RdaxHr9/SiRjpxVWYLRrIOw52gpQ/ruO8FB1oqZ7mBo7Ihjw
 uh8auvihGIjmwS+CFzJr46UlOZogoPcTV8uyk6xOf/scz0C3gu7ALOvRRLJRFh6mY8Tj
 c/qZoiUfNLedPoeDsRQm7dvEE4NhdOdMPYCLzcKwcx5jv7EfvM8wO/DNV9fYWLNfu9Hy
 8f3SY3MabKfB8Cv61GCrgIpNmKoySsnzo7yrU1X7OsR1NBeFuJAvu85/hg0CkQen7iLc
 fJGA==
X-Gm-Message-State: AOJu0YzoAn2PehzXDvoS4oVfRRaiP9t+dPVKKLoah2SILsNe1qMju1Uo
 aoRxZbWe1gmO8yFlovnQEZgx0ePOr8OVz++VvqgHK7aFV72tz4o1Oubmg7kCV30rEB4g9p/Gz+u
 OlaEI95kyKargy6cl7lhn7uE=
X-Received: by 2002:a17:902:e74f:b0:1d0:b503:2edb with SMTP id
 p15-20020a170902e74f00b001d0b5032edbmr123568plf.69.1701665377837; 
 Sun, 03 Dec 2023 20:49:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFfg/wDkRbdANXVvIjFZdemmfsGmIrM53yE47s/PBoSmpxeBZi85ro72EfVE8M+tOBVWkrbw==
X-Received: by 2002:a17:902:e74f:b0:1d0:b503:2edb with SMTP id
 p15-20020a170902e74f00b001d0b5032edbmr123561plf.69.1701665377557; 
 Sun, 03 Dec 2023 20:49:37 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:49:37 -0800 (PST)
Message-ID: <33402763-5c3c-4804-bffb-819a61e1e6f5@redhat.com>
Date: Mon, 4 Dec 2023 14:49:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 08/25] memory: Have
 memory_region_init_rom_device_nomigrate() return a boolean
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-9-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/memory.h | 4 +++-
>   system/memory.c       | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 

s/cpu_exec_realizefn()/memory_region_init_rom_device_nomigrate()

Reviewed-by: Gavin Shan <gshan@redhat.com>


