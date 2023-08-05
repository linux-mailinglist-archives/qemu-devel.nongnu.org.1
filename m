Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3EE770E10
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 08:17:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSAZg-0000Aa-MY; Sat, 05 Aug 2023 02:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSAZT-00009F-Oo; Sat, 05 Aug 2023 02:15:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSAZR-0004Nr-Pb; Sat, 05 Aug 2023 02:15:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0E5F31857E;
 Sat,  5 Aug 2023 09:15:42 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C3B411B93E;
 Sat,  5 Aug 2023 09:15:20 +0300 (MSK)
Message-ID: <86a640b2-a9f8-5b62-349c-c0927c2a013b@tls.msk.ru>
Date: Sat, 5 Aug 2023 09:15:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 0/3] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR
Content-Language: en-US
To: Hawkins Jiawei <yin31149@gmail.com>, jasowang@redhat.com, mst@redhat.com, 
 eperezma@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, 18801353760@163.com
References: <cover.1688438055.git.yin31149@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <cover.1688438055.git.yin31149@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
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

04.07.2023 06:34, Hawkins Jiawei wrote:
> According to VirtIO standard, "The class, command and
> command-specific-data are set by the driver,
> and the device sets the ack byte.
> There is little it can do except issue a diagnostic
> if ack is not VIRTIO_NET_OK."
> 
> Therefore, QEMU should stop sending the queued SVQ commands and
> cancel the device startup if the device's ack is not VIRTIO_NET_OK.
> 
> Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
> `*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
> As a result, net->nc->info->load() also returns 1, this makes
> vhost_net_start_one() incorrectly assume the device state is
> successfully loaded by vhost_vdpa_net_load() and return 0, instead of
> goto `fail` label to cancel the device startup, as vhost_net_start_one()
> only cancels the device startup when net->nc->info->load() returns a
> negative value.
> 
> This patchset fixes this problem by returning -EIO when the device's
> ack is not VIRTIO_NET_OK.
> 
> Changelog
> =========
> v3:
>   - split the fixes suggested by Eugenio
>   - return -EIO suggested by Michael
> 
> v2: https://lore.kernel.org/all/69010e9ebb5e3729aef595ed92840f43e48e53e5.1687875592.git.yin31149@gmail.com/
>   - fix the same bug in vhost_vdpa_net_load_offloads()
> 
> v1: https://lore.kernel.org/all/cover.1686746406.git.yin31149@gmail.com/
> 
> Hawkins Jiawei (3):
>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()
>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_offloads()

Hi!

I don't remember why, but this patch series is marked as "check later" in
my qemu-stable-to-apply email folder.  Does it make sense to back-port this
series to stable-8.0?

6f34807116 vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_offloads()
f45fd95ec9 vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
b479bc3c9d vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()

Patch 6f34807116 also needs

b58d3686a0 vdpa: Add vhost_vdpa_net_load_offloads()

for 8.0.

Thanks,

/mjt

