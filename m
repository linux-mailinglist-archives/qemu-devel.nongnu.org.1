Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF885E116
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 16:28:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoQP-0007UI-MA; Wed, 21 Feb 2024 10:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoL4-00010D-9i
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rclkZ-0006bw-Ii
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708518656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0izBSbbHIueP8VABdK7wpWQFGQTEczRcEHj1BQZ0JHA=;
 b=gqbaiBHnVyTjNpw/u+P2FwPazKrCDdOA9DhgkDtL7m8ijmPL9KBasMCTsTHQ5eAKOd1b1u
 TFzsest/JiSgm9Wc6XGp56WMC5XrsgVWBoyf46AIrfxoCV2+jTSu6afhYXYkOoDWdjpaQq
 07yRoYZtGLe6SKI/UINunc/fMFZw0R8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-CNOKigFJPlyC99SVhMEgXw-1; Wed, 21 Feb 2024 07:30:52 -0500
X-MC-Unique: CNOKigFJPlyC99SVhMEgXw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F992830DCF;
 Wed, 21 Feb 2024 12:30:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F38CD492BC6;
 Wed, 21 Feb 2024 12:30:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF04621E66C8; Wed, 21 Feb 2024 13:30:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com,  mst@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  qemu-devel@nongnu.org,  berrange@redhat.com,
 yuri.benditovich@daynix.com,  yan@daynix.com,  akihiko.odaki@daynix.com
