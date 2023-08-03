Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3176EC2A
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:17:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZ80-0003fj-Md; Thu, 03 Aug 2023 10:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRZ7y-0003dx-I6
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRZ7w-00026D-Nn
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691072191;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/7qde2mqi3X/6eC5SmCusqRy437w+I6rsqxi7rAT03I=;
 b=KQhgQ3i5QsDU9wUUnHUMylQRAn/1rQTn7q+OCPEaOqU1+FG4taRqndL/2+G50vvGuhfg+U
 BDnk4pzRHKIcoc39xDL3INjhcwhVL7hzrvmLLtRcoqIj9hHpyHrIMMOR/8XeS6jmyC366l
 iC/BJN9fIquClHNbK0AFSyb5waxHuIE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-692-3UXhYLrQNLOzzv8WNbWdKg-1; Thu, 03 Aug 2023 10:16:27 -0400
X-MC-Unique: 3UXhYLrQNLOzzv8WNbWdKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA347858F1E;
 Thu,  3 Aug 2023 14:16:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBC21200B680;
 Thu,  3 Aug 2023 14:16:25 +0000 (UTC)
Date: Thu, 3 Aug 2023 15:16:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org,
 yuri.benditovich@daynix.com, yan@daynix.com
Subject: Re: [PATCH v5 4/5] qmp: Added new command to retrieve eBPF blob.
Message-ID: <ZMu2t/egT5giMXk4@redhat.com>
References: <20230802204125.33688-1-andrew@daynix.com>
 <20230802204125.33688-5-andrew@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802204125.33688-5-andrew@daynix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Aug 02, 2023 at 11:41:22PM +0300, Andrew Melnychenko wrote:
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
>  ebpf/ebpf.c           | 70 +++++++++++++++++++++++++++++++++++++++++++
>  ebpf/ebpf.h           | 31 +++++++++++++++++++
>  ebpf/ebpf_rss.c       |  6 ++++
>  ebpf/meson.build      |  2 +-
>  qapi/ebpf.json        | 57 +++++++++++++++++++++++++++++++++++
>  qapi/meson.build      |  1 +
>  qapi/qapi-schema.json |  1 +
>  7 files changed, 167 insertions(+), 1 deletion(-)
>  create mode 100644 ebpf/ebpf.c
>  create mode 100644 ebpf/ebpf.h
>  create mode 100644 qapi/ebpf.json

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
> +
> +##
> +# @EbpfObject:
> +#
> +# Structure that holds eBPF ELF object encoded in base64.
> +#
> +# Since: 8.3

We're just releasing 8.1, so next will be 8.2

There will never be any 8.3 because we reset to next major
version in the first release of each year.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


