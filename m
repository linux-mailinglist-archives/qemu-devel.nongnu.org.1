Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB69725A90
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:33:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6pX4-0006ZF-BS; Wed, 07 Jun 2023 05:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6pWu-0006XW-5K
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:32:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6pWs-0004lG-J4
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:32:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 524CAB44D;
 Wed,  7 Jun 2023 12:32:32 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B37BCA2B2;
 Wed,  7 Jun 2023 12:32:31 +0300 (MSK)
Message-ID: <89b6ba60-8744-bda5-0dfa-b653d7b3ca62@tls.msk.ru>
Date: Wed, 7 Jun 2023 12:32:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] vhost: fix vhost_dev_enable_notifiers() error case
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, longpeng2@huawei.com
References: <20230602162735.3670785-1-lvivier@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230602162735.3670785-1-lvivier@redhat.com>
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

02.06.2023 19:27, Laurent Vivier wrote:
> in vhost_dev_enable_notifiers(), if virtio_bus_set_host_notifier(true)
> fails, we call vhost_dev_disable_notifiers() that executes
> virtio_bus_set_host_notifier(false) on all queues, even on queues that
> have failed to be initialized.
> 
> This triggers a core dump in memory_region_del_eventfd():
> 
>   virtio_bus_set_host_notifier: unable to init event notifier: Too many open files (-24)
>   vhost VQ 1 notifier binding failed: 24
>   .../softmmu/memory.c:2611: memory_region_del_eventfd: Assertion `i != mr->ioeventfd_nb' failed.
> 
> Fix the problem by providing to vhost_dev_disable_notifiers() the
> number of queues to disable.
> 
> Fixes: 8771589b6f81 ("vhost: simplify vhost_dev_enable_notifiers")
> Cc: longpeng2@huawei.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/virtio/vhost.c | 65 ++++++++++++++++++++++++++---------------------
>   1 file changed, 36 insertions(+), 29 deletions(-)

Is this one a candidate for -stable?

The diffstat is somewhat large but it is just moving bit of code around.

Thanks,

/mjt

