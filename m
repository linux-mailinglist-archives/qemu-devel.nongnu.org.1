Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 170FF7DF1E6
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 13:01:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyWN8-00059J-VX; Thu, 02 Nov 2023 08:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qyWMw-000567-AH
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:00:14 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qyWMq-0004pK-PP
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:00:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:88b:0:640:d9e4:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 184E761C16;
 Thu,  2 Nov 2023 15:00:04 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8005::1:a] (unknown
 [2a02:6b8:b081:8005::1:a])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 20WUYM5OdW20-gWRYnCeu; Thu, 02 Nov 2023 15:00:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1698926403;
 bh=1AX98m8z+gRt1dJg6otmmLlfI+XZ3b+watOzdOSgJ1s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vnawbDrXy+PWO9TKBDGHgWTH7kQpIKCgu4VrIBs0mYCsNC1UO0Lg2sXr7kgF+DsJK
 mgWy+wY5AM+R1dhML1SeguPjo1mrfMvWurEZLXcu8OTC4g3IRk+03/ynyjFF2A+LHa
 LE8+Gt9mK2taHIMuGE34bpthrvJG2PCf6SqTTq/k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d69f0aeb-303a-4721-b25b-52a08b8cd63f@yandex-team.ru>
Date: Thu, 2 Nov 2023 15:00:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] pci hotplug tracking
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, den-plotnikov@yandex-team.ru,
 yc-core@yandex-team.ru, Peter Krempa <pkrempa@redhat.com>,
 nshirokovskiy@openvz.org, devel@lists.libvirt.org
References: <20231005092926.56231-1-vsementsov@yandex-team.ru>
 <20231102072800-mutt-send-email-mst@kernel.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231102072800-mutt-send-email-mst@kernel.org>
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

On 02.11.23 14:31, Michael S. Tsirkin wrote:
> On Thu, Oct 05, 2023 at 12:29:22PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Main thing this series does is DEVICE_ON event - a counter-part to
>> DEVICE_DELETED. A guest-driven event that device is powered-on.
>> Details are in patch 2. The new event is paried with corresponding
>> command query-hotplug.
> 
> Several things questionable here:
> 1. depending on guest activity you can get as many
>     DEVICE_ON events as you like

No, I've made it so it may be sent only once per device

> 2. it's just for shpc and native pcie - things are
>     confusing enough for management, we should make sure
>     it can work for all devices

Agree, I'm thinking about it

> 3. what about non hotpluggable devices? do we want the event for them?
> 

I think, yes, especially if we make async=true|false flag for device_add, so that successful device_add must be always followed by DEVICE_ON - like device_del is followed by DEVICE_DELETED.

Maybe, to generalize, it should be called not DEVICE_ON (which mostly relate to hotplug controller statuses) but DEVICE_ADDED - a full counterpart for DEVICE_DELETED.

> 
> I feel this needs actual motivation so we can judge what's the
> right way to do it.

My first motivation for this series was the fact that successful device_add doesn't guarantee that hard disk successfully hotplugged to the guest. It relates to some problems with shpc/pcie hotplug we had in the past, and they are mostly fixed. But still, for management tool it's good to understand that all actions related to hotplug controller are done and we have "green light".

Recently new motivation come, as I described in my "ping" letter <6bd19a07-5224-464d-b54d-1d738f5ba8f7@yandex-team.ru>, that we have a performance degradation because of 7bed89958bfbf40df, which introduces drain_call_rcu() in device_add, to make it more synchronous. So, my suggestion is make it instead more asynchronous (probably with special flag) and rely on DEVICE_ON event.

> 
> 
>>
>> v8:
>>   - improve naming, wording and style
>>   - make new QMP interface experimental
>>
>>
>> Vladimir Sementsov-Ogievskiy (4):
>>    qapi/qdev.json: unite DEVICE_* event data into single structure
>>    qapi: add DEVICE_ON and query-hotplug infrastructure
>>    shpc: implement DEVICE_ON event and query-hotplug
>>    pcie: implement DEVICE_ON event and query-hotplug
>>
>>   hw/core/hotplug.c               |  12 +++
>>   hw/pci-bridge/pci_bridge_dev.c  |  14 +++
>>   hw/pci-bridge/pcie_pci_bridge.c |   1 +
>>   hw/pci/pcie.c                   |  83 +++++++++++++++
>>   hw/pci/pcie_port.c              |   1 +
>>   hw/pci/shpc.c                   |  86 +++++++++++++++
>>   include/hw/hotplug.h            |  11 ++
>>   include/hw/pci/pci_bridge.h     |   2 +
>>   include/hw/pci/pcie.h           |   2 +
>>   include/hw/pci/shpc.h           |   2 +
>>   include/hw/qdev-core.h          |   7 ++
>>   include/monitor/qdev.h          |   6 ++
>>   qapi/qdev.json                  | 178 +++++++++++++++++++++++++++++---
>>   softmmu/qdev-monitor.c          |  58 +++++++++++
>>   14 files changed, 451 insertions(+), 12 deletions(-)
>>
>> -- 
>> 2.34.1
> 

-- 
Best regards,
Vladimir


