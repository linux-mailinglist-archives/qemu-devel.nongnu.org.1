Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B67726345
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uSt-0008CQ-KV; Wed, 07 Jun 2023 10:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q6uSq-0008B8-Np; Wed, 07 Jun 2023 10:48:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q6uSo-0008J0-Un; Wed, 07 Jun 2023 10:48:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6CC76B597;
 Wed,  7 Jun 2023 17:48:39 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 63D1BA4FB;
 Wed,  7 Jun 2023 17:48:38 +0300 (MSK)
Message-ID: <518cc5c8-422f-1fa0-1285-12f8fc0460e8@tls.msk.ru>
Date: Wed, 7 Jun 2023 17:48:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/12] xen queue
Content-Language: en-US
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org,
 David Woodhouse <dwmw@amazon.co.uk>, qemu-stable <qemu-stable@nongnu.org>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

07.06.2023 17:18, Anthony PERARD via wrote:
..
> Anthony PERARD (1):
>        xen-block: fix segv on unrealize
> 
> Bernhard Beschow (7):
>        include/hw/xen/xen: Rename xen_piix3_set_irq() to xen_intx_set_irq()
>        hw/pci/pci.c: Don't leak PCIBus::irq_count[] in pci_bus_irqs()
>        hw/isa/piix3: Reuse piix3_realize() in piix3_xen_realize()
>        hw/isa/piix3: Wire up Xen PCI IRQ handling outside of PIIX3
>        hw/isa/piix3: Avoid Xen-specific variant of piix3_write_config()
>        hw/isa/piix3: Resolve redundant k->config_write assignments
>        hw/isa/piix3: Resolve redundant TYPE_PIIX3_XEN_DEVICE
> 
> David Woodhouse (4):
>        hw/xen: Simplify emulated Xen platform init
>        hw/xen: Fix memory leak in libxenstore_open() for Xen
>        xen: Drop support for Xen versions below 4.7.1
>        hw/xen: Fix broken check for invalid state in xs_be_open()

 From the description it looks like these two:

         hw/xen: Fix memory leak in libxenstore_open() for Xen
         hw/xen: Fix broken check for invalid state in xs_be_open()

should be applied to -stable too. Am I right?

/mjt

