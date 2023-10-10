Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 554447BF501
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:57:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7bk-0004fk-9J; Tue, 10 Oct 2023 03:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qq7bh-0004fW-SE
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:56:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qq7bf-00068t-RQ
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:56:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9580328D80;
 Tue, 10 Oct 2023 10:56:36 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4EC812E034;
 Tue, 10 Oct 2023 10:56:33 +0300 (MSK)
Message-ID: <b80debfa-b789-400b-bc0c-a0ccc77a3530@tls.msk.ru>
Date: Tue, 10 Oct 2023 10:56:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] tap: Fix virtio-net header buffer size
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20231010025924.14593-1-akihiko.odaki@daynix.com>
 <20231010025924.14593-2-akihiko.odaki@daynix.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231010025924.14593-2-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

10.10.2023 05:59, Akihiko Odaki wrote:
> The largest possible virtio-net header is struct virtio_net_hdr_v1_hash.
> 
> Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   net/tap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/tap.c b/net/tap.c
> index c6639d9f20..ea46feeaa8 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -118,7 +118,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
>       TAPState *s = DO_UPCAST(TAPState, nc, nc);
>       const struct iovec *iovp = iov;
>       struct iovec iov_copy[iovcnt + 1];
> -    struct virtio_net_hdr_mrg_rxbuf hdr = { };
> +    struct virtio_net_hdr_v1_hash hdr = { };

BTW, can we get rid of (implicit) memzero() here and in
similar places, initializing only the actually used fields?
Not that his particular structure is very large (and this
change makes it 8 bytes larger), but still..

Thanks,

/mjt

