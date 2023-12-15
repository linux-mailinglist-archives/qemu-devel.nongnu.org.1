Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 620E3814726
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:42:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6Zn-0005wG-TU; Fri, 15 Dec 2023 06:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rE6Zl-0005w8-N3
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:41:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rE6Zh-0007NF-IS
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702640507;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RcGT/f4QiVoWjmiqJaWfkSmGZlRLrJpFFrlUYRoeKb8=;
 b=XsZfh61gpHqCFU+kqdOaHbR8ZnODSgBNINP3uW+9wGBXoGMqlducx7RTo5vj0DuRN1wF9v
 tFy5rdqQQz3C/YwTgKqjCYTVkqCyS9MkRGTRPxx+nRzF/00eSSxDJRB2W+1U+aim2ZXbL4
 jQ2uBBICQrceFmt3EkiBLp4pp9dDZZo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-0Ix6gEXeMjiaD0piCmJ2Mg-1; Fri,
 15 Dec 2023 06:41:44 -0500
X-MC-Unique: 0Ix6gEXeMjiaD0piCmJ2Mg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC50C280D580;
 Fri, 15 Dec 2023 11:41:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 926BD1C060B1;
 Fri, 15 Dec 2023 11:41:42 +0000 (UTC)
Date: Fri, 15 Dec 2023 11:41:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, sw@weilnetz.de,
 t.lamprecht@proxmox.com
Subject: Re: [PATCH] qemu_init: increase NOFILE soft limit on POSIX
Message-ID: <ZXw7dO9U94c82_LW@redhat.com>
References: <20231212143250.677668-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212143250.677668-1-f.ebner@proxmox.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Tue, Dec 12, 2023 at 03:32:50PM +0100, Fiona Ebner wrote:
> In many configurations, e.g. multiple vNICs with multiple queues or
> with many Ceph OSDs, the default soft limit of 1024 is not enough.
> QEMU is supposed to work fine with file descriptors >= 1024 and does
> not use select() on POSIX. Bump the soft limit to the allowed hard
> limit to avoid issues with the aforementioned configurations.
> 
> Of course the limit could be raised from the outside, but the man page
> of systemd.exec states about 'LimitNOFILE=':
> 
> > Don't use.
> > [...]
> > Typically applications should increase their soft limit to the hard
> > limit on their own, if they are OK with working with file
> > descriptors above 1023,
> 
> Buglink: https://bugzilla.proxmox.com/show_bug.cgi?id=4507
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  include/sysemu/os-posix.h |  1 +
>  include/sysemu/os-win32.h |  5 +++++
>  os-posix.c                | 18 ++++++++++++++++++
>  system/vl.c               |  2 ++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
> index dff32ae185..b881ac6c6f 100644
> --- a/include/sysemu/os-posix.h
> +++ b/include/sysemu/os-posix.h
> @@ -51,6 +51,7 @@ bool is_daemonized(void);
>  void os_daemonize(void);
>  bool os_set_runas(const char *user_id);
>  void os_set_chroot(const char *path);
> +void os_setup_limits(void);
>  void os_setup_post(void);
>  int os_mlock(void);
>  
> diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
> index 1047d260cb..106f155037 100644
> --- a/include/sysemu/os-win32.h
> +++ b/include/sysemu/os-win32.h
> @@ -128,6 +128,11 @@ static inline int os_mlock(void)
>      return -ENOSYS;
>  }
>  
> +void os_setup_limits(void)
> +{
> +    return;
> +}
> +
>  #define fsync _commit
>  
>  #if !defined(lseek)
> diff --git a/os-posix.c b/os-posix.c
> index 52ef6990ff..eb55473140 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -24,6 +24,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include <sys/resource.h>
>  #include <sys/wait.h>
>  #include <pwd.h>
>  #include <grp.h>
> @@ -256,6 +257,23 @@ void os_daemonize(void)
>      }
>  }
>  
> +void os_setup_limits(void)
> +{
> +    struct rlimit nofile;
> +
> +    if (getrlimit(RLIMIT_NOFILE, &nofile) < 0) {
> +        warn_report("unable to query NOFILE limit: %s", strerror(errno));
> +        return;
> +    }
> +

I'd suggest to return here, if cur == max, to avoid the
redundant setrlimit call. This will avoid a needless
warning message if someone used a strict seccomp filter
to block setrlimit, and had raisd NOFILE before QEMU was
execd

> +    nofile.rlim_cur = nofile.rlim_max;
> +
> +    if (setrlimit(RLIMIT_NOFILE, &nofile) < 0) {
> +        warn_report("unable to set NOFILE limit: %s", strerror(errno));
> +        return;
> +    }
> +}
> +
>  void os_setup_post(void)
>  {
>      int fd = 0;
> diff --git a/system/vl.c b/system/vl.c
> index 2bcd9efb9a..6f42f37200 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2774,6 +2774,8 @@ void qemu_init(int argc, char **argv)
>      error_init(argv[0]);
>      qemu_init_exec_dir(argv[0]);
>  
> +    os_setup_limits();
> +
>      qemu_init_arch_modules();
>  
>      qemu_init_subsystems();
> -- 
> 2.39.2
> 
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


