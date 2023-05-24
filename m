Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E41EE70F2B9
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:27:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1km2-0005q5-Ql; Wed, 24 May 2023 05:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1km1-0005pl-7V
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1klz-0004lg-TY
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684920431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8doqJFucJygx1DAUBs42oslGuibioM5nA5nbvNdNto=;
 b=IpMs8u963FzybUStQ8n7UShM9tLBmnq6KMRM2CzPb9Qr0IDs7F8BBeTq/zkR7t1CZy3spV
 ZNRgNkOy2Xdui8KjkAvLxGar1nff9CKf/hXYUvRLr7df+DhUM8DT0n2/Xph+5M1g4H1NMW
 oklri8FwzbV0dnG53LRjTqUNX1tnx3k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-3Mg5PfqhO4mYFIV8BDm0ng-1; Wed, 24 May 2023 05:27:09 -0400
X-MC-Unique: 3Mg5PfqhO4mYFIV8BDm0ng-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f4f2f5098bso4728475e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684920428; x=1687512428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l8doqJFucJygx1DAUBs42oslGuibioM5nA5nbvNdNto=;
 b=KPgycW8GJU317zCBI4RGtUzESuyXnYjnL1qCkWdCvJUvXWz6HKrR7QUEo3Ub/kAU6k
 h+IRnlhHYfWEYMIR2SFj6R6yX4NvF2SkhtI27LBlmBarwuJ3tpuF40qczzGOIyMiUxw/
 fkvz+qpsvZ+T1frQgcIwJXUtoHoBAckor2tJBuVeH53NwJ74q7W4zQtB1c+JFUe/8jjT
 x5t2HzYQVkmy3D6c6PGn1C/Kx+oJ9UvNWr5lt2nguy8/BbSk3GdMqZ6NyB1hcpiAAP3u
 eePnR8QuvKiKBL1s86u9d/FlSUtsskK2KvY4WsI8C/kNZRW+6pHpEpu9dIHD+W/+IgSO
 VPVA==
X-Gm-Message-State: AC+VfDwLEZRc+A34SXNp393QXMx5x0UZufC/SLydVq//J+fGYRoVhZ+w
 89ep2j2QumMauGWAo4oRdw2LVnZdEU7/OiERw18djXF4rxRK+gpNcdx4xeZQ+6KR2PaTvAWJjc8
 eJEVfsI8tOiaY5shiEOTqyxg3PNgAtd6pMRlKwB6N0akSt7QhLuclCYF17Y81KRH1851o4WM=
X-Received: by 2002:a1c:7311:0:b0:3f5:6e5:1689 with SMTP id
 d17-20020a1c7311000000b003f506e51689mr12705641wmb.17.1684920428770; 
 Wed, 24 May 2023 02:27:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6POKRu5zJlaIFhnV6oB1SeffYfDbHFdsinBuxonZ+XNZJ+6JGNSp0BtvURYA+zuHVNCkWmeQ==
X-Received: by 2002:a1c:7311:0:b0:3f5:6e5:1689 with SMTP id
 d17-20020a1c7311000000b003f506e51689mr12705621wmb.17.1684920428417; 
 Wed, 24 May 2023 02:27:08 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 g5-20020a7bc4c5000000b003f427687ba7sm1634124wmk.41.2023.05.24.02.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:27:08 -0700 (PDT)
Message-ID: <f1dde9bc-4b45-5a76-2cb0-edb0df2a22d8@redhat.com>
Date: Wed, 24 May 2023 11:27:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] hw/arm/sbsa-ref: honor "-vga none" argument
Content-Language: en-US
To: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <20230524083913.696175-1-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524083913.696175-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 24/05/2023 10.39, Marcin Juszkiewicz wrote:
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
>   
>       create_smmu(sms, pci->bus);
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>


