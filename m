Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 338ED70F494
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 12:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1m4j-0005Pl-W1; Wed, 24 May 2023 06:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1m4h-0005Ot-A5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1m4f-0005tj-R0
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684925433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tg9A53sw9YkDVVqjhs6LhBWqtblAEzt4rZTB7Jvd5nM=;
 b=baPQnh3B92GeqYLnk7EaV32lUKwZv5YJLwb5C96h+uUBDIP8S0e3G+FSvvtL63lmAdhDa1
 ZpmNZxYRS6eiQoitw9ec8adC019+fUDPKEjVSw7dMlrLnSBbsntFcsO0Q0/Rf75jviircl
 6fwCHKy2P/xxtzSxb9nrIqiMHpl+ff0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-OiTrCcrAMNO3ZubKPL_auw-1; Wed, 24 May 2023 06:50:31 -0400
X-MC-Unique: OiTrCcrAMNO3ZubKPL_auw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f61408d926so1939245e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 03:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684925430; x=1687517430;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tg9A53sw9YkDVVqjhs6LhBWqtblAEzt4rZTB7Jvd5nM=;
 b=AGUzKtHKns9a1j/DoXSGDH4yIVYQh96VRi2jesmlMnS9uDopY/avDQTw5MsZSsxIUI
 i+qzhfLefydEK6iriQUC5/f3PPX3BSWDCH+IcDzakWdqWmOv+p47ts6FHv7ECKskIr7E
 O9AxehzTmlWGShJRLq7VLXxG394MNs7MQJIB8jYBaESz9X6JPRTJ7NQZzEonPHYWHIiz
 QG78CR/SgdtLa3YDCWYSkLWJ6ZNb3rdNzuTAGJ+Ofdu3XiN4+mxQEnJCjHy8Tane5eBd
 KcKbJKJ4ZPZHp2sWNoDq5VchxYR9YkTiauj42UdcJcbq9LJqYovjeP1aM4pqyDIzZOHq
 Z8Vw==
X-Gm-Message-State: AC+VfDxNquMgHaOJQ6BgIoPSuJ+FLTMgrfAHTUIJOmzW53V+ciOzFmD/
 6KGqhHQkNqZTAiES7EPPPzzZzkq5M83yIcZJI1r5MNi6DW5wnz7j5aZzA/rvvF85Xx1ks3LtnBP
 3DOGb6QDCHd0n4GU=
X-Received: by 2002:a1c:ed0d:0:b0:3f4:2897:4eb7 with SMTP id
 l13-20020a1ced0d000000b003f428974eb7mr12033327wmh.38.1684925430379; 
 Wed, 24 May 2023 03:50:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ433vLdvBnnyvYqwygyulFM1zHo86DL8P9F48zaio17giuJt10pGAXgzvUtGUbBeQU7kBJOKQ==
X-Received: by 2002:a1c:ed0d:0:b0:3f4:2897:4eb7 with SMTP id
 l13-20020a1ced0d000000b003f428974eb7mr12033312wmh.38.1684925430141; 
 Wed, 24 May 2023 03:50:30 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 l5-20020a1c7905000000b003f4289b18a7sm1971136wme.5.2023.05.24.03.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 03:50:29 -0700 (PDT)
Message-ID: <c4981714-e3d6-e035-cf88-338d8d018fbd@redhat.com>
Date: Wed, 24 May 2023 12:50:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/5] hw/arm/sbsa-ref: honor "-vga none" argument
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230524102729.810892-1-marcin.juszkiewicz@linaro.org>
 <20230524102729.810892-4-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524102729.810892-4-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 24/05/2023 12.27, Marcin Juszkiewicz wrote:
> In case someone wants to run without graphics card.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 9c3e670ec6..c540b2f1ba 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -649,7 +649,9 @@ static void create_pcie(SBSAMachineState *sms)
>           }
>       }
>   
> -    pci_create_simple(pci->bus, -1, "bochs-display");
> +    if (vga_interface_type != VGA_NONE) {
> +        pci_create_simple(pci->bus, -1, "bochs-display");
> +    }

Once you extended pci_vga_init(), I think you should simply replace this 
line with pci_vga_init(pci->bus) - then you get the handling for VGA_NONE 
and other graphic adapters automatically (especially one could use "-vga 
std" to switch back to the normal VGA card that was used in former times).

  Thomas



