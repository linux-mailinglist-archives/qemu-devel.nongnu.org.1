Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F4F7D47D4
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 08:59:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvBNz-0006QG-GJ; Tue, 24 Oct 2023 02:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvBNx-0006PS-DV
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:59:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvBNv-0000kt-Tt
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:59:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so35289865e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 23:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698130766; x=1698735566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3LKoaw12Kegy/5Wwnu5bK7CWabfG8BwbA9wvMxlQdZI=;
 b=RgiIgt75xS1g81WSUjRKC7povlAyiTKzMrFW8j2EIwgYs9e5ASELiKbDSWa7lCCErB
 FSBYPHS9ch5qy1sQZGBrOIpJW7hfPg+rX8hpWdbuEaoz9w8LdKwQYY0EAfzFHYp5CsKh
 1Oqh7IBmOj7pM4GDX7iw06ZZULSJPOkuGUFVQ+bpuxMeLwlecUaiBzuzIRM3zhqyf05I
 64qp6RMqSHBsdF4keTtA+XS1+yvbCvQSg5+8bJpzBDef6StWbzYf/UJcPcRJqNm6lgeG
 Av+miEmYv5QVYOKoaU9a5Kvm3OGaaet/La80FjZkmqEGkjBvbd7lhmYheGYGwNqQAQJt
 +EVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698130766; x=1698735566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3LKoaw12Kegy/5Wwnu5bK7CWabfG8BwbA9wvMxlQdZI=;
 b=Cyr3msY2PkJIWhpp5acjTefuH7cCRXEuwM0Yh7uMDL5+lMuL1QNbTFTbfF6RC6Isx7
 UGnY4C55b+QISQMvi+p/dTZavJkEUfYYCATSpKaog1b/N/qZA4HkFWy74gscuyJ3IAtq
 YBguSmkEppzhLjk9ATf6wU2TiGcU0q0UhZGXViU7ejspu8jprQTWjUdUlE6RcyxjRKxy
 oBqm0LJIuUNkWZ5Qbny9yNHldyn8JrwtZfBsA7lTw2qd1ns/ZHMQYM0OduoaEnhSvlF4
 gP8G+v47/ZEcDyv4KPmjezSA3X+SD31Gt0ecYX/mtlNAVceUitBsG81/WKiUSjJvNB6g
 Bxuw==
X-Gm-Message-State: AOJu0YzTV2u7a5o0dOq7mfCqMEzXjNI9gWa5Mc2Mrt40+Rwuf2TXvzvj
 HDyj65+sLw/IYcfqWL88U1WtXg==
X-Google-Smtp-Source: AGHT+IHBgCGOmEpFns7TOif3qZ7m4RtrTb/0GbGpQU2ZohXDTZBpeswhX2yxOVE6tNC2cXlN/aKu2g==
X-Received: by 2002:a05:600c:4f01:b0:405:3cc5:1105 with SMTP id
 l1-20020a05600c4f0100b004053cc51105mr9013389wmq.8.1698130766190; 
 Mon, 23 Oct 2023 23:59:26 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 l23-20020a1c7917000000b004063cced50bsm11027118wme.23.2023.10.23.23.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 23:59:25 -0700 (PDT)
Message-ID: <bdaf1998-7870-ade6-a611-ed4bd793cf54@linaro.org>
Date: Tue, 24 Oct 2023 08:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] hw/arm/virt: Add serial aliases in DTB
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Axel Heider <axel.heider@hensoldt.net>, Laszlo Ersek <lersek@redhat.com>, 
 Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20231023161532.2729084-1-peter.maydell@linaro.org>
 <20231023161532.2729084-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231023161532.2729084-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/10/23 18:15, Peter Maydell wrote:
> If there is more than one UART in the DTB, then there is no guarantee
> on which order a guest is supposed to initialise them.  The standard
> solution to this is "serialN" entries in the "/aliases" node of the
> dtb which give the nodename of the UARTs.
> 
> At the moment we only have two UARTs in the DTB when one is for
> the Secure world and one for the Non-Secure world, so this isn't
> really a problem. However if we want to add a second NS UART we'll
> need the aliases to ensure guests pick the right one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/virt.c | 4 ++++
>   1 file changed, 4 insertions(+)


> @@ -889,7 +891,9 @@ static void create_uart(const VirtMachineState *vms, int uart,
>   
>       if (uart == VIRT_UART) {

I'd have put this patch after the rename (#2 <-> #1). Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
> +        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
>       } else {
> +        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial1", nodename);
>           /* Mark as not usable by the normal world */
>           qemu_fdt_setprop_string(ms->fdt, nodename, "status", "disabled");
>           qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");


