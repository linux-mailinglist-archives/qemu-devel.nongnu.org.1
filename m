Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA87BE66B8
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Oct 2025 07:30:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9d10-0001bL-9V; Fri, 17 Oct 2025 01:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9d0x-0001bA-F6
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:28:31 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9d0u-0001jD-6I
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:28:30 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.222])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cntdh4GFsz5y2J;
 Fri, 17 Oct 2025 05:28:24 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 17 Oct
 2025 07:28:23 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004dde2f7f3-2e77-4121-8e42-616f73ae4f5c,
 48F321F6F3AAA1B288770452BCFEC79A981EE5C7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a540fa15-6e0e-4b01-8c36-50440558bade@kaod.org>
Date: Fri, 17 Oct 2025 07:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 03/12] hw/arm/ast27x0: Add SRAM link and alias
 mapping for SSP coprocessor
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
 <20251015062210.3128710-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251015062210.3128710-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 9b4f35c1-17e1-4cff-9516-043229b7a2a9
X-Ovh-Tracer-Id: 15273958137082448687
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFZq5SZnFJE7G4OKQNfF2Fc3k8YMuST+QnEcwN4XU0wZXaBvYA88NmRdFlg8x1CrbvTiPOWs+PCSoT/fqeKJPRCu8vSJw/oCllFpiabx1ImQ57yuIxdOfTb74e1DWFeIn5279a7y0jceIsC8KKm0Sl00RrD6LRbRRELBYw0XbMC2wK6vDGI61YFPSXD7j6v+fbgCWPZ6lEfRdKGw4XJIsvIZn9Jb1Iv5nICXlY1EE+iHRMAjIgZchnzJWYgeChjh/CxMtLTr4yexbbJthRbJ4VJ0QrSKBRRwV5U/VbyutIZMKzN7kGHxYgbMqRNDKcCybbRxo2eNaN0QMFwWcTJMxvjaom0zv8+3Ivlt4LOrp99enm0oAuS86FIjAzBRtTFziEgv2DdHwxywIKUkdXVStc9R0zGWb9lqsO28pbl186rJlXSn0lQHYeN3gathXmf4XbCzi3v65VWWm3ietY4lUU23SJCwn8jgLLDd6X6DjYg/XdoFfDmFHdNqFII2v5v5I8yIltsjagaV1eoBvwdJOVMAzLQeM7ZmOtJ4dsEvrfGPIMcljofKmt1NZiy938hveyeH7JkKyVtIrr6V78iV/mDjQtj380884w2kUhVptvXar25VK580/6Cxwvk0iil+X7nJbN/YH0mYk3cwf2EO2IkjFSt/aYRf5/+kpfAFDgC1A
DKIM-Signature: a=rsa-sha256; bh=LNAMW1isCWZMxdd24Di8tMuD7kgjmi7l3lhCfc6WTIY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760678904; v=1;
 b=LXGLzviEFjsq2qvA7zhHxVbMJ9lfiLwweht5158LrsshmWBA85DQjgLaOBmHWXESk0sRUu94
 HPV4T8IsOaa0lzLb+Ni69bx34CiixZxC8JZZk0X5ZOE8NOOkWri6CmcgRyUesPGjiAP6jz2i0ez
 pQ2ffaVrE/MicSK1Ml4sHtBZueeMBXkI64JQyVCbtXn+nDy38hR/ogCuFXWDF2EzgWZVJpYX+ct
 pIwp+GxPNDlGFFqGQUEmgQRSiFMcOxofHBKd+TKysJWlIS/Q3jwZzyRJvA8UJOzknvn5n7B7hlp
 qtS7Gyfi+69V/DVRKgKxWwYv915WUg8oAG5lqmEIBB4yA==
Received-SPF: pass client-ip=188.165.42.229; envelope-from=clg@kaod.org;
 helo=4.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/15/25 08:21, Jamin Lin wrote:
> AST2700 has a 128KB SRAM, physically mapped at 0x10000000–0x1001FFFF for
> the PSP (CA35) processor. The SSP coprocessor shares this same SRAM but
> accesses it through a different address window at 0x70000000–0x7001FFFF.
> 
> To model this shared-memory behavior in QEMU, this commit introduces a
> linked SRAM property and alias mapping between the PSP and SSP subsystems.
> 
> Changes include:
> - Add a "MemoryRegion *sram" link and "MemoryRegion sram_alias" to
>    AspeedCoprocessorState.
> - Register the new "sram" property in aspeed_coprocessor_common.c.
> - In aspeed_ast27x0-fc.c, connect the SSP coprocessor’s "sram" link to
>    the PSP’s SRAM region.
> - In aspeed_ast27x0-ssp.c, create an alias mapping for SRAM at
>    0x70000000 – 0x7001FFFF in the SSP’s memory map.
> 
> This ensures that the SSP can correctly access the shared SRAM contents
> through its own address space while maintaining a consistent physical
> backing region. It also guarantees that the SRAM is realized before the
> SSP device, ensuring successful alias setup.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h | 3 ++-
>   hw/arm/aspeed_ast27x0-fc.c          | 4 ++++
>   hw/arm/aspeed_ast27x0-ssp.c         | 7 +++++++
>   hw/arm/aspeed_coprocessor_common.c  | 2 ++
>   4 files changed, 15 insertions(+), 1 deletion(-)
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




