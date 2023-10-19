Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4450D7D041B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:41:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtakY-0003cP-Ud; Thu, 19 Oct 2023 17:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtakW-0003an-KE
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:40:12 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtakT-0000A9-9q
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:40:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53db1fbee70so123270a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697751607; x=1698356407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rbmDuYpvV88iKNjkf/AlL0vQESOVZTA9WYJH0rHE3Qs=;
 b=P3YEnKlEgBOYYnKFSNxEDfaNSMB1VgPgnVcAF50a5PyajiJ5wukXknXY+eGfPqf59P
 fHRQ+43SmTuUK1YHgdZsSs8e485v7G16TOKK/5RCQqOfz/RYehv5d4tw9G22/eozBBw5
 ZPQWgoWN1k6y9X47TC6iWUUVlxsYEj7cncnasi7x9N3LXiUKoCigj8o9vmoVeIWRolg4
 VvuiJePE7lEudiVVzA39APnZ2TnjFPjGgvVMQiJ97Kqp1JL4CbLEePJeYBGtGyPjg/ec
 n+Wg5Tm4u4lYnQRV6e3N7ZlFNzu19uwppW1VM0mp9C77N3aukdCkEr+IlpjIsn+naP7w
 W9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697751607; x=1698356407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rbmDuYpvV88iKNjkf/AlL0vQESOVZTA9WYJH0rHE3Qs=;
 b=M/Oq1xtmR2aM/yLLOoEW26A+mZw3cm0srIq4e63WZM8+nNvXUI7sB2XB+nW4IZysZC
 BHb+cddM1eYLD+jkP2WuQrAFr7ky/osK87hbQaalYaDxQCY2nOqiOZZlDTHZ4cYslOiy
 QMZgRkZRg6mrYpV+FIA5jwdBNg21XXTaFKvzP2rF1dIRkuXf+v2J4Na08mSFWQaEwXTT
 QEbOpoReAzVr6euwqkwNPyRBbZbBj6U6s5USOxchLrnKMkGttBZ2MPxRZgCyiFJqw0X2
 vY+VLlS5/9M72eHD9Sh7oQpJ1vQLeQPCvGgSWKyn2moYIPOypx2M4tE5N+mfnGsMpwV5
 0Pfg==
X-Gm-Message-State: AOJu0YzcN+YzeJk7s3HoyC+T6ktxSgv4rtnt7+TzGzmPhQeGZADOsxNp
 8+xqDwKFxoy4fPjYg/DfbBephk+uEGNFLuxwirhQ/A==
X-Google-Smtp-Source: AGHT+IFgj1tEqwjH3TKAjoC7MTEJRzP7+VhYONVf57ly/RM4/prZw/85yBB7loAQZvtGej1eByRsdA==
X-Received: by 2002:a50:d719:0:b0:53e:1815:ed0f with SMTP id
 t25-20020a50d719000000b0053e1815ed0fmr106515edi.31.1697751607172; 
 Thu, 19 Oct 2023 14:40:07 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 g2-20020a50d5c2000000b0053e36dd75dfsm268482edj.35.2023.10.19.14.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:40:06 -0700 (PDT)
Message-ID: <1e0f77e0-5a93-28f7-8c7b-819366c3c5e0@linaro.org>
Date: Thu, 19 Oct 2023 23:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 00/12] hw: Strengthen SysBus & QBus API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, Beniamino Galvani
 <b.galvani@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20231019071611.98885-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19/10/23 09:15, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (12):
>    hw/i386/amd_iommu: Do not use SysBus API to map local MMIO region
>    hw/i386/intel_iommu: Do not use SysBus API to map local MMIO region
>    hw/misc/allwinner-dramc: Move sysbus_mmio_map call from init ->
>      realize
>    hw/misc/allwinner-dramc: Do not use SysBus API to map local MMIO
>      region
>    hw/pci-host/bonito: Do not use SysBus API to map local MMIO region
>    hw/acpi: Realize ACPI_GED sysbus device before accessing it
>    hw/arm/virt: Realize ARM_GICV2M sysbus device before accessing it
>    hw/isa: Realize ISA BUS sysbus device before accessing it
>    hw/s390x/css-bridge: Realize sysbus device before accessing it

Patches 1-9 queued to hw-misc.

