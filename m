Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48A70482A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 10:49:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqLk-0004C9-Mx; Tue, 16 May 2023 04:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyqLg-0004AV-6r
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyqLe-0001YF-AM
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684226876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ad9a3THlXKPz+w2a1IoOzWBJsc79aj1vdAKX2WCfAOo=;
 b=b1fCTUwpIgiZbNEDg1i7vl4ZvmGeUuq33iLgIU/xKhWMCMYUrEET9+Ay7rkO/NavvwqjSF
 4IanPDv9QzHPaDZUY4JmvBL6aF27WJcwGkLDrFLlccabWM3UsZnI/ns0fq/9T6pwS+I+88
 ttcdciIhPHeVmfx1MmP9NDPfspDz0WA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-HyTmwSRLP9aQq3I-4GsdvQ-1; Tue, 16 May 2023 04:47:54 -0400
X-MC-Unique: HyTmwSRLP9aQq3I-4GsdvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47513185A78B;
 Tue, 16 May 2023 08:47:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05E40C15BA0;
 Tue, 16 May 2023 08:47:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBE6A21E681C; Tue, 16 May 2023 10:47:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>,  jasowang@redhat.com,
 mst@redhat.com,  eblake@redhat.com,  qemu-devel@nongnu.org,
 yuri.benditovich@daynix.com,  yan@daynix.com
Subject: Re: [PATCH v2 5/6] qmp: Added new command to retrieve eBPF blob.
References: <20230512122902.34345-1-andrew@daynix.com>
 <20230512122902.34345-6-andrew@daynix.com>
 <ZGIAUxfLmI6hm3VT@redhat.com>
Date: Tue, 16 May 2023 10:47:52 +0200
In-Reply-To: <ZGIAUxfLmI6hm3VT@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 15 May 2023 10:50:11 +0100")
Message-ID: <87zg64u0g7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Question for Markus at the bottom....
>
> On Fri, May 12, 2023 at 03:29:01PM +0300, Andrew Melnychenko wrote:
>> Added command "request-ebpf". This command returns
>> eBPF program encoded base64. The program taken from the
>> skeleton and essentially is an ELF object that can be
>> loaded in the future with libbpf.

Yes, but why is this useful?

Explaining why we want this patch is even more important than explaining
what it does.  If the commit message does badly at the latter, I can
still read the actual patch.  If it does badly at the former, I'm lost.

>>=20
>> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
>> ---
>>  monitor/qmp-cmds.c | 16 ++++++++++++++++
>>  qapi/misc.json     | 38 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 54 insertions(+)
>>=20
>> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
>> index b0f948d3376..259bc87ccb1 100644
>> --- a/monitor/qmp-cmds.c
>> +++ b/monitor/qmp-cmds.c
>> @@ -32,6 +32,7 @@
>>  #include "hw/mem/memory-device.h"
>>  #include "hw/intc/intc.h"
>>  #include "hw/rdma/rdma.h"
>> +#include "ebpf/ebpf.h"
>>=20=20
>>  NameInfo *qmp_query_name(Error **errp)
>>  {
>> @@ -209,3 +210,18 @@ static void __attribute__((__constructor__)) monito=
r_init_qmp_commands(void)
>>                           qmp_marshal_qmp_capabilities,
>>                           QCO_ALLOW_PRECONFIG, 0);
>>  }
>> +
>> +EbpfObject *qmp_request_ebpf(EbpfProgramID id, Error **errp)
>> +{
>> +    EbpfObject *ret =3D NULL;
>> +    size_t size =3D 0;
>> +    const void *data =3D ebpf_find_binary_by_id(id, &size, errp);
>> +    if (!data) {
>> +        return NULL;
>> +    }
>> +
>> +    ret =3D g_new0(EbpfObject, 1);
>> +    ret->object =3D g_base64_encode(data, size);
>> +
>> +    return ret;
>> +}

I recently moved a load of commands from monitor/ to the appropriate
subsystem.  I'm reluctant to add back commands that aren't about
controlling the monitor.  Why not ebpf/ebpf-qmp-cmd.c, so MAINTAINERS
covers it properly?

>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 6ddd16ea283..e96dac8482b 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json

Why not qapi/ebpf.json, so MAINTAINERS covers it properly?

>> @@ -618,3 +618,41 @@
>>  { 'event': 'VFU_CLIENT_HANGUP',
>>    'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
>>              'dev-id': 'str', 'dev-qom-path': 'str' } }
>> +
>> +##
>> +# @EbpfObject:
>> +#
>> +# Structure that holds eBPF ELF object encoded in base64.
>> +#
>> +# Since: 8.1
>> +#
>> +##
>> +{ 'struct': 'EbpfObject',
>> +  'data': {'object': 'str'} }
>> +
>> +##
>> +# @EbpfProgramID:
>> +#
>> +# An enumeration of the eBPF programs. Currently, only RSS is presented.

What is RSS, and why should I care?

>> +#
>> +# Since: 8.1
>> +##
>> +{ 'enum': 'EbpfProgramID',
>> +  'data': [ { 'name': 'rss', 'if': 'CONFIG_EBPF' } ] }
>> +
>> +##
>> +# @request-ebpf:
>> +#
>> +# Function returns eBPF object that can be loaded with libbpf.

Command, not function.

Please use imperative mood like "Return X" instead of descriptions like
"Command returns X" or "Function returns X".

>> +# Management applications (g.e. libvirt) may load it and pass file
>> +# descriptors to QEMU. Which allows running QEMU without BPF capabiliti=
es.
>> +#
>> +# Returns: RSS eBPF object encoded in base64.
>> +#
>> +# Since: 8.1
>> +#
>> +##

So, this is basically a way to retrieve an eBPF program by some
well-known name.

Ignorant question: how are these programs desposited?

>> +{ 'command': 'request-ebpf',
>> +  'data': { 'id': 'EbpfProgramID' },
>> +  'returns': 'EbpfObject' }
>> +
>
> Fnuctionally this is fine so
>
>   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> A question for Markus though - is is perhaps better to mark all the
> command/enum/object as conditional on CONFIG_EBPF, rather than just
> reporting an empty EbpfProgramID enum when EBPF is disabled at build
> time ?

Using conditionals has two advantages:

1. Checking for the feature is commonly more straightforward

   Checking for presence of command with query-qmp-schema works fine
   both for old versions of QEMU (where the command doesn't exist) and
   new versions (where it exists, but is disabled).

   Without conditionals, you need two checks: command present, and
   command can actually do something.  More complicated even when the
   latter check is easy, as it is here.

2. Slightly leaner program when the feature is off


