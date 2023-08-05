Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E9770E7A
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 09:36:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSBoq-0001KT-1r; Sat, 05 Aug 2023 03:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qSBoT-0001JG-Fd
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qSBoR-0002V2-CP
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691220897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VD6tq5DuG6W+iDFtI+olY4gS9Pn1x22DVbWf/45qlNI=;
 b=SizoeByo8XO9aWmC6kGGiepOGzgPos9O7LRrdd7ws81G4a9EqEjoeV3A/SKiEVYofsOYJB
 +S4tiuWaad2cCpVYIAaDcatff8nA6Q+NjDhnbeQI6BPoUPSgHkxgJ8uOryMVG9c4PTkRXb
 b/0T/LSBu2gHm2/2QN+fOLsmtC7aVRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-5SFArG8KPDyOgXBlznDihg-1; Sat, 05 Aug 2023 03:34:55 -0400
X-MC-Unique: 5SFArG8KPDyOgXBlznDihg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB52E88D196;
 Sat,  5 Aug 2023 07:34:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8816C4021B9;
 Sat,  5 Aug 2023 07:34:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61DE321E692A; Sat,  5 Aug 2023 09:34:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com,  mst@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  berrange@redhat.com,  qemu-devel@nongnu.org,
 yuri.benditovich@daynix.com,  yan@daynix.com
Subject: Re: [PATCH v5 4/5] qmp: Added new command to retrieve eBPF blob.
References: <20230802204125.33688-1-andrew@daynix.com>
 <20230802204125.33688-5-andrew@daynix.com>
Date: Sat, 05 Aug 2023 09:34:53 +0200
In-Reply-To: <20230802204125.33688-5-andrew@daynix.com> (Andrew Melnychenko's
 message of "Wed, 2 Aug 2023 23:41:22 +0300")
Message-ID: <87sf8yx7qa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Andrew Melnychenko <andrew@daynix.com> writes:

> Now, the binary objects may be retrieved by id.
> It would require for future qmp commands that may require specific
> eBPF blob.
>
> Added command "request-ebpf". This command returns
> eBPF program encoded base64. The program taken from the
> skeleton and essentially is an ELF object that can be
> loaded in the future with libbpf.
>
> The reason to use the command to provide the eBPF object
> instead of a separate artifact was to avoid issues related
> to finding the eBPF itself. eBPF object is an ELF binary
> that contains the eBPF program and eBPF map description(BTF).
> Overall, eBPF object should contain the program and enough
> metadata to create/load eBPF with libbpf. As the eBPF
> maps/program should correspond to QEMU, the eBPF can't
> be used from different QEMU build.
>
> The first solution was a helper that comes with QEMU
> and loads appropriate eBPF objects. And the issue is
> to find a proper helper if the system has several
> different QEMUs installed and/or built from the source,
> which helpers may not be compatible.
>
> Another issue is QEMU updating while there is a running
> QEMU instance. With an updated helper, it may not be
> possible to hotplug virtio-net device to the already
> running QEMU. Overall, requesting the eBPF object from
> QEMU itself solves possible failures with acceptable effort.
>
> Links:
> [PATCH 3/5] qmp: Added the helper stamp check.
> https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---

[...]

> diff --git a/qapi/ebpf.json b/qapi/ebpf.json
> new file mode 100644
> index 00000000000..40851f8c177
> --- /dev/null
> +++ b/qapi/ebpf.json
> @@ -0,0 +1,57 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> +# See the COPYING file in the top-level directory.
> +
> +##
> +# = eBPF Objects
> +##
> +
> +{ 'include': 'common.json' }

This looks superfluous.

> +
> +##
> +# @EbpfObject:
> +#
> +# Structure that holds eBPF ELF object encoded in base64.
> +#
> +# Since: 8.3

8.2

More of the same below, not noting it again.

> +#
> +##

You're not documenting member @object.  Leaving a member undocumented
should be a hard error.  It isn't only because we have hundreds of
instances to fix.

