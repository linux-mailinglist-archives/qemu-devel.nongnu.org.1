Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5099670483F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 10:55:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqSL-0006cY-Hc; Tue, 16 May 2023 04:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pyqSK-0006c8-3T
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pyqSI-0004D5-Di
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684227289;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXQtBS3xf4vpZAboOYTkjKc1x4b/zgqIzTaDSmf3Tko=;
 b=N1+xawVjvt437x3XRbKJgInEsx0n4MtbEVzNtDCvJ9i05Hm5AJcmeSAHIySg5DI3RsLExN
 bboBmY0KlI8Ny4NEd0ZScEbYgx3r2LCLMihXo0i8ZDVGscb4UZnP/hHykcJIjU2FMiS4Rz
 fOLKvFTQkk6YDi93uM9DXsKveQWfCjE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-PWNwO8V-NcC9I-5dGLhTTw-1; Tue, 16 May 2023 04:54:45 -0400
X-MC-Unique: PWNwO8V-NcC9I-5dGLhTTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42AD33C0F243;
 Tue, 16 May 2023 08:54:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D89A863F84;
 Tue, 16 May 2023 08:54:43 +0000 (UTC)
Date: Tue, 16 May 2023 09:54:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com,
 mst@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 yuri.benditovich@daynix.com, yan@daynix.com
Subject: Re: [PATCH v2 5/6] qmp: Added new command to retrieve eBPF blob.
Message-ID: <ZGNE0bk2zCDpUkYS@redhat.com>
References: <20230512122902.34345-1-andrew@daynix.com>
 <20230512122902.34345-6-andrew@daynix.com>
 <ZGIAUxfLmI6hm3VT@redhat.com> <87zg64u0g7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg64u0g7.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, May 16, 2023 at 10:47:52AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Question for Markus at the bottom....
> >
> > On Fri, May 12, 2023 at 03:29:01PM +0300, Andrew Melnychenko wrote:
> >> Added command "request-ebpf". This command returns
> >> eBPF program encoded base64. The program taken from the
> >> skeleton and essentially is an ELF object that can be
> >> loaded in the future with libbpf.
> 
> Yes, but why is this useful?
> 
> Explaining why we want this patch is even more important than explaining
> what it does.  If the commit message does badly at the latter, I can
> still read the actual patch.  If it does badly at the former, I'm lost.
> 
> >> 
> >> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> >> ---
> >>  monitor/qmp-cmds.c | 16 ++++++++++++++++
> >>  qapi/misc.json     | 38 ++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 54 insertions(+)
> >> 
> >> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> >> index b0f948d3376..259bc87ccb1 100644
> >> --- a/monitor/qmp-cmds.c
> >> +++ b/monitor/qmp-cmds.c
> >> @@ -32,6 +32,7 @@
> >>  #include "hw/mem/memory-device.h"
> >>  #include "hw/intc/intc.h"
> >>  #include "hw/rdma/rdma.h"
> >> +#include "ebpf/ebpf.h"
> >>  
> >>  NameInfo *qmp_query_name(Error **errp)
> >>  {
> >> @@ -209,3 +210,18 @@ static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
> >>                           qmp_marshal_qmp_capabilities,
> >>                           QCO_ALLOW_PRECONFIG, 0);
> >>  }
> >> +
> >> +EbpfObject *qmp_request_ebpf(EbpfProgramID id, Error **errp)
> >> +{
> >> +    EbpfObject *ret = NULL;
> >> +    size_t size = 0;
> >> +    const void *data = ebpf_find_binary_by_id(id, &size, errp);
> >> +    if (!data) {
> >> +        return NULL;
> >> +    }
> >> +
> >> +    ret = g_new0(EbpfObject, 1);
> >> +    ret->object = g_base64_encode(data, size);
> >> +
> >> +    return ret;
> >> +}
> 
> I recently moved a load of commands from monitor/ to the appropriate
> subsystem.  I'm reluctant to add back commands that aren't about
> controlling the monitor.  Why not ebpf/ebpf-qmp-cmd.c, so MAINTAINERS
> covers it properly?
> 
> >> diff --git a/qapi/misc.json b/qapi/misc.json
> >> index 6ddd16ea283..e96dac8482b 100644
> >> --- a/qapi/misc.json
> >> +++ b/qapi/misc.json
> 
> Why not qapi/ebpf.json, so MAINTAINERS covers it properly?
> 
> >> @@ -618,3 +618,41 @@
> >>  { 'event': 'VFU_CLIENT_HANGUP',
> >>    'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
> >>              'dev-id': 'str', 'dev-qom-path': 'str' } }
> >> +
> >> +##
> >> +# @EbpfObject:
> >> +#
> >> +# Structure that holds eBPF ELF object encoded in base64.
> >> +#
> >> +# Since: 8.1
> >> +#
> >> +##
> >> +{ 'struct': 'EbpfObject',
> >> +  'data': {'object': 'str'} }
> >> +
> >> +##
> >> +# @EbpfProgramID:
> >> +#
> >> +# An enumeration of the eBPF programs. Currently, only RSS is presented.
> 
> What is RSS, and why should I care?
> 
> >> +#
> >> +# Since: 8.1
> >> +##
> >> +{ 'enum': 'EbpfProgramID',
> >> +  'data': [ { 'name': 'rss', 'if': 'CONFIG_EBPF' } ] }
> >> +
> >> +##
> >> +# @request-ebpf:
> >> +#
> >> +# Function returns eBPF object that can be loaded with libbpf.
> 
> Command, not function.
> 
> Please use imperative mood like "Return X" instead of descriptions like
> "Command returns X" or "Function returns X".
> 
> >> +# Management applications (g.e. libvirt) may load it and pass file
> >> +# descriptors to QEMU. Which allows running QEMU without BPF capabilities.
> >> +#
> >> +# Returns: RSS eBPF object encoded in base64.
> >> +#
> >> +# Since: 8.1
> >> +#
> >> +##
> 
> So, this is basically a way to retrieve an eBPF program by some
> well-known name.
> 
> Ignorant question: how are these programs desposited?

The eBPF code blob is linked into QEMU at build time. THis API lets
libvirt fetch it from QEMU, in base64 format. When libvirt later
creates NICs, it can attach the eBPF code blob to the TAP device (which
requires elevated privilleges that QEMU lacks). NB, libvirt would fetch
the eBPF code from QEMU when probing capabilities, as once a VM is
running it is untrusted.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


