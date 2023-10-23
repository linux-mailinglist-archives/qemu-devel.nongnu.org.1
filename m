Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9F97D3A57
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwTL-0001UB-PH; Mon, 23 Oct 2023 11:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwTK-0001TU-0H
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:04:02 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwTH-0005CH-Ku
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:04:01 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so505697366b.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698073437; x=1698678237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G2l4xlf5FZSuh1ZEkXuGRd6Zn3cWhy8D2f0DOG0FLgc=;
 b=iwYEZcMoY7/w706WftGtocL5Ucuvxt/GiHeOA+xX18f3z7gc7dPu/wdJCz933CjvBv
 p7WjEbuNmKT41g9C0lq2kXxoIPw9bagnGGWdxQttwvZa79iytqDo19BSW7Yufhr9nMKV
 821byzL7g5jN4a7G6YxIq0KicaRsmubxPci2NXTmSOP/ivWG8lm4v5oakA0QYmO6Rfc9
 huDoPXA6w3Wwg0Hz8uC+notTM+6rxtlLVaIJN1T7Ip0GYPWYUt3aR5o7ZKxew9GvsEI5
 +r31rgOJCi9YqT3cw2EU9Xbsa7HpDbzrvNm2EJZOIRvsiZg1CNIMaNWpSC81Z0MxGy4/
 0GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698073437; x=1698678237;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G2l4xlf5FZSuh1ZEkXuGRd6Zn3cWhy8D2f0DOG0FLgc=;
 b=SOvdi3WX37Zaw7jfn+mN3lojAiNl0S3tMPfXEiJPzn/26wgXwhsiHNk1S/sWFOWYKC
 XqzdmUO+mweLJvrK7eTyHc4eAwjsFEFUbOkNKYLC+Wp896k6E+S/G9zel0tcpPyEBrkO
 4dU8X+oRrjpfJjs0NZ7DwYApyyuZKeFZX8+7jRp0rMMbeX9NkvGBx8NJcecAc5sgVvrp
 03ZEr5dP7+P0Juj/gYT+H4aXaZoLMXg7fMDMYGKHE4deqddRhwX+UGq3LicTqlcXBtPY
 xLPlMCCyUrT3WLWsmsjF0r0Wf8v3EfePVtOj7RvdNZdsmOJvUrASgDevdAisIaB4uDgw
 QYSA==
X-Gm-Message-State: AOJu0YyKI1SW4tCpXrF/O/ZzZBL0OSSVqSPb2aZSg4gQh6RdMZUddntd
 Pc6F9afx3lOQj0ov8BcmyiTjlg==
X-Google-Smtp-Source: AGHT+IG6p+vKIYGk1+dLGTSCvimynlA4TCDBhuc8MuMk8zITV7p1j4x/UV+UwHz0QxG0q+8R4BdE/Q==
X-Received: by 2002:a17:907:724d:b0:9bd:b8d0:c099 with SMTP id
 ds13-20020a170907724d00b009bdb8d0c099mr6547810ejc.6.1698073437033; 
 Mon, 23 Oct 2023 08:03:57 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr. [176.170.216.159])
 by smtp.gmail.com with ESMTPSA id
 10-20020a170906218a00b009c0c511bd62sm6722714eju.197.2023.10.23.08.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 08:03:55 -0700 (PDT)