Generated documentation looks like

    "EbpfObject" (Object)
    ---------------------

    Structure that holds eBPF ELF object encoded in base64.


    Members
    ~~~~~~~

    "object": "string"
       Not documented

    [...]

This isn't what you want :)

Better:

   ##
   # @EbpfObject:
   #
   # An eBPF ELF object.
   #
   # @object: the eBPF object encoded in base64
   #
   # Since: 8.2
   ##

> +{ 'struct': 'EbpfObject',
> +  'data': {'object': 'str'},
> +  'if': 'CONFIG_EBPF' }
> +
> +##
> +# @EbpfProgramID:
> +#
> +# The eBPF programs that can be gotten with request-ebpf.
> +#
> +# @rss: Receive side scaling, technology that allows steering traffic
> +# between queues by calculation hash. Users may set up indirection table
> +# and hash/packet types configurations. Used with virtio-net.

Please format like

   # @rss: Receive side scaling, technology that allows steering traffic
   #     between queues by calculation hash.  Users may set up
   #     indirection table and hash/packet types configurations.  Used
   #     with virtio-net.

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

> +#
> +# Since: 8.3
> +##
> +{ 'enum': 'EbpfProgramID',
> +  'if': 'CONFIG_EBPF',
> +  'data': [ { 'name': 'rss' } ] }
> +
> +##
> +# @request-ebpf:
> +#
> +# Returns eBPF object that can be loaded with libbpf.
> +# Management applications (g.e. libvirt) may load it and pass file
> +# descriptors to QEMU. Which allows running QEMU without BPF capabilities.
> +# It's crucial that eBPF program/map is compatible with QEMU, so it's
> +# provided through QMP.
> +#
> +# Returns: RSS eBPF object encoded in base64.

What does "RSS" mean?

> +#
> +# Since: 8.3
> +#
> +##

You're not documenting argument @id.

Generated documentation looks like

    "request-ebpf" (Command)
    ------------------------

    Returns eBPF object that can be loaded with libbpf. Management
    applications (g.e. libvirt) may load it and pass file descriptors to
    QEMU. Which allows running QEMU without BPF capabilities. It's crucial
    that eBPF program/map is compatible with QEMU, so it's provided
    through QMP.


    Arguments
    ~~~~~~~~~

    "id": "EbpfProgramID"
       Not documented


    Returns
    ~~~~~~~

    RSS eBPF object encoded in base64.
    [...]

Here's my try:

    ##
    # @request-ebpf:
    #
    # Retrieve an eBPF object that can be loaded with libbpf.  Management
    # applications (g.e. libvirt) may load it and pass file descriptors to
    # QEMU, so they can run running QEMU without BPF capabilities.
    #
    # @id: The ID of the program to return.
    #
    # Returns: RSS eBPF object encoded in base64.
    #
    # Since: 8.3
    ##

I omitted the "It's crucial" part, because I feel rationale doesn't
belong here.  The commit message still has us covered.

> +{ 'command': 'request-ebpf',
> +  'data': { 'id': 'EbpfProgramID' },
> +  'returns': 'EbpfObject',
> +  'if': 'CONFIG_EBPF' }

Terminology: you use "eBPF program" and "eBPF object".  What's the
difference?  If there's none, use only one term, please.  To me,
"program" feels more clear.

> diff --git a/qapi/meson.build b/qapi/meson.build
> index 60a668b3432..90047dae1c8 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -33,6 +33,7 @@ qapi_all_modules = [
>    'crypto',
>    'cxl',
>    'dump',
> +  'ebpf',
>    'error',
>    'introspect',
>    'job',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 6594afba312..2c82a49baec 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -53,6 +53,7 @@
>  { 'include': 'char.json' }
>  { 'include': 'dump.json' }
>  { 'include': 'net.json' }
> +{ 'include': 'ebpf.json' }
>  { 'include': 'rdma.json' }
>  { 'include': 'rocker.json' }
>  { 'include': 'tpm.json' }


