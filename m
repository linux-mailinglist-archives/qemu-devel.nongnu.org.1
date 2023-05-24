Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBB270F2BE
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:28:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kmh-0006bt-Dx; Wed, 24 May 2023 05:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kmf-0006V8-4y
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kmd-0004rG-ML
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684920471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufFcDheTSf78huTOmn56tXCiVzbq+QEy3Ph+84ltRvY=;
 b=Ctayd2Ezq4N2wlXgk4FpUl6KlX5hLSsCPIUumvByXo7lThS5CnTL8Pa6FpIgOBMar/uFcX
 PISYUruBVhoT9VXEQ4dxJO68D8X7uoJukmhfnjGA8qMqbPw0kcJ9aH9LfUKolHkaFle0Vp
 U/1T5LSCjfsaiyVxVqMN+Rr/yi7WC4o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-WUTl_VTWNf6wP3ScXVdmKQ-1; Wed, 24 May 2023 05:27:49 -0400
X-MC-Unique: WUTl_VTWNf6wP3ScXVdmKQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5d6dc52fdso4437165e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684920468; x=1687512468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ufFcDheTSf78huTOmn56tXCiVzbq+QEy3Ph+84ltRvY=;
 b=XpQJHGy31W6gc5Is4z6XMYzdNfNWaEeDDbiLWOpUthqQtWR9DovCufQ7qRO1JrTCGg
 68Wubp/jpeKl+iemT7POx7ITTiEzDABK8WXM9DoIRoaLyGFe5G2LOJghXWJC0GaM54uj
 PlpWOltk6iVo7woEs5Q18o+JQU+m43OddK8LymSabVMxBxjhMjnhCkJ1BggrKISMCDM5
 hAsLPIn0pyveL+o3/sDQl5gdopWdfbQoSa26XQhqUOt79/kxP6m5xDiiMcO8NPDgKTem
 JGeBpUbSldytQzGYNu69VC4dUpEPRNslhsMZomvzRUz7OtILhIu1fyd8lw9pzNCZMepO
 P+Gw==
X-Gm-Message-State: AC+VfDzwj7iX59iHeqO4/l9D0ZkKeCv0Mb1gG72C0immLxgz4iOLun5d
 m1Hp57od666CJ+1qtql/jicL5iyBhgAzwImevp0lRPcR8OvBeyx+MJBlmzlmGmap4A8dGdvNYTf
 MIZPiPTeumaeEuwTjyLOLDCQ7ZluJ7rzy5+oBfi1QoiWv+ZfIRpzFuIL+i/vpiNGs2ET9fPQ=
X-Received: by 2002:a05:600c:1c0a:b0:3f6:335:d8f0 with SMTP id
 j10-20020a05600c1c0a00b003f60335d8f0mr8132433wms.13.1684920468532; 
 Wed, 24 May 2023 02:27:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ734MaIXNKSTMI90wWT5MxqDKtaZTQNWoCh2TtQIz2ODJsLhzKJV01+St6k7OLLkBBF+3mHaw==
X-Received: by 2002:a05:600c:1c0a:b0:3f6:335:d8f0 with SMTP id
 j10-20020a05600c1c0a00b003f60335d8f0mr8132419wms.13.1684920468201; 
 Wed, 24 May 2023 02:27:48 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 13-20020a05600c24cd00b003f4dde07956sm1629948wmu.42.2023.05.24.02.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:27:47 -0700 (PDT)
Message-ID: <1eddac35-9a75-7a03-6501-6e50a0ba7cd7@redhat.com>
Date: Wed, 24 May 2023 11:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] hw/arm/sbsa-ref: add gfx card only if we have pci
Content-Language: en-US
To: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <20230524083913.696175-1-marcin.juszkiewicz@linaro.org>
 <20230524083913.696175-2-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524083913.696175-2-marcin.juszkiewicz@linaro.org>
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

On 24/05/2023 10.39, Marcin Juszkiewicz wrote:
> Creation of network card is guarded with check do we
> have pci bus. Do the same with graphics card.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index c540b2f1ba..9a3d77d6b6 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -647,10 +647,10 @@ static void create_pcie(SBSAMachineState *sms)
>   
>               pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
>           }
> -    }
>   
> -    if (vga_interface_type != VGA_NONE) {
> -        pci_create_simple(pci->bus, -1, "bochs-display");
> +        if (vga_interface_type != VGA_NONE) {
> +            pci_create_simple(pci->bus, -1, "bochs-display");
> +        }
>       }

I wonder whether pci->bus can ever be NULL in this function?

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>



