Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B8DA5069A
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Mar 2025 18:42:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpsjI-0001uE-GD; Wed, 05 Mar 2025 12:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpsjC-0001s7-BN
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 12:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpsj7-0007B3-7N
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 12:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741196407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sCOzi0wXsAtvsUqY3ZLmyoS2Rh+ikV6GVuS1+H9G6wM=;
 b=feXKgds9F1GzKsp2jKxUdWbwIXVrQ/azjY+TCCqGYyfZmuLhq0QCDx+jfZGiLlkPyA2Ah6
 kspZ8Yt4ISB/ADuPnlaKB3fCtn74qpNhCRuEJM+JSzSNGJFMZtJhBqjwf0FqKc0kniIszQ
 tcVbdL271G4xaYhg0fP+59jwdCmXmT4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-8157Tcx6MtqvT1QnIVuVXQ-1; Wed, 05 Mar 2025 12:40:05 -0500
X-MC-Unique: 8157Tcx6MtqvT1QnIVuVXQ-1
X-Mimecast-MFC-AGG-ID: 8157Tcx6MtqvT1QnIVuVXQ_1741196404
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so51781495e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 09:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741196404; x=1741801204;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCOzi0wXsAtvsUqY3ZLmyoS2Rh+ikV6GVuS1+H9G6wM=;
 b=EUai2ywOx5ryIwCEaScJysASMMl2RffNcAsOJLLgN5nKjoih4/IteGlh5/yLbdpLt8
 80DSJTSYKX9JoTxnqOt+BPqzYHTIqBc7JJuhn8WcJjizYGHX1cdEMx+goEbpz5V4M/A9
 RQB4bsQWuKbgbwmQWByTRUuuU8viqh64voc/mE9p9uo0gGtsOS2CoHeN4GCMIxVaqCH9
 swQygGzpN7ixEU85tepeoPAZO5JdPBbf5fVloYgXTOzPTSVDaZPRum1P250P6HKgRAty
 Np7WGOBMgD38EcV7rtzF+zfsahYE/uBLp9U+cJv08/FFFQ5RGWG3ykpLZRvszMjyAO7R
 Nxag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0GwCzuSChwy6G5kEpt5HBojQhe/NiFb25K5Fgbi/52xSTcsYoy5MeeRTjrOA6byMG/gnCjucyHSex@nongnu.org
X-Gm-Message-State: AOJu0YwoTLwlvCE3ntObmrlv5sz0rHn4i7dA9a+DyuaGwanhA+/kFjGS
 U6Qmp4vlGxv++8RqzbrPF1D0ipv5kx5HEr7P3hdThAlxG97ImQYIYFnqvsVgyv1zZNuvFO//zPt
 tZC+PR60pqbO2EeQA8GYhJfMwa0QsR0MKi1UBX9nuSR2Op/Y3nvuF
X-Gm-Gg: ASbGnctGfi76wStNEsFlnoHeFq51v9tdKPm6FjQGNTUqcxSquah7NvWutlYOG494rob
 ZqVt0JIPDY1LvkDLeDfVtG1TTJGh6vpQrXIqY+7VrlxB9G0Im3Rrh0W/glzhfVBMu7EKOtZyOZq
 GgqjW7483HJtrxx0gW9W95m2OYUngDF2MjnX5DZKT96FjQxTabx7WGzhlccpEyqeQL0LnQh/fPX
 oDA/mX7csZfeuAkWQNI5bcrCBHNZE1szHV6tNzPoKwLbgUpDvsA40zT9YlYHX8x+tBqN+oOJMON
 yFJHaBLwXYIOSLKuaGEq7mcOO5JKMhva9iSfTRZEyxo+hAQ=
X-Received: by 2002:a05:600c:354c:b0:43b:b67f:6802 with SMTP id
 5b1f17b1804b1-43bd289edcbmr37089325e9.0.1741196404371; 
 Wed, 05 Mar 2025 09:40:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhGmLOzpxT7kZqNasEeFKxHayZwHfxUP//aM0sNY7J78hUhDPxsiZfGBuMZvtbdj/qT7PYWA==
