Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B07DEDE7
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 09:08:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySio-0001Wk-M4; Thu, 02 Nov 2023 04:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qySim-0001Wa-VO
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:06:32 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qySik-00051b-2W
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:06:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 42B5562A16;
 Thu,  2 Nov 2023 11:06:25 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8005::1:a] (unknown
 [2a02:6b8:b081:8005::1:a])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id N6SfJhIOm8c0-8ulCr97E; Thu, 02 Nov 2023 11:06:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1698912384;
 bh=hi8ywannSJAxwu8acgeGakHHhqbxe2iULvKJ4qEWKu0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wTOHlLZxyAlJQ/1a7xGPEpfKVmQsQtM3ERgzil8wB7B7B/U5Okyl5+v1zNcldTVmU
 pVl3K7BoW/kZC9tur2ukn3xxj3VZBvGkcVsz695bhT6bTBnV8/7QXaCLoXEMIpsYPQ
 yn6Hiq6E9ZnzRPv5k/JCkk/Y5lvRuSQ9Es/aijEw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <880f6360-ca45-48de-b092-780f176988e0@yandex-team.ru>
Date: Thu, 2 Nov 2023 11:06:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] pci hotplug tracking
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, den-plotnikov@yandex-team.ru,
 yc-core@yandex-team.ru, mlevitsk@redhat.com,
 Viktor Danilov <zaglossus@yandex-team.ru>, ds-gavr@yandex-team.ru
References: <20231005092926.56231-1-vsementsov@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231005092926.56231-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ping.

And some addition. We have the case, when the commit

commit 7bed89958bfbf40df9ca681cefbdca63abdde39d
Author: Maxim Levitsky <mlevitsk@redhat.com>
Date:   Tue Oct 6 14:38:58 2020 +0200

     device_core: use drain_call_rcu in in qmp_device_add
     
     Soon, a device removal might only happen on RCU callback execution.
     This is okay for device-del which provides a DEVICE_DELETED event,
     but not for the failure case of device-add.  To avoid changing
     monitor semantics, just drain all pending RCU callbacks on error.

sensibly slows down vm initialization (several calls to device_add of pc-dimm).

And looking at commit message, I see that what I do in the series is exactly a suggestion to change monitor semantics.

What do you think?

Maybe we need a boolean "async" parameter for device_add, which will turn off drain_call_rcu() call and rely on user to handle DEVICE_ON?

On 05.10.23 12:29, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Main thing this series does is DEVICE_ON event - a counter-part to
> DEVICE_DELETED. A guest-driven event that device is powered-on.
> Details are in patch 2. The new event is paried with corresponding
> command query-hotplug.
> 
> 
> v8:
>   - improve naming, wording and style
>   - make new QMP interface experimental
> 
> 
> Vladimir Sementsov-Ogievskiy (4):
>    qapi/qdev.json: unite DEVICE_* event data into single structure
>    qapi: add DEVICE_ON and query-hotplug infrastructure
>    shpc: implement DEVICE_ON event and query-hotplug
>    pcie: implement DEVICE_ON event and query-hotplug
> 
>   hw/core/hotplug.c               |  12 +++
>   hw/pci-bridge/pci_bridge_dev.c  |  14 +++
>   hw/pci-bridge/pcie_pci_bridge.c |   1 +
>   hw/pci/pcie.c                   |  83 +++++++++++++++
>   hw/pci/pcie_port.c              |   1 +
>   hw/pci/shpc.c                   |  86 +++++++++++++++
>   include/hw/hotplug.h            |  11 ++
>   include/hw/pci/pci_bridge.h     |   2 +
>   include/hw/pci/pcie.h           |   2 +
>   include/hw/pci/shpc.h           |   2 +
>   include/hw/qdev-core.h          |   7 ++
>   include/monitor/qdev.h          |   6 ++
>   qapi/qdev.json                  | 178 +++++++++++++++++++++++++++++---
>   softmmu/qdev-monitor.c          |  58 +++++++++++
>   14 files changed, 451 insertions(+), 12 deletions(-)
> 

-- 
Best regards,
Vladimir


