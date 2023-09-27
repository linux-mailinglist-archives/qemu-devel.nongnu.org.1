Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 926837AFDA2
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 10:08:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlPZ9-0001qo-QT; Wed, 27 Sep 2023 04:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1qlPZ8-0001qV-Ja
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:06:38 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1qlPZ2-0004lF-6G
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:06:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7d8a:0:640:8fc3:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 89914609F0;
 Wed, 27 Sep 2023 11:06:25 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:3865:3bcf:c96b:f374] (unknown
 [2a02:6b8:0:419:3865:3bcf:c96b:f374])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id O6LcBa05YSw0-8zaZkcAN; Wed, 27 Sep 2023 11:06:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695801984;
 bh=Cdq5NDQdakFTRocdi0paHyjWQ4X6yPnw5/WgsaNTgOg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=uVxkTxdg9Qy+19CkbIj0ervfk4hQggBU+b0joQoLZPRrEsVi6n/G46vze/mORbv0g
 jeVaBKsJJGVix6ApLSd7685PMTeUG+WQ/aJ0dNhJ1KFQfh4TgNhDiGcbeApwq43/+U
 ePgG7KC19fbYSTtDKjpiOTjIJxRuTFSOxxSZfBNQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b25f0ad1-04ae-e3dd-a72b-87158b5b7414@yandex-team.ru>
Date: Wed, 27 Sep 2023 11:06:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/8] coverity fixes
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, yc-core@yandex-team.ru,
 qemu-devel@nongnu.org
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <20230926201532.221152-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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


On 9/26/23 23:15, Vladimir Sementsov-Ogievskiy wrote:
> v2:
> 01: add explanations, new assert and avoid extra assignment
>      add CIDs [thx to Paolo]
> 02: add explanation, improve wording
> 04,07: s/{0}/{}
> 06,08: improve wording
>
> Hi! Here are some improvements to handle issues found by Coverity (not
> public Coverity site, so there are no CIDs).
>
> Vladimir Sementsov-Ogievskiy (8):
>    hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd(): assert no overflow
>    util/filemonitor-inotify: qemu_file_monitor_watch(): assert no
>      overflow
>    libvhost-user.c: add assertion to vu_message_read_default
>    mc146818rtc: rtc_set_time(): initialize tm to zeroes
>    pcie_sriov: unregister_vfs(): fix error path
>    block/nvme: nvme_process_completion() fix bound for cid
>    hw/core/loader: gunzip(): initialize z_stream
>    io/channel-socket: qio_channel_socket_flush(): improve msg validation
>
>   block/nvme.c                              |  7 ++++---
>   hw/core/loader.c                          |  2 +-
>   hw/i386/intel_iommu.c                     | 23 ++++++++++++++++++---
>   hw/pci/pcie_sriov.c                       |  9 +++-----
>   hw/rtc/mc146818rtc.c                      |  2 +-
>   io/channel-socket.c                       |  5 +++++
>   subprojects/libvhost-user/libvhost-user.c |  1 +
>   util/filemonitor-inotify.c                | 25 +++++++++++++++--------
>   8 files changed, 52 insertions(+), 22 deletions(-)
>
all patches:
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>

