Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DABA284DA
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Feb 2025 08:15:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfZcb-0006Ab-KT; Wed, 05 Feb 2025 02:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfZca-0006A6-Cj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 02:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfZcY-0006Xx-VE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 02:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738739689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q08gyaOL1JIzvZPs/Oftw2VLYpHf3NNC58+jxMltE20=;
 b=JG9efrBb6weY9Rb9k6qaF6W8kV+NvgPQy5NpLd/O8PG6UkNt4FNyV90BXn9WbDyTA2BDWO
 NWcnR9AQ3klplGQOdMjbjF+y2GYei8uuEStWjxm8s1lgf5Fe6znmwRZxQXtv5O7by0q9uK
 DvouVCM+ch06aPUv0Qhe0Y2dp5wzqCo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-Gqj3FlHmOvijqkIMv7c1pQ-1; Wed, 05 Feb 2025 02:14:48 -0500
X-MC-Unique: Gqj3FlHmOvijqkIMv7c1pQ-1
X-Mimecast-MFC-AGG-ID: Gqj3FlHmOvijqkIMv7c1pQ
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab2b300e5daso724688866b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 23:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738739687; x=1739344487;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q08gyaOL1JIzvZPs/Oftw2VLYpHf3NNC58+jxMltE20=;
 b=rnbsWWmSTFwciP7G1+IbwSgNWFCzpYqf3UgVE413xjGx3kehM8KQMsHlo0rUVeGzTP
 lIb6YVQOPqSzutLbwtKYBRUaEVauQB3Ph2WaPLl9zR3TgbPbcE4TDOHvxFToyMQt25ia
 16L010kQoED/mF+BzRHV0rP0DQ7FpzUpIh8jsDvh1gpVEbqEM15Z6METj8MUFcH7jY1b
 JrCzyPJbNDBLCXIH7ACbMDxCY44op+/NRLC6tCMhgjX0QhWtWRFweOlP5LgphOjLTWK6
 EKkK2DqQXQSSlD64YIoQ+j4yILn4j2XGOmRsGaa0xZ0SAgTDBMAtgPY4ym6EMZq7CZAJ
 d04w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIfVELYKwRV8TBAd5PJsFZysNpUdGRbj+2/yHDsyIaZiQQMTMjHSKkb+QrgikEPqIT0nw6y9mo1ZBv@nongnu.org
X-Gm-Message-State: AOJu0YwGZxWp/ivHiutBian3XH9iC+nYrDTP0uRvFeOljfbYOuhfPJwh
 O9DQNPepozCULVtV3lJTUeBvpjSFB/nv50yQDbt9u3Yedd/wUs58OVxGGuVYEDJRYU9+80NBckF
 bZYgpbn1P4f1EDyJQwSi3uXdjimATw18hIyiicqZEvPbZNb2Z3E4n
X-Gm-Gg: ASbGncu9uD6y3ssQgpMvc9Ad7lF50NIJ6MUd3bym6jAazPylTuOIycLZUKTHs2yx+m8
 shpudtBBUwo6oQe7BXAYsHwyMReyYM2AFFe29wKvnn3Roe8gz+i/v1UTvH+3LLaA1d3LqHaPD9b
 BjBSrKeo/OulX3indoqN474yrGyjs8Ec4eFiFU28oHzRai1qIKRLDI5rxggYs0hwBunEya6FWfr
 wKaRxlDWQd0CTNg9BZ2isyacgQoEYvuYIBFXkV2qmQXh1D1Ljx9xIy8SzG8l0LBvosvC4ER24hT
 LrJmyuRKbZj3oRctwOnvp4qXX37NySLOWAeP
X-Received: by 2002:a17:907:3f96:b0:aa6:6a52:970 with SMTP id
 a640c23a62f3a-ab75e2335e1mr154669966b.1.1738739687305; 
 Tue, 04 Feb 2025 23:14:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfC/EmmN3sGniVWCBKRP4MEygMgvO3JIdUiGj6sB91JH1Q+BG7GZajsosRlcYcP9ijm/V3lg==
X-Received: by 2002:a17:907:3f96:b0:aa6:6a52:970 with SMTP id
 a640c23a62f3a-ab75e2335e1mr154667066b.1.1738739686867; 
 Tue, 04 Feb 2025 23:14:46 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7656d5d5asm16241866b.48.2025.02.04.23.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 23:14:46 -0800 (PST)
Message-ID: <9d8874db-b95a-40a3-9d65-a8179bd6f938@redhat.com>
Date: Wed, 5 Feb 2025 08:14:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] hw/arm: Remove all invalid uses of
 auto_create_sdcard=true
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250204200934.65279-1-philmd@linaro.org>
 <20250204200934.65279-6-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250204200934.65279-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 04/02/2025 21.09, Philippe Mathieu-Daudé wrote:
> MachineClass::auto_create_sdcard is only useful to automatically
> create a SD card, attach a IF_SD block drive to it and plug the
> card onto a SD bus. None of the ARM machines modified by this
> commit try to use the IF_SD interface.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/aspeed.c            | 1 -
>   hw/arm/b-l475e-iot01a.c    | 1 -
>   hw/arm/collie.c            | 1 -
>   hw/arm/digic_boards.c      | 1 -
>   hw/arm/highbank.c          | 2 --
>   hw/arm/kzm.c               | 1 -
>   hw/arm/microbit.c          | 1 -
>   hw/arm/mps2-tz.c           | 4 ----
>   hw/arm/mps2.c              | 4 ----
>   hw/arm/mps3r.c             | 1 -
>   hw/arm/msf2-som.c          | 1 -
>   hw/arm/musca.c             | 2 --
>   hw/arm/musicpal.c          | 1 -
>   hw/arm/netduino2.c         | 1 -
>   hw/arm/netduinoplus2.c     | 1 -
>   hw/arm/olimex-stm32-h405.c | 1 -
>   hw/arm/sbsa-ref.c          | 1 -
>   hw/arm/stellaris.c         | 1 -
>   hw/arm/stm32vldiscovery.c  | 1 -
>   hw/arm/virt.c              | 1 -
>   hw/arm/xen-pvh.c           | 1 -
>   21 files changed, 29 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


