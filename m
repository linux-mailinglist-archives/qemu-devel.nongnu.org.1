Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB927CF242
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 10:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtODD-0003ox-Jg; Thu, 19 Oct 2023 04:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PA0m=GB=kaod.org=clg@ozlabs.org>)
 id 1qtODB-0003id-9b; Thu, 19 Oct 2023 04:16:57 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PA0m=GB=kaod.org=clg@ozlabs.org>)
 id 1qtOD7-0003rc-AP; Thu, 19 Oct 2023 04:16:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SB0tR5XKkz4xcL;
 Thu, 19 Oct 2023 19:16:47 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SB0tN0MPgz4xc1;
 Thu, 19 Oct 2023 19:16:43 +1100 (AEDT)
Message-ID: <cd99c52d-8232-4598-83cf-088a715a7a34@kaod.org>
Date: Thu, 19 Oct 2023 10:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Introduce model for IBM's FSI
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231011151339.2782132-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=PA0m=GB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 10/11/23 17:13, Ninad Palsule wrote:
> Hello,
> 
> Please review the patch-set version 5.
> I have incorporated review comments from Cedric.
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

I made some comments, mostly on the bus models which need to be reworked.
This is code reshuffling and it should simplify the models. Please consider
reducing the amount of files.

Also, could please remove my Sob ?  I didn't write any of this, only did
quick fixes over the years because I kept the series in my aspeed tree.
And this would help me to add a Rb :)

I expect one or two respins before merge. 8.2 freeze window is in less
than 3 weeks. It could make it, else the next. No big issue since I think
we have been dragging these models for at least 5/6 years.

Thanks,

C.


> 
>   MAINTAINERS                        |   8 +
>   docs/specs/fsi.rst                 | 141 ++++++++++++
>   meson.build                        |   1 +
>   hw/fsi/trace.h                     |   1 +
>   include/hw/arm/aspeed_soc.h        |   4 +
>   include/hw/fsi/aspeed-apb2opb.h    |  33 +++
>   include/hw/fsi/cfam.h              |  58 +++++
>   include/hw/fsi/engine-scratchpad.h |  33 +++
>   include/hw/fsi/fsi-master.h        |  30 +++
>   include/hw/fsi/fsi-slave.h         |  29 +++
>   include/hw/fsi/fsi.h               |  37 +++
>   include/hw/fsi/lbus.h              |  51 +++++
>   include/hw/fsi/opb.h               |  43 ++++
>   include/qemu/bitops.h              |   6 +
>   hw/arm/aspeed_ast2600.c            |  19 ++
>   hw/fsi/aspeed-apb2opb.c            | 350 +++++++++++++++++++++++++++++
>   hw/fsi/cfam.c                      | 220 ++++++++++++++++++
>   hw/fsi/engine-scratchpad.c         |  99 ++++++++
>   hw/fsi/fsi-master.c                | 198 ++++++++++++++++
>   hw/fsi/fsi-slave.c                 |  96 ++++++++
>   hw/fsi/fsi.c                       |  54 +++++
>   hw/fsi/lbus.c                      |  87 +++++++
>   hw/fsi/opb.c                       | 185 +++++++++++++++
>   tests/qtest/fsi-test.c             | 210 +++++++++++++++++
>   hw/Kconfig                         |   1 +
>   hw/arm/Kconfig                     |   1 +
>   hw/fsi/Kconfig                     |  23 ++
>   hw/fsi/meson.build                 |   6 +
>   hw/fsi/trace-events                |  15 ++
>   hw/meson.build                     |   1 +
>   tests/qtest/meson.build            |   2 +
>   31 files changed, 2042 insertions(+)
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
>   create mode 100644 tests/qtest/fsi-test.c
>   create mode 100644 hw/fsi/Kconfig
>   create mode 100644 hw/fsi/meson.build
>   create mode 100644 hw/fsi/trace-events
> 


