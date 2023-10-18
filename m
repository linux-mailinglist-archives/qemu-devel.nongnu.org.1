Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FAA7CDB3D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:05:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5Ib-000880-8I; Wed, 18 Oct 2023 08:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qt5IX-00084X-Bw; Wed, 18 Oct 2023 08:05:14 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qt5IT-0003VA-TL; Wed, 18 Oct 2023 08:05:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1bac:0:640:75a2:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id DB92F620BF;
 Wed, 18 Oct 2023 15:05:00 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b667::1:1d] (unknown
 [2a02:6b8:b081:b667::1:1d])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id x4kDGvAOdSw0-1zhNX6FR; Wed, 18 Oct 2023 15:05:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697630700;
 bh=tyICDHoF6y002cjAWwUEEVKV+0xQ8fINHu98H0D605Y=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=twnf5v1xsmNNFBVBbmw+W/N+/k5o1E6hlnULUfC4fp7GO+xd/52scUy+8mvzvB98V
 QOv8mDRBQlAVpJOKHJ6k5eqgGvkakIohF3TPRbVQ6CgUlEeBoDxzqBp+9IqXXkQeHw
 ud8Zp1NJsRofJTN90UnWCxitjbmjQ7GtfhTrhCJI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <63825da4-6df0-47a7-8d22-2aa7d75ba85d@yandex-team.ru>
Date: Wed, 18 Oct 2023 15:04:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] qapi: add x-blockdev-replace command
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 alexander.ivanov@virtuozzo.com
References: <20231017184444.932733-1-vsementsov@yandex-team.ru>
 <20231017184444.932733-5-vsementsov@yandex-team.ru>
 <874jiotdis.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <874jiotdis.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 18.10.23 13:45, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Add a command that can replace bs in following BdrvChild structures:
>>
>>   - qdev blk root child
>>   - block-export blk root child
>>   - any child of BlockDriverState selected by child-name
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[..]

>> --- /dev/null
>> +++ b/stubs/blk-by-qdev-id.c
>> @@ -0,0 +1,9 @@
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "sysemu/block-backend.h"
>> +
>> +BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
>> +{
>> +    error_setg(errp, "blk '%s' not found", id);
> 
> Is this expected to happen?

Yes, if call the command from qemu-storage-daemon, where qdev-monitor is not linked in.

Maybe, better message would be

    "devices are not supported"

Maybe, that possible to use some 'if': notation in qapi, to not include support for qdev into the new command, when it compiled into qemu-storage-daemon? Seems that would not be simple, as we also need to split compilation of the command somehow, now it compiled once both for qemu and qemu tools..

> 
>> +    return NULL;
>> +}
> 
> [...]
> 
> QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 

-- 
Best regards,
Vladimir


