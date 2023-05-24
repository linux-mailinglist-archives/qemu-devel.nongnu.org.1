Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D358570EC5C
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 06:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1flp-0002yr-52; Wed, 24 May 2023 00:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1flc-0002yZ-QK
 for qemu-devel@nongnu.org; Wed, 24 May 2023 00:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1flZ-00041E-JA
 for qemu-devel@nongnu.org; Wed, 24 May 2023 00:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684901184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsDgFdZyzyF+FSZ5LYkFSiKrw5WHgOIcLbpdyp7FNTw=;
 b=fxdJan9yLa5OGkWEz3tp+9mm22fsFIzQRPuiVBXdWsuntgTR1Ghm8mUz7/+OhVFAwPpNkM
 LhQwMN8y7a6LIpR+kEcPU+/71vnhNrZzFu1+3vhHncMHVWQrM2MQpP7Z7P2QfSSKfGg91R
 HrvvpVwSiOjpJkx711SHbQ97HvYYdQc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-hZnLUGX8MRWhi0jEIxwpBw-1; Wed, 24 May 2023 00:06:22 -0400
X-MC-Unique: hZnLUGX8MRWhi0jEIxwpBw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f495fc7a43so168334e87.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 21:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684901181; x=1687493181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nsDgFdZyzyF+FSZ5LYkFSiKrw5WHgOIcLbpdyp7FNTw=;
 b=Xw19HASHpbhFywx3TZSpHLpTqw7zy/9wUv6RQ/Frq8XLhC/Uzlx/AmXuOm98+hwug5
 HLOza+L9RaBQgPda4wU77ilUWN4bJkXNupZY+M25tTvTgP7ZLHst1x3hw8a72aVGCCZ/
 /7MXpM8zyhAt4/A3PEIIilVQUbGi2YPot9PjpysjD0bic2C3HETTgpvXGZb3ARwUDIMC
 gSkHx5dWeW1Co2MlodUY0TKClfnQ7gTCyWJblHnQ4OlUtcRWlPfvZeq1SsLXgGzxtVO7
 obSSzaoJoE4nFU04ZBz7JagWBFpr/EyPDy2ZlHVwd4GmRGUGN7NIxniunUSM5Otb1CFG
 +LVQ==
X-Gm-Message-State: AC+VfDwyEBWcI2Wij0pdWUnICot5o9n5dWg2EH6RyCDIxoskYrXKHPuF
 +vY39gLhJImtU2oyNaz3p6b8rHEuyuWjQWV2W0YB60zWLMiE4a9ObCwa6cLLx8nbYGAhDIN1wUJ
 29dh6Cgo2EltKtEThKh2nGe6mk1lNeUM=
X-Received: by 2002:ac2:599a:0:b0:4f3:80a3:b40a with SMTP id
 w26-20020ac2599a000000b004f380a3b40amr3827292lfn.69.1684901180890; 
 Tue, 23 May 2023 21:06:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Cr+oC+hp53P0dXjXMrJp7bi1H5L+s1v0KD5hNzsKSXgPJk/r/dPwcIAv9l7U3M3JnBW4fQYEWhKeXuXoByrM=
X-Received: by 2002:ac2:599a:0:b0:4f3:80a3:b40a with SMTP id
 w26-20020ac2599a000000b004f380a3b40amr3827290lfn.69.1684901180548; Tue, 23
 May 2023 21:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230523073238.54236-1-jasowang@redhat.com>
 <1d43383e-e13c-0217-b1df-3572826ff87d@tls.msk.ru>
In-Reply-To: <1d43383e-e13c-0217-b1df-3572826ff87d@tls.msk.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 May 2023 12:06:09 +0800
Message-ID: <CACGkMEssJ8=_ityBAN-T29JwTGDB+=-cbq0pfNqZtOE6-RmjCA@mail.gmail.com>
Subject: Re: [PULL 00/50] Net patches
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 24, 2023 at 3:54=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 23.05.2023 10:31, Jason Wang wrote:
>
> >    https://github.com/jasowang/qemu.git tags/net-pull-request
>
> I might be wrong but it looks like besides the rtl8139 fix which went
> to -stable already, and "e1000e: Fix tx/rx counters" change which has
> been agreed upon before, there are a few other changes which are worth
> to have in -stable, in 8.0 and some even in 7.2. What do you think,
> which ones are important for -stable?

I'm not sure, most fixes are for igb, considering igb is complicated
and just introduced since 8.0, it should be considered as a technical
preview somehow. Then I'm not sure whether or not it's worth it to
backport them. For the rest, it looks like it should be fine to go for
-stable.

Akihiko, what's your thoughts?

Thanks

>
> If there's stable material in the future, please Cc: qemu-stable@nongnu.o=
rg.
>
> Thanks,
>
> /mjt
>
> > Akihiko Odaki (48):
> >        hw/net/net_tx_pkt: Decouple implementation from PCI
> >        hw/net/net_tx_pkt: Decouple interface from PCI
> >        e1000x: Fix BPRC and MPRC
> >        igb: Fix Rx packet type encoding
> >        igb: Do not require CTRL.VME for tx VLAN tagging
> >        igb: Clear IMS bits when committing ICR access
> >        net/net_rx_pkt: Use iovec for net_rx_pkt_set_protocols()
> >        e1000e: Always copy ethernet header
> >        igb: Always copy ethernet header
> >        Fix references to igb Avocado test
> >        tests/avocado: Remove unused imports
> >        tests/avocado: Remove test_igb_nomsi_kvm
> >        hw/net/net_tx_pkt: Remove net_rx_pkt_get_l4_info
> >        net/eth: Rename eth_setup_vlan_headers_ex
> >        e1000x: Share more Rx filtering logic
> >        e1000x: Take CRC into consideration for size check
> >        e1000x: Rename TcpIpv6 into TcpIpv6Ex
> >        e1000e: Always log status after building rx metadata
> >        igb: Always log status after building rx metadata
> >        igb: Remove goto
> >        igb: Read DCMD.VLE of the first Tx descriptor
> >        e1000e: Reset packet state after emptying Tx queue
> >        vmxnet3: Reset packet state after emptying Tx queue
> >        igb: Add more definitions for Tx descriptor
> >        igb: Share common VF constants
> >        igb: Fix igb_mac_reg_init coding style alignment
> >        igb: Clear EICR bits for delayed MSI-X interrupts
> >        e1000e: Rename a variable in e1000e_receive_internal()
> >        igb: Rename a variable in igb_receive_internal()
> >        net/eth: Use void pointers
> >        net/eth: Always add VLAN tag
> >        hw/net/net_rx_pkt: Enforce alignment for eth_header
> >        tests/qtest/libqos/igb: Set GPIE.Multiple_MSIX
> >        igb: Implement MSI-X single vector mode
> >        igb: Use UDP for RSS hash
> >        igb: Implement Rx SCTP CSO
> >        igb: Implement Tx SCTP CSO
> >        igb: Strip the second VLAN tag for extended VLAN
> >        igb: Filter with the second VLAN tag for extended VLAN
> >        igb: Implement igb-specific oversize check
> >        igb: Implement Rx PTP2 timestamp
> >        igb: Implement Tx timestamp
> >        e1000e: Notify only new interrupts
> >        igb: Notify only new interrupts
> >        igb: Clear-on-read ICR when ICR.INTA is set
> >        vmxnet3: Do not depend on PC
> >        MAINTAINERS: Add a reviewer for network packet abstractions
> >        docs/system/devices/igb: Note igb is tested for DPDK
>


