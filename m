Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C02770F23
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 11:54:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSDyb-0000MG-31; Sat, 05 Aug 2023 05:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSDyY-0000Lp-Vq; Sat, 05 Aug 2023 05:53:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSDyX-0001PY-7J; Sat, 05 Aug 2023 05:53:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A9BE9185C7;
 Sat,  5 Aug 2023 12:53:42 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 353E71B9F2;
 Sat,  5 Aug 2023 12:53:21 +0300 (MSK)
Message-ID: <cc8daf17-76cf-aed0-7516-a0b525f9506c@tls.msk.ru>
Date: Sat, 5 Aug 2023 12:53:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 0/3] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR
Content-Language: en-US
To: Hawkins Jiawei <yin31149@gmail.com>, jasowang@redhat.com, mst@redhat.com, 
 eperezma@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, 18801353760@163.com
References: <cover.1688438055.git.yin31149@gmail.com>
 <86a640b2-a9f8-5b62-349c-c0927c2a013b@tls.msk.ru>
 <CAKrof1NXV22zdjww=+P2NybZCyoNBOdahDMLrJfTDmK0Xa5BEA@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAKrof1NXV22zdjww=+P2NybZCyoNBOdahDMLrJfTDmK0Xa5BEA@mail.gmail.com>
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

05.08.2023 12:28, Hawkins Jiawei wrote:
..
>> I don't remember why, but this patch series is marked as "check later" in
>> my qemu-stable-to-apply email folder.  Does it make sense to back-port this
>> series to stable-8.0?
>>
>> 6f34807116 vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
>> _load_offloads()
>> f45fd95ec9 vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
>> b479bc3c9d vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()
>>
> 
> Hi Michael,
> 
> Yes, this bug exists in stable-8.0, so it makes sense to back-port this
> series.
> 
> Commit f45fd95ec9("vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
> _load_mq()") and
> commit b479bc3c9d("vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
> _load_mac()") can be back-ported directly.
> 
>> Patch 6f34807116 also needs
>>
>> b58d3686a0 vdpa: Add vhost_vdpa_net_load_offloads()
> 
> As you point out, patch 6f34807116("vdpa: Return -EIO if device ack is
> VIRTIO_NET_ERR in _load_offloads()") is a fix to the commit
> b58d3686a0("vdpa: Add vhost_vdpa_net_load_offloads()"), which was
> introduced by patch series "Vhost-vdpa Shadow Virtqueue Offloads
> support" at [1].
> 
> This mentioned patch series introduces a new feature for QEMU and
> has not been merged into stable-8.0 yet, so I think we do not need to
> apply the
> patch 6f34807116("vdpa: Return -EIO if device ack is
> VIRTIO_NET_ERR in _load_offloads()") to stable-8.0.

Ok, this makes sense, thank you for making it clear.

> Sorry for not mentioning this information in the cover letter.

That's okay.  I too didn't pick it up in time, so fixing this now :

/mjt

