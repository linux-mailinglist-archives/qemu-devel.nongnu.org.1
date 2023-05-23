Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1370E610
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:54:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Y58-0007yM-KE; Tue, 23 May 2023 15:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q1Y54-0007yA-A8
 for qemu-devel@nongnu.org; Tue, 23 May 2023 15:54:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q1Y52-0005XM-8O
 for qemu-devel@nongnu.org; Tue, 23 May 2023 15:54:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 807747FDD;
 Tue, 23 May 2023 22:53:58 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 06C8173B6;
 Tue, 23 May 2023 22:53:57 +0300 (MSK)
Message-ID: <1d43383e-e13c-0217-b1df-3572826ff87d@tls.msk.ru>
Date: Tue, 23 May 2023 22:53:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/50] Net patches
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
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

23.05.2023 10:31, Jason Wang wrote:

>    https://github.com/jasowang/qemu.git tags/net-pull-request

I might be wrong but it looks like besides the rtl8139 fix which went
to -stable already, and "e1000e: Fix tx/rx counters" change which has
been agreed upon before, there are a few other changes which are worth
to have in -stable, in 8.0 and some even in 7.2. What do you think,
which ones are important for -stable?

If there's stable material in the future, please Cc: qemu-stable@nongnu.org.

Thanks,

/mjt

> Akihiko Odaki (48):
>        hw/net/net_tx_pkt: Decouple implementation from PCI
>        hw/net/net_tx_pkt: Decouple interface from PCI
>        e1000x: Fix BPRC and MPRC
>        igb: Fix Rx packet type encoding
>        igb: Do not require CTRL.VME for tx VLAN tagging
>        igb: Clear IMS bits when committing ICR access
>        net/net_rx_pkt: Use iovec for net_rx_pkt_set_protocols()
>        e1000e: Always copy ethernet header
>        igb: Always copy ethernet header
>        Fix references to igb Avocado test
>        tests/avocado: Remove unused imports
>        tests/avocado: Remove test_igb_nomsi_kvm
>        hw/net/net_tx_pkt: Remove net_rx_pkt_get_l4_info
>        net/eth: Rename eth_setup_vlan_headers_ex
>        e1000x: Share more Rx filtering logic
>        e1000x: Take CRC into consideration for size check
>        e1000x: Rename TcpIpv6 into TcpIpv6Ex
>        e1000e: Always log status after building rx metadata
>        igb: Always log status after building rx metadata
>        igb: Remove goto
>        igb: Read DCMD.VLE of the first Tx descriptor
>        e1000e: Reset packet state after emptying Tx queue
>        vmxnet3: Reset packet state after emptying Tx queue
>        igb: Add more definitions for Tx descriptor
>        igb: Share common VF constants
>        igb: Fix igb_mac_reg_init coding style alignment
>        igb: Clear EICR bits for delayed MSI-X interrupts
>        e1000e: Rename a variable in e1000e_receive_internal()
>        igb: Rename a variable in igb_receive_internal()
>        net/eth: Use void pointers
>        net/eth: Always add VLAN tag
>        hw/net/net_rx_pkt: Enforce alignment for eth_header
>        tests/qtest/libqos/igb: Set GPIE.Multiple_MSIX
>        igb: Implement MSI-X single vector mode
>        igb: Use UDP for RSS hash
>        igb: Implement Rx SCTP CSO
>        igb: Implement Tx SCTP CSO
>        igb: Strip the second VLAN tag for extended VLAN
>        igb: Filter with the second VLAN tag for extended VLAN
>        igb: Implement igb-specific oversize check
>        igb: Implement Rx PTP2 timestamp
>        igb: Implement Tx timestamp
>        e1000e: Notify only new interrupts
>        igb: Notify only new interrupts
>        igb: Clear-on-read ICR when ICR.INTA is set
>        vmxnet3: Do not depend on PC
>        MAINTAINERS: Add a reviewer for network packet abstractions
>        docs/system/devices/igb: Note igb is tested for DPDK


