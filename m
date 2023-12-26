Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F105881E739
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 13:09:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI6Ew-0007qB-61; Tue, 26 Dec 2023 07:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI6Et-0007po-Ii
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 07:08:51 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI6Er-0003PR-Ui
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 07:08:51 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d22d3e751so30851395e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703592528; x=1704197328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yp7V8Ra/80Vegj6Re0+Iy3f1Jpa7yFrSLqsBmK0ACgU=;
 b=qxo+ZzPdhGKTfJPBiwhQ+AtCD2dkmTt9YsP/95hR/v/sIIGrQs7hjbiSAO8zlrtFV1
 GIuSAGlGEQIbAaAuVNG3RrYE7fPDd3VC7ak14pQ+41L2KKvARljGRjEigwsaYlAfJfOV
 W5/fm4hkl20rPcmfavgFUd/uQ8Cj1a4qrnL5ybuG3qx4x6MXG5WxUsW8KlBBz21MVRWs
 f7laRWtEjft+weXr/IKkyy/nu+s5i70KUptqQCvVmNsgCySXDiXScxASnAUpsKQIN3/E
 ZzXtU+cCw6cYPFpvBtTsljnR8ZaSMODBrU/NJ0nrhXlvII0gWedQY9WGPFnvF6mP0bER
 RM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703592528; x=1704197328;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yp7V8Ra/80Vegj6Re0+Iy3f1Jpa7yFrSLqsBmK0ACgU=;
 b=W4/79vjrWTZuI08k+rrQw6zmYsSZ7d+bOf/Sfd8FW8EHGfsXs0adxCBwlqpfkO5Bkk
 Ot0kO+e4KUQf4aLaY1UlxMLEe8NNmB+7K7s+t7mj4Lr1jfWDcJzLlmvf5imQS7LtSV7b
 gG4hNiuqoDqSO9A2Gw/xAp0aU0oS+FZOZO95p8Shl4ScBePbbTeAH/RxtlI+8iUc7Tu4
 dxjX5iMgzOfTS8GgOMW11YKX7iEWu+sV7VERKYIUag/gs4m6kMkA0CXPx4jmvdi1s4Ki
 1edrANfc1d4FcMXDY2s+1OakOw9qjkAEBaFtdxH7++Kz2PsgMKfyJjxiGvBTTSdKIBNg
 gIPw==
X-Gm-Message-State: AOJu0YzynONSzwfpLYlaNuUbQh8Kc7sKKTyn1scYDMruM+NrqFhrl9c3
 7+Yo9dhxEDJJMqY+4jb50osIFz2IsB+50A==
X-Google-Smtp-Source: AGHT+IFojBgBgh8JIajrP4kiJVE3ocHfX3RCMXt1jzWRs0f0myWTyWAUVf1U/3nZZK7g7DAZKvoZKA==
X-Received: by 2002:a05:600c:b87:b0:40d:3869:7e41 with SMTP id
 fl7-20020a05600c0b8700b0040d38697e41mr3453935wmb.8.1703592528250; 
 Tue, 26 Dec 2023 04:08:48 -0800 (PST)
Received: from [192.168.96.175] (137.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.137]) by smtp.gmail.com with ESMTPSA id
 w5-20020a5d5445000000b0033660f75d08sm12496291wrv.116.2023.12.26.04.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 04:08:47 -0800 (PST)
Message-ID: <e05e239f-2d1d-4d9b-86bb-a1e9d9b98550@linaro.org>
Date: Tue, 26 Dec 2023 13:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] esp: process the result of scsi_device_find()
Content-Language: en-US
To: Alexandra Diupina <adiupina@astralinux.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
References: <20231218150213.27253-1-adiupina@astralinux.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231218150213.27253-1-adiupina@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Cc'ing Mark for the logical change (should we rather assert?).

On 18/12/23 16:02, Alexandra Diupina wrote:
> Add a 'current_lun' check for a null value
> to avoid null pointer dereferencing
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 4eb8606560 (esp: store lun coming from the MESSAGE OUT phase)
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>   hw/scsi/esp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 9b11d8c573..3a2ec35f9b 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -292,6 +292,11 @@ static void do_command_phase(ESPState *s)
>       esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
>   
>       current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, s->lun);
> +
> +    if (!current_lun) {
> +        return;
> +    }
> +
>       s->current_req = scsi_req_new(current_lun, 0, s->lun, buf, cmdlen, s);
>       datalen = scsi_req_enqueue(s->current_req);
>       s->ti_size = datalen;


