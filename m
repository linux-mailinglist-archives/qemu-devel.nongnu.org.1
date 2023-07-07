Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62574B32B
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:42:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHmdg-00077F-RZ; Fri, 07 Jul 2023 10:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHmdb-00076W-3m
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHmdW-0003PW-Jb
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688740841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qYWvEDzUv1opQE0IR1GjEypVajFGs0nLDNPYaAGg0uQ=;
 b=SP6jpmIMPxbjJJzMtd0Yt3xzP4Hq3VpbstVyYC/A8G3D42v7V7RMtr6YQVDTTHpuGyJSR4
 5Hu6JlDBVflF/gRDACi3YY4cK/0FLrlyQa/ePYC+Gnu0qZqOHcZ1vVInYdJSDc5aduXGH1
 9/minKqcTgkWEV88/CGa16g79pz+/eY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-432kc122MHCGl8wUcUYiiQ-1; Fri, 07 Jul 2023 10:40:40 -0400
X-MC-Unique: 432kc122MHCGl8wUcUYiiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D93868022EF;
 Fri,  7 Jul 2023 14:40:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25E741121330;
 Fri,  7 Jul 2023 14:40:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1998C21E6A1F; Fri,  7 Jul 2023 16:40:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhangjin Wu <falcon@tinylab.org>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini
 <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Xuzhou Cheng
 <xuzhou.cheng@windriver.com>
Subject: Re: [PATCH v4 4/6] util/osdep: Introduce qemu_close_range()
References: <20230628152726.110295-1-bmeng@tinylab.org>
 <20230628152726.110295-5-bmeng@tinylab.org>
Date: Fri, 07 Jul 2023 16:40:38 +0200
In-Reply-To: <20230628152726.110295-5-bmeng@tinylab.org> (Bin Meng's message
 of "Wed, 28 Jun 2023 23:27:24 +0800")
Message-ID: <877crbg4yh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
> Changes in v4:
> - add 'first > last' check logic
> - reorder the ifdefs logic
> - change i to unsigned int type
> - use qemu_strtoi() instead of atoi()
> - limit last upper value to sysconf(_SC_OPEN_MAX) - 1
>
> Changes in v3:
> - fix win32 build failure
>
> Changes in v2:
> - new patch: "util/osdep: Introduce qemu_close_range()"
>
>  include/qemu/osdep.h |  1 +
>  util/osdep.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
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
> index e996c4744a..1d8c719b3f 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -411,6 +411,66 @@ int qemu_close(int fd)
>      return close(fd);
>  }
>  
> +int qemu_close_range(unsigned int first, unsigned int last)
> +{
> +    if (first > last) {
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +#ifndef _WIN32
> +    if (last >= sysconf(_SC_OPEN_MAX)) {
> +        last = sysconf(_SC_OPEN_MAX) - 1;
> +    }
> +#endif
> +
> +#ifdef CONFIG_CLOSE_RANGE
> +    int r = close_range(first, last, 0);

TOCTTOU if sysconf(_SC_OPEN_MAX) can change at run time.

Say the caller passes ~0U to @last, like the example program in
close_range()'s manual page does.

Since this is larger than sysconf(_SC_OPEN_MAX), we clamp it to
sysconf(_SC_OPEN_MAX).  If the actual value increases before we get to
call close_range(), we can fail to close all fds.

Can't happen if we simply drop the clamping.

> +    if (!r) {
> +        /* Success, no need to try other ways */
> +        return 0;
> +    }
> +#endif

What are the failure modes of close_range() where the other ways are
worth trying?  I asked this in review of v3, and you replied it should
only ever fail when first > last, which you catch before getting here in
v4.

Why not simply return r?

> +
> +#ifdef __linux__
> +    DIR *dir = opendir("/proc/self/fd");
> +    if (dir) {
> +        /* Avoid closing the directory */
> +        int dfd = dirfd(dir);
> +
> +        for (struct dirent *de = readdir(dir); de; de = readdir(dir)) {
> +            int fd, ret;
> +
> +            ret = qemu_strtoi(de->d_name, NULL, 10, &fd);
> +            if (ret) {
> +                /* skip "." and ".." */

Anything that isn't a decimal integer, actually.  Should be just "." and
".." in practice.

> +                continue;
> +            }
> +            if (fd < first || fd > last) {

Not clamping @last is just fine here.

> +                /* Exclude the fds outside the target range */

Suggest to put this comment right before the if.

> +                continue;
> +            }
> +            if (fd != dfd) {
> +                close(fd);
> +            }

Do we still need this now we skip "."?

> +        }
> +        closedir(dir);
> +
> +        return 0;
> +    }
> +#endif
> +
> +    /*
> +     * If /proc is not mounted or /proc/self/fd is not supported,
> +     * try close() from first to last.
> +     */
> +    for (unsigned int i = first; i <= last; i++) {

Here, we do need to stop at sysconf(_SC_OPEN_MAX) - 1.  Recommend to
move the clamping before this loop.

Still a TOCTTOU, but acceptable here, because this fallback is
fundamentally racy no matter what.

> +        close(i);
> +    }
> +
> +    return 0;
> +}
> +
>  /*
>   * Delete a file from the filesystem, unless the filename is /dev/fdset/...
>   *


