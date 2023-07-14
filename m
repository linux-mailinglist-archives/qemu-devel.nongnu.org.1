Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D0753320
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKD9X-0008P4-Ij; Fri, 14 Jul 2023 03:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qKD9V-0008Oe-Um
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qKD9T-000229-Qv
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689319421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CczqcZPjthTIFjHLgdyykkQfTtGC75of5V9+yZ0pgD4=;
 b=gLyCLo/Kocb8JluSLvzFwgDyVFe0P4+CNU4pDipilBkLouqefvU1pW87qm1F8yGegWnMSg
 brYmNx2m0SdILsgmmVmxtQ9/qUiYmNNn4PN6sI6KuYAQ7BWvhz5JYcHmpIyTG4iJgBlvJc
 wTAZyZigH/vhdyoiDip3LYv1o/VF+44=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-glrU6B1bPeiK_Gn6Qe18MA-1; Fri, 14 Jul 2023 03:23:37 -0400
X-MC-Unique: glrU6B1bPeiK_Gn6Qe18MA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 790EA1C172A8;
 Fri, 14 Jul 2023 07:23:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C92940C2063;
 Fri, 14 Jul 2023 07:23:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A17E21E6A1F; Fri, 14 Jul 2023 09:23:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com,  mst@redhat.com,  eblake@redhat.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,
 yuri.benditovich@daynix.com,  yan@daynix.com
Subject: Re: [PATCH v4 4/6] ebpf: Added declaration/initialization routines.
References: <20230714022358.2438995-1-andrew@daynix.com>
 <20230714022358.2438995-5-andrew@daynix.com>
Date: Fri, 14 Jul 2023 09:23:36 +0200
In-Reply-To: <20230714022358.2438995-5-andrew@daynix.com> (Andrew
 Melnychenko's message of "Fri, 14 Jul 2023 05:23:56 +0300")
Message-ID: <87jzv3gdmv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> Now, the binary objects may be retrieved by id.
> It would require for future qmp commands that may require specific
> eBPF blob.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  ebpf/ebpf.c      | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
>  ebpf/ebpf.h      | 31 +++++++++++++++++++++
>  ebpf/ebpf_rss.c  |  6 +++++
>  ebpf/meson.build |  2 +-
>  4 files changed, 108 insertions(+), 1 deletion(-)
>  create mode 100644 ebpf/ebpf.c
>  create mode 100644 ebpf/ebpf.h
>
> diff --git a/ebpf/ebpf.c b/ebpf/ebpf.c
> new file mode 100644
> index 0000000000..ea97c0403e
> --- /dev/null
> +++ b/ebpf/ebpf.c
> @@ -0,0 +1,70 @@
> +/*
> + * QEMU eBPF binary declaration routine.
> + *
> + * Developed by Daynix Computing LTD (http://www.daynix.com)
> + *
> + * Authors:
> + *  Andrew Melnychenko <andrew@daynix.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/queue.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-ebpf.h"

Does not compile:

    ../ebpf/ebpf.c:16:10: fatal error: qapi/qapi-commands-ebpf.h: No such file or directory

The header doesn't exist until you add qapi/ebpf.json in the next
commit.

> +#include "ebpf/ebpf.h"
> +
> +struct ElfBinaryDataEntry {
> +    int id;
> +    const void *data;
> +    size_t datalen;
> +
> +    QSLIST_ENTRY(ElfBinaryDataEntry) node;
> +};
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
> index 0000000000..b6266b28b8
> --- /dev/null
> +++ b/ebpf/ebpf.h
> @@ -0,0 +1,31 @@
> +/*
> + * QEMU eBPF binary declaration routine.
> + *
> + * Developed by Daynix Computing LTD (http://www.daynix.com)
> + *
> + * Authors:
> + *  Andrew Melnychenko <andrew@daynix.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef EBPF_H
> +#define EBPF_H
> +
> +struct Error;
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
> index 24bc6cc409..8679dc452d 100644
> --- a/ebpf/ebpf_rss.c
> +++ b/ebpf/ebpf_rss.c
> @@ -13,6 +13,8 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qapi/qapi-types-misc.h"
> +#include "qapi/qapi-commands-ebpf.h"

Likewise.

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
> index 2f627d6c7d..c9bbaa7c90 100644
> --- a/ebpf/meson.build
> +++ b/ebpf/meson.build
> @@ -1 +1 @@
> -system_ss.add(when: libbpf, if_true: files('ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
> +common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
> \ No newline at end of file


