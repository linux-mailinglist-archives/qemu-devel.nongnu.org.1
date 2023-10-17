Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6C57CBBDD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 09:02:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qse52-0006rj-6G; Tue, 17 Oct 2023 03:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=acei=F7=kaod.org=clg@ozlabs.org>)
 id 1qse4r-0006rT-7n; Tue, 17 Oct 2023 03:01:18 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=acei=F7=kaod.org=clg@ozlabs.org>)
 id 1qse4n-0005ht-2p; Tue, 17 Oct 2023 03:01:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S8lJ00NKTz4xFQ;
 Tue, 17 Oct 2023 18:01:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8lHy1wQtz4x1P;
 Tue, 17 Oct 2023 18:01:02 +1100 (AEDT)
Message-ID: <80d1a481-10bb-4d6c-82a5-418dff62880a@kaod.org>
Date: Tue, 17 Oct 2023 09:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add PowerNV I2C Controller Model
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com,
 philmd@linaro.org
References: <20231016222013.3739530-1-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231016222013.3739530-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=acei=F7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 10/17/23 00:20, Glenn Miles wrote:
> Upstreams the PowerNV I2C controller model originally
> authored by Cédric Le Goater with minor changes by
> myself to split the actual addition of the model from
> wiring it up to a power processor model.
> 
> This series only attaches the controller to the powernv9
> chip model, but is expected to eventually also be attached
> to the powernv10 chip model.
> 
> Cédric Le Goater (2):
>    ppc/pnv: Add an I2C controller model
>    ppc/pnv: Connect I2C controller model to powernv9 chip


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks for taking care of upstreaming Glenn. Waiting for the P10 part now !

C.


> 
>   hw/ppc/meson.build         |   1 +
>   hw/ppc/pnv.c               |  28 ++
>   hw/ppc/pnv_i2c.c           | 697 +++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chip.h  |   8 +
>   include/hw/ppc/pnv_i2c.h   |  38 ++
>   include/hw/ppc/pnv_xscom.h |   3 +
>   6 files changed, 775 insertions(+)
>   create mode 100644 hw/ppc/pnv_i2c.c
>   create mode 100644 include/hw/ppc/pnv_i2c.h
> 


