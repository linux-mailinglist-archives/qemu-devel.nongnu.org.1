Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7958E797CD5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 21:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeKml-0000R3-50; Thu, 07 Sep 2023 15:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeKmg-0000Py-J3; Thu, 07 Sep 2023 15:35:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeKme-0002WN-23; Thu, 07 Sep 2023 15:35:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E9F041FE0C;
 Thu,  7 Sep 2023 22:36:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 176F0266E6;
 Thu,  7 Sep 2023 22:35:16 +0300 (MSK)
Message-ID: <231a1986-8af0-1153-ba2f-a77384fec9f5@tls.msk.ru>
Date: Thu, 7 Sep 2023 22:35:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/net/vmxnet3: Fix guest-triggerable assert()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: pjp@fedoraproject.org, qemu-trivial@nongnu.org, qemu-stable@nongnu.org
References: <20230817125600.1440195-1-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230817125600.1440195-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

17.08.2023 15:56, Thomas Huth wrote:
> The assert() that checks for valid MTU sizes can be triggered by
> the guest (e.g. with the reproducer code from the bug ticket
> https://gitlab.com/qemu-project/qemu/-/issues/517 ). Let's avoid
> this problem by simply logging the error and refusing to activate
> the device instead.

I'm applying this to trivial-patches tree with some hesitation :)

Thanks,

/mjt

> Fixes: d05dcd94ae ("net: vmxnet3: validate configuration values during activate")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/net/vmxnet3.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 5dfacb1098..6674122a7e 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -1439,7 +1439,10 @@ static void vmxnet3_activate_device(VMXNET3State *s)
>       vmxnet3_setup_rx_filtering(s);
>       /* Cache fields from shared memory */
>       s->mtu = VMXNET3_READ_DRV_SHARED32(d, s->drv_shmem, devRead.misc.mtu);
> -    assert(VMXNET3_MIN_MTU <= s->mtu && s->mtu <= VMXNET3_MAX_MTU);
> +    if (s->mtu < VMXNET3_MIN_MTU || s->mtu > VMXNET3_MAX_MTU) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Bad MTU size: %d\n", s->mtu);
> +        return;
> +    }
>       VMW_CFPRN("MTU is %u", s->mtu);
>   
>       s->max_rx_frags =


