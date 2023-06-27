Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2257406C4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 01:10:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEHok-0004C9-98; Tue, 27 Jun 2023 19:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qEHoh-0004BL-Cf
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 19:09:47 -0400
Received: from relay1-d.mail.gandi.net ([2001:4b98:dc4:8::221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qEHoe-0005W7-9f
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 19:09:47 -0400
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5A35240002;
 Tue, 27 Jun 2023 23:09:28 +0000 (UTC)
Message-ID: <d6f6f2aa-d7a4-e2f5-52be-b4d1e4e2dfea@ovn.org>
Date: Wed, 28 Jun 2023 01:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20230622215824.2173343-1-i.maximets@ovn.org>
 <CAJSP0QV5pjCxXm9U0FPYxBWKAyyLmTmWx4YcGfVtumSatJNW7g@mail.gmail.com>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
In-Reply-To: <CAJSP0QV5pjCxXm9U0FPYxBWKAyyLmTmWx4YcGfVtumSatJNW7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: neutral client-ip=2001:4b98:dc4:8::221;
 envelope-from=i.maximets@ovn.org; helo=relay1-d.mail.gandi.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.103,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_NEUTRAL=0.779,
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

On 6/27/23 10:56, Stefan Hajnoczi wrote:
> Can multiple VMs share a host netdev by filtering incoming traffic
> based on each VM's MAC address and directing it to the appropriate
> XSK? If yes, then I think AF_XDP is interesting when SR-IOV or similar
> hardware features are not available.

Good point.  Thanks!

Yes, they can.  Traffic can be re-directed via 'ethtool -N' similarly
to an example in the patch.  Or, potentially, via custom XDP program.
Then different QEMU instances may use different start-queue arguments
and use their own range of queues this way.

> 
> The idea of an AF_XDP passthrough device seems interesting because it
> would minimize the overhead and avoid some of the existing software
> limitations (mostly in QEMU's networking subsystem) that you
> described. I don't know whether the AF_XDP API is suitable or can be
> extended to build a hardware emulation interface, but it seems
> plausible. When Stefano Garzarella played with io_uring passthrough
> into the guest, one of the issues was guest memory translation (since
> the guest doesn't use host userspace virtual addresses). I guess
> AF_XDP would need an API for adding/removing memory translations or
> operate in a mode where addresses are relative offsets from the start
> of the umem regions

Actually, addresses in AF_XDP rings are already offsets from the
start of the umem region.  For example, xsk_umem__get_data is
implemented as &((char *)umem_area)[addr]; inside libxdp.  So, that
should not be an issue.

> (but this may be impractical if it limits where
> the guest can allocate packet payload buffers).

Yeah, we will either need to:

a. register the whole guest memory as umem and offset buffer pointers
   in the guest driver by the start of guest physical memory.

   (I'm not familiar much with QEMU memory subsystem.  Is guest physical
    memory always start at 0? I know that it's not always true for the
    real hardware.)

b. or require the guest driver to allocate a chunk of aligned contiguous
   memory and copy all the packets there on Tx.  And populate the Fill
   ring only with buffers from that area.  Assuming guest pages align
   with the host pages.  Again, a single copy might not be that bad,
   but it's hard to tell what the actual impact will be without testing.

> 
> Whether you pursue the passthrough approach or not, making -netdev
> af-xdp work in an environment where QEMU runs unprivileged seems like
> the most important practical issue to solve.

Yes, working on it.  Doesn't seem to be hard to do, but I need to test.

Best regards, Ilya Maximets.


