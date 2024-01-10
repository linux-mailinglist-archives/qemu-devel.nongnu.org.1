Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4638B829477
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 08:47:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNTGj-0001yg-AT; Wed, 10 Jan 2024 02:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=E0xP=IU=kaod.org=clg@ozlabs.org>)
 id 1rNTGf-0001vg-7F; Wed, 10 Jan 2024 02:44:53 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=E0xP=IU=kaod.org=clg@ozlabs.org>)
 id 1rNTGc-0003mF-Ep; Wed, 10 Jan 2024 02:44:52 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T90Dx6wL8z4wch;
 Wed, 10 Jan 2024 18:44:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T90Dt1PqXz4wnw;
 Wed, 10 Jan 2024 18:44:29 +1100 (AEDT)
Message-ID: <d9d29531-e3a1-4f16-b0af-f9328d72508f@kaod.org>
Date: Wed, 10 Jan 2024 08:44:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Introduce model for IBM's FSI
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231128235700.599584-1-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231128235700.599584-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=E0xP=IU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello Ninad,

Here are comments on the file organization and configs.

On 11/29/23 00:56, Ninad Palsule wrote:
> Hello,
> 
> Please review the patch-set version 8.
> I have incorporated review comments from Cedric.
>    - Fixed checkpatch failures.
>    - Fixed commit messages.
>    - Fixed LBUS memory map size.
> 
> Ninad Palsule (10):
>    hw/fsi: Introduce IBM's Local bus
>    hw/fsi: Introduce IBM's FSI Bus
>    hw/fsi: Introduce IBM's cfam,fsi-slave,scratchpad
>    hw/fsi: IBM's On-chip Peripheral Bus
>    hw/fsi: Introduce IBM's FSI master
>    hw/fsi: Aspeed APB2OPB interface
>    hw/arm: Hook up FSI module in AST2600
>    hw/fsi: Added qtest
>    hw/fsi: Added FSI documentation
>    hw/fsi: Update MAINTAINER list
> 
>   MAINTAINERS                     |   8 +
>   docs/specs/fsi.rst              | 138 ++++++++++++++
>   docs/specs/index.rst            |   1 +
>   meson.build                     |   1 +
>   hw/fsi/trace.h                  |   1 +
>   include/hw/arm/aspeed_soc.h     |   4 +
>   include/hw/fsi/aspeed-apb2opb.h |  34 ++++

aspeed-apb2opb is a HW logic bridging the FSI world and Aspeed. It
doesn't belong to the FSI susbsytem. Since we don't have a directory
for platform specific devices, I think the model shoud go under hw/misc/.


>   include/hw/fsi/cfam.h           |  45 +++++

scratchpad is the only lbus device and it is quite generic, we could
move it to lbus files. It would be nice to implement more than one
reg.

  
>   include/hw/fsi/fsi-master.h     |  32 ++++
>   include/hw/fsi/fsi-slave.h      |  29 +++
>   include/hw/fsi/fsi.h            |  24 +++

I would move the definitions and implementation of the fsi bus and
the fsi slave under the fsi.h and fsi.c files


>   include/hw/fsi/lbus.h           |  40 ++++
>   include/hw/fsi/opb.h            |  25 +++

opb is quite minimal now and I think it could be hidden under
aspeed-apb2opb.

>   hw/arm/aspeed_ast2600.c         |  19 ++
>   hw/fsi/aspeed-apb2opb.c         | 316 ++++++++++++++++++++++++++++++++
>   hw/fsi/cfam.c                   | 261 ++++++++++++++++++++++++++
>   hw/fsi/fsi-master.c             | 165 +++++++++++++++++
>   hw/fsi/fsi-slave.c              |  78 ++++++++
>   hw/fsi/fsi.c                    |  22 +++
>   hw/fsi/lbus.c                   |  51 ++++++
>   hw/fsi/opb.c                    |  36 ++++
>   tests/qtest/aspeed-fsi-test.c   | 205 +++++++++++++++++++++
>   hw/Kconfig                      |   1 +
>   hw/arm/Kconfig                  |   1 +
>   hw/fsi/Kconfig                  |  21 +++

one CONFIG_FSI option and one CONFIG_FSI_APB2OPB should be enough.
CONFIG_FSI_APB2OPB should select FSI and depends on CONFIG_ASPEED_SOC.


Thanks,

C.




>   hw/fsi/meson.build              |   5 +
>   hw/fsi/trace-events             |  13 ++
>   hw/meson.build                  |   1 +
>   tests/qtest/meson.build         |   1 +
>   29 files changed, 1578 insertions(+)
>   create mode 100644 docs/specs/fsi.rst
>   create mode 100644 hw/fsi/trace.h
>   create mode 100644 include/hw/fsi/aspeed-apb2opb.h
>   create mode 100644 include/hw/fsi/cfam.h
>   create mode 100644 include/hw/fsi/fsi-master.h
>   create mode 100644 include/hw/fsi/fsi-slave.h
>   create mode 100644 include/hw/fsi/fsi.h
>   create mode 100644 include/hw/fsi/lbus.h
>   create mode 100644 include/hw/fsi/opb.h
>   create mode 100644 hw/fsi/aspeed-apb2opb.c
>   create mode 100644 hw/fsi/cfam.c
>   create mode 100644 hw/fsi/fsi-master.c
>   create mode 100644 hw/fsi/fsi-slave.c
>   create mode 100644 hw/fsi/fsi.c
>   create mode 100644 hw/fsi/lbus.c
>   create mode 100644 hw/fsi/opb.c
>   create mode 100644 tests/qtest/aspeed-fsi-test.c
>   create mode 100644 hw/fsi/Kconfig
>   create mode 100644 hw/fsi/meson.build
>   create mode 100644 hw/fsi/trace-events
> 


