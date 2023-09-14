Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A707A0553
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:17:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmCM-0000rR-Bj; Thu, 14 Sep 2023 09:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qgmCJ-0000qv-9x
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:15:55 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qgmCH-0008V5-Cw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:15:55 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-500913779f5so1605353e87.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694697351; x=1695302151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rvg5/oqSKaJkI/BDusWToy5I7SmDAvtrYXFEZErW++g=;
 b=ONtyu94HwLfgzGGyd4G3vWPE6jnBW7M+0keSIx7NG6fnZu9p8qWAHynONs/Ds8kQ2T
 +nWW0NwISvN3W7K50g+xgyNax7XISk26CVGyvYvc80wxQaW2iBnThZwLOKbBXrv5QsWR
 h/WC8ODFfsCasb9E6rnjvheAgwdH1Bp0/WEPHInjCIyw01gdKCpyF9PCKXTgMASo6WRs
 LOqiyxp9ii79wSbYaAOfF9sSgz+QoXuT7trXC/NiCP7rUMn7y/2DU6ujmO2UTmN7xdOw
 mEPzJiL6t4dWU6kGlo6FMJaLurGGcSd9dM3OOtYMbzVCayOYs28oMrzHiHVVO3oLYGKD
 DQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694697351; x=1695302151;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rvg5/oqSKaJkI/BDusWToy5I7SmDAvtrYXFEZErW++g=;
 b=kxcR6WKIUIgtDbPaW1WDhFLxvqIr5Zv7+nuFpKQht5BT+KWEUV2pMJVcjCIYk/q/pu
 er2O0khShmYUScvk8zbp8PDeJxlBXSAMKIRirIcjA97ucJoynM0epk/kuPA+XquOlfHe
 JFdws6NWlIlx5rZXo8WtJ65GoQ6Kf0SVzSTAOOIP7msBVnKNtqpcc/ydvOgtLuYgCBER
 ynTyflGUC1KKdKFun6cj6vi4sQlBwLYQRgviDJMfHOs2gnAmQXXpie2jyDNsMdq8kWcw
 1AfPfRkxxyizqBCjofEVIbL7ICBmchQ1CdfU/rPEiyca/QujCe+z07g4tFUmy0iTN97H
 zMtw==
X-Gm-Message-State: AOJu0Yz1QYvFnqeeER2CbVv5RI2hszoCRh3ufJVCNuVIeks98mSRhz4J
 Dy5NrJZBjKPCyFHwj2+V9w/c/A==
X-Google-Smtp-Source: AGHT+IH+Fkzovzdl/8Qt7RIZpNGd0AJlKqu2BV1WEkvnZupomVTCblCzX2S4eauu3RDF0rvoANq6Qg==
X-Received: by 2002:a19:2d52:0:b0:500:be7e:e84d with SMTP id
 t18-20020a192d52000000b00500be7ee84dmr3810806lft.61.1694697351067; 
 Thu, 14 Sep 2023 06:15:51 -0700 (PDT)
Received: from [192.168.200.206] (83.21.94.247.ipv4.supernova.orange.pl.
 [83.21.94.247]) by smtp.gmail.com with ESMTPSA id
 m25-20020a195219000000b004fe119b0105sm269684lfb.272.2023.09.14.06.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 06:15:50 -0700 (PDT)
Message-ID: <986148e3-2830-4333-bfd7-29de9fa2dab8@linaro.org>
Date: Thu, 14 Sep 2023 15:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Refactor PPI logic/definitions for virt/sbsa-ref
Content-Language: pl-PL, en-GB, en-HK
To: Leif Lindholm <quic_llindhol@quicinc.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230914120124.55410-1-quic_llindhol@quicinc.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230914120124.55410-1-quic_llindhol@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

W dniu 14.09.2023 o 14:01, Leif Lindholm pisze:
> While reviewing Marcin's patch this morning, cross referencing different
> specifications and looking at various places around the source code in
> order to convinced myself he really hadn't missed something out (the
> existing plumbing made it *so* clean to add), my brain broke slightly
> at keeping track of PPIs/INTIDs between the various sources.
> 
> Moreover, I found the PPI() macro in virt.h to be doing the exact
> opposite of what I would have expected it to (it converts a PPI to an
> INTID rather than the other way around).
> 
> So I refactored stuff so that:
> - PPIs defined by BSA are moved to a (new) common header.
> - The _IRQ definitions for those PPIs refer to the INTIDs.
> - sbsa-ref and virt both use these definitions.
> 
> This change does objectively add a bit more noise to the code, since it
> means more locations need to use the PPI macro than before, but it felt
> like a readability improvement to me.

I like how code looks after those changes. No more adding 16 to irq
numbers to fit them into BSA spec numbers is nice to have.

Will rebase my "non-secure EL2 virtual timer" patch on top of it.

> Not even compilation tested, just the least confusing way of asking
> whether the change could be accepted at all.

There are build warnings and final binary segfaults on start.

--------------------------------------------
[1799/2931] Compiling C object libqemu-aarch64-softmmu.fa.p/hw_arm_sbsa-ref.c.o
../hw/arm/sbsa-ref.c: In function ‘create_gic’:
../hw/arm/sbsa-ref.c:496:13: warning: assignment to ‘int’ from ‘qemu_irq’ {aka ‘struct IRQState *’} makes integer from pointer without a cast [-Wint-conversion]
   496 |         irq = qdev_get_gpio_in(sms->gic,
       |             ^
../hw/arm/sbsa-ref.c:499:37: warning: passing argument 4 of ‘qdev_connect_gpio_out_named’ makes pointer from integer without a cast [-Wint-conversion]
   499 |                                     irq);
       |                                     ^~~
       |                                     |
       |                                     int
In file included from /home/marcin/devel/linaro/sbsa-qemu/code/qemu/include/hw/core/cpu.h:23,
                  from ../target/arm/cpu-qom.h:23,
                  from ../target/arm/cpu.h:26,
                  from /home/marcin/devel/linaro/sbsa-qemu/code/qemu/include/sysemu/kvm.h:244,
                  from ../hw/arm/sbsa-ref.c:27:
/home/marcin/devel/linaro/sbsa-qemu/code/qemu/include/hw/qdev-core.h:699:43: note: expected ‘qemu_irq’ {aka ‘struct IRQState *’} but argument is of type ‘int’
   699 |                                  qemu_irq input_pin);
       |                                  ~~~~~~~~~^~~~~~~~~
../hw/arm/sbsa-ref.c:501:13: warning: assignment to ‘int’ from ‘qemu_irq’ {aka ‘struct IRQState *’} makes integer from pointer without a cast [-Wint-conversion]
   501 |         irq = qdev_get_gpio_in(sms->gic,
       |             ^
../hw/arm/sbsa-ref.c:503:65: warning: passing argument 4 of ‘qdev_connect_gpio_out_named’ makes pointer from integer without a cast [-Wint-conversion]
   503 |         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0, irq);
       |                                                                 ^~~
       |                                                                 |
       |                                                                 int
/home/marcin/devel/linaro/sbsa-qemu/code/qemu/include/hw/qdev-core.h:699:43: note: expected ‘qemu_irq’ {aka ‘struct IRQState *’} but argument is of type ‘int’
   699 |                                  qemu_irq input_pin);
       |                                  ~~~~~~~~~^~~~~~~~~
--------------------------------------------

