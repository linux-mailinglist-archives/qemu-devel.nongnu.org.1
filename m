Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC227AD6DB
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjcf-0005HJ-0k; Mon, 25 Sep 2023 07:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qkjcb-0005Gx-Du
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:19:25 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qkjcZ-0000M8-O9
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:19:25 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 33CCD240006;
 Mon, 25 Sep 2023 11:19:19 +0000 (UTC)
Message-ID: <18c1b691-2b9f-5555-1c67-19ac411b1123@ovn.org>
Date: Mon, 25 Sep 2023 13:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: use shadow_avail_idx while checking number of
 heads
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20230825170448.1953409-1-i.maximets@ovn.org>
From: Ilya Maximets <i.maximets@ovn.org>
In-Reply-To: <20230825170448.1953409-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.193; envelope-from=i.maximets@ovn.org;
 helo=relay1-d.mail.gandi.net
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

On 8/25/23 19:04, Ilya Maximets wrote:
> We do not need the most up to date number of heads, we only want to
> know if there is at least one.
> 
> Use shadow variable as long as it is not equal to the last available
> index checked.  This avoids expensive qatomic dereference of the
> RCU-protected memory region cache as well as the memory access itself
> and the subsequent memory barrier.
> 
> The change improves performance of the af-xdp network backend by 2-3%.
> 
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Kind reminder.

Best regards, Ilya Maximets.

>  hw/virtio/virtio.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 309038fd46..04bf7cc977 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -999,7 +999,15 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>  /* Called within rcu_read_lock().  */
>  static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
>  {
> -    uint16_t num_heads = vring_avail_idx(vq) - idx;
> +    uint16_t num_heads;
> +
> +    if (vq->shadow_avail_idx != idx) {
> +        num_heads = vq->shadow_avail_idx - idx;
> +
> +        return num_heads;
> +    }
> +
> +    num_heads = vring_avail_idx(vq) - idx;
>  
>      /* Check it isn't doing very strange things with descriptor numbers. */
>      if (num_heads > vq->vring.num) {


