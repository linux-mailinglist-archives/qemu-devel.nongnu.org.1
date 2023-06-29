Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BAC7428FF
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEt6K-0000s9-Sm; Thu, 29 Jun 2023 10:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEt6I-0000r9-5n
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 10:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEt6E-00076Q-Mm
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 10:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688050701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dpf4SJHgWwROyUacCORRSpJuSmOpwbMA9DPWbcP4mTA=;
 b=PQiEe56mmUYNREYpJklgOvD6LIm9L4anzXMnjCu9SgcVpm99B/Am6OohEXO7vWgz4hKf2H
 TpOPAr3cyLxG18dywa9An2SojJOIwVmw5ujeT3Oa+nUGhb/fW4ZdKdYr3nz7jDNsBrdeFx
 DSZVDSrKyqNLFnaGa5pXBJ7DHb4KMHI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-nvKjz45zPXGVutpIAxa1WQ-1; Thu, 29 Jun 2023 10:58:20 -0400
X-MC-Unique: nvKjz45zPXGVutpIAxa1WQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fa979d0c32so3758855e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 07:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688050699; x=1690642699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dpf4SJHgWwROyUacCORRSpJuSmOpwbMA9DPWbcP4mTA=;
 b=RGLGaYt6q9uRwV8bwVKucakjb8ONp12Jz42t1Tq+vCDpwIFkUM03BUd1C8WEAVc8V9
 wHup82UXZ8DPFrasrjFMBIiaCncdwcnxRA1Y2NEDkBvuEbE8UVa09z0lsPMfwap3Y1J3
 ICWzKG4aCvRVptDguCasqMGEqnNSPPy1stkdoe2yaYtrkXZTvZb83of+XAhSSSnDhJUZ
 0dbNW2x4K4DotQwqobNN6JqOTQ4EYZiOAFhmpsIUfZ8w/TJRxif/XJIyHU66ey4C8RRg
 AQ/R7IasvhXGVh9yXSj+eP0PxjScNxYhb+0PqC7a9Tw0CmBDGENYiOSglM4GojFQ/689
 8kaw==
X-Gm-Message-State: AC+VfDw6/UpSOQd0IOccEI3lXthUTW/8DsbvkPghoTRx45bX3pxJNc/8
 +C0Q9o0Wz+qTqNCOtYPwJ03duz5QRWpdh7BHWRQL0B6HAyOgwU1WPOerSLGqjxZxnLWspO6Pu9S
 rNx8qyEcUmZnmQ44=
X-Received: by 2002:a7b:c8d8:0:b0:3fb:b1bf:7df3 with SMTP id
 f24-20020a7bc8d8000000b003fbb1bf7df3mr4060809wml.16.1688050699276; 
 Thu, 29 Jun 2023 07:58:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zdjLiJBM8xSkXYa9Olo6ZnoPBMZVIPmQnWD5/v4TnCbB75yBAC9qgf2L45A50Xxhsz0vTCA==
X-Received: by 2002:a7b:c8d8:0:b0:3fb:b1bf:7df3 with SMTP id
 f24-20020a7bc8d8000000b003fbb1bf7df3mr4060794wml.16.1688050699018; 
 Thu, 29 Jun 2023 07:58:19 -0700 (PDT)
Received: from [192.168.8.100] (tmo-067-34.customers.d1-online.com.
 [80.187.67.34]) by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b003fbacc853ccsm5422266wmc.18.2023.06.29.07.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 07:58:18 -0700 (PDT)
Message-ID: <509ddf59-b401-41c5-099a-0acbf2c94f11@redhat.com>
Date: Thu, 29 Jun 2023 16:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hw: Simplify calls to pci_nic_init_nofail()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20230629125449.234945-1-thuth@redhat.com>
 <dc6a61da-73d0-d0ae-fc62-3a04ccea5417@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <dc6a61da-73d0-d0ae-fc62-3a04ccea5417@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 29/06/2023 15.47, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 29/6/23 14:54, Thomas Huth wrote:
>> pci_nic_init_nofail() calls qemu_find_nic_model(), and this function
>> sets nd->model = g_strdup(default_model) if it has not been initialized
>> yet. So we don't have to set nd->model to the default_nic in the
>> calling sites.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/arm/sbsa-ref.c        | 8 +-------
>>   hw/arm/virt.c            | 8 +-------
>>   hw/loongarch/virt.c      | 8 +-------
>>   hw/mips/loongson3_virt.c | 8 +-------
>>   hw/xtensa/virt.c         | 8 +-------
>>   5 files changed, 5 insertions(+), 35 deletions(-)
...
> This remind me of a branch from end of April with this
> unfinished patch, did we already discuss this together?

No, I haven't seen your patch yet, neither we talked about it. I came up 
with the idea for my patch on my own after looking at certain spots in the 
code. But I guess you could easily rebase your patch on top of mine in case 
you want to finish it ;-)

  Thomas


