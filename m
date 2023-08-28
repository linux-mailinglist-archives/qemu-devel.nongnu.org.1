Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07478A56B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 07:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaVBV-0005uY-Ku; Mon, 28 Aug 2023 01:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qaVBR-0005u0-AX
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 01:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qaVBN-0002yo-J9
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 01:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693201954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wwtUsOUVBZeWYQBTl04B2bpXYlQCvc5VNPgH/+En7fg=;
 b=Exu463q1XtaivRLCi6AA9QpQ2391Ffay/W3uBduns1OsBtRyA8DO2OL6l0ee9K8pDYH2ZJ
 3EpOIHyrrlE4dk4kpFRYm5qIsd3EJdejrNqdTJBkKEI9jJ+/OFzhuGGMsPFS7nLBsqfkEf
 sHZj6fk85GGJbKv7AQfIXbCnxJY7slA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-uhV7EEBgOk-6vf3op2zGiQ-1; Mon, 28 Aug 2023 01:52:32 -0400
X-MC-Unique: uhV7EEBgOk-6vf3op2zGiQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99c0bd2ca23so210078066b.2
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 22:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693201952; x=1693806752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wwtUsOUVBZeWYQBTl04B2bpXYlQCvc5VNPgH/+En7fg=;
 b=E1kI67TADEjnfUh+hQbjUuqPGaj6hfDE9g4jFGulq0iEf5FYNKP1pkEFOcC0fTZ/JC
 i04lNunQXtOXEblQ3aJG/qqZnSjJejVxSDfrXFOPzyq32uzDTZp93pLsLx/dE2KbnnCR
 7q5JurA682nLBln86omHjM2df7Zkc6Ysc710aGNDAovlciouZVNGYmGNsVZf63P3n+Q5
 oOAlOV7rOLTNFHFU0vF18MZZOgy3MlFV6xgJ0Zx25fnHdZyaQt3gVRSZuuOltTi7vUpS
 T61/UrUYGIbHnU7TKd/5+WxzEDBEsSobFfYB1SczE7TiMp6W6MQf9UKHBtVtD3tPYZun
 AsZg==
X-Gm-Message-State: AOJu0Yzsz6ExMkhlfEnMc3S/LHDq27X8RVTvVa93iJxIhwxvzMd6uPvE
 LUEQKHJmsGPL0fliaDtvfGanCEWDp+LyAK73IcQcwdx9S3dQS6wMUnWBWAY1QE/2PdKLNXMDPqD
 0mPTyB3SOLzEP4OE=
X-Received: by 2002:a17:906:748c:b0:9a1:ffec:aadd with SMTP id
 e12-20020a170906748c00b009a1ffecaaddmr7019772ejl.56.1693201951932; 
 Sun, 27 Aug 2023 22:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR6VRryp9gNOVTdjglR/ZQgan22ayWaWi41KZI/cIsKbpuAR5GvHoax2yA14C1MFRAfddKaw==
X-Received: by 2002:a17:906:748c:b0:9a1:ffec:aadd with SMTP id
 e12-20020a170906748c00b009a1ffecaaddmr7019763ejl.56.1693201951674; 
 Sun, 27 Aug 2023 22:52:31 -0700 (PDT)
Received: from [192.168.8.103] (tmo-098-91.customers.d1-online.com.
 [80.187.98.91]) by smtp.gmail.com with ESMTPSA id
 e8-20020a170906044800b009a57d30df89sm3918282eja.132.2023.08.27.22.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 22:52:31 -0700 (PDT)
Message-ID: <6d153709-8099-7737-8fbd-3988a35af71a@redhat.com>
Date: Mon, 28 Aug 2023 07:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/7] hw/fsi: Introduce IBM's scratchpad
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org
Cc: qemu-arm@nongnu.org
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-3-ninad@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230825203046.3692467-3-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.414, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 25/08/2023 22.30, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The LBUS device is embeded inside the scratchpad. The scratchpad
> provides a non-functional registers. There is a 1-1 relation between
> scratchpad and LBUS devices. Each LBUS device has 1K memory mapped in
> the LBUS.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   hw/fsi/Kconfig                     |   4 ++
>   hw/fsi/engine-scratchpad.c         | 100 +++++++++++++++++++++++++++++
>   hw/fsi/meson.build                 |   1 +
>   include/hw/fsi/engine-scratchpad.h |  32 +++++++++
>   4 files changed, 137 insertions(+)
>   create mode 100644 hw/fsi/engine-scratchpad.c
>   create mode 100644 include/hw/fsi/engine-scratchpad.h
> 
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> index 687449e14e..2a9c49f2c9 100644
> --- a/hw/fsi/Kconfig
> +++ b/hw/fsi/Kconfig
> @@ -1,2 +1,6 @@
> +config SCRATCHPAD
> +    bool
> +    select LBUS
> +
>   config LBUS
>       bool

The config names sound pretty generic ... could you maybe name them 
FSI_SCRATCHPAD and FSI_LBUS instead?

  Thomas



