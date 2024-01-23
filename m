Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BD838CD7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:04:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEYz-0006ZF-Bn; Tue, 23 Jan 2024 06:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rSEYv-0006Yq-UH
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:03:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rSEYu-0002vJ-AS
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706007803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s6w7nZLqpbikdJBSQd58uNaPb3qOIQoebYpUpcckZu4=;
 b=HIYJvaYOUCRDOA8h4lwlsZVMPLnQY0xv+XExhLpAD8cjEs7DmjhU2Wek8K9OTBXe8YWrV6
 j9Gx8Vo5qR4WighnoF4jL7+YpCqhX58ymeaGojGcIDalADbZq7zEHLy4QO9LxcIlciIFFW
 5hLkeOwc2e2AYT7W2KKiU4DPEEORFy0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-ejSiQi5EM5uN5zqwltiFtQ-1; Tue, 23 Jan 2024 06:03:19 -0500
X-MC-Unique: ejSiQi5EM5uN5zqwltiFtQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3bd49f232c8so4507774b6e.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706007798; x=1706612598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6w7nZLqpbikdJBSQd58uNaPb3qOIQoebYpUpcckZu4=;
 b=XHPD++Fbl2+b3EhPrhgddLAvCP5jPwI3+CdgIMXOC3Ggi4PqLVTwSuB8BdOv4erTlv
 MQ7hr5YRYfki4SIEPOqORW89ra9bGAyugyAmnUThIdecMH0CQzfup0BYBBS5RZaQ/6Y1
 k7nB9alLSQuAS+dQcrgWVdp1a73Lc7PhPK1lP/3Yprt280P+IghAr+p0fsPN05EHgizM
 UqG4LSVL5IHMnGiT9B2ETgEj+M1kymYaVXa3/+EaCPSYKZVxBHp1yALkyB+IX4Nh1XmT
 KhIF8LS1DBGHxKm49rCTNGrt7EI/DFWOr95fRzGZyuI5hScxBCq0eXD5b3G+YLa69nfu
 LnQQ==
X-Gm-Message-State: AOJu0YzC9YK14+EO5gHToYSM6v8PJQfzlPdyEyaMVFV98YF/Akh40hSD
 NpefQ6YcaINlVqpE+HvoGtN9Mq9/s6l47ONthxVVAHuInODWheZ4E8XBJILhYHtxRm/8HIxIpdl
 ul68rK+ZlOcPVbXiR+WVUxYfZASp22iCdgghNKG2syCOgHQ5ntkVZ
X-Received: by 2002:a05:6808:2103:b0:3bd:ad1a:7fe6 with SMTP id
 r3-20020a056808210300b003bdad1a7fe6mr3102650oiw.1.1706007798514; 
 Tue, 23 Jan 2024 03:03:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnQTvp6a4JjdCcOZUW2dzvNlonc32UgL+KzEWlg7ouc7gVyY3UPHpgnBm/D9ssT9m0XU0KIQ==
X-Received: by 2002:a05:6808:2103:b0:3bd:ad1a:7fe6 with SMTP id
 r3-20020a056808210300b003bdad1a7fe6mr3102644oiw.1.1706007798233; 
 Tue, 23 Jan 2024 03:03:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ca9-20020a05622a1f0900b00429b97f01dcsm3389428qtb.9.2024.01.23.03.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 03:03:17 -0800 (PST)
Message-ID: <eaf71668-fe0d-45db-817e-fe052df91c17@redhat.com>
Date: Tue, 23 Jan 2024 12:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/raven.c: Mark raven_io_ops as implementing
 unaligned accesses
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>
References: <20240112134640.1775041-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240112134640.1775041-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/12/24 14:46, Peter Maydell wrote:
> The raven_io_ops MemoryRegionOps is the only one in the source tree
> which sets .valid.unaligned to indicate that it should support
> unaligned accesses and which does not also set .impl.unaligned to
> indicate that its read and write functions can do the unaligned
> handling themselves.  This is a problem, because at the moment the
> core memory system does not implement the support for handling
> unaligned accesses by doing a series of aligned accesses and
> combining them (system/memory.c:access_with_adjusted_size() has a
> TODO comment noting this).
> 
> Fortunately raven_io_read() and raven_io_write() will correctly deal
> with the case of being passed an unaligned address, so we can fix the
> missing unaligned access support by setting .impl.unaligned in the
> MemoryRegionOps struct.
> 
> Fixes: 9a1839164c9c8f06 ("raven: Implement non-contiguous I/O region")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Spotted by code inspection: I was looking for devices whose behaviour
> might be changed by a patch I'm reviewing that adds that missing
> support for unaligned accesses in the core memory system. But even
> if we do implement it there, it's more efficient for the raven MR
> to correctly mark it as handling unaligned accesses itself.
> 
> Tested with 'make check' and 'make check-avocado' only.

It doesn't affect the prep machine boot with OpenBIOS and a
"Debian GNU/Linux 3.0 6015" image.

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   hw/pci-host/raven.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index c7a0a2878ab..a7dfddd69ea 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -200,6 +200,7 @@ static const MemoryRegionOps raven_io_ops = {
>       .write = raven_io_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .impl.max_access_size = 4,
> +    .impl.unaligned = true,
>       .valid.unaligned = true,
>   };
>   


