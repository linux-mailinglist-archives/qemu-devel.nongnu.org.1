Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE17E8BC7
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 17:57:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1rGg-00079F-5h; Sat, 11 Nov 2023 11:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UdCb=GY=kaod.org=clg@ozlabs.org>)
 id 1r1rGV-000772-0X; Sat, 11 Nov 2023 11:55:24 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UdCb=GY=kaod.org=clg@ozlabs.org>)
 id 1r1rGS-0002Rg-ON; Sat, 11 Nov 2023 11:55:22 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SSMHy30qGz4x5q;
 Sun, 12 Nov 2023 03:55:10 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SSMHt2gm9z4xGQ;
 Sun, 12 Nov 2023 03:55:05 +1100 (AEDT)
Message-ID: <20c41ee9-66cd-4f6c-a044-5824917941f3@kaod.org>
Date: Sat, 11 Nov 2023 17:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] pnv nest1 chiplet model
Content-Language: en-US
To: qemu-devel@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 Chalapathi V <chalapathi.v@linux.ibm.com>
References: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=UdCb=GY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

Hello Chalapathi,

Please tune the "From: " email address of the series you send.
This one uses " Chalapathi V <chalap1@gfwr516.rchland.ibm.com>"
which is certainly from an internal IBM host. Unfortunately, we
can not reply to this user/sender.

On 11/7/23 08:41, Chalapathi V wrote:
> From: Chalapathi V <chalapathi.v@linux.ibm.com>
> 
> Hello,
> 
> For modularity reasons the P10 processor chip is split into multiple
> chiplets individually controlled and managed by the pervasive logic.
> The boundaries of these chiplets are defined based on physical design
> parameters like clock grids, the nature of the functional units as well
> as their pervasive requirements (e.g. clock domains). Examples of chiplet
> in the P10 chip are processor cores and caches, memory controllers or IO
> interfaces like PCIe. Partitioning the processor chip into these chiplets
> allows the pervasive logic to test, initialize, control and manage these
> chip partitions individually.
> 
> In this series, we create a nest1 chiplet model and implements the chiplet
> control scom registers on nest1 chiplet. The chiplet control registers does
> the initialization and configuration of a chiplet.
> 
> PATCH4: The review comments of PATCH3 has been addressed.

What do you mean by PATCH4 and PATCH3 ? Version 4 and 3 ?

Usually, people send a small changelog with the cover letter explaining
the differences between each respin. See the Zhenzhong's series "vfio:
Adopt iommufd" [1] for an example. Your series does not need that much
details, but "comments have been addressed" is not very useful.

Thanks,

C.


> 
> /nest1_chiplet (pnv-nest1-chiplet)
>        /perv_chiplet (pnv-pervasive-chiplet)
>          /xscom-chiplet-control-regs[0] (memory-region)
> 
> Chalapathi V (3):
>    hw/ppc: Add pnv pervasive common chiplet units
>    hw/ppc: Add nest1 chiplet model
>    hw/ppc: Nest1 chiplet wiring
> 
>   hw/ppc/meson.build                |   2 +
>   hw/ppc/pnv.c                      |  14 +++
>   hw/ppc/pnv_nest1_chiplet.c        |  94 +++++++++++++++++
>   hw/ppc/pnv_pervasive.c            | 213 ++++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chip.h         |   2 +
>   include/hw/ppc/pnv_nest_chiplet.h |  41 ++++++++
>   include/hw/ppc/pnv_pervasive.h    |  39 +++++++
>   include/hw/ppc/pnv_xscom.h        |   3 +
>   8 files changed, 408 insertions(+)
>   create mode 100644 hw/ppc/pnv_nest1_chiplet.c
>   create mode 100644 hw/ppc/pnv_pervasive.c
>   create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
>   create mode 100644 include/hw/ppc/pnv_pervasive.h
> 


