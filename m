Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 332A87AFE65
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 10:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlPuQ-00081A-Ny; Wed, 27 Sep 2023 04:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlPuE-00080G-KF
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlPuD-00071R-AP
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695803304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQV+9PKtEbpaKo2t0iq1bhNiyEuhWiqXnj6+OF5ST4s=;
 b=DvVk/EYwSAWk5bmBmL96sxRlXJGt6kJJHnHH2L81Y3COQG4f8cKC30gKqvO0P5oHRpypqE
 6CdKZ5XQBIYwxZLVW5JOWqMWeqXVoXQkU3eMVjTBafS9YIX1h17HEv7iK0J/+GzyZFaMov
 VuOVqcJ4i2v67Ax4i/H7xWIp2xZwmic=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-M3YVsJoaNJK4k19WdCzr1A-1; Wed, 27 Sep 2023 04:28:22 -0400
X-MC-Unique: M3YVsJoaNJK4k19WdCzr1A-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41805d9509aso93534381cf.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 01:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695803302; x=1696408102;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fQV+9PKtEbpaKo2t0iq1bhNiyEuhWiqXnj6+OF5ST4s=;
 b=qd91G5zdam/d22ii2z17oDybrmUl9yUqxrhfva0C/SxO2EnyEviPKrETBZv6LVQzN2
 uE+hPC068bsxw0ezT57hh95AypwCnzfuy7nu6DpLNJSr/LYaKgHyt4BX8KT2RthzFtYw
 krrrQBSh+erVCEEEgGdd3g2SLq+dRY6abUg6vMp4F7LIDKvzsfYu01IqiLn/QubbE7vN
 NuaIPh7PTtTDOsUSiu186EnF5SeCXN/51XkiAeWT9G3CsONMoXhQXUmX0p0d65IIjfxc
 Ce/5Kytc49frvgpjNVWicFuXo/xgCbN3A0WrnDFA/Sa3J1ReTRqMGuXW6hb8dBbFxfv5
 45wg==
X-Gm-Message-State: AOJu0Ywk81WR6gRGKwY9zwBEC/LREopjNoxvdT6ngjW6ooi2Ict5elhi
 ZsiYGATCYGt+43VEPdD9nyoNLC2tcLsCuAbebbnzRWQL8DKxKwCZfbsBJdVASe7q2NfAbK+1STM
 xRRtj1SL1etbmLDo=
X-Received: by 2002:a0c:e24e:0:b0:656:3045:5638 with SMTP id
 x14-20020a0ce24e000000b0065630455638mr1243529qvl.16.1695803302296; 
 Wed, 27 Sep 2023 01:28:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIl9BZ+qN7pPQwCvhJwGfP3XNJLfcHHsiAbZEvMvkJuBxZJzHIBssOB0elh6SjUas7Y20bjw==
X-Received: by 2002:a0c:e24e:0:b0:656:3045:5638 with SMTP id
 x14-20020a0ce24e000000b0065630455638mr1243523qvl.16.1695803302042; 
 Wed, 27 Sep 2023 01:28:22 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-22.web.vodafone.de.
 [109.43.178.22]) by smtp.gmail.com with ESMTPSA id
 p4-20020a05620a056400b0077412ca0ae1sm4849493qkp.65.2023.09.27.01.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 01:28:21 -0700 (PDT)
Message-ID: <6edeac78-cf2a-c9b2-0672-15956091795b@redhat.com>
Date: Wed, 27 Sep 2023 10:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] esp: use correct type for esp_dma_enable() in
 sysbus_esp_gpio_demux()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
 <20230913204410.65650-2-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230913204410.65650-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/09/2023 22.44, Mark Cave-Ayland wrote:
> The call to esp_dma_enable() was being made with the SYSBUS_ESP type instead of
> the ESP type. This meant that when GPIO 1 was being used to trigger a DMA
> request from an external DMA controller, the setting of ESPState's dma_enabled
> field would clobber unknown memory whilst the dma_cb callback pointer would
> typically return NULL so the DMA request would never start.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index e52188d022..4218a6a960 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -1395,7 +1395,7 @@ static void sysbus_esp_gpio_demux(void *opaque, int irq, int level)
>           parent_esp_reset(s, irq, level);
>           break;
>       case 1:
> -        esp_dma_enable(opaque, irq, level);
> +        esp_dma_enable(s, irq, level);
>           break;
>       }
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>