Message-ID: <0177b29e-ee73-d266-3ce0-6541bc2db649@linaro.org>
Date: Mon, 23 Oct 2023 17:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 07/10] hw/arm: Hook up FSI module in AST2600
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-8-ninad@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231021211720.3571082-8-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 21/10/23 23:17, Ninad Palsule wrote:
> This patchset introduces IBM's Flexible Service Interface(FSI).
> 
> Time for some fun with inter-processor buses. FSI allows a service
> processor access to the internal buses of a host POWER processor to
> perform configuration or debugging.
> 
> FSI has long existed in POWER processes and so comes with some baggage,
> including how it has been integrated into the ASPEED SoC.
> 
> Working backwards from the POWER processor, the fundamental pieces of
> interest for the implementation are:
> 
> 1. The Common FRU Access Macro (CFAM), an address space containing
>     various "engines" that drive accesses on buses internal and external
>     to the POWER chip. Examples include the SBEFIFO and I2C masters. The
>     engines hang off of an internal Local Bus (LBUS) which is described
>     by the CFAM configuration block.
> 
> 2. The FSI slave: The slave is the terminal point of the FSI bus for
>     FSI symbols addressed to it. Slaves can be cascaded off of one
>     another. The slave's configuration registers appear in address space
>     of the CFAM to which it is attached.
> 
> 3. The FSI master: A controller in the platform service processor (e.g.
>     BMC) driving CFAM engine accesses into the POWER chip. At the
>     hardware level FSI is a bit-based protocol supporting synchronous and
>     DMA-driven accesses of engines in a CFAM.
> 
> 4. The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
>     POWER processors. This now makes an appearance in the ASPEED SoC due
>     to tight integration of the FSI master IP with the OPB, mainly the
>     existence of an MMIO-mapping of the CFAM address straight onto a
>     sub-region of the OPB address space.
> 
> 5. An APB-to-OPB bridge enabling access to the OPB from the ARM core in
>     the AST2600. Hardware limitations prevent the OPB from being directly
>     mapped into APB, so all accesses are indirect through the bridge.
> 
> The implementation appears as following in the qemu device tree:
> 
>      (qemu) info qtree
>      bus: main-system-bus
>        type System
>        ...
>        dev: aspeed.apb2opb, id ""
>          gpio-out "sysbus-irq" 1
>          mmio 000000001e79b000/0000000000001000
>          bus: opb.1
>            type opb
>            dev: fsi.master, id ""
>              bus: fsi.bus.1
>                type fsi.bus
>                dev: cfam.config, id ""
>                dev: cfam, id ""
>                  bus: fsi.lbus.1
>                    type lbus
>                    dev: scratchpad, id ""
>                      address = 0 (0x0)
>          bus: opb.0
>            type opb
>            dev: fsi.master, id ""
>              bus: fsi.bus.0
>                type fsi.bus
>                dev: cfam.config, id ""
>                dev: cfam, id ""
>                  bus: fsi.lbus.0
>                    type lbus
>                    dev: scratchpad, id ""
>                      address = 0 (0x0)
> 
> The LBUS is modelled to maintain the qdev bus hierarchy and to take
> advantage of the object model to automatically generate the CFAM
> configuration block. The configuration block presents engines in the
> order they are attached to the CFAM's LBUS. Engine implementations
> should subclass the LBusDevice and set the 'config' member of
> LBusDeviceClass to match the engine's type.
> 
> CFAM designs offer a lot of flexibility, for instance it is possible for
> a CFAM to be simultaneously driven from multiple FSI links. The modeling
> is not so complete; it's assumed that each CFAM is attached to a single
> FSI slave (as a consequence the CFAM subclasses the FSI slave).
> 
> As for FSI, its symbols and wire-protocol are not modelled at all. This
> is not necessary to get FSI off the ground thanks to the mapping of the
> CFAM address space onto the OPB address space - the models follow this
> directly and map the CFAM memory region into the OPB's memory region.
> Future work includes supporting more advanced accesses that drive the
> FSI master directly rather than indirectly via the CFAM mapping, which
> will require implementing the FSI state machine and methods for each of
> the FSI symbols on the slave. Further down the track we can also look at
> supporting the bitbanged SoftFSI drivers in Linux by extending the FSI
> slave model to resolve sequences of GPIO IRQs into FSI symbols, and
> calling the associated symbol method on the slave to map the access onto
> the CFAM.
> 
> Testing:
>      Tested by reading cfam config address 0 on rainier machine type.
> 
>      root@p10bmc:~# pdbg -a getcfam 0x0
>      p0: 0x0 = 0xc0022d15
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   include/hw/arm/aspeed_soc.h |  4 ++++
>   hw/arm/aspeed_ast2600.c     | 19 +++++++++++++++++++
>   2 files changed, 23 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