X-Received: by 2002:a05:600c:354c:b0:43b:b67f:6802 with SMTP id
 5b1f17b1804b1-43bd289edcbmr37088945e9.0.1741196403940; 
 Wed, 05 Mar 2025 09:40:03 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484451fsm22079426f8f.63.2025.03.05.09.40.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 09:40:03 -0800 (PST)
Message-ID: <91882e5b-bd0f-4f84-9c03-c40b5e3d3e3f@redhat.com>
Date: Wed, 5 Mar 2025 18:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] hw/arm/raspi: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250305161248.54901-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05/03/2025 17.12, Philippe Mathieu-Daudé wrote:
> For legacy ARM binaries, legacy_binary_is_64bit() is
> equivalent of the compile time TARGET_AARCH64 definition.
> 
> Use it as TypeInfo::registerable() callback to dynamically
> add Aarch64 specific types in qemu-system-aarch64 binary,
> removing the need of TARGET_AARCH64 #ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/bcm2836.c | 6 ++----
>   hw/arm/raspi.c   | 7 +++----
>   2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 95e16806fa1..88a32e5fc20 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -12,6 +12,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "qemu/module.h"
> +#include "qemu/legacy_binary_info.h"
>   #include "hw/arm/bcm2836.h"
>   #include "hw/arm/raspi_platform.h"
>   #include "hw/sysbus.h"
> @@ -195,7 +196,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
>       dc->realize = bcm2836_realize;
>   };
>   
> -#ifdef TARGET_AARCH64
>   static void bcm2837_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -208,7 +208,6 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
>       bc->clusterid = 0x0;
>       dc->realize = bcm2836_realize;
>   };
> -#endif
>   
>   static const TypeInfo bcm283x_types[] = {
>       {
> @@ -219,12 +218,11 @@ static const TypeInfo bcm283x_types[] = {
>           .name           = TYPE_BCM2836,
>           .parent         = TYPE_BCM283X,
>           .class_init     = bcm2836_class_init,
> -#ifdef TARGET_AARCH64
>       }, {
>           .name           = TYPE_BCM2837,
>           .parent         = TYPE_BCM283X,
> +        .registerable   = legacy_binary_is_64bit,
>           .class_init     = bcm2837_class_init,
> -#endif
>       }, {
>           .name           = TYPE_BCM283X,
>           .parent         = TYPE_BCM283X_BASE,
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index dce35ca11aa..f7e647a9cbf 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -15,6 +15,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "qemu/cutils.h"
> +#include "qemu/legacy_binary_info.h"
>   #include "qapi/error.h"
>   #include "hw/arm/boot.h"
>   #include "hw/arm/bcm2836.h"
> @@ -367,7 +368,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
>       raspi_machine_class_init(mc, rmc->board_rev);
>   };
>   
> -#ifdef TARGET_AARCH64
>   static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -387,7 +387,6 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
>       rmc->board_rev = 0xa02082;
>       raspi_machine_class_init(mc, rmc->board_rev);
>   };
> -#endif /* TARGET_AARCH64 */
>   
>   static const TypeInfo raspi_machine_types[] = {
>       {
> @@ -402,16 +401,16 @@ static const TypeInfo raspi_machine_types[] = {
>           .name           = MACHINE_TYPE_NAME("raspi2b"),
>           .parent         = TYPE_RASPI_MACHINE,
>           .class_init     = raspi2b_machine_class_init,
> -#ifdef TARGET_AARCH64
>       }, {
>           .name           = MACHINE_TYPE_NAME("raspi3ap"),
>           .parent         = TYPE_RASPI_MACHINE,
> +        .registerable   = legacy_binary_is_64bit,
>           .class_init     = raspi3ap_machine_class_init,
>       }, {
>           .name           = MACHINE_TYPE_NAME("raspi3b"),
>           .parent         = TYPE_RASPI_MACHINE,
> +        .registerable   = legacy_binary_is_64bit,
>           .class_init     = raspi3b_machine_class_init,
> -#endif
>       }, {
>           .name           = TYPE_RASPI_MACHINE,
>           .parent         = TYPE_RASPI_BASE_MACHINE,

Uh, this (together with patch 1) looks very cumbersome. Why don't you simply 
split the array into two, one for 32-bit and one for 64-bit, and then use a 
simply "if (legacy_binary_is_64bit())" in the type_init function instead?

  Thomas


