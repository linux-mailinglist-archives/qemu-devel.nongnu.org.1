Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 619A079C965
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfyUB-0001M7-Qa; Tue, 12 Sep 2023 04:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfyU7-0001Lt-MU
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:10:59 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfyU5-0001d6-C2
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:10:59 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a645e54806so660083866b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 01:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694506256; x=1695111056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tag4LaXwTeMt6fj7GAFey8WPL6VPvTFiR3Hdgjc7UmM=;
 b=fFQ9GPa87s5wvOCQXydyGBEtWLgg4i4raRlSlr6Ow0iRT1k8UrqNd1ilG68FYEbhkk
 ShhkcBvITGkEpVNNJM2RZa+RIgqxBuQJwZ8hraHYVBfg2sHnxiQs0twcvqDAtQ9YbS+1
 w3Kk/SNtw5C8v5/oshX/1X3G9Xbf28dV4E1rGP8/zApt/pBrJr1PQWjiRPJwtkUZk3W/
 Z/Tt+07FYNK/AG3E4tZlV+WLuuY3i2o6EA6YIL0ZEAKFQH8EnpGUhrx02+BlD/UMqECe
 /MNy931449GDsxwQmmcDTaLoK8RtLsOHESONCLfyWYk/5dQLJDkidSwvPQyB4o936uaC
 AYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694506256; x=1695111056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tag4LaXwTeMt6fj7GAFey8WPL6VPvTFiR3Hdgjc7UmM=;
 b=BfVxZddgPuL1I7vEaweIxDPWalIsF9XcQm/vtZtiGrGXYiNRySR7ql+7BujOW4LwsR
 4bX9X4AZDnfA3iklx19BT065OqYTtH4Ex4bytInsGIgnfw9DW9ArpxoCWYuomGROMw9t
 B2Cpcn6pu/vLuAxlhK5njHQ7+NeqkZpV5MnIXfv+nDRF/QDzHYVpCqxrFitgqVS4nitV
 QMablPw7B+fLxR0gPTvREBlSyKu1Mf0bIJUWSDizSMaTHWVFkwMHwPg80/aOgSsOYIoJ
 BQhQoherPkOe+O06KD1j6KKWJ0GxXqDtz0fBTJe0FP4xNx3KNcAcrJRufpvZ38Qc9G9T
 xDJQ==
X-Gm-Message-State: AOJu0YwosSXs2NNaDdlV5O90TvhkelCKZWyVmS1f1dgqd7p0QNSgHHqu
 RKmQczm9E4e2qknua5Z0NesZfQ==
X-Google-Smtp-Source: AGHT+IH0ylhRMhSNzsWFXyfg5x0Sfu+tWbJgQOWeUKAKg7TqUrBPa1fJMR7QK2oGi09pwkz3d1qIqg==
X-Received: by 2002:a17:906:3299:b0:9a1:c447:3c62 with SMTP id
 25-20020a170906329900b009a1c4473c62mr9853044ejw.49.1694506255671; 
 Tue, 12 Sep 2023 01:10:55 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 i18-20020a17090671d200b0099cf840527csm6497784ejk.153.2023.09.12.01.10.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 01:10:54 -0700 (PDT)
Message-ID: <043acdaf-219b-b2b5-6b2d-056ba1bd9ce2@linaro.org>
Date: Tue, 12 Sep 2023 10:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 03/10] make qdev_disconnect_gpio_out_named() public
Content-Language: en-US
To: xianglai li <lixianglai@loongson.cn>, Salil Mehta <salil.mehta@opnsrc.net>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>, 
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <d3e388d55f36a93108d0f7b1736f97435237cb77.1694433326.git.lixianglai@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <d3e388d55f36a93108d0f7b1736f97435237cb77.1694433326.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hi,

On 12/9/23 04:11, xianglai li wrote:
> It will be reused in loongarch/virt.c for unwiring
> the vcpu<->exioi interrupts for the vcpu hot-(un)plug
> cases.

Since we never had to use this, I'm surprised we really need it.

QEMU IRQs/GPIOs are similar to hardware ones, and aren't expected
to be rewired at runtime. Usually another hot-pluggable bus layer is
used, and the bus is physically wired toward the hardware.


I suppose you want to add that because a unplugged vCPU is still
receiving IRQs. The question is, why? Before unplugging, I expect
the INTC (IPI) here to be signaled a vCPU is going to be unplugged,
so maybe you are missing handling the unplug event there. See
in loongarch_ipi_writel():

     switch (addr) {
     case CORE_EN_OFF:
         s->en = val;
         break;
     case CORE_SET_OFF:
         s->status |= val;
         if (s->status != 0 && (s->status & s->en) != 0) {
             qemu_irq_raise(s->irq);
         }
         break;
     case CORE_CLEAR_OFF:
         s->status &= ~val;
         if (s->status == 0 && s->en != 0) {
             qemu_irq_lower(s->irq);
         }
         break;

Maybe you need to factor ipi_raise/lower() helpers which check cores
are available & enabled before propagating IRQ?

> Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
> Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Ani Sinha <anisinha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>   hw/core/gpio.c         | 4 ++--
>   include/hw/qdev-core.h | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/gpio.c b/hw/core/gpio.c
> index 80d07a6ec9..4fc6409545 100644
> --- a/hw/core/gpio.c
> +++ b/hw/core/gpio.c
> @@ -143,8 +143,8 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n)
>   
>   /* disconnect a GPIO output, returning the disconnected input (if any) */
>   
> -static qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
> -                                               const char *name, int n)
> +qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
> +                                        const char *name, int n)
>   {
>       char *propname = g_strdup_printf("%s[%d]",
>                                        name ? name : "unnamed-gpio-out", n);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 151d968238..32bb54163e 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -739,6 +739,8 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n);
>    */
>   qemu_irq qdev_intercept_gpio_out(DeviceState *dev, qemu_irq icpt,
>                                    const char *name, int n);
> +qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
> +                                        const char *name, int n);
>   
>   BusState *qdev_get_child_bus(DeviceState *dev, const char *name);
>   


