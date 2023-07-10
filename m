Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583374CE82
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlOT-0007nx-Ij; Mon, 10 Jul 2023 03:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qIlOP-0007nS-DJ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:33:09 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qIlON-00084k-Rq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:33:09 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b6f9edac8dso61013691fa.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688974385; x=1691566385;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=R9trHrdS1Xn+uVa5c17I4MVCbtAck/un8jjbp4RLqXA=;
 b=Cvo8I75NE3LGfEFwRYuFIbbqYdy4n0jUdFI2jFsI4JrrBDXMz7tkI/6BMV1inp5klE
 46xsarZZbcyhrFZY+VcNg700OthI11huZwIptJAsJP/7TeV/VGyxAdLACKJphruSXPCB
 NS/LP2sdkwYrGySPx236WgttZosXw0WHZ5m+JF555hgNyN29wI8wGfzYEJrfeqllJKEB
 a6055AyXCVv2hkdLnGnIiTYc8fElDwSSC+sq6uOvjC8L52+kqdpJaQzv9ZybY5XeZOw0
 mPnZkEseA5t6+cLWHEgT6JhuDfWUzf8nKKejd0jD6AiXzMIaX7kcqrs56QDvVxlM8KLE
 gA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688974385; x=1691566385;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R9trHrdS1Xn+uVa5c17I4MVCbtAck/un8jjbp4RLqXA=;
 b=PQjqNMgveg/RqPllAZFU4cYd5h2AGcgBs41gq2ZoJFBt+MKiQZg80i3X9zKpGVrDtU
 Uck08lvbLBfQxiyEROCu5Dx5XBPM6u6U7+Vutrhu3YHWIJ4HAJD1Ewu9NDxntz1jnxB8
 gdCMIcD2gFCsasNh5OYeS6EAdqeHFSwoINbRW+gGM9QnYMY9pSC2cMFG1iHy87QDm6tb
 o7Sb7M7usxVxQR2/A+o/NxBrnar+oE7jAI4EmVywA6wccQGN8369RF+obH/TmSAtUBmb
 nBthWBRTQH8rSFiuRHzj/6s5EbEWu55xQs+qiaYKhrvO446zDcVZdIAsW4ODuHuZCQh/
 1VIg==
X-Gm-Message-State: ABy/qLZtEXb81fOXLNP5yJFrzqjUyN4kZ9t5gbNIoVE6iyAWzrxFzXiC
 HR5gCCt5f64zqE8ys1wfdSjVTQ==
X-Google-Smtp-Source: APBJJlHPycSrkgfb6G/DwHY8mgg5Cmh8orhlM5vuOfBiBhMHYWFRh1XIg45I+u2deO6kjAthoI5KuA==
X-Received: by 2002:a2e:7d15:0:b0:2b6:d7a0:c27d with SMTP id
 y21-20020a2e7d15000000b002b6d7a0c27dmr8392149ljc.37.1688974385384; 
 Mon, 10 Jul 2023 00:33:05 -0700 (PDT)
Received: from [192.168.200.206] (83.21.151.197.ipv4.supernova.orange.pl.
 [83.21.151.197]) by smtp.gmail.com with ESMTPSA id
 o15-20020a2e9b4f000000b002b6ff6e7dccsm1878321ljj.26.2023.07.10.00.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 00:33:05 -0700 (PDT)
Message-ID: <e3050d63-844e-31f7-511d-48d31279be44@linaro.org>
Date: Mon, 10 Jul 2023 09:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: set 'slots' property of xhci
Content-Language: pl-PL, en-GB, en-HK
To: Richard Henderson <richard.henderson@linaro.org>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: quic_llindhol@quicinc.com, chenbaozi@phytium.com.cn
References: <20230710063750.473510-1-wangyuquan1236@phytium.com.cn>
 <20230710063750.473510-2-wangyuquan1236@phytium.com.cn>
 <6f7e7eb1-0837-58d4-1b6b-4f408150579e@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <6f7e7eb1-0837-58d4-1b6b-4f408150579e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

W dniu 10.07.2023 o 09:28, Richard Henderson pisze:
> 
> hw/usb/hcd-xhci-nec.c:    DEFINE_PROP_UINT32("slots", XHCINecState, 
> slots, XHCI_MAXSLOTS),
> hw/usb/hcd-xhci-sysbus.c:    DEFINE_PROP_UINT32("slots", 
> XHCISysbusState, xhci.numslots, XHCI_MAXSLOTS),
> 
> The default is XCHI_MAXSLOTS, not 1.  So I can't see why you'd need this.

There are two systems using XHCI: i386/microvm and arm/sbsa. First
one sets amount of slots already.

Without this patch Linux complains that there is only one port and
refuses to connect second usb device:

xhci-hcd PNP0D10:00: Error while assigning device slot ID: No Slots Available Error
xhci-hcd PNP0D10:00: Max number of devices this xHCI host supports is 1.
usb usb1-port2: couldn't allocate usb_device

So it looks like default being XHCI_MAXSLOTS is not applied somewhere.

