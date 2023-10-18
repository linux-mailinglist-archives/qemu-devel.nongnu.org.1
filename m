Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AEF7CDC40
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:51:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt60j-0007ng-2F; Wed, 18 Oct 2023 08:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt60g-0007g1-Ev
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt60e-0004RU-Gu
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697633447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D7ga2QhlZ05rSKhQz5UTt3B6JVGcJt6P4YBNMixZkq8=;
 b=bG4B71j7fY/sBYfYuQ3elCIznvL1tN3hJE6qlwNX9Jzcw2zCqvOxp0P2PWCjrOysKcEuWU
 NqtImMvlgfiar3AVmCVcXF215Xr4S/Qqn/4CReUpuB6srWgYQ1QIQt3DFEgfmLJmkHNn8H
 1jD3JJfWtIz72VeKSfsbPpHpcip14VA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-691-BeXo2b9aPc2frrgNgf7WLQ-1; Wed, 18 Oct 2023 08:50:27 -0400
X-MC-Unique: BeXo2b9aPc2frrgNgf7WLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C54AA1C2B676;
 Wed, 18 Oct 2023 12:50:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E9ABC15BB8;
 Wed, 18 Oct 2023 12:50:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72AB521E6A1F; Wed, 18 Oct 2023 14:50:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  pbonzini@redhat.com,
 eblake@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com,
 den@openvz.org,  alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v8 4/7] qapi: add x-blockdev-replace command
References: <20231017184444.932733-1-vsementsov@yandex-team.ru>
 <20231017184444.932733-5-vsementsov@yandex-team.ru>
 <874jiotdis.fsf@pond.sub.org>
 <63825da4-6df0-47a7-8d22-2aa7d75ba85d@yandex-team.ru>
Date: Wed, 18 Oct 2023 14:50:25 +0200
In-Reply-To: <63825da4-6df0-47a7-8d22-2aa7d75ba85d@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 18 Oct 2023 15:04:59 +0300")
Message-ID: <87r0lsnlgu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 18.10.23 13:45, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> Add a command that can replace bs in following BdrvChild structures:
>>>
>>>   - qdev blk root child
>>>   - block-export blk root child
>>>   - any child of BlockDriverState selected by child-name
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> [..]
>
>>> --- /dev/null
>>> +++ b/stubs/blk-by-qdev-id.c
>>> @@ -0,0 +1,9 @@
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "sysemu/block-backend.h"
>>> +
>>> +BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
>>> +{
>>> +    error_setg(errp, "blk '%s' not found", id);
>>
>> Is this expected to happen?
>
> Yes, if call the command from qemu-storage-daemon, where qdev-monitor is not linked in.

It happens when you try to x-blockdev-replace with "parent-type":
"qdev".  Correct?

> Maybe, better message would be
>
>    "devices are not supported"

Best to spell out which argument is the problem.

Stupidest solution that could possibly work:

    "Parameter 'parent-type' does not accept value 'qdev'"

This is exactly what we'd get if we compiled out the parts that don't
make sense for qemu-storage-daemon.

> Maybe, that possible to use some 'if': notation in qapi, to not include support for qdev into the new command, when it compiled into qemu-storage-daemon? Seems that would not be simple, as we also need to split compilation of the command somehow, now it compiled once both for qemu and qemu tools..

That's precisely the problem.

Our reuse of parts of qemu-system-FOO's QAPI schema for
qemu-storage-daemon isn't pretty, but has worked for us so far.

>>> +    return NULL;
>>> +}
>> [...]
>> QAPI schema
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> 


