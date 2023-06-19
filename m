Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4125B734F98
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:23:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBB6G-0006Ge-Nu; Mon, 19 Jun 2023 05:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qBB6E-0006Fj-Hb
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qBB6C-0002rE-Rm
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687166579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmKtW8HJc0NAQyaw2K4NO0cjStJ3CU6kcls924xHpm8=;
 b=NX9k/r5lA2oXCo+SPcDJrLi8VRkv2dtrUvg1gebNIiOCv+/JC67TmARV4x858D05/Ko/IU
 EjdTyv88H8mL/3eXeVcojEQ5yxmFK8P8pY7L2LXtpr/Cvhlksu6eFE6wRJEHSIWV7h/mAy
 nZ3a/f589UCT/auRyavqRtnHA2Fh+9E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-arkq29n1M9KVdlkmxfxNLg-1; Mon, 19 Jun 2023 05:22:55 -0400
X-MC-Unique: arkq29n1M9KVdlkmxfxNLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F2AE3C11C66;
 Mon, 19 Jun 2023 09:22:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7701112132C;
 Mon, 19 Jun 2023 09:22:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD07521E675B; Mon, 19 Jun 2023 11:22:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: qemu-devel@nongnu.org,  Zhangjin Wu <falcon@tinylab.org>,  Alberto Faria
 <afaria@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Nikita Ivanov <nivanov@cloudlinux.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Xuzhou Cheng <xuzhou.cheng@windriver.com>
Subject: Re: [PATCH v3 4/6] util/osdep: Introduce qemu_close_range()
References: <20230617053621.50359-1-bmeng@tinylab.org>
 <20230617053621.50359-5-bmeng@tinylab.org>
Date: Mon, 19 Jun 2023 11:22:53 +0200
In-Reply-To: <20230617053621.50359-5-bmeng@tinylab.org> (Bin Meng's message of
 "Sat, 17 Jun 2023 13:36:19 +0800")
Message-ID: <87a5wv24cy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Bin Meng <bmeng@tinylab.org> writes:

> This introduces a new QEMU API qemu_close_range() that closes all
> open file descriptors from first to last (included).
>
> This API will try a more efficient call to close_range(), or walk
> through of /proc/self/fd whenever these are possible, otherwise it
> falls back to a plain close loop.
>
> Co-developed-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
>
> ---
>
> Changes in v3:
> - fix win32 build failure
>
> Changes in v2:
> - new patch: "util/osdep: Introduce qemu_close_range()"
>
>  include/qemu/osdep.h |  1 +
>  util/osdep.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index cc61b00ba9..e22434ce10 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -560,6 +560,7 @@ int qemu_open_old(const char *name, int flags, ...);
>  int qemu_open(const char *name, int flags, Error **errp);
>  int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
>  int qemu_close(int fd);
> +int qemu_close_range(unsigned int first, unsigned int last);
>  int qemu_unlink(const char *name);
>  #ifndef _WIN32
>  int qemu_dup_flags(int fd, int flags);
> diff --git a/util/osdep.c b/util/osdep.c
> index e996c4744a..91275e70f8 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -30,6 +30,7 @@
>  #include "qemu/mprotect.h"
>  #include "qemu/hw-version.h"
>  #include "monitor/monitor.h"
> +#include <dirent.h>
>  
>  static const char *hw_version = QEMU_HW_VERSION;
>  
> @@ -411,6 +412,53 @@ int qemu_close(int fd)
>      return close(fd);
>  }
>  
> +int qemu_close_range(unsigned int first, unsigned int last)
> +{
> +    DIR *dir = NULL;
> +
> +#ifdef CONFIG_CLOSE_RANGE
> +    int r = close_range(first, last, 0);

close_range(2) explains flag

       CLOSE_RANGE_UNSHARE
              Unshare  the specified file descriptors from any other processes
              before closing them, avoiding races with other  threads  sharing
              the file descriptor table.

Can anybody explain the races this avoids?

> +    if (!r) {
> +        /* Success, no need to try other ways. */
> +        return 0;
> +    }

What are the failure modes of close_range() where the other ways are
worth trying?

> +#endif
> +
> +#ifdef __linux__
> +    dir = opendir("/proc/self/fd");
> +#endif
> +    if (!dir) {
> +        /*
> +         * If /proc is not mounted or /proc/self/fd is not supported,
> +         * try close() from first to last.
> +         */
> +        for (int i = first; i <= last; i++) {
> +            close(i);
> +        }
> +
> +        return 0;
> +    }
> +
> +#ifndef _WIN32
> +    /* Avoid closing the directory */
> +    int dfd = dirfd(dir);

This directory contains "." "..", "0", "1", ...

> +
> +    for (struct dirent *de = readdir(dir); de; de = readdir(dir)) {
> +        int fd = atoi(de->d_name);

Maps "." and ".." to 0.  Unclean.

Please use qemu_strtoi(de->d_name, NULL, 10, &fd), and skip entries
where it fails.

> +        if (fd < first || fd > last) {
> +            /* Exclude the fds outside the target range */
> +            continue;
> +        }
> +        if (fd != dfd) {
> +            close(fd);
> +        }
> +    }
> +    closedir(dir);
> +#endif /* _WIN32 */
> +
> +    return 0;
> +}

I'd prefer to order this from most to least preferred:

    close_range()
    iterate over /proc/self/fd
    iterate from first to last

Unlike close_range(), qemu_close_range() returns 0 when last < first.
If we want to deviate from close_range(), we better document the
differences.

This is a generalized version of async-teardown.c's close_all_open_fd().
I'd mention this in the commit message.  Suggestion, not demand.

> +
>  /*
>   * Delete a file from the filesystem, unless the filename is /dev/fdset/...
>   *


