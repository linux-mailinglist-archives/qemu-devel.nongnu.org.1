Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D4D74B025
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:45:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHju1-0005f9-5x; Fri, 07 Jul 2023 07:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHjto-0005Qh-Er
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHjtl-0003W5-0v
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688730316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hf2FON4TwZFFxywUbMuLqqUaq4hm0JOo25+c0uZwpTQ=;
 b=UC2IXF4vLkTfMJ2cRiwdYV2DLXK/TvOv8TqF9JeqOqbf0gVcEpJkHZNz0KCOI0cUX/jKlO
 wGhDVifXEwW/T5HizO4jKXtecaLtGiaKGDB2l5XAlLWLb60N42bGnOjM6xF9SJlOh0CMgp
 k6qkCuk76tkvMp8jI+ENEI2ruv6O94g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-f9djNf9HNmSsdCw-AxdiDw-1; Fri, 07 Jul 2023 07:45:13 -0400
X-MC-Unique: f9djNf9HNmSsdCw-AxdiDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6A6580027F;
 Fri,  7 Jul 2023 11:45:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68B40EE37C;
 Fri,  7 Jul 2023 11:45:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5636B21E6A1F; Fri,  7 Jul 2023 13:45:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com,  mst@redhat.com,  eblake@redhat.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,
 yuri.benditovich@daynix.com,  yan@daynix.com
Subject: Re: [PATCH v3 5/6] qmp: Added new command to retrieve eBPF blob.
References: <20230614221026.56950-1-andrew@daynix.com>
 <20230614221026.56950-6-andrew@daynix.com>
Date: Fri, 07 Jul 2023 13:45:11 +0200
In-Reply-To: <20230614221026.56950-6-andrew@daynix.com> (Andrew Melnychenko's
 message of "Thu, 15 Jun 2023 01:10:25 +0300")
Message-ID: <87edlkj67s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Andrew Melnychenko <andrew@daynix.com> writes:

> Added command "request-ebpf". This command returns
> eBPF program encoded base64. The program taken from the
> skeleton and essentially is an ELF object that can be
> loaded in the future with libbpf.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>

In review of v2, I asked why we need to provide eBPF programs via QMP,
and not simply via the filesystem, like all the other build artifacts.
Daniel explained

    Fetching it from QEMU gives us a strong guarantee that the eBPF
    code actually matches the QEMU binary we're talking to, which is
    useful if you're dealing with RPMs which can be upgraded behind
    your back, or have multiple parallel installs of QEMU.

I asked to work this rationale into the QAPI schema doc comments and the
commit message.

Only the doc comments are updated in this version.  Please update the
commit message as well.

I remain unconvinced this justifies adding an entirely new transport.
If we want to guard against mismatch, we can do it the usual way: bake
the version into the build artifacts that must match, then check they
do.

Since I feel vetoing the change would overstep my authority as a QAPI
maintainer, I'm asking you to treat my objection as advice.

If you you elect not to follow my advice, I want you to describe the
path not chosen in the commit message.  I.e. briefly explain the need
for an exact version match, describe the ways to ensure it we
considered, and the reasons for your pick.

> ---
>  qapi/ebpf.json        | 55 +++++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build      |  1 +
>  qapi/qapi-schema.json |  1 +
>  3 files changed, 57 insertions(+)
>  create mode 100644 qapi/ebpf.json
>
> diff --git a/qapi/ebpf.json b/qapi/ebpf.json
> new file mode 100644
> index 00000000000..6f9a1f1a0c9
> --- /dev/null
> +++ b/qapi/ebpf.json
> @@ -0,0 +1,55 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> +# See the COPYING file in the top-level directory.
> +
> +##
> +# = Machines

Copy-pasta :)

> +##
> +
> +{ 'include': 'common.json' }
> +
> +##
> +# @EbpfObject:
> +#
> +# Structure that holds eBPF ELF object encoded in base64.
> +#
> +# Since: 8.1
> +#
> +##
> +{ 'struct': 'EbpfObject',
> +  'data': {'object': 'str'} }
> +
> +##
> +# @EbpfProgramID:
> +#
> +# An enumeration of the eBPF programs. Currently, only RSS is presented.
> +# RSS - Receive side scaling, technology that allows steering traffic
> +# between queues by calculation hash. Users may set up indirection table
> +# and hash/packet types configurations. Used with virtio-net.

Let's stick to the common way to document enum members, like this:

   # The eBPF programs that can be gotten with request-ebpf.
   #
   # @rss: ...

> +#
> +# Since: 8.1
> +##
> +{ 'enum': 'EbpfProgramID',
> +  'data': [ { 'name': 'rss', 'if': 'CONFIG_EBPF' } ] }

Uh, this makes just the member @rss conditional on CONFIG_EBPF.
Why not the entire enum?

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
> +# Since: 8.1
> +#
> +##
> +{ 'command': 'request-ebpf',
> +  'data': { 'id': 'EbpfProgramID' },
> +  'returns': 'EbpfObject',
> +  'if': 'CONFIG_EBPF' }
> +
> diff --git a/qapi/meson.build b/qapi/meson.build
> index 9fd480c4d81..12a1cb1f9c2 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -52,6 +52,7 @@ qapi_all_modules = [
>    'transaction',
>    'virtio',
>    'yank',
> +  'ebpf',

Keep this list alphabetically sorted, please.

>  ]
>  if have_system
>    qapi_all_modules += [
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 6594afba312..169cfe8d386 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -79,3 +79,4 @@
>  { 'include': 'virtio.json' }
>  { 'include': 'cryptodev.json' }
>  { 'include': 'cxl.json' }
> +{ 'include': 'ebpf.json' }

This puts it at the end of the QMP reference manual.  Is this the best
spot?


