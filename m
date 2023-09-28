Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2727B0FF2
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 02:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qletX-0001fH-48; Wed, 27 Sep 2023 20:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qletV-0001et-Af
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 20:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qletT-00059X-TB
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 20:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695860918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=naGB67P35Hh6ey4h7HMOBQWk3NFVJt+hndCv0Q54Ov0=;
 b=ZY29oz66MDak94WtmU8YBxMB11rNOMYEnEjm+Tqpi5VnZkMw1RKzyTfBt9YT3sbkTIvhMN
 F2ln6zbEaQueTXwksiQPSxI41uHg2igk+Nx8w9DDu9Hw700ECF8TN40kMKdCJcStA0O0No
 XmpcSsxhPbxzftC2g2FN/8SMsyvJHYM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-GLxAA0ugMU-XxrBlwyh29Q-1; Wed, 27 Sep 2023 20:28:36 -0400
X-MC-Unique: GLxAA0ugMU-XxrBlwyh29Q-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1c735563177so4157765ad.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 17:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695860915; x=1696465715;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=naGB67P35Hh6ey4h7HMOBQWk3NFVJt+hndCv0Q54Ov0=;
 b=ifT4IiF8bdzmOJmPOIpuNStZIS75CnmUL9MYbaXO6esE6VMKJGMlvlgwNbAHq5Gcyw
 WCAYMzKxWNUsgu2A32xwp6BTIyrPvu2bV9h+NUe93aJUYfehjiQbVg7QNtp/UlwLUwkv
 dvfdbAm1y0eLu9I7UBphp6nkX1kECyIjD5A1+AsgET29vsm6hb+Nti2Bufbw9W5dOzEX
 01BiQpWRCMLj89zA5vHVXHcJMl4wDaRS6Q6lVh0m0HtcsmdNqHAB8FsQCqnJD6MRvkTy
 E76pB5mZB3qGtyW6Hf4TLKEaPty0f0UIqbnCZPv8WkFD6IZmsmX2CHzoT5HOzlrclfnR
 lZSQ==
X-Gm-Message-State: AOJu0YyxyhR7tzoR9f5CB+7E35iIq0rhLHShDdedgCqLTd8AYSz5/EUF
 8F+FVPWplVmrXMhCn8oeM8y6k7eqPGlgxBSiiOrE4N5Kjoanu16Sdzhs+Yv29PS3HrqATW9ZHyl
 qFUEOsf6PfYrYfi1pnyxR7a8=
X-Received: by 2002:a17:902:7682:b0:1c3:f745:1cd5 with SMTP id
 m2-20020a170902768200b001c3f7451cd5mr3436173pll.34.1695860915022; 
 Wed, 27 Sep 2023 17:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGmrad0E+uBSM7NaYfGt3ST5SxzZOwR7yg+FrTmBsLw+1uFrxh+DkPG+YP2stR8qBO9K6a3g==
X-Received: by 2002:a17:902:7682:b0:1c3:f745:1cd5 with SMTP id
 m2-20020a170902768200b001c3f7451cd5mr3436153pll.34.1695860914750; 
 Wed, 27 Sep 2023 17:28:34 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a170902ee8200b001b66a71a4a0sm13692639pld.32.2023.09.27.17.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 17:28:34 -0700 (PDT)
Message-ID: <dd1028a6-e229-07e3-95e8-ba636dc0651e@redhat.com>
Date: Thu, 28 Sep 2023 10:28:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 11/37] hw/acpi: Add ACPI CPU hotplug init stub
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-12-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-12-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 9/26/23 20:04, Salil Mehta wrote:
> ACPI CPU hotplug related initialization should only happend if ACPI_CPU_HOTPLUG
> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
> stub to avoid compilation break.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/acpi-cpu-hotplug-stub.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
> index 3fc4b14c26..c6c61bb9cd 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>       return;
>   }
>   
> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> +                         CPUHotplugState *state, hwaddr base_addr)
> +{
> +    return;
> +}
> +
>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>   {
>       return;


