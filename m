Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E58802B35
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 06:06:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA19D-000581-Tr; Mon, 04 Dec 2023 00:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA16V-0003Hp-GI
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA16T-0001fo-Ma
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701666164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQVBgghTw1IkrIC7RUvLQ9NlqSvSwNrEhXnaeQmAb8E=;
 b=jDx+8nrz6gai2/6lQmRuO9IUfAZFDBHOPKp1pRPosRbQMsQbOJ1NFfmx2PAOrt5Vj8zlM/
 r/+Rnko3hJWXCpofVOltLivTT2BYzxtJRnflJzFuDXAhko1OHM9uvgQy9OKDVNmuVZQAVu
 tqRVg1h8s3CAVICONV+NT25wJLbPiNY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-FO5D992tNP-bma_jYiySAA-1; Mon, 04 Dec 2023 00:02:43 -0500
X-MC-Unique: FO5D992tNP-bma_jYiySAA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1cfc2a7e382so20469345ad.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 21:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701666162; x=1702270962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EQVBgghTw1IkrIC7RUvLQ9NlqSvSwNrEhXnaeQmAb8E=;
 b=TRu1er5t9B+WAWf0gu7GQRnYT8Tr1xUtX9TrmwfVDLinO05Z4Wx2fya7rMAQdo0kAQ
 eCPk/wFFf+Uc1fbj277iLvsEFjAUkJIVDHi6J4MVdKoe8RrRnPofjPXYV1BMFcaEeAF7
 wdMH/w/e6j0pBzSLDtl4IerkZJMVP5Y3lzTnmcUS7JNceHeLZxWrYDsjcrcT/fDeH4lH
 PfmRvaDBimaHJ59dIDkICp8f8Efw6eaqcTPOSmzKMKOcVcKahFcHhFjlJXfPb2JpdBIY
 CBJRn5BP98cykm9SRBOKcchsGLeRZ0XKhkdObwduOH/cTYmVI4artIG2nrmFkhTuuWnZ
 ASwA==
X-Gm-Message-State: AOJu0Ywjc8z2LTclpq7lGVNNGQJP4IA9tF0bGUWJ+oPJ/3ab4SQGAWKJ
 ZFKIJPinnRAroF1Ya0/ATsjHLgwXl6if894o3Ar2MmJjVfSa8MwlE3d2fbcoL0hYCx0RUT3Yazs
 oP6/jiEM9W/JO4WQ=
X-Received: by 2002:a17:902:e845:b0:1d0:af63:2403 with SMTP id
 t5-20020a170902e84500b001d0af632403mr703493plg.50.1701666162073; 
 Sun, 03 Dec 2023 21:02:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxNPG06JbGNHB/DAPGX9M8YW904XmBmceTYLAOfYmi5b8rPlzLTyAVGhLcW0hPcsC07CQ6Cw==
X-Received: by 2002:a17:902:e845:b0:1d0:af63:2403 with SMTP id
 t5-20020a170902e84500b001d0af632403mr703474plg.50.1701666161842; 
 Sun, 03 Dec 2023 21:02:41 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.21.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 21:02:41 -0800 (PST)
Message-ID: <7f9928a0-62cc-4d11-9e02-c4c62f6be7a3@redhat.com>
Date: Mon, 4 Dec 2023 15:02:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 23/25] hw/misc: Simplify
 memory_region_init_ram_from_fd() calls
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
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-24-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> expression mr, owner, arg3, arg4, arg5, arg6, arg7, errp;
> @@
> -   memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp);
>      if (
> -       errp
> +       !memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp)
>      ) {
>          ...
>          return;
>      }
> 
> and removing the local Error variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/ivshmem.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>    


