Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B137197DD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4f1p-0007pt-Ur; Thu, 01 Jun 2023 05:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4f1j-0007nc-EE
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4f1a-0006lP-W0
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685613317;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34JWIeUvG8wOxusmTQHP8jX1IRf1+5+KrqgdbCa3PNs=;
 b=IFkfSa0NWvyTxDNpcv8LZhDGf/ZVaLwljgA0dGElkgGLYrr1loS1Y3lft7yBh+UiNuXqoP
 vLE7WHIlgC87FTvhRhp1X2n5BxZnT7Ue9OCvshoOC0h7+HHrKx8xIbev7BQ4l3IDlNzfwG
 fvDqwz53ulZm2/oE3q4UY+zw6c7csuE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-3yNDAp0xNZelGxYMAIl_WQ-1; Thu, 01 Jun 2023 05:55:14 -0400
X-MC-Unique: 3yNDAp0xNZelGxYMAIl_WQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28050381494A;
 Thu,  1 Jun 2023 09:55:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B5CE170EB;
 Thu,  1 Jun 2023 09:55:11 +0000 (UTC)
Date: Thu, 1 Jun 2023 10:55:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Ed Maste <emaste@freebsd.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH 3/3] tests/vm/freebsd: Get up-to-date package list from
 lcitool vars file
Message-ID: <ZHhq9tvTtHQwHdm/@redhat.com>
References: <20230531200906.17790-1-philmd@linaro.org>
 <20230531200906.17790-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531200906.17790-4-philmd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, May 31, 2023 at 10:09:06PM +0200, Philippe Mathieu-Daudé wrote:
> See previous commit for rationale on using lcitool vars file to
> get an up-to-date package list. Since there is a such file generated
> for FreeBSD 13 available in the repository, use it. That way we
> don't need to manually keep this array in sync.
> 
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/vm/freebsd | 44 ++++----------------------------------------
>  1 file changed, 4 insertions(+), 40 deletions(-)
> 
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 6a0d7a4569..4f12878645 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -31,45 +31,7 @@ class FreeBSDVM(basevm.BaseVM):
>      link = "https://download.freebsd.org/releases/CI-IMAGES/13.2-RELEASE/amd64/Latest/FreeBSD-13.2-RELEASE-amd64-BASIC-CI.raw.xz"
>      csum = "a4fb3b6c7b75dd4d58fb0d75e4caf72844bffe0ca00e66459c028b198ffb3c0e"
>      size = "20G"
> -    pkgs = [
> -        # build tools
> -        "git",
> -        "pkgconf",
> -        "bzip2",
> -        "python39",
> -        "ninja",
> -
> -        # gnu tools
> -        "bash",
> -        "gmake",
> -        "gsed",
> -        "gettext",
> -
> -        # libs: crypto
> -        "gnutls",
> -
> -        # libs: images
> -        "jpeg-turbo",
> -        "png",
> -
> -        # libs: ui
> -        "sdl2",
> -        "gtk3",
> -        "libxkbcommon",
> -
> -        # libs: opengl
> -        "libepoxy",
> -        "mesa-libs",
> -
> -        # libs: migration
> -        "zstd",
> -
> -        # libs: networking
> -        "libslirp",
> -
> -        # libs: sndio
> -        "sndio",
> -    ]
> +    lcitool_vars = ".gitlab-ci.d/cirrus/freebsd-13.vars"

So we have various other distros in the tests/vm/ directory, for which
we have lcitool support, but for which there's no existing vars file.

I'm wondering if we're better off just putting the data files we need
directly in the tests/vm/ directory, and keeping it indepenant of the
cirrus CI data files. It is all auto-generated, so the duplication
would not be a maint burden.

eg just have a 'freebsd.json' file, alongside the 'freebsd' script.

We should also expand lcitool to cover haiku, netbsd and openbsd
distros one day.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


