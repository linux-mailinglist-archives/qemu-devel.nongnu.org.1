Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F080CB11
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:31:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgMj-0007MK-Hs; Mon, 11 Dec 2023 08:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rCgMe-0007KT-3q
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:30:28 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rCgMR-0001zH-QY
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:30:27 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d06d4d685aso24784925ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702301410; x=1702906210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w5lk0S4MKk7kTfOoLt53+VBp8ju+IsHlYguOVxO1EDI=;
 b=GiRzx7rPEEbVDZMluSYtdE0smk4vio46pH75f2+PHDxElDECcOHfOyKI4N2btWzT+x
 SaTrXZXg2+xex1FRSwS4kX4rGZ7Q0XgQdp4eqaM7TZlQKMRQwQk8VeGZwvwxX5GUzo7d
 ootBC4MrzkwUU1U3uM3ZJKS9ug7dppKcNIfToqLhn+ZDG2PzOaqGu8fTNddreb6ubqn5
 uZjDO3BXNcPj9DtAPKijAfdAKLkA3+SSlU8YVokfbBBmKTuMi8lhnfH/hqojmX0+cLRg
 /PNN45J9Iz4fCFzXgcVI1EalfkpevpZnvGU9DtAYSuI/aU/v224+OR0VzZRt9RhgHhfl
 EBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702301410; x=1702906210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w5lk0S4MKk7kTfOoLt53+VBp8ju+IsHlYguOVxO1EDI=;
 b=PGgnnnmu744CGb0YyfGq+MKkiMsYkHFseWvMzBoypOerqtB64lppbv808X7FN6uXM9
 6JWJPgCAdBsLlQdCX4gYIY6E9FLA5VrJ0cgHL3sR82pZKijEKj6Rp2RD4oWFtZ2+jUxd
 xiMsKQcNtbXoF/qh0lgE3WD7hebl+7YX9zKpwNJ6xQwLT2Ja20VZdJV7w0yeqXNGB6oB
 WigJdFhtd9Yqf8UqJwIjir7zYpVwIvCT/1gI1nzRvrz2jiKw17cvjZAGGc8ceAHFjl+9
 87KuZe3QiRGc4+MePxjZvARNmg7tQVDSwA2LJYdJV6GXRb8EW4YMyMl2D0qLh+bIeMH2
 Lekw==
X-Gm-Message-State: AOJu0YxiZMgDTf7W8M+sLAXXBzhnLRJkmsMJiMo6zyOwS0HeUC17E0vG
 AAaCBWrxmIdQLvX4Ziva85g=
X-Google-Smtp-Source: AGHT+IH7f9dMbrWKKHGtFn0wixUPmi92es8e9nKvgfoDM7cj2AaxpCAE29rN3hvCZNHSox3fFT7iuQ==
X-Received: by 2002:a17:902:8301:b0:1d0:bcb2:4b8a with SMTP id
 bd1-20020a170902830100b001d0bcb24b8amr1553463plb.131.1702301410354; 
 Mon, 11 Dec 2023 05:30:10 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a170902e74c00b001d077da4ac4sm6543212plf.212.2023.12.11.05.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 05:30:09 -0800 (PST)
Message-ID: <44d8d424-33f4-4472-89f6-19b5fd2f359d@gmail.com>
Date: Mon, 11 Dec 2023 22:30:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] qmp: Added new command to retrieve eBPF blob.
Content-Language: en-US
To: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com,
 mst@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 berrange@redhat.com
Cc: yuri.benditovich@daynix.com, yan@daynix.com
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-5-andrew@daynix.com>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230831065140.496485-5-andrew@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2023/08/31 15:51, Andrew Melnychenko wrote:
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
>   ebpf/ebpf.c           | 70 +++++++++++++++++++++++++++++++++++++++++++
>   ebpf/ebpf.h           | 31 +++++++++++++++++++
>   ebpf/ebpf_rss.c       |  6 ++++
>   ebpf/meson.build      |  2 +-
>   qapi/ebpf.json        | 66 ++++++++++++++++++++++++++++++++++++++++
>   qapi/meson.build      |  1 +
>   qapi/qapi-schema.json |  1 +
>   7 files changed, 176 insertions(+), 1 deletion(-)
>   create mode 100644 ebpf/ebpf.c
>   create mode 100644 ebpf/ebpf.h
>   create mode 100644 qapi/ebpf.json
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

Use SPDX License Identifier. I had been asked the same thing but 
unfortunately it's not documented in docs/devel/style.rst.

> +
> +#include "qemu/osdep.h"
> +#include "qemu/queue.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-ebpf.h"
> +#include "ebpf/ebpf.h"
> +
> +struct ElfBinaryDataEntry {
> +    int id;
> +    const void *data;
> +    size_t datalen;
> +
> +    QSLIST_ENTRY(ElfBinaryDataEntry) node;
> +};

Add typedef. See docs/devel/style.rst.

> +
> +static QSLIST_HEAD(, ElfBinaryDataEntry) ebpf_elf_obj_list =
> +                                            QSLIST_HEAD_INITIALIZER();

Why don't you use GHashTable?

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

Why do you need this?

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
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
> +#include "qapi/qapi-types-misc.h"
> +#include "qapi/qapi-commands-ebpf.h"
>   
>   #include <bpf/libbpf.h>
>   #include <bpf/bpf.h>
> @@ -21,6 +23,8 @@
>   
>   #include "ebpf/ebpf_rss.h"
>   #include "ebpf/rss.bpf.skeleton.h"
> +#include "ebpf/ebpf.h"
> +
>   #include "trace.h"
>   
>   void ebpf_rss_init(struct EBPFRSSContext *ctx)
> @@ -261,3 +265,5 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
>       ctx->map_toeplitz_key = -1;
>       ctx->map_indirections_table = -1;
>   }
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

These need to be updated; we missed 8.2.

