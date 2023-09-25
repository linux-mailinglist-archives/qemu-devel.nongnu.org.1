Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B97AD6DE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:20:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjdI-00060V-Iw; Mon, 25 Sep 2023 07:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qkjdG-0005vm-L1
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:20:06 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qkjdE-0000RP-VO
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:20:06 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E9AB2000A;
 Mon, 25 Sep 2023 11:20:01 +0000 (UTC)
Message-ID: <c6ef44f6-7566-921a-2744-0a3a1a76f3f0@ovn.org>
Date: Mon, 25 Sep 2023 13:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: i.maximets@ovn.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: remove unnecessary thread fence while reading
 next descriptor
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20230825170136.1953236-1-i.maximets@ovn.org>
From: Ilya Maximets <i.maximets@ovn.org>
In-Reply-To: <20230825170136.1953236-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.200; envelope-from=i.maximets@ovn.org;
 helo=relay7-d.mail.gandi.net
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/25/23 19:01, Ilya Maximets wrote:
> It was supposed to be a compiler barrier and it was a compiler barrier
> initially called 'wmb' (??) when virtio core support was introduced.
> Later all the instances of 'wmb' were switched to smp_wmb to fix memory
> ordering issues on non-x86 platforms.  However, this one doesn't need
> to be an actual barrier.  It's enough for it to stay a compiler barrier
> as its only purpose is to ensure that the value is not read twice.
> 
> There is no counterpart read barrier in the drivers, AFAICT.  And even
> if we needed an actual barrier, it shouldn't have been a write barrier.
> 
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Kind reminder.

Best regards, Ilya Maximets.

>  hw/virtio/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 309038fd46..6eb8586858 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1051,7 +1051,7 @@ static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
>      /* Check they're not leading us off end of descriptors. */
>      *next = desc->next;
>      /* Make sure compiler knows to grab that: we don't want it changing! */
> -    smp_wmb();
> +    barrier();
>  
>      if (*next >= max) {
>          virtio_error(vdev, "Desc next is %u", *next);


