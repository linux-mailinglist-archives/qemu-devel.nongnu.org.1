Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34147032B3
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:18:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyatv-0003Gr-RA; Mon, 15 May 2023 12:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pyate-00036W-V6; Mon, 15 May 2023 12:18:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pyatc-0004Ua-TQ; Mon, 15 May 2023 12:18:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 67572602B;
 Mon, 15 May 2023 19:17:58 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5FF5C55B1;
 Mon, 15 May 2023 19:17:57 +0300 (MSK)
Message-ID: <66a3afb0-9a10-fc9a-e4c8-61bd81cdd5d0@msgid.tls.msk.ru>
Date: Mon, 15 May 2023 19:17:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH trivial for-8.0] hw/virtio/virtio-qmp.c: spelling: suppoted
Content-Language: en-US
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>
References: <20230401085140.2691965-1-mjt@msgid.tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230401085140.2691965-1-mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -106
X-Spam_score: -10.7
X-Spam_bar: ----------
X-Spam_report: (-10.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.811,
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

01.04.2023 11:51, Michael Tokarev wrote:
> Fixes: f3034ad71fcd0a6a58bc37830f182b307f089159
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> ---
>   hw/virtio/virtio-qmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This patch were previously sent at 5 Nov 2022, now the
> code moved to another file, and the patch is still applies
> (with changed filename).
> 
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 808446b4c9..e76218bdd5 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -343 +343 @@ qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
> -            "buffers suppoted"),
> +            "buffers supported"),

Ping?

/mjt

