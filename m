Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C69575ACE7
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 13:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMRj0-0006LL-J2; Thu, 20 Jul 2023 07:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMRiy-0006L7-HB
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 07:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMRix-0008QJ-8X
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 07:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689852094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7P/oMFhXTCKkqVVNtahqE5pSrbhKH4zdLc2mA7VQv3g=;
 b=bBKryI1T5IS7OEuFgeYpAY0vI/fCL1QLRXty+a9EFpHGfx4K0YsNSIdgplPrZcY02oiQqF
 zCGsTWMckULe2Orik+ipSiG1KRdac5SfGbrHTfsrfrQJw5gJ8x5WipPQfRX2kIxXe8U39N
 Ljfg03AJ7z1+fgWJ5Uybw6y+p3pNa+k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-QxeuO-eRP_uVCAxcBiBorA-1; Thu, 20 Jul 2023 07:21:31 -0400
X-MC-Unique: QxeuO-eRP_uVCAxcBiBorA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so3486985e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 04:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689851783; x=1690456583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7P/oMFhXTCKkqVVNtahqE5pSrbhKH4zdLc2mA7VQv3g=;
 b=DZM9WzlsbL60fVJ8gNEbrRmHwN5TqSk7XKFLDZmp3S2cLBPzZSLQaRnaQ8VIh+tcHM
 YxszJo3FuoPXJdCXHUip4nrQEbngic8CYgwsJxqwWL8QXL8oguFHfvqBUCujwWs0TdT4
 N7riuE3OnNLAQz1zM0aCSCjWYnZqH4h/6+CeVxL+SzenL0wJ9MH1Cu5zEZ4w7yRWE+Zy
 BsZf2a97Nx/opXG/ndnAgJn1l/thgM8Ilm073exzDIwZ52OWZupr+sGUZ4KFF+AI7dKf
 FqWpQldx7/AgWEpJhGgD/ady09sJwstZRSkT8r+EM6AmBX5xMvaLC53EEfdLbIGkdQ3Z
 aXFA==
X-Gm-Message-State: ABy/qLYXlBswupazoOWibpajmFXb9kaGwr1NLGM38yFTHZiEk0aPdOWm
 lL9ZvK2Eiokf7/OPCnH8JxVekk5UYPzpr3duSQjxhyeuaI6obv2TDZJxZQVb6wWD9iKIRG8bDPD
 PQuSSrvmA3pnTzNY=
X-Received: by 2002:a05:600c:219a:b0:3f7:e3dd:8a47 with SMTP id
 e26-20020a05600c219a00b003f7e3dd8a47mr3854314wme.11.1689851783536; 
 Thu, 20 Jul 2023 04:16:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYNm1Ho2aSZ3MyjFeYLKNGXXWLqQwrlhw3AqP1alyzsxRTDLm+86nufLSeEAyvPXp7hgJ0Qw==
X-Received: by 2002:a05:600c:219a:b0:3f7:e3dd:8a47 with SMTP id
 e26-20020a05600c219a00b003f7e3dd8a47mr3854307wme.11.1689851783241; 
 Thu, 20 Jul 2023 04:16:23 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 q3-20020a05600c46c300b003fc3b03caa5sm3959845wmo.1.2023.07.20.04.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 04:16:22 -0700 (PDT)
Message-ID: <7f5a5de1-6830-3c4a-9b87-995fc68fce24@redhat.com>
Date: Thu, 20 Jul 2023 13:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/nvme: use stl/ldl pci dma api
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230720094223.27767-2-its@irrelevant.dk>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230720094223.27767-2-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/07/2023 11.42, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Use the stl/ldl pci dma api for writing/reading doorbells. This removes
> the explicit endian conversions.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 42 +++++++++++++-----------------------------
>   1 file changed, 13 insertions(+), 29 deletions(-)


Reviewed-by: Thomas Huth <thuth@redhat.com>


