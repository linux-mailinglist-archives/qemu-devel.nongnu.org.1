Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F97E79C7
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 08:36:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1M3v-0002Ei-Oc; Fri, 10 Nov 2023 02:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1r1M3t-0002ES-NJ
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:36:17 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1r1M3p-0007gM-UQ
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:36:17 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 169D040F1DC9;
 Fri, 10 Nov 2023 07:35:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 169D040F1DC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1699601749;
 bh=kWvgxc/jGKx7jXVckM1lbFYR0S+6FRKosMPl38Fg4Ug=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kX0skPBDBebW4N+vX4EEjFO4pgY1a2CoQ/ybKGHQHplXI5zRpXf/Hr7YD0CaQzmlD
 kYvYB59DgigBExZ2RMuWf0u+eWan28posgqI9fmnRFLQ8Whyad3dWBegBpjZCpQQmZ
 hfYFkCV+H/O2rghLK2OI9S+W7FHAxyG3QRNEiHQQ=
Message-ID: <44477e7d-c3a6-45d1-91e0-217306d97673@ispras.ru>
Date: Fri, 10 Nov 2023 10:35:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/21] net: Remove flag propagation
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-7-akihiko.odaki@daynix.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20231030051356.33123-7-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

You need to bump REPLAY_VERSION in replay/replay.c, because your patch 
changes the replay log format.

