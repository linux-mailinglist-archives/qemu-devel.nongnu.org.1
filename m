Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 379B076B974
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 18:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrwZ-0000Gh-2W; Tue, 01 Aug 2023 12:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQrwW-0000GI-HN
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQrwU-00017K-VB
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690906190;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3jlf1MkWdbf/UtqlIfptqNSUiTuTzDBYgygdeKM62dM=;
 b=FZRI74Lb6KG/NN6sMv5LE9rD4IJHv7FuDh6kOWrJdYcc94lDTPWKISLUWWLTqAp66Iw14H
 IlzuEpoYKHGDbjC2UAlj8Xt6wDnrvfdBci9V6MjEWr94OdWjIxiZmsBxohhTNR5UtP52g7
 0E8uGrrmy5aKxYC3+Wn9UJXVTKxsqoQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-GYPhoJKfMI2qR75Jxa02Pw-1; Tue, 01 Aug 2023 12:09:48 -0400
X-MC-Unique: GYPhoJKfMI2qR75Jxa02Pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 482DA104458B;
 Tue,  1 Aug 2023 16:09:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87D604024F83;
 Tue,  1 Aug 2023 16:09:47 +0000 (UTC)
Date: Tue, 1 Aug 2023 17:09:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Helge Deller <deller@gmx.de>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] linux-user: Fix openat() emulation to correctly detect
 accesses to /proc
Message-ID: <ZMkuSZL/fZ6CO934@redhat.com>
References: <ZMkdsWHTeHT2+lF2@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMkdsWHTeHT2+lF2@p100>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On Tue, Aug 01, 2023 at 04:58:57PM +0200, Helge Deller wrote:
> In qemu we catch accesses to files like /proc/cpuinfo or /proc/net/route
> and return to the guest contents which would be visible on a real system
> (instead what the host would show).
> 
> This patch fixes a bug, where for example the accesses
>     cat /proc////cpuinfo
> or
>     cd /proc && cat cpuinfo
> will not be recognized by qemu and where qemu will wrongly show
> the contents of the host's /proc/cpuinfo file.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 917c388073..bb864c2bb3 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8531,9 +8531,11 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
>  }
>  #endif
> 
> -int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
> +int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>                      int flags, mode_t mode, bool safe)
>  {
> +    char proc_name[PATH_MAX];

No PATH_MAX buffers declared on the stack please.

> +    const char *pathname;
>      struct fake_open {
>          const char *filename;
>          int (*fill)(CPUArchState *cpu_env, int fd);
> @@ -8560,6 +8562,13 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
>          { NULL, NULL, NULL }
>      };
> 
> +    /* if this is a file from /proc/ filesystem, expand full name */
> +    if (realpath(fname, proc_name) && strncmp(proc_name, "/proc/", 6) == 0) {

QEMU relies on the extended semantics of realpath() where passing NULL
for 'proc_name' causes it to allocate a buffer of the correct size and
return the new buffer. Using that avoids PATH_MAX variables.

> +        pathname = proc_name;
> +    } else {
> +        pathname = fname;
> +    }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


