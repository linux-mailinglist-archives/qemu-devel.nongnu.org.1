Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B3E7A926B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:00:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEao-0005pV-Jm; Thu, 21 Sep 2023 03:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEa3-0004aD-BC
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:58:36 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEa1-0002UB-NX
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:58:35 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fdd6011f2so487994b3a.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695283112; x=1695887912;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3DrpI+ZHGjv2FRmLG9rSaZtdD/DlF4umIrUK5n93qbQ=;
 b=aSTxmYH0YsIHn+ickX7Jf5eLe76RjfpQuQtePhKabLFuX64L/dTpotUdtzi8ErfM9v
 D1G/8Hh3muZiCJ2yGczzQnNGo6O8zFmLUviUD62aRq6MeMTnA7qJRpF4myp5b8sHKe7I
 KGXjzglBs8d0X6f6BqZewNO6SbSgpxBjK7yVLOs4r1rZ/yiYqHqIIiUp+ozVCal0KY2G
 57IErcBDBoC6ot/eaCfoza1OLDMX5zlZtMPcxVTFMX9mpXZTYbcGiHJAeBSlRazeRJTE
 SOFhAdvvusYqxmvpzTmdXZO2gFxrRD32sNh3h+HZB7ms7kh/nTToi9Gg/b9OIoJCMQVU
 t9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695283112; x=1695887912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3DrpI+ZHGjv2FRmLG9rSaZtdD/DlF4umIrUK5n93qbQ=;
 b=QCQ4uy8iFGMnC9FTVZV+3fIbqBO26dZchdmxZfCRgWTz7GEUZ4agDaeFJF4WNNXy6I
 0vkSt0OngKz0WvYD++zOyNDBXfH4uODAA7lsz0ZZNO+P7/VO85CJXOtRojzaBPBRqzqT
 GIdPRX4WH12QV0/z5cFHot9g2+hp2TeXE7WR19xo3f3XqlGvkgFTJqUd1VQX2Tcx/QuF
 uXy2xyGo++Ensb32yTH5FyizxHOvayB8xIgcO5/xTaf1a0AiZjBqNv0ZYj+mZMmGu6/7
 eHFkIZhhbV7MBDSqijP5ACekYkfIn3TFfe9ciRIoSV1nU5c2BymN9BcM2C4LTQvcf0EV
 GPgw==
X-Gm-Message-State: AOJu0Yx7sG2rJIvbz8mqtK6IuN3kKwh0065JLQwUGMrVxqX35FeYaPHp
 RKbWnSqt/5zz6VaD4VP4qd9DpQ==
X-Google-Smtp-Source: AGHT+IE6XeFeECvjXbFKujkrYJ8jWg5fXQdecijPB3uoidUlINGvVMXVZWnV/LlR5MCJMlQlgVGNiQ==
X-Received: by 2002:a05:6a00:4783:b0:690:cd33:a582 with SMTP id
 dh3-20020a056a00478300b00690cd33a582mr3537390pfb.7.1695283112574; 
 Thu, 21 Sep 2023 00:58:32 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 fe18-20020a056a002f1200b0069102aa1918sm726832pfb.48.2023.09.21.00.58.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 00:58:32 -0700 (PDT)
Message-ID: <f3895076-5ccc-4542-8cc5-635a99cff182@daynix.com>
Date: Thu, 21 Sep 2023 16:58:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] qga: Remove platform GUID definitions
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>
References: <20221110100629.61496-1-akihiko.odaki@daynix.com>
 <20221110100629.61496-2-akihiko.odaki@daynix.com>
 <CAPMcbCrGkXzeZex_veDYV8HSMMzH8d=zy1jkf21t4qFekGmDpg@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAPMcbCrGkXzeZex_veDYV8HSMMzH8d=zy1jkf21t4qFekGmDpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2022/11/17 18:45, Konstantin Kostiuk wrote:
> Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com 
> <mailto:kkostiuk@redhat.com>>
> 
> Will merge this patch in QGA series
> 
> On Thu, Nov 10, 2022 at 12:06 PM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     GUID_DEVINTERFACE_DISK and GUID_DEVINTERFACE_STORAGEPORT are already
>     defined by MinGW-w64. They are not only unnecessary, but can lead to
>     duplicate definition errors at link time with some unknown condition.
> 
>     Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>     ---
>       qga/commands-win32.c | 7 -------
>       1 file changed, 7 deletions(-)
> 
>     diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>     index ec9f55b453..dde5d401bb 100644
>     --- a/qga/commands-win32.c
>     +++ b/qga/commands-win32.c
>     @@ -506,13 +506,6 @@ static GuestDiskBusType
>     find_bus_type(STORAGE_BUS_TYPE bus)
>           return win2qemu[(int)bus];
>       }
> 
>     -DEFINE_GUID(GUID_DEVINTERFACE_DISK,
>     -        0x53f56307L, 0xb6bf, 0x11d0, 0x94, 0xf2,
>     -        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
>     -DEFINE_GUID(GUID_DEVINTERFACE_STORAGEPORT,
>     -        0x2accfe60L, 0xc130, 0x11d2, 0xb0, 0x82,
>     -        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
>     -
>       static void get_pci_address_for_device(GuestPCIAddress *pci,
>                                              HDEVINFO dev_info)
>       {
>     -- 
>     2.38.1
> 

Hi Konstantin,

This patch seems missed since then. Can you merge it?

Regards,
Akihiko Odaki

