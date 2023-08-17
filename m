Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E6177F7DC
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:38:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdCH-0003Cs-U9; Thu, 17 Aug 2023 09:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWdCF-0003CL-Dw
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWdCA-0000rW-QU
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692279469;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=py7VV6irdjVSfMcNcz9QEwd/ZhGYzC6obLh+uIM8KZQ=;
 b=IsaPUSzazNjpyh5v2UT+NccDtxX7WHNgwBT3dWJL/ggrTJuA/7wtfZ071huM1sdBecIhDi
 0TJ1lsoD5zNvzz15Jhf9bIvK3iUFW4WGyg72TiSz1KG2YWs+RFsHthEUgQbDK2IJ3FoUrr
 z4JMbecTh3UAfgG1BidnsgDlze8uZ5k=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-wSPae08KOiqN_oDjXEi5Gw-1; Thu, 17 Aug 2023 09:37:46 -0400
X-MC-Unique: wSPae08KOiqN_oDjXEi5Gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 336CF382C97D;
 Thu, 17 Aug 2023 13:37:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 302322026D68;
 Thu, 17 Aug 2023 13:37:45 +0000 (UTC)
Date: Thu, 17 Aug 2023 14:37:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZN4iporZWZGqc2gU@redhat.com>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807190736.572665-2-david@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 07, 2023 at 09:07:32PM +0200, David Hildenbrand wrote:
> From: Thiner Logoer <logoerthiner1@163.com>
> 
> Users may specify
> * "-mem-path" or
> * "-object memory-backend-file,share=off,readonly=off"
> and expect such COW (MAP_PRIVATE) mappings to work, even if the user
> does not have write permissions to open the file.
> 
> For now, we would always fail in that case, always requiring file write
> permissions. Let's detect when that failure happens and fallback to opening
> the file readonly.
> 
> Warn the user, since there are other use cases where we want the file to
> be mapped writable: ftruncate() and fallocate() will fail if the file
> was not opened with write permissions.
> 
> Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  softmmu/physmem.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 3df73542e1..d1ae694b20 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -1289,8 +1289,7 @@ static int64_t get_file_align(int fd)
>  static int file_ram_open(const char *path,
>                           const char *region_name,
>                           bool readonly,
> -                         bool *created,
> -                         Error **errp)
> +                         bool *created)
>  {
>      char *filename;
>      char *sanitized_name;
> @@ -1334,10 +1333,7 @@ static int file_ram_open(const char *path,
>              g_free(filename);
>          }
>          if (errno != EEXIST && errno != EINTR) {
> -            error_setg_errno(errp, errno,
> -                             "can't open backing store %s for guest RAM",
> -                             path);
> -            return -1;
> +            return -errno;
>          }
>          /*
>           * Try again on EINTR and EEXIST.  The latter happens when
> @@ -1946,9 +1942,23 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>      bool created;
>      RAMBlock *block;
>  
> -    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
> -                       errp);
> +    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created);
> +    if (fd == -EACCES && !(ram_flags & RAM_SHARED) && !readonly) {
> +        /*
> +         * We can have a writable MAP_PRIVATE mapping of a readonly file.
> +         * However, some operations like ftruncate() or fallocate() might fail
> +         * later, let's warn the user.
> +         */
> +        fd = file_ram_open(mem_path, memory_region_name(mr), true, &created);
> +        if (fd >= 0) {
> +            warn_report("backing store %s for guest RAM (MAP_PRIVATE) opened"
> +                        " readonly because the file is not writable", mem_path);

IIUC, from the description, the goal is that usage of a readonly
backing store is intented to be an explicitly supported deployment
configuration. At the time time though, this scenario could also be
a deployment mistake that we want to diagnose

It is inappropriate to issue warn_report() for things that are
supported usage.

It is also undesirable to continue execution in the case of things
which are a deployment mistake.

These two scenarios are mutually incompatible, so I understand why
you choose to fudge it with a warn_report().

I wonder if this is pointing to the need for another configuration
knob for the memory backend, to express the different desired usage
models.

We want O_WRONLY when opening the file, either if we want to file
shared, or so that we can ftruncate it to the right size, if it
does not exist. If shared=off and the file is pre-created at the
right size, we should be able to use O_RDONLY even if the file is
writable.

So what if we added a 'create=yes|no' option to memory-backend-file

   -object memory-backend-file,share=off,readonly=off,create=yes

would imply need for O_WRONLY|O_RDONLY, so that ftruncate() can
do its work. 

With share=off,create=no, we could unconditionally open O_RDONLY,
even if the file is writable.

This would let us support read-only backing files, without any
warn_reports() for this usage, while also stopping execution
with deployment mistakes

This doesn't help -mem-path, since it doesn't take options, but
IMHO it would be acceptable to say users need to use the more
verbose '-object memory-backend-file' instead.

> +        }
> +    }
>      if (fd < 0) {
> +        error_setg_errno(errp, -fd,
> +                         "can't open backing store %s for guest RAM",
> +                         mem_path);
>          return NULL;
>      }
>  
> -- 
> 2.41.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


