Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 797ED7AE8D3
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 11:21:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql4E1-00045f-ID; Tue, 26 Sep 2023 05:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql4Dw-00045M-AK
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 05:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql4Du-00046W-RN
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 05:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695719957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NH+2oWjOW3WMNZEbNoFRziJL/mK390lemyUxxaYsbB0=;
 b=cI+9A7t9qwxIAB6Mg+srKQf73wbwxaM66W88DhCjq/97P2kTH9HqRYkzzfJLF9DWTgPrKE
 +08SDNsrjtdu+6tw+zqoL50rxN4093wtR0ywsoRcZyJ1mYeKYLyqXihbqIeycEpD8hDQPz
 CpjXWMfkAIdSzjOhsPvgehTjykLbMeM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-APsrlRU2NM6fUSn6awTrSA-1; Tue, 26 Sep 2023 05:19:14 -0400
X-MC-Unique: APsrlRU2NM6fUSn6awTrSA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBA343822551;
 Tue, 26 Sep 2023 09:19:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C94D97B62;
 Tue, 26 Sep 2023 09:19:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA5FC21E6900; Tue, 26 Sep 2023 11:19:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "quintela@redhat.com"
 <quintela@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 52/52] migration/rdma: Fix how we show device details on
 open
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-53-armbru@redhat.com>
 <33c6b098-dc29-535f-5b17-e6e606049e59@fujitsu.com>
Date: Tue, 26 Sep 2023 11:19:12 +0200
In-Reply-To: <33c6b098-dc29-535f-5b17-e6e606049e59@fujitsu.com> (Zhijian Li's
 message of "Tue, 26 Sep 2023 06:49:55 +0000")
Message-ID: <87v8bxgulr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 18/09/2023 22:42, Markus Armbruster wrote:
>> qemu_rdma_dump_id() dumps RDMA device details to stdout.
>> 
>> rdma_start_outgoing_migration() calls it via qemu_rdma_source_init()
>> and qemu_rdma_resolve_host() to show source device details.
>> rdma_start_incoming_migration() arranges its call via
>> rdma_accept_incoming_migration() and qemu_rdma_accept() to show
>> destination device details.
>> 
>> Two issues:
>> 
>> 1. rdma_start_outgoing_migration() can run in HMP context.  The
>>     information should arguably go the monitor, not stdout.
>> 
>> 2. ibv_query_port() failure is reported as error.  Its callers remain
>>     unaware of this failure (qemu_rdma_dump_id() can't fail), so
>>     reporting this to the user as an error is problematic.
>> 
>> Use qemu_printf() instead of printf() and error_report().
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   migration/rdma.c | 20 +++++++++++---------
>>   1 file changed, 11 insertions(+), 9 deletions(-)
>> 
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 9e9904984e..8c84fbab7a 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -30,6 +30,7 @@
>>   #include "qemu/sockets.h"
>>   #include "qemu/bitmap.h"
>>   #include "qemu/coroutine.h"
>> +#include "qemu/qemu-print.h"
>>   #include "exec/memory.h"
>>   #include <sys/socket.h>
>>   #include <netdb.h>
>> @@ -742,24 +743,25 @@ static void qemu_rdma_dump_id(const char *who, struct ibv_context *verbs)
>>       struct ibv_port_attr port;
>>   
>>       if (ibv_query_port(verbs, 1, &port)) {
>> -        error_report("Failed to query port information");
>> +        qemu_printf("%s RDMA Device opened, but can't query port information",
>> +                    who);
>
>
> '\n' newline is missing ?

Yes.

>>           return;
>>       }
>>   
>> -    printf("%s RDMA Device opened: kernel name %s "
>> -           "uverbs device name %s, "
>> -           "infiniband_verbs class device path %s, "
>> -           "infiniband class device path %s, "
>> -           "transport: (%d) %s\n",
>> +    qemu_printf("%s RDMA Device opened: kernel name %s "
>> +                "uverbs device name %s, "
>> +                "infiniband_verbs class device path %s, "
>> +                "infiniband class device path %s, "
>> +                "transport: (%d) %s\n",
>>                   who,
>>                   verbs->device->name,
>>                   verbs->device->dev_name,
>>                   verbs->device->dev_path,
>>                   verbs->device->ibdev_path,
>>                   port.link_layer,
>> -                (port.link_layer == IBV_LINK_LAYER_INFINIBAND) ? "Infiniband" :
>> -                 ((port.link_layer == IBV_LINK_LAYER_ETHERNET)
>> -                    ? "Ethernet" : "Unknown"));
>> +                port.link_layer == IBV_LINK_LAYER_INFINIBAND ? "Infiniband"
>> +                : port.link_layer == IBV_LINK_LAYER_ETHERNET ? "Ethernet"
>> +                : "Unknown");
>
>
> Most of the time, these messages are not needed, so i would prefer to put it to the trace instead.

Makes sense.

>>   }
>>   
>>   /*

Thanks!