Otherwise, for replay part:
Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 30.10.2023 08:12, Akihiko Odaki wrote:
> There is no defined flag now.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/net/filter.h    |  3 ---
>   include/net/queue.h     |  6 ------
>   include/sysemu/replay.h |  2 +-
>   net/dump.c              |  4 ++--
>   net/filter-buffer.c     |  4 +---
>   net/filter-mirror.c     |  6 ++----
>   net/filter-replay.c     |  3 +--
>   net/filter-rewriter.c   |  5 ++---
>   net/filter.c            |  8 +++-----
>   net/net.c               | 43 ++++++++++++++---------------------------
>   replay/replay-net.c     |  8 ++------
>   11 files changed, 28 insertions(+), 64 deletions(-)
> 
> diff --git a/include/net/filter.h b/include/net/filter.h
> index 27ffc630df..e523771e72 100644
> --- a/include/net/filter.h
> +++ b/include/net/filter.h
> @@ -26,7 +26,6 @@ typedef void (FilterCleanup) (NetFilterState *nf);
>    */
>   typedef ssize_t (FilterReceiveIOV)(NetFilterState *nc,
>                                      NetClientState *sender,
> -                                   unsigned flags,
>                                      const struct iovec *iov,
>                                      int iovcnt,
>                                      NetPacketSent *sent_cb);
> @@ -65,14 +64,12 @@ struct NetFilterState {
>   ssize_t qemu_netfilter_receive(NetFilterState *nf,
>                                  NetFilterDirection direction,
>                                  NetClientState *sender,
> -                               unsigned flags,
>                                  const struct iovec *iov,
>                                  int iovcnt,
>                                  NetPacketSent *sent_cb);
>   
>   /* pass the packet to the next filter */
>   ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
> -                                    unsigned flags,
>                                       const struct iovec *iov,
>                                       int iovcnt,
>                                       void *opaque);
> diff --git a/include/net/queue.h b/include/net/queue.h
> index 7a43863be2..571f4e1436 100644
> --- a/include/net/queue.h
> +++ b/include/net/queue.h
> @@ -30,15 +30,12 @@ typedef struct NetQueue NetQueue;
>   
>   typedef void (NetPacketSent) (NetClientState *sender, ssize_t ret);
>   
> -#define QEMU_NET_PACKET_FLAG_NONE  0
> -
>   /* Returns:
>    *   >0 - success
>    *    0 - queue packet for future redelivery
>    *   <0 - failure (discard packet)
>    */
>   typedef ssize_t (NetQueueDeliverFunc)(NetClientState *sender,
> -                                      unsigned flags,
>                                         const struct iovec *iov,
>                                         int iovcnt,
>                                         void *opaque);
> @@ -47,7 +44,6 @@ NetQueue *qemu_new_net_queue(NetQueueDeliverFunc *deliver, void *opaque);
>   
>   void qemu_net_queue_append_iov(NetQueue *queue,
>                                  NetClientState *sender,
> -                               unsigned flags,
>                                  const struct iovec *iov,
>                                  int iovcnt,
>                                  NetPacketSent *sent_cb);
> @@ -64,14 +60,12 @@ ssize_t qemu_net_queue_receive_iov(NetQueue *queue,
>   
>   ssize_t qemu_net_queue_send(NetQueue *queue,
>                               NetClientState *sender,
> -                            unsigned flags,
>                               const uint8_t *data,
>                               size_t size,
>                               NetPacketSent *sent_cb);
>   
>   ssize_t qemu_net_queue_send_iov(NetQueue *queue,
>                                   NetClientState *sender,
> -                                unsigned flags,
>                                   const struct iovec *iov,
>                                   int iovcnt,
>                                   NetPacketSent *sent_cb);
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 08aae5869f..67b2d3ac73 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -158,7 +158,7 @@ ReplayNetState *replay_register_net(NetFilterState *nfs);
>   /*! Unregisters replay network filter. */
>   void replay_unregister_net(ReplayNetState *rns);
>   /*! Called to write network packet to the replay log. */
> -void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
> +void replay_net_packet_event(ReplayNetState *rns,
>                                const struct iovec *iov, int iovcnt);
>   
>   /* Audio */
> diff --git a/net/dump.c b/net/dump.c
> index 956e34a123..dd8ada9b5e 100644
> --- a/net/dump.c
> +++ b/net/dump.c
> @@ -150,8 +150,8 @@ struct NetFilterDumpState {
>   };
>   
>   static ssize_t filter_dump_receive_iov(NetFilterState *nf, NetClientState *sndr,
> -                                       unsigned flags, const struct iovec *iov,
> -                                       int iovcnt, NetPacketSent *sent_cb)
> +                                       const struct iovec *iov, int iovcnt,
> +                                       NetPacketSent *sent_cb)
>   {
>       NetFilterDumpState *nfds = FILTER_DUMP(nf);
>   
> diff --git a/net/filter-buffer.c b/net/filter-buffer.c
> index 283dc9cbe6..6d8b581cd8 100644
> --- a/net/filter-buffer.c
> +++ b/net/filter-buffer.c
> @@ -58,7 +58,6 @@ static void filter_buffer_release_timer(void *opaque)
>   /* filter APIs */
>   static ssize_t filter_buffer_receive_iov(NetFilterState *nf,
>                                            NetClientState *sender,
> -                                         unsigned flags,
>                                            const struct iovec *iov,
>                                            int iovcnt,
>                                            NetPacketSent *sent_cb)
> @@ -79,8 +78,7 @@ static ssize_t filter_buffer_receive_iov(NetFilterState *nf,
>        * the packets without caring about the receiver. This is suboptimal.
>        * May need more thoughts (e.g keeping sent_cb).
>        */
> -    qemu_net_queue_append_iov(s->incoming_queue, sender, flags,
> -                              iov, iovcnt, NULL);
> +    qemu_net_queue_append_iov(s->incoming_queue, sender, iov, iovcnt, NULL);
>       return iov_size(iov, iovcnt);
>   }
>   
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 34a63b5dbb..752571a548 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -145,12 +145,12 @@ static void redirector_to_filter(NetFilterState *nf,
>   
>       if (nf->direction == NET_FILTER_DIRECTION_ALL ||
>           nf->direction == NET_FILTER_DIRECTION_TX) {
> -        qemu_netfilter_pass_to_next(nf->netdev, 0, &iov, 1, nf);
> +        qemu_netfilter_pass_to_next(nf->netdev, &iov, 1, nf);
>       }
>   
>       if (nf->direction == NET_FILTER_DIRECTION_ALL ||
>           nf->direction == NET_FILTER_DIRECTION_RX) {
> -        qemu_netfilter_pass_to_next(nf->netdev->peer, 0, &iov, 1, nf);
> +        qemu_netfilter_pass_to_next(nf->netdev->peer, &iov, 1, nf);
>        }
>   }
>   
> @@ -190,7 +190,6 @@ static void redirector_chr_event(void *opaque, QEMUChrEvent event)
>   
>   static ssize_t filter_mirror_receive_iov(NetFilterState *nf,
>                                            NetClientState *sender,
> -                                         unsigned flags,
>                                            const struct iovec *iov,
>                                            int iovcnt,
>                                            NetPacketSent *sent_cb)
> @@ -212,7 +211,6 @@ static ssize_t filter_mirror_receive_iov(NetFilterState *nf,
>   
>   static ssize_t filter_redirector_receive_iov(NetFilterState *nf,
>                                                NetClientState *sender,
> -                                             unsigned flags,
>                                                const struct iovec *iov,
>                                                int iovcnt,
>                                                NetPacketSent *sent_cb)
> diff --git a/net/filter-replay.c b/net/filter-replay.c
> index 54690676ef..ab132f6f24 100644
> --- a/net/filter-replay.c
> +++ b/net/filter-replay.c
> @@ -31,7 +31,6 @@ struct NetFilterReplayState {
>   
>   static ssize_t filter_replay_receive_iov(NetFilterState *nf,
>                                            NetClientState *sndr,
> -                                         unsigned flags,
>                                            const struct iovec *iov,
>                                            int iovcnt, NetPacketSent *sent_cb)
>   {
> @@ -39,7 +38,7 @@ static ssize_t filter_replay_receive_iov(NetFilterState *nf,
>       switch (replay_mode) {
>       case REPLAY_MODE_RECORD:
>           if (nf->netdev == sndr) {
> -            replay_net_packet_event(nfrs->rns, flags, iov, iovcnt);
> +            replay_net_packet_event(nfrs->rns, iov, iovcnt);
>               return iov_size(iov, iovcnt);
>           }
>           return 0;
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index c18c4c2019..5da0b097db 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -251,7 +251,6 @@ static int handle_secondary_tcp_pkt(RewriterState *rf,
>   
>   static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
>                                            NetClientState *sender,
> -                                         unsigned flags,
>                                            const struct iovec *iov,
>                                            int iovcnt,
>                                            NetPacketSent *sent_cb)
> @@ -294,7 +293,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
>           if (sender == nf->netdev) {
>               /* NET_FILTER_DIRECTION_TX */
>               if (!handle_primary_tcp_pkt(s, conn, pkt, &key)) {
> -                qemu_net_queue_send(s->incoming_queue, sender, 0,
> +                qemu_net_queue_send(s->incoming_queue, sender,
>                   (const uint8_t *)pkt->data, pkt->size, NULL);
>                   packet_destroy(pkt, NULL);
>                   pkt = NULL;
> @@ -307,7 +306,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
>           } else {
>               /* NET_FILTER_DIRECTION_RX */
>               if (!handle_secondary_tcp_pkt(s, conn, pkt, &key)) {
> -                qemu_net_queue_send(s->incoming_queue, sender, 0,
> +                qemu_net_queue_send(s->incoming_queue, sender,
>                   (const uint8_t *)pkt->data, pkt->size, NULL);
>                   packet_destroy(pkt, NULL);
>                   pkt = NULL;
> diff --git a/net/filter.c b/net/filter.c
> index 3335908771..cc870114b7 100644
> --- a/net/filter.c
> +++ b/net/filter.c
> @@ -28,7 +28,6 @@ static inline bool qemu_can_skip_netfilter(NetFilterState *nf)
>   ssize_t qemu_netfilter_receive(NetFilterState *nf,
>                                  NetFilterDirection direction,
>                                  NetClientState *sender,
> -                               unsigned flags,
>                                  const struct iovec *iov,
>                                  int iovcnt,
>                                  NetPacketSent *sent_cb)
> @@ -39,7 +38,7 @@ ssize_t qemu_netfilter_receive(NetFilterState *nf,
>       if (nf->direction == direction ||
>           nf->direction == NET_FILTER_DIRECTION_ALL) {
>           return NETFILTER_GET_CLASS(OBJECT(nf))->receive_iov(
> -                                   nf, sender, flags, iov, iovcnt, sent_cb);
> +                                   nf, sender, iov, iovcnt, sent_cb);
>       }
>   
>       return 0;
> @@ -62,7 +61,6 @@ static NetFilterState *netfilter_next(NetFilterState *nf,
>   }
>   
>   ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
> -                                    unsigned flags,
>                                       const struct iovec *iov,
>                                       int iovcnt,
>                                       void *opaque)
> @@ -96,7 +94,7 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
>            * to the sender, so sent_cb shouldn't be called later, just
>            * pass NULL to next.
>            */
> -        ret = qemu_netfilter_receive(next, direction, sender, flags, iov,
> +        ret = qemu_netfilter_receive(next, direction, sender, iov,
>                                        iovcnt, NULL);
>           if (ret) {
>               return ret;
> @@ -111,7 +109,7 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
>        */
>       if (sender && sender->peer) {
>           qemu_net_queue_send_iov(sender->peer->incoming_queue,
> -                                sender, flags, iov, iovcnt, NULL);
> +                                sender, iov, iovcnt, NULL);
>       }
>   
>   out:
> diff --git a/net/net.c b/net/net.c
> index ad8ecce5d6..9883f12940 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -250,7 +250,6 @@ static void qemu_net_client_destructor(NetClientState *nc)
>       g_free(nc);
>   }
>   static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
> -                                       unsigned flags,
>                                          const struct iovec *iov,
>                                          int iovcnt,
>                                          void *opaque);
> @@ -613,7 +612,6 @@ int qemu_can_send_packet(NetClientState *sender)
>   static ssize_t filter_receive_iov(NetClientState *nc,
>                                     NetFilterDirection direction,
>                                     NetClientState *sender,
> -                                  unsigned flags,
>                                     const struct iovec *iov,
>                                     int iovcnt,
>                                     NetPacketSent *sent_cb)
> @@ -623,7 +621,7 @@ static ssize_t filter_receive_iov(NetClientState *nc,
>   
>       if (direction == NET_FILTER_DIRECTION_TX) {
>           QTAILQ_FOREACH(nf, &nc->filters, next) {
> -            ret = qemu_netfilter_receive(nf, direction, sender, flags, iov,
> +            ret = qemu_netfilter_receive(nf, direction, sender, iov,
>                                            iovcnt, sent_cb);
>               if (ret) {
>                   return ret;
> @@ -631,7 +629,7 @@ static ssize_t filter_receive_iov(NetClientState *nc,
>           }
>       } else {
>           QTAILQ_FOREACH_REVERSE(nf, &nc->filters, next) {
> -            ret = qemu_netfilter_receive(nf, direction, sender, flags, iov,
> +            ret = qemu_netfilter_receive(nf, direction, sender, iov,
>                                            iovcnt, sent_cb);
>               if (ret) {
>                   return ret;
> @@ -645,7 +643,6 @@ static ssize_t filter_receive_iov(NetClientState *nc,
>   static ssize_t filter_receive(NetClientState *nc,
>                                 NetFilterDirection direction,
>                                 NetClientState *sender,
> -                              unsigned flags,
>                                 const uint8_t *data,
>                                 size_t size,
>                                 NetPacketSent *sent_cb)
> @@ -655,7 +652,7 @@ static ssize_t filter_receive(NetClientState *nc,
>           .iov_len = size
>       };
>   
> -    return filter_receive_iov(nc, direction, sender, flags, &iov, 1, sent_cb);
> +    return filter_receive_iov(nc, direction, sender, &iov, 1, sent_cb);
>   }
>   
>   void qemu_purge_queued_packets(NetClientState *nc)
> @@ -692,10 +689,9 @@ void qemu_flush_queued_packets(NetClientState *nc)
>       qemu_flush_or_purge_queued_packets(nc, false);
>   }
>   
> -static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
> -                                                 unsigned flags,
> -                                                 const uint8_t *buf, int size,
> -                                                 NetPacketSent *sent_cb)
> +ssize_t qemu_send_packet_async(NetClientState *sender,
> +                               const uint8_t *buf, int size,
> +                               NetPacketSent *sent_cb)
>   {
>       NetQueue *queue;
>       int ret;
> @@ -711,28 +707,20 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
>   
>       /* Let filters handle the packet first */
>       ret = filter_receive(sender, NET_FILTER_DIRECTION_TX,
> -                         sender, flags, buf, size, sent_cb);
> +                         sender, buf, size, sent_cb);
>       if (ret) {
>           return ret;
>       }
>   
>       ret = filter_receive(sender->peer, NET_FILTER_DIRECTION_RX,
> -                         sender, flags, buf, size, sent_cb);
> +                         sender, buf, size, sent_cb);
>       if (ret) {
>           return ret;
>       }
>   
>       queue = sender->peer->incoming_queue;
>   
> -    return qemu_net_queue_send(queue, sender, flags, buf, size, sent_cb);
> -}
> -
> -ssize_t qemu_send_packet_async(NetClientState *sender,
> -                               const uint8_t *buf, int size,
> -                               NetPacketSent *sent_cb)
> -{
> -    return qemu_send_packet_async_with_flags(sender, QEMU_NET_PACKET_FLAG_NONE,
> -                                             buf, size, sent_cb);
> +    return qemu_net_queue_send(queue, sender, buf, size, sent_cb);
>   }
>   
>   ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size)
> @@ -771,7 +759,7 @@ ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int size)
>   }
>   
>   static ssize_t nc_sendv_compat(NetClientState *nc, const struct iovec *iov,
> -                               int iovcnt, unsigned flags)
> +                               int iovcnt)
>   {
>       uint8_t *buf = NULL;
>       uint8_t *buffer;
> @@ -798,7 +786,6 @@ static ssize_t nc_sendv_compat(NetClientState *nc, const struct iovec *iov,
>   }
>   
>   static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
> -                                       unsigned flags,
>                                          const struct iovec *iov,
>                                          int iovcnt,
>                                          void *opaque)
> @@ -827,7 +814,7 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
>       if (nc->info->receive_iov) {
>           ret = nc->info->receive_iov(nc, iov, iovcnt);
>       } else {
> -        ret = nc_sendv_compat(nc, iov, iovcnt, flags);
> +        ret = nc_sendv_compat(nc, iov, iovcnt);
>       }
>   
>       if (owned_reentrancy_guard) {
> @@ -859,22 +846,20 @@ ssize_t qemu_sendv_packet_async(NetClientState *sender,
>   
>       /* Let filters handle the packet first */
>       ret = filter_receive_iov(sender, NET_FILTER_DIRECTION_TX, sender,
> -                             QEMU_NET_PACKET_FLAG_NONE, iov, iovcnt, sent_cb);
> +                             iov, iovcnt, sent_cb);
>       if (ret) {
>           return ret;
>       }
>   
>       ret = filter_receive_iov(sender->peer, NET_FILTER_DIRECTION_RX, sender,
> -                             QEMU_NET_PACKET_FLAG_NONE, iov, iovcnt, sent_cb);
> +                             iov, iovcnt, sent_cb);
>       if (ret) {
>           return ret;
>       }
>   
>       queue = sender->peer->incoming_queue;
>   
> -    return qemu_net_queue_send_iov(queue, sender,
> -                                   QEMU_NET_PACKET_FLAG_NONE,
> -                                   iov, iovcnt, sent_cb);
> +    return qemu_net_queue_send_iov(queue, sender, iov, iovcnt, sent_cb);
>   }
>   
>   ssize_t
> diff --git a/replay/replay-net.c b/replay/replay-net.c
> index 3b70f71cf1..87e6d68f4e 100644
> --- a/replay/replay-net.c
> +++ b/replay/replay-net.c
> @@ -24,7 +24,6 @@ struct ReplayNetState {
>   
>   typedef struct NetEvent {
>       uint8_t id;
> -    uint32_t flags;
>       uint8_t *data;
>       size_t size;
>   } NetEvent;
> @@ -50,11 +49,10 @@ void replay_unregister_net(ReplayNetState *rns)
>       g_free(rns);
>   }
>   
> -void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
> +void replay_net_packet_event(ReplayNetState *rns,
>                                const struct iovec *iov, int iovcnt)
>   {
>       NetEvent *event = g_new(NetEvent, 1);
> -    event->flags = flags;
>       event->data = g_malloc(iov_size(iov, iovcnt));
>       event->size = iov_size(iov, iovcnt);
>       event->id = rns->id;
> @@ -74,7 +72,7 @@ void replay_event_net_run(void *opaque)
>       assert(event->id < network_filters_count);
>   
>       qemu_netfilter_pass_to_next(network_filters[event->id]->netdev,
> -        event->flags, &iov, 1, network_filters[event->id]);
> +        &iov, 1, network_filters[event->id]);
>   
>       g_free(event->data);
>       g_free(event);
> @@ -85,7 +83,6 @@ void replay_event_net_save(void *opaque)
>       NetEvent *event = opaque;
>   
>       replay_put_byte(event->id);
> -    replay_put_dword(event->flags);
>       replay_put_array(event->data, event->size);
>   }
>   
> @@ -94,7 +91,6 @@ void *replay_event_net_load(void)
>       NetEvent *event = g_new(NetEvent, 1);
>   
>       event->id = replay_get_byte();
> -    event->flags = replay_get_dword();
>       replay_get_array_alloc(&event->data, &event->size);
>   
>       return event;