Subject: Re: [PATCH v9 4/5] qmp: Added new command to retrieve eBPF blob.
In-Reply-To: <20240205165437.1965981-5-andrew@daynix.com> (Andrew
 Melnychenko's message of "Mon, 5 Feb 2024 18:54:34 +0200")
References: <20240205165437.1965981-1-andrew@daynix.com>
 <20240205165437.1965981-5-andrew@daynix.com>
Date: Wed, 21 Feb 2024 13:30:49 +0100
Message-ID: <87ttm2gft2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> ---
>  ebpf/ebpf.c           | 69 +++++++++++++++++++++++++++++++++++++++++++
>  ebpf/ebpf.h           | 29 ++++++++++++++++++
>  ebpf/ebpf_rss.c       |  6 ++++
>  ebpf/meson.build      |  2 +-
>  qapi/ebpf.json        | 66 +++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build      |  1 +
>  qapi/qapi-schema.json |  1 +
>  7 files changed, 173 insertions(+), 1 deletion(-)
>  create mode 100644 ebpf/ebpf.c
>  create mode 100644 ebpf/ebpf.h
>  create mode 100644 qapi/ebpf.json
>
> diff --git a/ebpf/ebpf.c b/ebpf/ebpf.c
> new file mode 100644
> index 0000000000..2d73beb479
> --- /dev/null
> +++ b/ebpf/ebpf.c
> @@ -0,0 +1,69 @@
> +/*
> + * QEMU eBPF binary declaration routine.
> + *
> + * Developed by Daynix Computing LTD (http://www.daynix.com)
> + *
> + * Authors:
> + *  Andrew Melnychenko <andrew@daynix.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/queue.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-ebpf.h"
> +#include "ebpf/ebpf.h"
> +
> +typedef struct ElfBinaryDataEntry {
> +    int id;
> +    const void *data;
> +    size_t datalen;
> +
> +    QSLIST_ENTRY(ElfBinaryDataEntry) node;
> +} ElfBinaryDataEntry;
> +
> +static QSLIST_HEAD(, ElfBinaryDataEntry) ebpf_elf_obj_list =
> +                                            QSLIST_HEAD_INITIALIZER();
> +
> +void ebpf_register_binary_data(int id, const void *data, size_t datalen)
> +{
> +    struct ElfBinaryDataEntry *dataentry = NULL;
> +
> +    dataentry = g_new0(struct ElfBinaryDataEntry, 1);
> +    dataentry->data = data;
> +    dataentry->datalen = datalen;
> +    dataentry->id = id;
> +
> +    QSLIST_INSERT_HEAD(&ebpf_elf_obj_list, dataentry, node);
> +}
> +
> +const void *ebpf_find_binary_by_id(int id, size_t *sz, Error **errp)
> +{
> +    struct ElfBinaryDataEntry *it = NULL;
> +    QSLIST_FOREACH(it, &ebpf_elf_obj_list, node) {
> +        if (id == it->id) {
> +            *sz = it->datalen;
> +            return it->data;
> +        }
> +    }
> +
> +    error_setg(errp, "can't find eBPF object with id: %d", id);
> +
> +    return NULL;
> +}
> +
> +EbpfObject *qmp_request_ebpf(EbpfProgramID id, Error **errp)
> +{
> +    EbpfObject *ret = NULL;
> +    size_t size = 0;
> +    const void *data = ebpf_find_binary_by_id(id, &size, errp);
> +    if (!data) {
> +        return NULL;
> +    }
> +
> +    ret = g_new0(EbpfObject, 1);
> +    ret->object = g_base64_encode(data, size);
> +
> +    return ret;
> +}
> diff --git a/ebpf/ebpf.h b/ebpf/ebpf.h
> new file mode 100644
> index 0000000000..378d4e9c70
> --- /dev/null
> +++ b/ebpf/ebpf.h
> @@ -0,0 +1,29 @@
> +/*
> + * QEMU eBPF binary declaration routine.
> + *
> + * Developed by Daynix Computing LTD (http://www.daynix.com)
> + *
> + * Authors:
> + *  Andrew Melnychenko <andrew@daynix.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef EBPF_H
> +#define EBPF_H
> +
> +
> +void ebpf_register_binary_data(int id, const void *data,
> +                               size_t datalen);
> +const void *ebpf_find_binary_by_id(int id, size_t *sz,
> +                                   struct Error **errp);
> +
> +#define ebpf_binary_init(id, fn)                                           \
> +static void __attribute__((constructor)) ebpf_binary_init_ ## fn(void)     \
> +{                                                                          \
> +    size_t datalen = 0;                                                    \
> +    const void *data = fn(&datalen);                                       \
> +    ebpf_register_binary_data(id, data, datalen);                          \
> +}
> +
> +#endif /* EBPF_H */
> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> index 150aa40813..c8a68da2c5 100644
> --- a/ebpf/ebpf_rss.c
> +++ b/ebpf/ebpf_rss.c
> @@ -13,6 +13,8 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qapi/qapi-types-misc.h"
> +#include "qapi/qapi-commands-ebpf.h"
>  
>  #include <bpf/libbpf.h>
>  #include <bpf/bpf.h>
> @@ -21,6 +23,8 @@
>  
>  #include "ebpf/ebpf_rss.h"
>  #include "ebpf/rss.bpf.skeleton.h"
> +#include "ebpf/ebpf.h"
> +
>  #include "trace.h"
>  
>  void ebpf_rss_init(struct EBPFRSSContext *ctx)
> @@ -261,3 +265,5 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
>      ctx->map_toeplitz_key = -1;
>      ctx->map_indirections_table = -1;
>  }
> +
> +ebpf_binary_init(EBPF_PROGRAMID_RSS, rss_bpf__elf_bytes)
> diff --git a/ebpf/meson.build b/ebpf/meson.build
> index 2f627d6c7d..c5bf9295a2 100644
> --- a/ebpf/meson.build
> +++ b/ebpf/meson.build
> @@ -1 +1 @@
> -system_ss.add(when: libbpf, if_true: files('ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
> +common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
> diff --git a/qapi/ebpf.json b/qapi/ebpf.json
> new file mode 100644
> index 0000000000..f413d00154
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
> +# Since: 9.0
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
> +# Since: 9.0
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
> +# Since: 9.0
> +##
> +{ 'command': 'request-ebpf',
> +  'data': { 'id': 'EbpfProgramID' },
> +  'returns': 'EbpfObject',
> +  'if': 'CONFIG_EBPF' }
> diff --git a/qapi/meson.build b/qapi/meson.build
> index f81a37565c..375d564277 100644
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
> index c01ec335e6..8304d45625 100644
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


