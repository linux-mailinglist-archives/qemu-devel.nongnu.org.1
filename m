Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0678C25C
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 12:36:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaw3n-0005tl-TW; Tue, 29 Aug 2023 06:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qaw3l-0005tY-4f
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 06:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qaw3i-0007ki-5Z
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 06:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693305292;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+LwsTJjFKnb2WcH55h/pW9tZmv7+qSHvl5gOfeAZ1Ig=;
 b=OGDjP6eidl+gpo6O5qnGBZ+4HWzSQmeK9c67Xqid60NLiH0jxexFPjY+Eake6XMy+6iwKN
 k/6lSPpIZuedGusqLKrXzAmfXraZ7FBJ4eFxbx9k1DGkpy4M26uRz/AOn6MTCEQbc+A1eq
 4IoJlGgh9/1xpnLjmoYW1Z84Eiuv14w=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-1gEgdCE8Pz-P3PPMYZA4zg-1; Tue, 29 Aug 2023 06:34:51 -0400
X-MC-Unique: 1gEgdCE8Pz-P3PPMYZA4zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01BFD1C05AF7
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:34:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8228E1121318;
 Tue, 29 Aug 2023 10:34:50 +0000 (UTC)
Date: Tue, 29 Aug 2023 11:34:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 02/10] meson: update unsupported host/CPU messages
Message-ID: <ZO3JyOmbfrLmD6pd@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829082931.67601-3-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Aug 29, 2023 at 10:29:23AM +0200, Paolo Bonzini wrote:
> Unsupported CPU and OSes are not really going away, but the
> project simply does not guarantee that they work.  Rephrase
> the messages accordingly.  While at it, move the warning for
> TCI performance at the end where it is more visible.

I think I agree wrt to CPUs, but in the case of OS I think
it is fairly accurate as-is.

When we bump the minimum version of libraries we will not
pay attention to unsupported OS, so it is entirely possible
to bump to a version that means the ability to run on an
OS goes away entirely (unless the user is willing to rebuild
packages at newer versions).

When writing #ifdefs for portability we also may explicitly
delete #ifdefs from unsupported OS platforms  if we consider
them obsolete enough. So again I think the ability to use an
unsupported OS may indeed goaway entirely.

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 98e68ef0b1e..02b035a3808 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -678,9 +678,7 @@ endif
>  tcg_arch = host_arch
>  if get_option('tcg').allowed()
>    if host_arch == 'unknown'
> -    if get_option('tcg_interpreter')
> -      warning('Unsupported CPU @0@, will use TCG with TCI (slow)'.format(cpu))
> -    else
> +    if not get_option('tcg_interpreter')
>        error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
>      endif
>    elif get_option('tcg_interpreter')
> @@ -4317,28 +4315,34 @@ summary_info += {'selinux':           selinux}
>  summary_info += {'libdw':             libdw}
>  summary(summary_info, bool_yn: true, section: 'Dependencies')
>  
> -if not supported_cpus.contains(cpu)
> +if host_arch == 'unknown'
>    message()
> -  warning('SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!')
> +  warning('UNSUPPORTED HOST CPU')
>    message()
> -  message('CPU host architecture ' + cpu + ' support is not currently maintained.')
> -  message('The QEMU project intends to remove support for this host CPU in')
> -  message('a future release if nobody volunteers to maintain it and to')
> -  message('provide a build host for our continuous integration setup.')
> -  message('configure has succeeded and you can continue to build, but')
> -  message('if you care about QEMU on this platform you should contact')
> -  message('us upstream at qemu-devel@nongnu.org.')
> +  message('Support for CPU host architecture ' + cpu + ' is not currently')
> +  message('maintained. The QEMU project does not guarantee that QEMU will')
> +  message('compile or work on this host CPU. You can help by volunteering')
> +  message('to maintain it and providing a build host for our continuous.')
> +  message('integration setup.')
>  endif
>  
>  if not supported_oses.contains(targetos)
>    message()
> -  warning('WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEASES!')
> +  warning('UNSUPPORTED HOST OS')
> +  message()
> +  message('Support for host OS ' + targetos + 'is not currently maintained.')
> +  message('The QEMU project does not guarantee that QEMU will compile or')
> +  message('work on this operating system. You can help by volunteering')
> +  message('to maintain it and providing a build host for our continuous.')
> +  message('integration setup.')
> +endif
> +
> +if host_arch == 'unknown' or not supported_oses.contains(targetos)
>    message()
> -  message('Host OS ' + targetos + 'support is not currently maintained.')
> -  message('The QEMU project intends to remove support for this host OS in')
> -  message('a future release if nobody volunteers to maintain it and to')
> -  message('provide a build host for our continuous integration setup.')
>    message('configure has succeeded and you can continue to build, but')
> +  if host_arch == 'unknown' and get_option('tcg').allowed() and target_dirs.length() > 0
> +    message('QEMU will use a slow interpreter to emulate the target CPU;')
> +  endif
>    message('if you care about QEMU on this platform you should contact')
>    message('us upstream at qemu-devel@nongnu.org.')
>  endif
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


