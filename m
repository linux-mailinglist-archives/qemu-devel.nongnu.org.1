Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1639A506A4
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Mar 2025 18:43:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpsmI-0004Hp-FD; Wed, 05 Mar 2025 12:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpsmG-0004Fx-CG
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 12:43:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpsmE-0008CY-Iy
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 12:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741196606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0io+YkR5jeMpVFQxenjogAXZmb91RzAb6Htvhb2NFNs=;
 b=MuaqdiTIMq4W0UzR6bZY6llxL8z6egAOqvI0F7LC+qUeAd/JYFOyo5FWaV+UEXYM9r2IjQ
 JXPzI95OYaRtQ7D6AD+AsmvDmOsW94RWhWJT4c119lZVDC0Klgjm8hnDltyce9XCF/tswV
 G0uJVE6yIodjOrCthvKw+XgBYiFtv2o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-njeDq-WTN4iv9OSC12FKWA-1; Wed, 05 Mar 2025 12:43:23 -0500
X-MC-Unique: njeDq-WTN4iv9OSC12FKWA-1
X-Mimecast-MFC-AGG-ID: njeDq-WTN4iv9OSC12FKWA_1741196603
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-390e5214efdso4763262f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 09:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741196602; x=1741801402;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0io+YkR5jeMpVFQxenjogAXZmb91RzAb6Htvhb2NFNs=;
 b=P2pMeegnaiUI3HioIL5i2wIaSCUN/uEfME+jJGTTcCmxJ+n7VE+4zR0y0n6oIRlER6
 av2+cQy2e+uTvpJQqVs1y7024aWWawKn/s16ZcvdBzkalnPHxAorFr3sm3wOtyjhY7a6
 2sKYTnUF8YY3dWW0Ly+GH0AKDEXTQgaIkvpMZQEXdql2g0S632Q7quZwCFyH+l4Yp4Ox
 wlBlw6v1zdwzgEjUJYL2hIxqQ8LnkT1CwmABgzwY4lmupiXkkCx67jSpbcJyARCsXKiF
 0wp3wqzP2+XBbsiQye/+6Myw+DkA8CwRyi/immSBwgUY02AQn6htpd2O+H8HNF4vEbqZ
 jFsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFlJfSxJxipD1dXX/yY4gHb4GOVXq87ntV1SXVu/3jdoRJqFssPCc0tEEKN3NPuNLXPwMmYC9uYEbs@nongnu.org
X-Gm-Message-State: AOJu0Yx5TWF7/cmGGUuojwoC6FMf1GNAghtLRYYx/0ltZWLpHdPYa62t
 sJGRCtVUfOTbdcwZKDeVL0Mbfw75IE8qfcQ0ln70ysq0eOJYKQRHL0LzphWgalBaKquYul39ccX
 kuHGZLZQSF3Vx3A1Js1LJIEJFw3kKLKatm2Epf0d6QuccQ70BengQ
X-Gm-Gg: ASbGncu13RewR8Eids5h3wUq/YpttTxci4ymDIuRSYoMZa/lVIKBUGidcmyfcwL0XaE
 Rt4bfbNuvIlgel6vxSurtcJsyz4vNysYgXHq/0RbFCmbkiz3E9Vaf94j645zoGR5/YOC4XHk81M
 7LqQ83IDWJOngfh0LBKGHf36tXEXPW/0vf/CoR4vFEjf+gZrm+UlXCWRJO+Cs1Tm1CmevoLGaWM
 XiaO32CLclcIjgcTEe9Zy+tZDdJexf4qy+nMl77AAVelNMmynfb0MbWJN0mdcMr9DDPfbRTr+5X
 rWZPGYWGIHZJq3KnJGPOWI5B+U/m9BgT2ApzFAf8fo/scW0=
X-Received: by 2002:a5d:47a7:0:b0:38f:6697:af6e with SMTP id
 ffacd0b85a97d-3911f720584mr3015132f8f.1.1741196602543; 
 Wed, 05 Mar 2025 09:43:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESk1dUJwlWyukNsrgasNBQwcF37/cLt3s6JZO3uyUZt6Fbu953WTlv+WUb4krlOkwHX5Wbqw==
X-Received: by 2002:a5d:47a7:0:b0:38f:6697:af6e with SMTP id
 ffacd0b85a97d-3911f720584mr3015109f8f.1.1741196602117; 
 Wed, 05 Mar 2025 09:43:22 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391241bd151sm1859318f8f.21.2025.03.05.09.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 09:43:21 -0800 (PST)
Message-ID: <97c614a5-9de0-4615-ba84-207affcaf54a@redhat.com>
Date: Wed, 5 Mar 2025 18:43:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] hw/arm/aspeed: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250305161248.54901-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>   hw/arm/aspeed.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 98bf071139b..3f18a4501e0 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -28,6 +28,7 @@
>   #include "hw/loader.h"
>   #include "qemu/error-report.h"
>   #include "qemu/units.h"
> +#include "qemu/legacy_binary_info.h"
>   #include "hw/qdev-clock.h"
>   #include "system/system.h"
>   
> @@ -179,11 +180,9 @@ struct AspeedMachineState {
>   #define AST2600_EVB_HW_STRAP1 0x000000C0
>   #define AST2600_EVB_HW_STRAP2 0x00000003
>   
> -#ifdef TARGET_AARCH64
>   /* AST2700 evb hardware value */
>   #define AST2700_EVB_HW_STRAP1 0x000000C0
>   #define AST2700_EVB_HW_STRAP2 0x00000003
> -#endif
>   
>   /* Rainier hardware value: (QEMU prototype) */
>   #define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
> @@ -1661,7 +1660,6 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
>       aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
> -#ifdef TARGET_AARCH64
>   static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
>   {
>       AspeedSoCState *soc = bmc->soc;
> @@ -1690,7 +1688,6 @@ static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
>       mc->default_ram_size = 1 * GiB;
>       aspeed_machine_class_init_cpus_defaults(mc);
>   }
> -#endif
>   
>   static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
>                                                        void *data)
> @@ -1813,12 +1810,11 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name           = MACHINE_TYPE_NAME("ast1030-evb"),
>           .parent         = TYPE_ASPEED_MACHINE,
>           .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
> -#ifdef TARGET_AARCH64
>       }, {
>           .name          = MACHINE_TYPE_NAME("ast2700-evb"),
>           .parent        = TYPE_ASPEED_MACHINE,
> +        .registerable   = legacy_binary_is_64bit,
>           .class_init    = aspeed_machine_ast2700_evb_class_init,
> -#endif
>       }, {
>           .name          = TYPE_ASPEED_MACHINE,
>           .parent        = TYPE_MACHINE,

Same as with previous patch, I'd prefer to split the array, and replace the 
DEFINE_TYPES() with a dynamic type_init() function.

  Thomas


