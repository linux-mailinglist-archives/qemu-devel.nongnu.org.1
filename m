Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE1576ED96
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:07:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZv2-0002EO-7J; Thu, 03 Aug 2023 11:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qRZv0-0002E3-1Y
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:07:14 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qRZux-0000zV-MZ
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:07:13 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso152194566b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691075230; x=1691680030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0cXqoXIy279gLDVv4Hu2uIWuvxfqgmNM+vlX3uwmTYg=;
 b=EvEcWq7FGO7y/CdqlCH5R5s5ulG9F1EOd96zBTvlrWD5ptYBx5BpMz3OPqulHgsBkt
 6l+b4WDdgcO/mMTvdcXNoJoxMv7AaZj/nAkD+2SHVzXoP911G9mMjXoT50QNSiB/Z8aI
 UA/MMaanpfVrJCTvMnzGDFWU3U3ndi8Tcm+8lY04g8NVW1mXuHP/mk0GZMOY2K1GY73L
 nT74vXpLCGJT5LE6tZFadHBA0PG1enkTMDNohqlSgJMNqQrrgcpWJdwQy7dyzea42cW3
 fETYqM+EeyL1Vv2wfFZF2L5LSNmnw2zP6K9NjVy3GhlQI93nf71SZyTgHQFe+eS2grGW
 1U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691075230; x=1691680030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cXqoXIy279gLDVv4Hu2uIWuvxfqgmNM+vlX3uwmTYg=;
 b=Q6MgRG+7de8GLiumbIxDz4TA83jVhhxM/7KeoXmRbk4Fz6pViFHo1F0iSnH6ducaTG
 QFlxIUkBHbNMH7xDwDE9QtKO95lhIywIo+bdIMFPZtCDc2S1eqLDOx0K8B1t7WE4c9R1
 i1hfC4Ot15bTr3bw6Mhl3hX3yvg+RjQE/xSjkLrS1CchTKIC8M1ARVszvgWDU/cVfS5X
 rZDfvekgpS0bS2Ltr6o6j6BoWRo9PCi49BPL9Zxu2I0G0HxbeO37tE3EhHFlbQMa3rZP
 QfXmrwNAIr/w405Y1X6rouSxzHQA5TrXDof0gG4z2RgTquBCRTfc0WQyeSsWXixhoj5p
 hanw==
X-Gm-Message-State: ABy/qLaPR/oNU45PkehCfL5fBAe3js+hi/kuicLW+AB34RVQi3/8Vg3Y
 sQdmyE0Zl5Zr5+myXFQzmCH+SQ==
X-Google-Smtp-Source: APBJJlFTAHbB95dodXdKQBYoly991uJL6pbvvv1ndLPuexQ4sDgt5D/p5Pj4sphIomeKoLzIMOWb4A==
X-Received: by 2002:a17:906:cc58:b0:991:d05c:f065 with SMTP id
 mm24-20020a170906cc5800b00991d05cf065mr7981368ejb.52.1691075229503; 
 Thu, 03 Aug 2023 08:07:09 -0700 (PDT)
Received: from localhost (212-5-140-29.ip.btc-net.bg. [212.5.140.29])
 by smtp.gmail.com with ESMTPSA id
 cw25-20020a170906c79900b0098d2d219649sm10684737ejb.174.2023.08.03.08.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 08:07:09 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:07:03 +0300
From: Andrew Jones <ajones@ventanamicro.com>
To: Fei Wu <fei2.wu@intel.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Andrei Warkentin <andrei.warkentin@intel.com>
Subject: Re: [PATCH] hw/riscv: split RAM into low and high memory
Message-ID: <20230803-3855259bbabb934c247c5607@orel>
References: <20230731015317.1026996-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731015317.1026996-1-fei2.wu@intel.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jul 31, 2023 at 09:53:17AM +0800, Fei Wu wrote:
> riscv virt platform's memory started at 0x80000000 and
> straddled the 4GiB boundary. Curiously enough, this choice
> of a memory layout will prevent from launching a VM with
> a bit more than 2000MiB and PCIe pass-thru on an x86 host, due
> to identity mapping requirements for the MSI doorbell on x86,
> and these (APIC/IOAPIC) live right below 4GiB.
> 
> So just split the RAM range into two portions:
> - 1 GiB range from 0x80000000 to 0xc0000000.
> - The remainder at 0x100000000
> 
> ...leaving a hole between the ranges.

Can you elaborate on the use case? Maybe provide details of the host
system and the QEMU command line? I'm wondering why we didn't have
any problems with the arm virt machine type. Has nobody tried this
use case with that? Is the use case something valid for riscv, but
not arm?

Thanks,
drew

