Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 165B6816F3D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:01:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD8O-0002fF-UK; Mon, 18 Dec 2023 07:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFD8N-0002ej-9E
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFD8K-0004ra-Ok
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702904047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IFIJ+RPzZkqaRY6iZci9OyAj1dWWVEMhl2Ha4XXbRMw=;
 b=aA1SpIX99gFu4iEVDzWke0NHqwbVKaPbZD4KF77FbhCF1Zmbx69jPgBIs2fnY8hVsFRAaC
 hw+4TUW7x16RV8cdR8o0UKlol2g1rQR3IbdaYjs2syDVYDI/78NPM0H8Mh4fc9x2ZktXBa
 9M/0CiG80wnxbkBkxdX2pLrGTwloRMM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-Y3ffz6cwOyG1s-zkD-9iZQ-1; Mon,
 18 Dec 2023 07:54:05 -0500
X-MC-Unique: Y3ffz6cwOyG1s-zkD-9iZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AEB938562C6;
 Mon, 18 Dec 2023 12:54:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E9B42026D66;
 Mon, 18 Dec 2023 12:54:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0813221E6920; Mon, 18 Dec 2023 13:54:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com,  mst@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  qemu-devel@nongnu.org,  berrange@redhat.com,
 yuri.benditovich@daynix.com,  yan@daynix.com
Subject: Re: [PATCH v7 4/5] qmp: Added new command to retrieve eBPF blob.
In-Reply-To: <20230831065140.496485-5-andrew@daynix.com> (Andrew Melnychenko's
 message of "Thu, 31 Aug 2023 09:51:39 +0300")
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-5-andrew@daynix.com>
Date: Mon, 18 Dec 2023 13:54:04 +0100
Message-ID: <874jgfu0wj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Uh, I missed this one, my apologies!  Let me have a quick look...

Commit message style nitpick:

    qmp: Add command to retrieve eBPF blob

or

    qmp: New command to retrieve eBPF blob

It's a title, not a sentence.

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

[...]

> diff --git a/qapi/ebpf.json b/qapi/ebpf.json
> new file mode 100644
> index 0000000000..ba78407148
> --- /dev/null
> +++ b/qapi/ebpf.json
> @@ -0,0 +1,66 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> +# See the COPYING file in the top-level directory.
> +
> +##
> +# = eBPF Objects
> +#
> +# eBPF object is an ELF binary that contains the eBPF
> +# program and eBPF map description(BTF). Overall, eBPF
> +# object should contain the program and enough metadata
> +# to create/load eBPF with libbpf. As the eBPF maps/program
> +# should correspond to QEMU, the eBPF can't be used from
> +# different QEMU build.

An introduction, nice!

Two spaces between sentences for consistency, please.

Wrap comment lines at column 70, like this:

   # eBPF object is an ELF binary that contains the eBPF program and eBPF
   # map description(BTF).  Overall, eBPF object should contain the
   # program and enough metadata to create/load eBPF with libbpf.  As the
   # eBPF maps/program should correspond to QEMU, the eBPF can't be used
   # from different QEMU build.

> +#
> +# Currently, there is a possible eBPF for receive-side scaling (RSS).
> +#
> +##
> +
> +##
> +# @EbpfObject:
> +#
> +# An eBPF ELF object.
> +#
> +# @object: the eBPF object encoded in base64
> +#
> +# Since: 8.2

Won't make 8.2, so bump to 9.0.  More of the same below, not noting it
again.

> +##
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
> +#     between queues by calculation hash.  Users may set up
> +#     indirection table and hash/packet types configurations.  Used
> +#     with virtio-net.
> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'EbpfProgramID',
> +  'if': 'CONFIG_EBPF',
> +  'data': [ { 'name': 'rss' } ] }
> +
> +##
> +# @request-ebpf:
> +#
> +# Retrieve an eBPF object that can be loaded with libbpf.  Management
> +# applications (g.e. libvirt) may load it and pass file descriptors to
> +# QEMU, so they can run running QEMU without BPF capabilities.
> +#
> +# @id: The ID of the program to return.
> +#
> +# Returns: eBPF object encoded in base64.
> +#
> +# Since: 8.2
> +##
> +{ 'command': 'request-ebpf',
> +  'data': { 'id': 'EbpfProgramID' },
> +  'returns': 'EbpfObject',
> +  'if': 'CONFIG_EBPF' }
> diff --git a/qapi/meson.build b/qapi/meson.build
> index 60a668b343..90047dae1c 100644
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
> index 6594afba31..2c82a49bae 100644
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

With the (minor) doc comment fixes:
Acked-by: Markus Armbruster <armbru@redhat.com>


