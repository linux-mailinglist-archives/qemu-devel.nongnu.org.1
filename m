Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F295A7AD6D8
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjbe-0004Y5-LV; Mon, 25 Sep 2023 07:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qkjbc-0004Xp-H6
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:18:24 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qkjba-0000CC-OL
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:18:24 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1C5A60004;
 Mon, 25 Sep 2023 11:18:15 +0000 (UTC)
Message-ID: <68d6bc20-a67f-0c96-a5e2-431b99fdf767@ovn.org>
Date: Mon, 25 Sep 2023 13:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20230811143423.3258788-1-i.maximets@ovn.org>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH v2] virtio: don't zero out memory region cache for
 indirect descriptors
In-Reply-To: <20230811143423.3258788-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.195; envelope-from=i.maximets@ovn.org;
 helo=relay3-d.mail.gandi.net
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/11/23 16:34, Ilya Maximets wrote:
> Lots of virtio functions that are on a hot path in data transmission
> are initializing indirect descriptor cache at the point of stack
> allocation.  It's a 112 byte structure that is getting zeroed out on
> each call adding unnecessary overhead.  It's going to be correctly
> initialized later via special init function.  The only reason to
> actually initialize right away is the ability to safely destruct it.
> Replacing a designated initializer with a function to only initialize
> what is necessary.
> 
> Removal of the unnecessary stack initializations improves throughput
> of virtio-net devices in terms of 64B packets per second by 6-14 %
> depending on the case.  Tested with a proposed af-xdp network backend
> and a dpdk testpmd application in the guest, but should be beneficial
> for other virtio devices as well.
> 
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
> 
> Version 2:
> 
>   * Introduced an initialization function, so we don't need to compare
>     pointers in the end. [Stefan]
>   * Removed the now unused macro. [Jason]
> 
>  hw/virtio/virtio.c    | 20 +++++++++++++++-----
>  include/exec/memory.h | 16 +++++++++++++---
>  2 files changed, 28 insertions(+), 8 deletions(-)

Kind reminder.

This patch was posted quite some time ago and it has 2 reviewed/acked-by tags.
Just making sure it didn't fall through the cracks.

Best regards, Ilya Maximets.

