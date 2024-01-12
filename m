Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 463B282C207
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 15:44:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOIjy-00047e-3f; Fri, 12 Jan 2024 09:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOIjv-00047H-Em; Fri, 12 Jan 2024 09:42:31 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOIjs-0001Ht-89; Fri, 12 Jan 2024 09:42:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TBPQ62BXrz4x5l;
 Sat, 13 Jan 2024 01:42:22 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TBPQ26V5Hz4x22;
 Sat, 13 Jan 2024 01:42:18 +1100 (AEDT)
Message-ID: <a7e043b3-ce5c-45eb-ae29-8f406735c3fa@kaod.org>
Date: Fri, 12 Jan 2024 15:42:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/9] Introduce model for IBM's FSI
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20240110231537.1654478-1-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240110231537.1654478-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=qInK=IW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This is looking much better. I have a couple more comments.
Please wait a little before sending a respin ! :) and please
run make check and script/checkpatch.pl.


On 1/11/24 00:15, Ninad Palsule wrote:
> Hello,
> 
> Please review the patch-set version 10.
> I have incorporated review comments from Cedric.
> v10:
>    - Moved aspeed-apb2opb to hw/misc directory

So, it looked better before ... can you please move it back to
the fsi dir ? Sorry about that.


Thanks,

C.



>    - Moved scratchpad to lbus files.
>    - Moved fsi-slave to fsi files.
>    - Merged opb changes in the aspeed-apb2opb files
>    - Reduced number of config option to 2


> 
> Ninad Palsule (9):
>    hw/fsi: Introduce IBM's Local bus and scratchpad
>    hw/fsi: Introduce IBM's FSI Bus and FSI slave
>    hw/fsi: Introduce IBM's cfam
>    hw/fsi: Introduce IBM's FSI master
>    hw/fsi: Aspeed APB2OPB interface, Onchip perif bus
>    hw/arm: Hook up FSI module in AST2600
>    hw/fsi: Added qtest
>    hw/fsi: Added FSI documentation
>    hw/fsi: Update MAINTAINER list
> 
>   MAINTAINERS                      |   8 +
>   docs/specs/fsi.rst               | 138 +++++++++++++
>   docs/specs/index.rst             |   1 +
>   meson.build                      |   1 +
>   hw/fsi/trace.h                   |   1 +
>   include/hw/arm/aspeed_soc.h      |   4 +
>   include/hw/fsi/cfam.h            |  34 ++++
>   include/hw/fsi/fsi-master.h      |  32 +++
>   include/hw/fsi/fsi.h             |  38 ++++
>   include/hw/fsi/lbus.h            |  52 +++++
>   include/hw/misc/aspeed-apb2opb.h |  50 +++++
>   hw/arm/aspeed_ast2600.c          |  19 ++
>   hw/fsi/cfam.c                    | 182 +++++++++++++++++
>   hw/fsi/fsi-master.c              | 173 ++++++++++++++++
>   hw/fsi/fsi.c                     | 111 ++++++++++
>   hw/fsi/lbus.c                    | 121 +++++++++++
>   hw/misc/aspeed-apb2opb.c         | 338 +++++++++++++++++++++++++++++++
>   tests/qtest/aspeed-fsi-test.c    | 205 +++++++++++++++++++
>   hw/Kconfig                       |   1 +
>   hw/arm/Kconfig                   |   1 +
>   hw/fsi/Kconfig                   |   2 +
>   hw/fsi/meson.build               |   1 +
>   hw/fsi/trace-events              |  11 +
>   hw/meson.build                   |   1 +
>   hw/misc/Kconfig                  |   5 +
>   hw/misc/meson.build              |   1 +
>   hw/misc/trace-events             |   4 +
>   tests/qtest/meson.build          |   1 +
>   28 files changed, 1536 insertions(+)
>   create mode 100644 docs/specs/fsi.rst
>   create mode 100644 hw/fsi/trace.h
>   create mode 100644 include/hw/fsi/cfam.h
>   create mode 100644 include/hw/fsi/fsi-master.h
>   create mode 100644 include/hw/fsi/fsi.h
>   create mode 100644 include/hw/fsi/lbus.h
>   create mode 100644 include/hw/misc/aspeed-apb2opb.h
>   create mode 100644 hw/fsi/cfam.c
>   create mode 100644 hw/fsi/fsi-master.c
>   create mode 100644 hw/fsi/fsi.c
>   create mode 100644 hw/fsi/lbus.c
>   create mode 100644 hw/misc/aspeed-apb2opb.c
>   create mode 100644 tests/qtest/aspeed-fsi-test.c
>   create mode 100644 hw/fsi/Kconfig
>   create mode 100644 hw/fsi/meson.build
>   create mode 100644 hw/fsi/trace-events
> 


