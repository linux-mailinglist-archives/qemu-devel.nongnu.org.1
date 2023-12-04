Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96619803B05
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:59:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rACHV-0007eT-0K; Mon, 04 Dec 2023 11:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rACHR-0007eI-QV
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rACHP-0000mY-LN
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701709126;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XcxkHW69UoO0Cs53r/u2qkdX3q8m8NqSnGfjgapDHgs=;
 b=fZOld+K9rm+k4qqJwHK8rSPhNRy1LuPgg7ewI1I1Dfs244ZzVHhoRaERLKiph43rKI2e/p
 VT8s7TjelYqOvihJy+7vJfcppEsBP2R4O0emhseCAqFyqYrYkZQW2aH4ic3sHtuVpmJEKp
 5C0BjxtiZQVSeTDajDA45zx6YnFzhpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-ogAMW_t-OHWH7tIZbfM-Ew-1; Mon, 04 Dec 2023 11:58:38 -0500
X-MC-Unique: ogAMW_t-OHWH7tIZbfM-Ew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 680BC811E8D;
 Mon,  4 Dec 2023 16:58:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2252B2166B26;
 Mon,  4 Dec 2023 16:58:36 +0000 (UTC)
Date: Mon, 4 Dec 2023 16:58:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Shu-Chun Weng <scw@google.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] linux-user: Fix openat() emulation to not modify atime
Message-ID: <ZW4FOs3LwSyVD7Xf@redhat.com>
References: <20231201032140.2470599-1-scw@google.com>
 <20231201032140.2470599-3-scw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201032140.2470599-3-scw@google.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 30, 2023 at 07:21:40PM -0800, Shu-Chun Weng wrote:
> Commit b8002058 strengthened openat()'s /proc detection by calling
> realpath(3) on the given path, which allows various paths and symlinks
> that points to the /proc file system to be intercepted correctly.
> 
> Using realpath(3), though, has a side effect that it reads the symlinks
> along the way, and thus changes their atime. The results in the
> following code snippet already get ~now instead of the real atime:
> 
>   int fd = open("/path/to/a/symlink", O_PATH | O_NOFOLLOW);
>   struct stat st;
>   fstat(fd, st);
>   return st.st_atime;
> 
> This change opens a path that doesn't appear to be part of /proc
> directly and checks the destination of /proc/self/fd/n to determine if
> it actually refers to a file in /proc.
> 
> Neither this nor the existing code works with symlinks or indirect paths
> (e.g.  /tmp/../proc/self/exe) that points to /proc/self/exe because it
> is itself a symlink, and both realpath(3) and /proc/self/fd/n will
> resolve into the location of QEMU.

I wonder if we can detect that by opening with O_NOFOLLOW, then
calling fstatfs() on the FD, and checking f_type == PROCFS_SUPER_MAGIC


> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e384e14248..25e2cda10a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8308,8 +8308,6 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
>  int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>                      int flags, mode_t mode, bool safe)
>  {
> -    g_autofree char *proc_name = NULL;
> -    const char *pathname;
>      struct fake_open {
>          const char *filename;
>          int (*fill)(CPUArchState *cpu_env, int fd);
> @@ -8333,13 +8331,39 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>  #endif
>          { NULL, NULL, NULL }
>      };
> +    char pathname[PATH_MAX];
>  
> -    /* if this is a file from /proc/ filesystem, expand full name */
> -    proc_name = realpath(fname, NULL);
> -    if (proc_name && strncmp(proc_name, "/proc/", 6) == 0) {
> -        pathname = proc_name;
> +    if (strncmp(fname, "/proc/", 6) == 0) {
> +        pstrcpy(pathname, sizeof(pathname), fname);
>      } else {
> -        pathname = fname;
> +        char procpath[PATH_MAX];
> +        int fd, n;
> +
> +        if (safe) {
> +            fd = safe_openat(dirfd, path(fname), flags, mode);
> +        } else {
> +            fd = openat(dirfd, path(fname), flags, mode);
> +        }
> +        if (fd < 0) {
> +            return fd;
> +        }
> +
> +        /*
> +         * Try to get the real path of the file we just opened. We avoid calling
> +         * `realpath(3)` because it calls `readlink(2)` on symlinks which
> +         * changes their atime. Note that since `/proc/self/exe` is a symlink,
> +         * `pathname` will never resolves to it (neither will `realpath(3)`).
> +         * That's why we check `fname` against the "/proc/" prefix first.
> +         */
> +        snprintf(procpath, sizeof(procpath), "/proc/self/fd/%d", fd);

g_strdup_printf() + g_autofree to avoid this PATH_MAX buffer

> +        n = readlink(procpath, pathname, sizeof(pathname));
> +        pathname[n < sizeof(pathname) ? n : sizeof(pathname)] = '\0';

If you call lstat() then sb_size will tell you how big the buffer
needs to be for a subsequent readlink(), whcih can be allocated
on the heap and released with g_autofree, avoiding the othuer PATH_MAX
buffer

> +
> +        /* if this is not a file from /proc/ filesystem, the fd is good as-is */
> +        if (strncmp(pathname, "/proc/", 6) != 0) {
> +            return fd;
> +        }
> +        close(fd);
>      }
>  
>      if (is_proc_myself(pathname, "exe")) {
> @@ -8390,9 +8414,9 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>      }
>  
>      if (safe) {
> -        return safe_openat(dirfd, path(pathname), flags, mode);
> +        return safe_openat(dirfd, pathname, flags, mode);
>      } else {
> -        return openat(dirfd, path(pathname), flags, mode);
> +        return openat(dirfd, pathname, flags, mode);
>      }
>  }
>  
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


