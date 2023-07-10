Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2099A74D32F
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:17:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInxM-0003Sy-OT; Mon, 10 Jul 2023 06:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInxL-0003SO-3d
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:17:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInxJ-0006hJ-KK
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:17:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso47864075e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688984240; x=1691576240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rGG7ZFKOrxvzabeWYoHjFp0+YYTEVGszXC9pHjkz7No=;
 b=aJ9VcNJWLgRRyoXRPp+xT+6PHm5/T6os94ZjDnagVpgU/HAUviox3bg8Knq+EKe/eC
 FP5EIUAhmzFEbvmn5IK+9ATL4NtQqv7DHe0cLO4wrkujdXxdgaTgRtbCzrwhDCnDkIdR
 8cV/8RiOPh36UJem7dFKLxi5aTheFIk3K0UxICA8rsnkQi6GDVySogcqDD9zA0gGJPH+
 XkYBuVZTrMi/9I19KlhOI8w5wGERR8I1/4XJL0AacO/wbQjnCYkpbAdwPzBICKW+vvT2
 n1Wj9RWCdsijwSzeOfzyf5Y6KOV/UrranO04LTkFPfsztcrG4E86x1GLNjjQSVdqGbFf
 cfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688984240; x=1691576240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rGG7ZFKOrxvzabeWYoHjFp0+YYTEVGszXC9pHjkz7No=;
 b=KUcwIKIUuiWfBYC/lRkFWVvbenDybJtRKcnzK2smzsFtnV6Re6DgpoPQd/O6y4jVoM
 eOZDQYae2GpaH3CWZT5SWzkLSOg/NEkQG3oz2/8aLGUTDWqHjW9CAk1bAysDMCCSgbV0
 X5klL3eTi3iJGoUtQLDw9eqrOPHQfRR4JTBvMtXdYCw+7W5bgqShFRVzrhGbj5V+ew4B
 g+V4SnDAeq1LfkNsF+R+XZB5mZIIkdZa0ZhVw0EEeoOryHhwe7IksQQ42wp8DmG1wTXM
 wVc4U9gZ7N/5JbGiokA0O1fDFeZjTHs7UbhQbz9delLr3rxLJMLXIgZGiOGXr6mIC8FS
 Tv9A==
X-Gm-Message-State: ABy/qLYHbQ2aEdD2Gk+lmcivN/k7BkHBCY5141VGH1hzNZigOPi6GszR
 wVNdA3ZQ+Ml+QY/oSkAfU6dqrw==
X-Google-Smtp-Source: APBJJlEn+TncV73TO2UsaUApL2Ib304AMJ3f7kNNh+DBFXuUQAkwvKybFPJZy3M6Q3d46TS2/Dgcqg==
X-Received: by 2002:a7b:ce87:0:b0:3fc:2d2:caa8 with SMTP id
 q7-20020a7bce87000000b003fc02d2caa8mr7907012wmj.29.1688984240014; 
 Mon, 10 Jul 2023 03:17:20 -0700 (PDT)
Received: from [192.168.229.175] (70.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.70]) by smtp.gmail.com with ESMTPSA id
 y15-20020a1c4b0f000000b003fbc9b9699dsm9822488wma.45.2023.07.10.03.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 03:17:19 -0700 (PDT)
Message-ID: <55c6b0b8-5223-fc16-4687-c2c0f99c3c19@linaro.org>
Date: Mon, 10 Jul 2023 12:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: set 'slots' property of xhci
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: quic_llindhol@quicinc.com, chenbaozi@phytium.com.cn
References: <20230710063750.473510-1-wangyuquan1236@phytium.com.cn>
 <20230710063750.473510-2-wangyuquan1236@phytium.com.cn>
 <6f7e7eb1-0837-58d4-1b6b-4f408150579e@linaro.org>
 <e3050d63-844e-31f7-511d-48d31279be44@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e3050d63-844e-31f7-511d-48d31279be44@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 10/7/23 09:33, Marcin Juszkiewicz wrote:
> W dniu 10.07.2023 o 09:28, Richard Henderson pisze:
>>
>> hw/usb/hcd-xhci-nec.c:    DEFINE_PROP_UINT32("slots", XHCINecState, 
>> slots, XHCI_MAXSLOTS),
>> hw/usb/hcd-xhci-sysbus.c:    DEFINE_PROP_UINT32("slots", 
>> XHCISysbusState, xhci.numslots, XHCI_MAXSLOTS),
>>
>> The default is XCHI_MAXSLOTS, not 1.  So I can't see why you'd need this.
> 
> There are two systems using XHCI: i386/microvm and arm/sbsa. First
> one sets amount of slots already.
> 
> Without this patch Linux complains that there is only one port and
> refuses to connect second usb device:
> 
> xhci-hcd PNP0D10:00: Error while assigning device slot ID: No Slots 
> Available Error
> xhci-hcd PNP0D10:00: Max number of devices this xHCI host supports is 1.
> usb usb1-port2: couldn't allocate usb_device
> 
> So it looks like default being XHCI_MAXSLOTS is not applied somewhere.

Or something sets it to 1 elsewhere.

At a glance xhci_sysbus_class_init() doesn't call
device_class_set_parent_FOO().

