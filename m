Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3774CE87
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:35:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlQL-0000TT-LY; Mon, 10 Jul 2023 03:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qIlQF-0000RJ-87
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:35:03 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qIlQD-0000rO-Ik
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:35:03 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f954d7309fso5112823e87.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688974500; x=1691566500;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=X6tQU9slBwhFsnNNlnGvU80p27+NY60RITLusb+xDxI=;
 b=p2im437bWcku/t8a7vAy+m+gYkVqLxt2wzbGJORpvNDG6SfBNybPE3N3FKIQrhy322
 8kRCAt6vOvJNtNmw7o8ecAQlHcO9HdwDFG3ds81mgQAfZSea/3ZVWNcP4oexw8o+9liy
 CrCEUSAewgUzKvBaxIqOiE06iaFdZ2TXC559j3b8rDXHfo/GDsTtbMXtt719hXSCzfOt
 1XWRjwnqEVnslJCUKJB3KJzWtbyQIvbduEAGGSpotDq/1aKlZl9XylAkgCplAPOGJ2aP
 dYyyAsbyTdb73zVvBA1pdG728qAgNWf64+zuyMhiWbP+pT0mrcCwQ/P6wY2t0YOCkQtH
 qGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688974500; x=1691566500;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6tQU9slBwhFsnNNlnGvU80p27+NY60RITLusb+xDxI=;
 b=E93TegZyBu64PKvIMjgDIE8e+Jx64FXUTzvTD+Ab/pKSXK+I+DNwp4o6AEIfXUZ7pl
 bhQuIHYQnwf+l271ItXSNYNM4RDeNXfs8FHY3oM3vc2+utzR9pPO2ielFIScqP6T4gUZ
 5QzvAsVolBwdkZLreRPFjcT2HxzvJVGb7AD0CamI9KrRxfSGgoso1Aa2OE9AO0mGn9gb
 0JfQoxsjeCIvGChDwvrFELkPXQ4427piaKeT2jVRgR+eU+8+gFnAGWeSaTz9QNUdZNoP
 1Ia09Xmd0fyxF4rfw1DrPq157lA9SatS8c+l4gU0JN47Ev0QhjMpdK4N2U4h91nV8hP9
 C5wA==
X-Gm-Message-State: ABy/qLZ7v6dGj2lG73GNlYkwsQTCW4RitHXcSBROUWpQXMrhGY6tWfkb
 19WcEu4vn7+ms9W6fHcdmiRTHw==
X-Google-Smtp-Source: APBJJlG1olaRa1xzCU515dyZHNSFBx7xuF6HO2AVKH+v7ZUBXnXpZuNVLX95DcLkGY7vjxAEca0Aog==
X-Received: by 2002:a05:6512:3d93:b0:4fb:9f08:2909 with SMTP id
 k19-20020a0565123d9300b004fb9f082909mr6303015lfv.3.1688974499742; 
 Mon, 10 Jul 2023 00:34:59 -0700 (PDT)
Received: from [192.168.200.206] (83.21.151.197.ipv4.supernova.orange.pl.
 [83.21.151.197]) by smtp.gmail.com with ESMTPSA id
 o5-20020ac24945000000b004fb957ac245sm1592195lfi.59.2023.07.10.00.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 00:34:59 -0700 (PDT)
Message-ID: <6e4d44f9-55d5-b9e9-871f-ac47b7e43f1d@linaro.org>
Date: Mon, 10 Jul 2023 09:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: set 'slots' property of xhci
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: quic_llindhol@quicinc.com, chenbaozi@phytium.com.cn
References: <20230710063750.473510-1-wangyuquan1236@phytium.com.cn>
 <20230710063750.473510-2-wangyuquan1236@phytium.com.cn>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230710063750.473510-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

W dniu 10.07.2023 o 08:37, Yuquan Wang pisze:
> This extends the slots of xhci to 64, since the default xhci_sysbus
> just supports one slot.
> 
> Signed-off-by: Wang Yuquan <wangyuquan1236@phytium.com.cn>
> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
> ---
>   hw/arm/sbsa-ref.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 64e1cbce17..bc89eb4806 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -611,6 +611,7 @@ static void create_xhci(const SBSAMachineState *sms)
>       hwaddr base = sbsa_ref_memmap[SBSA_XHCI].base;
>       int irq = sbsa_ref_irqmap[SBSA_XHCI];
>       DeviceState *dev = qdev_new(TYPE_XHCI_SYSBUS);
> +    qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);

Looks like tab instead of spaces.

>   
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);

Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>


Before:

xhci-hcd PNP0D10:00: Error while assigning device slot ID: No Slots Available Error
xhci-hcd PNP0D10:00: Max number of devices this xHCI host supports is 1.
usb usb1-port2: couldn't allocate usb_device


After:

input: QEMU QEMU USB Keyboard as /devices/platform/PNP0D10:00/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input0
hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v1.11 Keyboard [QEMU QEMU USB Keyboard] on usb-PNP0D10:00-1/input0
input: QEMU QEMU USB Tablet as /devices/platform/PNP0D10:00/usb1/1-2/1-2:1.0/0003:0627:0001.0002/input/input1
hid-generic 0003:0627:0001.0002: input,hidraw1: USB HID v0.01 Mouse [QEMU QEMU USB Tablet] on usb-PNP0D10:00-2/input0

