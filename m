Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F7802B2B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 06:02:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA16H-0002JQ-Ey; Mon, 04 Dec 2023 00:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA166-0002BK-2Z
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA163-0001Yt-6b
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701666138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3PsIIL5Ib1pyTFkNMNuOwTL7LiUmd0zN+mfcipb+sX4=;
 b=CpXKkI9Qlomj8H+INLjOoYCvOexPjgottl/Tv4P5eR830LzCncKBoH+x9dzDLL5MYMH2KT
 vHnd3APdzz5TAuhhwpcNevKVZK9hl0xym+oFG8qv4yimV/S8Xmkdjq3bQ67MOQx1IULS7K
 bQN+DF64U1q7LsJxHaG08G+9kxn2Oxo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-YkmYNUeNNFSXSocrxUo5Aw-1; Mon, 04 Dec 2023 00:02:16 -0500
X-MC-Unique: YkmYNUeNNFSXSocrxUo5Aw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d04d286b5cso32859355ad.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 21:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701666134; x=1702270934;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3PsIIL5Ib1pyTFkNMNuOwTL7LiUmd0zN+mfcipb+sX4=;
 b=cFOHnpZ0EMgB2sYB5KE/ddNXhs8H5TDS/wSW3s54xGEab9Hn2t/qGL6ss8Ab5IyeLI
 f6C8XlIOBJHe2eRj1/dEmlryfqtcfqOA6dcB9+UWJoPh/L0CWHXG8xLnytN2jLjM78XB
 OxnHwNnJdn2k9sdoIMqkBUSBfcKGjOX9BgrerLlcQngya5EQTFwl25kY6nj0K6bwb8jz
 F9HuGj0Q6TS8eWh7qJo36F8q1c0Qyb/Niv8y4VWS/2tveysrenW9Ua0F9/UdNH0VOC1d
 M/CVy8pmTWX46aFBxdUvfcSRUfJEa7FU7WUDt2BseAHAEiaQmhCOI48vz12qxPjOklyJ
 TG7g==
X-Gm-Message-State: AOJu0YwdwX4aEgp/zrPDXX/iO0Rd/V2Dlf+zleLVG5e1MoZudBb5uTmJ
 po/mneUkr1UMoL2m2a6UFeydiyAUPD08tWYRB4BIBRJH7Pojfdc0Alzoq7yDrsGDhUScH25QmU0
 7bj9Rrd21X6gcj761QbJODLw=
X-Received: by 2002:a17:902:968d:b0:1d0:6ffd:9e25 with SMTP id
 n13-20020a170902968d00b001d06ffd9e25mr3673487plp.119.1701666134727; 
 Sun, 03 Dec 2023 21:02:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQCdDDzlhQg093LYVFuDHyWN6QpfmvaV+UHhB9GUahCx3l9nKLtF4aW+sklC0eB8foKMgbSQ==
X-Received: by 2002:a17:902:968d:b0:1d0:6ffd:9e25 with SMTP id
 n13-20020a170902968d00b001d06ffd9e25mr3673483plp.119.1701666134461; 
 Sun, 03 Dec 2023 21:02:14 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.21.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 21:02:14 -0800 (PST)
Message-ID: <58282b3e-a86a-469b-9f9f-486010f48451@redhat.com>
Date: Mon, 4 Dec 2023 15:02:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 22/25] hw/sparc: Simplify
 memory_region_init_ram_nomigrate() calls
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
 Peter Xu <peterx@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-23-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-23-philmd@linaro.org>
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
> Mechanical change using the following coccinelle script:
> 
> @@
> expression mr, owner, arg3, arg4, errp;
> @@
> -   memory_region_init_ram_nomigrate(mr, owner, arg3, arg4, &errp);
>      if (
> -       errp
> +       !memory_region_init_ram_nomigrate(mr, owner, arg3, arg4, &errp)
>      ) {
>          ...
>          return;
>      }
> 
> and removing the local Error variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sparc/sun4m.c   | 20 ++++++--------------
>   hw/sparc64/sun4u.c |  7 ++-----
>   2 files changed, 8 insertions(+), 19 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


