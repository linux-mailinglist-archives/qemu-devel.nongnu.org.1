Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C37A32A12
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Feb 2025 16:31:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEhD-0007UF-SD; Wed, 12 Feb 2025 10:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tiEhB-0007Qg-0h
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:30:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tiEh9-0003eG-19
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739374233;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0q0QDyM3dBcxVTHlENW/ROJGrK21PkmZCoyy0Clf1XA=;
 b=bdkr/CzZxV4ZO46enkB00qO1y4RqY5lUxRf1eF1MZOKIDY6FiR4uUmvFwrguPoO2wWz7mu
 vs/+nEGrY8Oxv6xMYbg9Gp22b83oG6kRnn8NHGjcjxasGvwU44lpGbDT/l7+mg30ky02WF
 o4KgAqvMEl3H+7wdutfB/DI9y4CNVng=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-0txfMj4BMO-kS93YzkUVzw-1; Wed,
 12 Feb 2025 10:30:30 -0500
X-MC-Unique: 0txfMj4BMO-kS93YzkUVzw-1
X-Mimecast-MFC-AGG-ID: 0txfMj4BMO-kS93YzkUVzw_1739374229
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17B861956094; Wed, 12 Feb 2025 15:30:29 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B95D41955F1B; Wed, 12 Feb 2025 15:30:25 +0000 (UTC)
Date: Wed, 12 Feb 2025 15:30:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
Message-ID: <Z6y-jdFOCVz8mEXo@redhat.com>
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Feb 12, 2025 at 05:39:17PM +0300, Daniil Tatianin wrote:
> This will be used in the following commits to make it possible to only
> lock memory on fault instead of right away.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  include/system/os-posix.h |  2 +-
>  include/system/os-win32.h |  3 ++-
>  meson.build               |  6 ++++++
>  migration/postcopy-ram.c  |  2 +-
>  os-posix.c                | 14 ++++++++++++--
>  system/vl.c               |  2 +-
>  6 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> index b881ac6c6f..ce5b3bccf8 100644
> --- a/include/system/os-posix.h
> +++ b/include/system/os-posix.h
> @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
>  void os_set_chroot(const char *path);
>  void os_setup_limits(void);
>  void os_setup_post(void);
> -int os_mlock(void);
> +int os_mlock(bool on_fault);
>  
>  /**
>   * qemu_alloc_stack:
> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> index b82a5d3ad9..cd61d69e10 100644
> --- a/include/system/os-win32.h
> +++ b/include/system/os-win32.h
> @@ -123,8 +123,9 @@ static inline bool is_daemonized(void)
>      return false;
>  }
>  
> -static inline int os_mlock(void)
> +static inline int os_mlock(bool on_fault)
>  {
> +    (void)on_fault;

Is this really needed ? Our compiler flags don't enable warnings
about unused variables.

If they did, this would not be the way to hide them. Instead you
would use the "G_GNUC_UNUSED" annotation against the parameter.
eg

  static inline int os_mlock(bool on_fault G_GNUC_UNUSED)

>      return -ENOSYS;
>  }
>  
> diff --git a/os-posix.c b/os-posix.c
> index 9cce55ff2f..17b144c0a2 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -327,18 +327,28 @@ void os_set_line_buffering(void)
>      setvbuf(stdout, NULL, _IOLBF, 0);
>  }
>  
> -int os_mlock(void)
> +int os_mlock(bool on_fault)
>  {
>  #ifdef HAVE_MLOCKALL
>      int ret = 0;
> +    int flags = MCL_CURRENT | MCL_FUTURE;
>  
> -    ret = mlockall(MCL_CURRENT | MCL_FUTURE);
> +#ifdef HAVE_MLOCK_ONFAULT
> +    if (on_fault) {
> +        flags |= MCL_ONFAULT;
> +    }
> +#else
> +    (void)on_fault;
> +#endif
> +
> +    ret = mlockall(flags);
>      if (ret < 0) {
>          error_report("mlockall: %s", strerror(errno));
>      }
>  
>      return ret;
>  #else
> +    (void)on_fault;
>      return -ENOSYS;
>  #endif

Again casting to (void) should not be required AFAIK.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


