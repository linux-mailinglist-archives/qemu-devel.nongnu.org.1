Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A54148200F7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 18:52:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJH10-0005ur-RR; Fri, 29 Dec 2023 12:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJH0y-0005uP-Cb
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 12:51:20 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJH0w-00011S-5F
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 12:51:20 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-553ba2f0c8fso8156189a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703872276; x=1704477076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4RdVyM7Hh+0urF7eoBiQejjbf+pBbEzep7SYz/us++E=;
 b=w8xx+KVa9qauKjs+rpnBzayko9BTjhUphU/UOgTbDPVHuzjiELwghnqAwWxLkoBnB8
 ZyGk0M/dsWUxaMCoCGJF/H4dq2vPp5FVkY76kakW6FbBvwArYp5rTVBl02vydggYQOrD
 aDdyqKhHLuduEEt2DQdWb/DzVcStIvsaVOL+Qa4ar5EvcuRPm+7/aEQE77hU28XsnMSS
 cHXoP/I9CSSAuzdLEPPldWwOyj7iQgf3I9IWyuI8fvNR22Um9J0IRNZTqa9lUU0x1Zyn
 vNp0ywvLnDwo768bMozXwcYc4WNQkF4KU6M0VPpvn1jIgJejpie9eBw6oxdHJ3CBt9rC
 5rSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703872276; x=1704477076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4RdVyM7Hh+0urF7eoBiQejjbf+pBbEzep7SYz/us++E=;
 b=teoM0ToVoRQS5bqJHfvgASDYjLvXzgdfG0uagwhmG3nlkVTYH7i2mRDFoXuXexGYY/
 gHhD5mkry76GVgQy452MIiy61KFs+ayKStvAKgIsMUKjqSNJS5UH2n7H8Yvy5zGTCqh9
 Sr1x6wGdNC3PZBbMg2yZddu8/dBWMelQt2a7nh0IDgZNjhsJU9vCuJuJ9MXFGPR6TgMX
 QGbiFiIBxEAVVrGz0UBcaTN2QqDzffWUAuCKOWqCFKx2lTk3E8HkITT3Zukgv2rFsR17
 EDI+d7QpbHevZ2NOxP7tre7hrCblQUnG2D2LDjzttKU21fdWDWXeYOVyb4zsgBJmLGYj
 Or0A==
X-Gm-Message-State: AOJu0Yz9cJPZ4ikpTCt+uwzqJUCpV9qbe9/tyRKHwW276PbDUgSp1qiQ
 FYP+rssZTna2uiUUus+cC4EUKXyGG/IBNg==
X-Google-Smtp-Source: AGHT+IH2oI4CgTrlcvj9pESAVKMMY9pTbaFtp3NAP3Vu3m9xgTz+KNCYWIDnjuJuy8XrDDe8pjtrRA==
X-Received: by 2002:a50:ab54:0:b0:54b:f643:e45b with SMTP id
 t20-20020a50ab54000000b0054bf643e45bmr5101143edc.37.1703872276007; 
 Fri, 29 Dec 2023 09:51:16 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 cq8-20020a056402220800b0055507ee70a4sm5240507edb.23.2023.12.29.09.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 09:51:15 -0800 (PST)
Message-ID: <85be3ca7-4482-48cd-8676-8e2c192d4361@linaro.org>
Date: Fri, 29 Dec 2023 18:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] esp: process the result of scsi_device_find()
Content-Language: en-US
To: Alexandra Diupina <adiupina@astralinux.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231229152647.19699-1-adiupina@astralinux.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231229152647.19699-1-adiupina@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Cc'ing Mark.

On 29/12/23 16:26, Alexandra Diupina wrote:
> Add a 'current_lun' check for a null value
> to avoid null pointer dereferencing and
> recover host if NULL return
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 4eb8606560 (esp: store lun coming from the MESSAGE OUT phase)
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v2: duplicate the scsi_device_find() logic from esp_select()
>   hw/scsi/esp.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 9b11d8c573..03fdd53de6 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -292,6 +292,16 @@ static void do_command_phase(ESPState *s)
>       esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
>   
>       current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, s->lun);
> +
> +    if (!current_lun) {
> +        /* No such drive */
> +        s->rregs[ESP_RSTAT] = 0;
> +        s->rregs[ESP_RINTR] = INTR_DC;
> +        s->rregs[ESP_RSEQ] = SEQ_0;
> +        esp_raise_irq(s);
> +        return;
> +    }
> +
>       s->current_req = scsi_req_new(current_lun, 0, s->lun, buf, cmdlen, s);
>       datalen = scsi_req_enqueue(s->current_req);
>       s->ti_size = datalen;


