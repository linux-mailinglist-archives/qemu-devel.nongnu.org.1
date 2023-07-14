Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36824753360
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKDR4-0004g4-V1; Fri, 14 Jul 2023 03:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qKDR2-0004fc-G5
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qKDQu-0004Lw-ME
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689320502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aspo+uzVHIUUZbW0harIoUN2APT6Ijx5wloKb8l+ebk=;
 b=bXOgADphhwYCkIg7Pi6IdExrCHN+SkbwbJI5VjngeI3cT7SLGZPhmA/DrnhX1Ua8nOLuY0
 JkZmVyDYrOs0aYiktoPComDm4v2CCbdAQCVSWjPyENyR/pdySYFjXgajBqteEgXiIC65lm
 nTCIk+o/fJ4Fuyp4MSr6tT3Ik1OIu6Y=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-IiChLGhHM9GlHkW60t4b8A-1; Fri, 14 Jul 2023 03:41:38 -0400
X-MC-Unique: IiChLGhHM9GlHkW60t4b8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 730723806703;
 Fri, 14 Jul 2023 07:41:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3560CC57964;
 Fri, 14 Jul 2023 07:41:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2116721E6A1F; Fri, 14 Jul 2023 09:41:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com,  mst@redhat.com,  eblake@redhat.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,
 yuri.benditovich@daynix.com,  yan@daynix.com
Subject: Re: [PATCH v4 5/6] qmp: Added new command to retrieve eBPF blob.
References: <20230714022358.2438995-1-andrew@daynix.com>
 <20230714022358.2438995-6-andrew@daynix.com>
Date: Fri, 14 Jul 2023 09:41:37 +0200
In-Reply-To: <20230714022358.2438995-6-andrew@daynix.com> (Andrew
 Melnychenko's message of "Fri, 14 Jul 2023 05:23:57 +0300")
Message-ID: <87sf9rey8e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> Added command "request-ebpf". This command returns
> eBPF program encoded base64. The program taken from the
> skeleton and essentially is an ELF object that can be
> loaded in the future with libbpf.
>
> The reason to use the command to provide the eBPF object
> instead of a separate artifact was to avoid issues related
> to finding the eBPF itself. As the eBPF maps/program should
> correspond to QEMU, the eBPF cant be used from different

can't

> QEMU build.

Blank line between paragaphs.

> The first solution was a helper that comes with QEMU
> and loads appropriate eBPF objects. And the issue is
> to find a proper helper if the system has several
> different QEMUs installed and/or built from the source,
> which helpers may not be compatible.

Blank line between paragaphs.

> Another issue is QEMU updating while there is a running
> QEMU instance. With an updated helper, it may not be
> possible to hotplug virtio-net device to the already
> running QEMU. Overall, requesting the eBPF object from
> QEMU itself solves possible failures with very little effort.

I respectfully disagree with "very little".  But it's your commit
message, not mine.  "Acceptable effort"?

> Links:
> [PATCH 3/5] qmp: Added the helper stamp check.
> https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  qapi/ebpf.json        | 58 +++++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build      |  1 +
>  qapi/qapi-schema.json |  1 +
>  3 files changed, 60 insertions(+)
>  create mode 100644 qapi/ebpf.json
>
> diff --git a/qapi/ebpf.json b/qapi/ebpf.json
> new file mode 100644
> index 0000000000..3237da69a7
> --- /dev/null
> +++ b/qapi/ebpf.json
> @@ -0,0 +1,58 @@
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
> +
> +##
> +# @EbpfObject:
> +#
> +# Structure that holds eBPF ELF object encoded in base64.
> +#
> +# Since: 8.3
> +#
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
> +# between queues by calculation hash. Users may set up indirection table
> +# and hash/packet types configurations. Used with virtio-net.
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
> +#
> +# Since: 8.3
> +#
> +##
> +{ 'command': 'request-ebpf',
> +  'data': { 'id': 'EbpfProgramID' },
> +  'returns': 'EbpfObject',
> +  'if': 'CONFIG_EBPF' }
> +

Trim the trailing blank line.

Terminology: you use "eBPF program" and "eBPF object".  What's the
difference?  If there's none, use only one term, please.  To me,
"program" feels more clear.

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


