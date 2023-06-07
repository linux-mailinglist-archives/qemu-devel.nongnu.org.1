Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 524CC725A34
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:24:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6pNv-0002xc-61; Wed, 07 Jun 2023 05:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6pNr-0002xP-31
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:23:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6pNp-00038a-1K
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:23:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 40609B442;
 Wed,  7 Jun 2023 12:23:10 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AD198A2A6;
 Wed,  7 Jun 2023 12:23:09 +0300 (MSK)
Message-ID: <5bb1a930-3dbe-6c83-d612-c9b81fe1b8f4@tls.msk.ru>
Date: Wed, 7 Jun 2023 12:23:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] virtio-net: correctly report maximum tx_queue_size value
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230605142125.3881859-1-lvivier@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230605142125.3881859-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.094,
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

05.06.2023 17:21, Laurent Vivier wrote:
> Maximum value for tx_queue_size depends on the backend type.
> 1024 for vDPA/vhost-user, 256 for all the others.
> 
> The value is returned by virtio_net_max_tx_queue_size() to set the
> parameter:
> 
>      n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
>                                      n->net_conf.tx_queue_size);
> 
> But the parameter checking uses VIRTQUEUE_MAX_SIZE (1024).
> 
> So the parameter is silently ignored and ethtool reports a different
> value than the one provided by the user.
> 
>     ... -netdev tap,... -device virtio-net,tx_queue_size=1024
> 
>      # ethtool -g enp0s2
>      Ring parameters for enp0s2:
>      Pre-set maximums:
>      RX:		256
>      RX Mini:	n/a
>      RX Jumbo:	n/a
>      TX:		256
>      Current hardware settings:
>      RX:		256
>      RX Mini:	n/a
>      RX Jumbo:	n/a
>      TX:		256
> 
>     ... -netdev vhost-user,... -device virtio-net,tx_queue_size=2048
> 
>      Invalid tx_queue_size (= 2048), must be a power of 2 between 256 and 1024
> 
> With this patch the correct maximum value is checked and displayed.
> 
> For vDPA/vhost-user:
> 
>      Invalid tx_queue_size (= 2048), must be a power of 2 between 256 and 1024
> 
> For all the others:
> 
>      Invalid tx_queue_size (= 512), must be a power of 2 between 256 and 256
> 
> Fixes: 2eef278b9e63 ("virtio-net: fix tx queue size for !vhost-user")
> Cc: mst@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/net/virtio-net.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Is it a -stable material, or not worth fixing in -stable?
To me it looks like it should be fixed.

Thanks,

/mjt

