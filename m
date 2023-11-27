Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 424B17FA672
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 17:32:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7eX4-0000fU-GT; Mon, 27 Nov 2023 11:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5Qwu=HI=kaod.org=clg@ozlabs.org>)
 id 1r7eWj-0000Qb-TR; Mon, 27 Nov 2023 11:32:05 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5Qwu=HI=kaod.org=clg@ozlabs.org>)
 id 1r7eWh-0006oW-AF; Mon, 27 Nov 2023 11:32:05 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SfB1p4mRmz4xR5;
 Tue, 28 Nov 2023 03:31:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SfB1h2Krpz4xPf;
 Tue, 28 Nov 2023 03:31:51 +1100 (AEDT)
Message-ID: <417e8a68-2f35-4315-b694-892f78c811b6@kaod.org>
Date: Mon, 27 Nov 2023 17:31:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] Introduce model for IBM's FSI
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231026164741.1184058-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=5Qwu=HI=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 10/26/23 18:47, Ninad Palsule wrote:
> Hello,
> 
> Please review the patch-set version 7.
> I have incorporated review comments from Cedric, Philippe and Thomas.


I reworked v7 with the suggestions I made in patches 1-6. Please check :

   https://github.com/legoater/qemu/commits/aspeed-8.2

I will have more questions on the mappings because some parts are really
unclear.


Thanks,

C.


> 
> Ninad Palsule (10):
>    hw/fsi: Introduce IBM's Local bus
>    hw/fsi: Introduce IBM's scratchpad
>    hw/fsi: Introduce IBM's cfam,fsi-slave
>    hw/fsi: Introduce IBM's FSI
>    hw/fsi: IBM's On-chip Peripheral Bus
>    hw/fsi: Aspeed APB2OPB interface
>    hw/arm: Hook up FSI module in AST2600
>    hw/fsi: Added qtest
>    hw/fsi: Added FSI documentation
>    hw/fsi: Update MAINTAINER list
> 
>   MAINTAINERS                        |   8 +
>   docs/specs/fsi.rst                 | 138 +++++++++++++++
>   docs/specs/index.rst               |   1 +
>   meson.build                        |   1 +
>   hw/fsi/trace.h                     |   1 +
>   include/hw/arm/aspeed_soc.h        |   4 +
>   include/hw/fsi/aspeed-apb2opb.h    |  33 ++++
>   include/hw/fsi/cfam.h              |  34 ++++
>   include/hw/fsi/engine-scratchpad.h |  27 +++
>   include/hw/fsi/fsi-master.h        |  30 ++++
>   include/hw/fsi/fsi-slave.h         |  29 +++
>   include/hw/fsi/fsi.h               |  36 ++++
>   include/hw/fsi/lbus.h              |  43 +++++
>   include/hw/fsi/opb.h               |  33 ++++
>   hw/arm/aspeed_ast2600.c            |  19 ++
>   hw/fsi/aspeed-apb2opb.c            | 272 +++++++++++++++++++++++++++++
>   hw/fsi/cfam.c                      | 173 ++++++++++++++++++
>   hw/fsi/engine-scratchpad.c         |  93 ++++++++++
>   hw/fsi/fsi-master.c                | 161 +++++++++++++++++
>   hw/fsi/fsi-slave.c                 |  78 +++++++++
>   hw/fsi/fsi.c                       |  25 +++
>   hw/fsi/lbus.c                      |  74 ++++++++
>   hw/fsi/opb.c                       |  74 ++++++++
>   tests/qtest/aspeed-fsi-test.c      | 205 ++++++++++++++++++++++
>   hw/Kconfig                         |   1 +
>   hw/arm/Kconfig                     |   1 +
>   hw/fsi/Kconfig                     |  23 +++
>   hw/fsi/meson.build                 |   6 +
>   hw/fsi/trace-events                |  13 ++
>   hw/meson.build                     |   1 +
>   tests/qtest/meson.build            |   1 +
>   31 files changed, 1638 insertions(+)
>   create mode 100644 docs/specs/fsi.rst
>   create mode 100644 hw/fsi/trace.h
>   create mode 100644 include/hw/fsi/aspeed-apb2opb.h
>   create mode 100644 include/hw/fsi/cfam.h
>   create mode 100644 include/hw/fsi/engine-scratchpad.h
>   create mode 100644 include/hw/fsi/fsi-master.h
>   create mode 100644 include/hw/fsi/fsi-slave.h
>   create mode 100644 include/hw/fsi/fsi.h
>   create mode 100644 include/hw/fsi/lbus.h
>   create mode 100644 include/hw/fsi/opb.h
>   create mode 100644 hw/fsi/aspeed-apb2opb.c
>   create mode 100644 hw/fsi/cfam.c
>   create mode 100644 hw/fsi/engine-scratchpad.c
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


