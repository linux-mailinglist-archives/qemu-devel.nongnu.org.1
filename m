Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB123C23EDD
	for <lists+qemu-devel@lfdr.de>; Fri, 31 Oct 2025 09:53:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEkr6-0000FN-89; Fri, 31 Oct 2025 04:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEkr3-0000El-QY
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 04:51:29 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEkqr-0006hC-TH
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 04:51:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0AE77807B9;
 Fri, 31 Oct 2025 11:51:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:546::1:17] (unknown
 [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4pbBoP0FlCg0-8R4J2CwD; Fri, 31 Oct 2025 11:51:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761900667;
 bh=wR2SUVUemFXqpsQ4XAFOKGqoOQXU3MdlhlWn38R0azE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zcySzD/rPZmF1om6CQP9pHDMMBxGbLwYbZwOIwsLi+Udk8+wsQq+LY+LJGA6+VDHo
 KCZS2BwKCiunCbYMIvtuyvR6sb38tf7xCiLkiirydTFUxKB9FlcHdG3mRvT16nhgEa
 PVzmphiVE3tTuptpRjvZ8xmHGZoQdkW1dm9D/XpE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <47ca4c39-2a74-41b1-9586-279de93e44c4@yandex-team.ru>
Date: Fri, 31 Oct 2025 11:51:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/9] net/tap: postpone connect
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, peterx@redhat.com
References: <20251030171915.726441-1-vsementsov@yandex-team.ru>
 <CACGkMEtnSNJ__Kv_9fCGb7zNpTHuL7SFiZBbgGjZiUPkfh7Tiw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEtnSNJ__Kv_9fCGb7zNpTHuL7SFiZBbgGjZiUPkfh7Tiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 31.10.25 06:35, Jason Wang wrote:
> On Fri, Oct 31, 2025 at 1:19 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Hi all!
>>
>> That the second part of virtio-net backend transfer feature,
>> following previous
>>   "[PATCH v9 0/7] net/tap: simple refactoring".
>>
>> Here we realize postponing TAP opening to some future
>> point, when we know, are we going to do backend-transfer
>> incoming migration (and get open fd from migration stream),
>> or we should do open().
>>
>> v9:
>> most of patches just picked from
>>   "[PATCH v9 0/7] net/tap: simple refactoring".
>> but, 01 is new, and 09 is significantly changed:
>> instead of hacking with .check_peer_type and detecting
>> virtio-net by name, use the approach like in parallel
>> series for chardev:
>>   "[PATCH v4 0/7] chardev: postpone connect":
>> introduce specific PROPERTY macro, and avoid connecting
>> in setter of "netdev" property.
>>
>> Final part of virtio-net backend transfer is coming
>> soon and will be based on this series.
>>
>> Based-on: <20251030164023.710048-1-vsementsov@yandex-team.ru>
>>
>> Vladimir Sementsov-Ogievskiy (9):
>>    net: introduce backend-connect concept
>>    net/tap: rework net_tap_init()
>>    net/tap: split net_tap_fd_init()
>>    net/tap: rework sndbuf handling
>>    net/tap: introduce net_tap_setup()
>>    net/tap: move vhost fd initialization to net_tap_new()
>>    net/tap: finalize net_tap_set_fd() logic
>>    net/tap: introduce TAP_IFNAME_SZ
>>    net/tap: postpone tap setup to net_backend_connect() call
>>
>>   hw/core/qdev-properties-system.c    |  29 ++-
>>   include/hw/qdev-properties-system.h |   2 +
>>   include/net/net.h                   |   6 +
>>   net/net.c                           |  15 ++
>>   net/tap.c                           | 283 +++++++++++++++++++++-------
> 
> I will go through this but I'd like to see a test for this feature.
> 
> Thanks
> 

Thet's a preparation series, feature (and test) comes in
[PATCH v9 0/8] virtio-net: live-TAP local migration



-- 
Best regards,
Vladimir

