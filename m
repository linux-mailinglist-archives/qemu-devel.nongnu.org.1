Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476307AFE26
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 10:21:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlPmW-0005iC-8Q; Wed, 27 Sep 2023 04:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlPmL-0005ha-Ty
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlPmC-0002Li-K8
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695802806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJ4xnx4WnuinmNUwGW56pjc78PnAMqAi0DtpPDxVE5s=;
 b=ReOx6yU1ZYuObvWzIviQd5UXxeoMmYivNrqd8z7wxZ1Tt3mkq8tVjK51N9aWLzL0o4kmHK
 5qpLRqBlnNb5uH+3OGi8vX7wnrthkOOv20MFbat2fmj4QV3k7MaesKn30Amv332cFTPhST
 7UqekKC4CXKZ4nQ+p9jr/LfknjpGpYQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-kFtpcib5NvSFmbQyW-DSpg-1; Wed, 27 Sep 2023 04:20:04 -0400
X-MC-Unique: kFtpcib5NvSFmbQyW-DSpg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65af758fa1eso149287256d6.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 01:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695802804; x=1696407604;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJ4xnx4WnuinmNUwGW56pjc78PnAMqAi0DtpPDxVE5s=;
 b=nEOIAsQhcKPLwVTLrgCtA0iOOytoHQW0/ZBHhpx6HKQAYqswLMIcOmhmou8VsKsmWT
 0FGf9SWSMhsnVfCsy4QRMNCEIw/slM5BxJ25vDScVE9EqdJNTEkiEq6Cx21QXCTLejQD
 dJ1G8Vl/TWFn5zafR0638h9nCsfOJ1SOMJM6/53hE710TCCP4A5chSJjJStcDuip2Pky
 FM/G9+AB3NOj3aWThp7sE2XGqjFPPHhdyOLmBRfIBk+yWrxwPfuAY8GxiK6DM1OgL7SI
 OW9cdILwHcPcNFzxnwSvxbSmgzH6GVhSyXPp0eZ1qv3Uc9BhgjckjFsFYBkxU8CaffkB
 z2iQ==
X-Gm-Message-State: AOJu0Yyfs8xWpaba9N97AA7KqPox+eKFkSw8YfVYaZNnTp8BxHV91fgz
 uzlcSfArWR89JNYyicQ+zmqBdpc2GTjmYzBcqTey0uTNtoMS+r1mYtZKZJ1Z8+3iF14/5PVh0yP
 DuRco8c/Xzcr+3eI=
X-Received: by 2002:a0c:a998:0:b0:649:384f:ed4 with SMTP id
 a24-20020a0ca998000000b00649384f0ed4mr1602426qvb.19.1695802804476; 
 Wed, 27 Sep 2023 01:20:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd2zZhQiPncz51nRGpKqUiuNpEsOjuxpIyDUbm3JZR5QCYtnsGsxI3lzI3bbN6kG93QhNABg==
X-Received: by 2002:a0c:a998:0:b0:649:384f:ed4 with SMTP id
 a24-20020a0ca998000000b00649384f0ed4mr1602416qvb.19.1695802804199; 
 Wed, 27 Sep 2023 01:20:04 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-22.web.vodafone.de.
 [109.43.178.22]) by smtp.gmail.com with ESMTPSA id
 4-20020ad45ba4000000b00655ec7bbfd0sm4527032qvq.7.2023.09.27.01.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 01:20:03 -0700 (PDT)
Message-ID: <1632e156-f4a3-b782-d52a-c0862357b7c4@redhat.com>
Date: Wed, 27 Sep 2023 10:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] esp: restrict non-DMA transfer length to that of
 available data
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
 <20230913204410.65650-3-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230913204410.65650-3-mark.cave-ayland@ilande.co.uk>
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
> In the case where a SCSI layer transfer is incorrectly terminated, it is
> possible for a TI command to cause a SCSI buffer overflow due to the
> expected transfer data length being less than the available data in the
> FIFO. When this occurs the unsigned async_len variable underflows and
> becomes a large offset which writes past the end of the allocated SCSI
> buffer.
> 
> Restrict the non-DMA transfer length to be the smallest of the expected
> transfer length and the available FIFO data to ensure that it is no longer
> possible for the SCSI buffer overflow to occur.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1810
> ---
>   hw/scsi/esp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 4218a6a960..9b11d8c573 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -759,7 +759,8 @@ static void esp_do_nodma(ESPState *s)
>       }
>   
>       if (to_device) {
> -        len = MIN(fifo8_num_used(&s->fifo), ESP_FIFO_SZ);
> +        len = MIN(s->async_len, ESP_FIFO_SZ);
> +        len = MIN(len, fifo8_num_used(&s->fifo));
>           esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
>           s->async_buf += len;
>           s->async_len -= len;

Thanks for taking care of this!

Reviewed-by: Thomas Huth <thuth@redhat.com>


