Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3D69183D7
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jun 2024 16:22:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMTVz-0000pk-Mk; Wed, 26 Jun 2024 10:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMTVy-0000pY-4N
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMTVv-0007Om-VZ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719411646;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyZaLxL1fVded8yAr7hUAFouf/feJ7a7gDZYQs8G4Q4=;
 b=cVkU6bQxB0iYw8vZQAeKe9JmIuL8n3MyJzS1HOroq3e+TIN3Fwl4XcKPIxNq7kyyonhJc6
 VTaVtsijQxbKrn9hVjt2xoUUWtKKmVfGsLmP3dwvy0v7lj9gVBnoHwIWR1mRSkOwIh0K/R
 e3qRI4YKMLra3uS8BfHSDgq94DuxZnw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-PPS9qjKuMu6tYtsyqgDPrg-1; Wed,
 26 Jun 2024 10:20:43 -0400
X-MC-Unique: PPS9qjKuMu6tYtsyqgDPrg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBE5F1955DE1; Wed, 26 Jun 2024 14:20:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C789B1956050; Wed, 26 Jun 2024 14:20:39 +0000 (UTC)
Date: Wed, 26 Jun 2024 15:20:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH] target/i386: restrict SEV to 64 bit host builds
Message-ID: <ZnwjtOxQy1iiRoFh@redhat.com>
References: <20240626140307.1026816-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626140307.1026816-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 26, 2024 at 03:03:07PM +0100, Alex Bennée wrote:
> Re-enabling the 32 bit host build on i686 showed the recently merged
> SEV code doesn't take enough care over its types. While the format
> strings could use more portable types there isn't much we can do about
> casting uint64_t into a pointer. The easiest solution seems to be just
> to disable SEV for a 32 bit build. It's highly unlikely anyone would
> want this functionality anyway.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/i386/sev.h       | 2 +-
>  target/i386/meson.build | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/sev.h b/target/i386/sev.h
> index 858005a119..b0cb9dd7ed 100644
> --- a/target/i386/sev.h
> +++ b/target/i386/sev.h
> @@ -45,7 +45,7 @@ typedef struct SevKernelLoaderContext {
>      size_t cmdline_size;
>  } SevKernelLoaderContext;
>  
> -#ifdef CONFIG_SEV
> +#if defined(CONFIG_SEV) && defined(HOST_X86_64)
>  bool sev_enabled(void);
>  bool sev_es_enabled(void);
>  bool sev_snp_enabled(void);
> diff --git a/target/i386/meson.build b/target/i386/meson.build
> index 075117989b..d2a008926c 100644
> --- a/target/i386/meson.build
> +++ b/target/i386/meson.build
> @@ -6,7 +6,7 @@ i386_ss.add(files(
>    'xsave_helper.c',
>    'cpu-dump.c',
>  ))
> -i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confidential-guest.c'))
> +i386_ss.add(when: ['CONFIG_SEV', 'HOST_X86_64'], if_true: files('host-cpu.c', 'confidential-guest.c'))
>  
>  # x86 cpu type
>  i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
> @@ -21,7 +21,7 @@ i386_system_ss.add(files(
>    'cpu-apic.c',
>    'cpu-sysemu.c',
>  ))
> -i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
> +i386_system_ss.add(when: ['CONFIG_SEV', 'HOST_X86_64'], if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
>  
>  i386_user_ss = ss.source_set()

Instead of changing each usage of CONFIG_SEV, is it better to
prevent it getting enabled in the first place ?

eg. move

  #CONFIG_SEV=n

From

  configs/devices/i386-softmmu/default.mak

to

  configs/devices/x86_64-softmmu/default.mak

And then also change

  hw/i386/Kconfig

to say

  config SEV
      bool
      select X86_FW_OVMF
      depends on KVM && X86_64


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


