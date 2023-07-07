Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF2174B32A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:42:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHmdt-00079p-Su; Fri, 07 Jul 2023 10:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHmds-00079U-7m
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHmdq-0003VU-LI
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688740862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hYIyBZ+rUb67sVKnRW6QZK8ToqbojqvpWsJwzkm4McE=;
 b=XyjVqBkwMHgeB0bIfg8cUyAdN38+7EGnADVS9G0ov45BVRtdoR7ZOAncmBKgF2Ow1AaG0x
 dVtrDTV2CfDk5XlmNVn1mSBKt0VKHPzZaBL4zOTmXhK9tLYSSS+u4Tfuq+crROfmRRzmW8
 lnu0Z3iJMncR9ZMxPqVxbfh1pEQHl8c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-z1hHXmPpOf2c-5bra258BQ-1; Fri, 07 Jul 2023 10:40:57 -0400
X-MC-Unique: z1hHXmPpOf2c-5bra258BQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3AA988D06E;
 Fri,  7 Jul 2023 14:40:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81C78C52D9C;
 Fri,  7 Jul 2023 14:40:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 895A421E6A1F; Fri,  7 Jul 2023 16:40:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhangjin Wu <falcon@tinylab.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 5/6] util/async-teardown: Use qemu_close_range() to
 close fds
References: <20230628152726.110295-1-bmeng@tinylab.org>
 <20230628152726.110295-6-bmeng@tinylab.org>
Date: Fri, 07 Jul 2023 16:40:55 +0200
In-Reply-To: <20230628152726.110295-6-bmeng@tinylab.org> (Bin Meng's message
 of "Wed, 28 Jun 2023 23:27:25 +0800")
Message-ID: <875y6vg4y0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

> From: Zhangjin Wu <falcon@tinylab.org>
>
> Based on the old close_all_open_fd() of util/async-teardown.c, a new
> generic qemu_close_range() has been added in osdep.c.
>
> Now, let's switch over to use the generic qemu_close_range().
>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
>
> ---
>
> Changes in v4:
> - call sysconf directly instead of using a variable
>
> Changes in v3:
> - limit the last_fd of qemu_close_range() to sysconf(_SC_OPEN_MAX)
>
> Changes in v2:
> - new patch: "util/async-teardown: Use qemu_close_range() to close fds"
>
>  util/async-teardown.c | 41 +----------------------------------------
>  1 file changed, 1 insertion(+), 40 deletions(-)
>
> diff --git a/util/async-teardown.c b/util/async-teardown.c
> index 7e0177a8da..a038a255ff 100644
> --- a/util/async-teardown.c
> +++ b/util/async-teardown.c
> @@ -29,44 +29,6 @@
>  
>  static pid_t the_ppid;
>  
> -/*
> - * Close all open file descriptors.
> - */
> -static void close_all_open_fd(void)
> -{
> -    struct dirent *de;
> -    int fd, dfd;
> -    DIR *dir;
> -
> -#ifdef CONFIG_CLOSE_RANGE
> -    int r = close_range(0, ~0U, 0);
> -    if (!r) {
> -        /* Success, no need to try other ways. */
> -        return;
> -    }
> -#endif
> -
> -    dir = opendir("/proc/self/fd");
> -    if (!dir) {
> -        /* If /proc is not mounted, close fds one by one. */
> -        int open_max = sysconf(_SC_OPEN_MAX), i;
> -        for (i = 0; i < open_max; i++) {
> -                close(i);
> -        }
> -        return;
> -    }
> -    /* Avoid closing the directory. */
> -    dfd = dirfd(dir);
> -
> -    for (de = readdir(dir); de; de = readdir(dir)) {
> -        fd = atoi(de->d_name);
> -        if (fd != dfd) {
> -            close(fd);
> -        }
> -    }
> -    closedir(dir);
> -}
> -
>  static void hup_handler(int signal)
>  {
>      /* Check every second if this process has been reparented. */
> @@ -92,9 +54,8 @@ static int async_teardown_fn(void *arg)
>      /*
>       * Close all file descriptors that might have been inherited from the
>       * main qemu process when doing clone, needed to make libvirt happy.
> -     * Not using close_range for increased compatibility with older kernels.
>       */
> -    close_all_open_fd();
> +    qemu_close_range(0, sysconf(_SC_OPEN_MAX) - 1);

Why do you change the upper bound from ~0U to sysconf(_SC_OPEN_MAX) - 1?

>  
>      /* Set up a handler for SIGHUP and unblock SIGHUP. */
>      sigaction(SIGHUP, &sa, NULL);


