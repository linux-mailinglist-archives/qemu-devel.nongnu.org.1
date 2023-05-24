Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B65170F2B8
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kki-00053i-8x; Wed, 24 May 2023 05:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kkg-000537-Ql
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kkf-0004bd-CY
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684920348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZYikMW0jaMSlUycj9Phvy/pyaB4j3LM1eh7OhJrSgg=;
 b=ak964rv4WW/Inba1evo6Q5i1+JLE9AElkaElpP/1V45SA4fja6XzTRlZGIsrVJ47oywoZO
 bu2NGso8vt+RNAefYb3s7jodgxVMNCJqj4RwP8OylKXeNhHISb+dN3w/DCPVHTZRsX8XCS
 qEaiJRTOfjrPJ7QHfvMFXxfSQx4ABA8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-_j_qUkwsMLmLyaEo_s0kNg-1; Wed, 24 May 2023 05:25:47 -0400
X-MC-Unique: _j_qUkwsMLmLyaEo_s0kNg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f6045853c1so2834465e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684920346; x=1687512346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mZYikMW0jaMSlUycj9Phvy/pyaB4j3LM1eh7OhJrSgg=;
 b=RStHhPcg9hae6lzZyh5L1GjqIl6t/1ZfoP8LsHt3Hl0azw+dXhzYm9216masbLNRaf
 VyqjdRU4oLS+gNUhOxB3zZ6ITh+uOb6+KPXckWGtyihNhLCfNmSISyipFRjEuxnA5jWN
 FT1NzXGqjbxe5ImXkmb742rTlRAA54X0LfSnqY/IRxA1OretKrjIFJZv2YNeM5rp7kNa
 UArTZh94Lo+U4INYTtZvCnCVbMHR0DGz26PYzW6IYKs3ug4/OX/FeLXVpldorONn+N5o
 PnYv47n1XbYKYafkDJJg+atmt686mARbn6mYlV8oc1yhYZYq7zdM/NaExHT/2HDuk/nK
 qLgg==
X-Gm-Message-State: AC+VfDzQJ+sf6+l99WKdLc4JIKpO/3jnEcUT0C7xJsmrCUfpQ2j+69gq
 SQXYMtN6ScXCpKoOUxq6zc4C5mhVxbLfYOaPheguJ1w6Hu8KspRxuD6isIAJ/GrvXoftvOzfrgb
 GHOf3Tw3+TWyiN2K2g1CYQHdLCkC2VRcj9w+Mf12bfm/p/mR9mdcPbB0TpBWNF8G9erriO5E=
X-Received: by 2002:a7b:cd8b:0:b0:3f4:e4f5:1f63 with SMTP id
 y11-20020a7bcd8b000000b003f4e4f51f63mr10292539wmj.41.1684920346076; 
 Wed, 24 May 2023 02:25:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74WPsyRq821cwonx3t2rnTh5PUjNxAZ2D5S1qFRI96KBoaJ67MkgF0PRG3bsvkmQ/tg3uFaw==
X-Received: by 2002:a7b:cd8b:0:b0:3f4:e4f5:1f63 with SMTP id
 y11-20020a7bcd8b000000b003f4e4f51f63mr10292525wmj.41.1684920345770; 
 Wed, 24 May 2023 02:25:45 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 n11-20020a05600c294b00b003f6129d2e30sm1708857wmd.1.2023.05.24.02.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:25:45 -0700 (PDT)
Message-ID: <94fa33bb-56a7-8c08-4edb-3283745ad903@redhat.com>
Date: Wed, 24 May 2023 11:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] hw/arm/sbsa-ref: use MachineClass->default_display
Content-Language: en-US
To: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <20230524083913.696175-1-marcin.juszkiewicz@linaro.org>
 <20230524083913.696175-3-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524083913.696175-3-marcin.juszkiewicz@linaro.org>
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
> Mark the default graphica via the new MachineClass->default_display
> setting so that the machine-defaults code in vl.c can decide whether the
> default graphics is usable or not (for example when compiling with the
> "--without-default-devices" configure switch).
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 9a3d77d6b6..30ce7f7db4 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -649,7 +649,7 @@ static void create_pcie(SBSAMachineState *sms)
>           }
>   
>           if (vga_interface_type != VGA_NONE) {
> -            pci_create_simple(pci->bus, -1, "bochs-display");
> +            pci_create_simple(pci->bus, -1, mc->default_display);

Based-on: <20230524082037.1620952-1-thuth@redhat.com>
(otherwise you don't have the "mc" variable available here)

>           }
>       }
>   
> @@ -865,6 +865,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
>       mc->default_ram_size = 1 * GiB;
>       mc->default_ram_id = "sbsa-ref.ram";
>       mc->default_cpus = 4;
> +    mc->default_display = "bochs-display";
>       mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
>       mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
>       mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;

I guess this might not work as expected yet...

The code in vl.c looks through the vga_interfaces[] array and warns if it 
cannot find the default_display there... and since there is no entry for the 
bochs-display in that array, you likely now always get this warning message, 
even if it is available?

So I think you either have to drop this patch, or you've got to add an entry 
for the bochs-display to vga_interfaces[], too.

  Thomas


