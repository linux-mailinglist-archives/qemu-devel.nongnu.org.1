Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B710874F14C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:12:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJE5G-0008Ae-Ni; Tue, 11 Jul 2023 10:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJE59-00089Y-Rb
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJE57-0002DD-Q8
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689084669;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYaixrUq0WgF2Pnsw+f9MgnqeAE4P0hnrdM7xrpN4qw=;
 b=VzJhMWABlzjWgWotqgBx9p4Zzt+3nP62P5HMxQ0xPLL8f2tHkHIA1pyov0q6kgZ9JYABB2
 t/59U9iimGzlbwp65X7dx0za4f7pH96iUzgjwYA+ojdnGUJFzAAqqMy+rRokdyKa6UJ8Bz
 yhu6CL0r8NYcqEADUgalnKYoJa+Yh5k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-VWKwLr4NPZCzKCt27I8sXQ-1; Tue, 11 Jul 2023 10:11:02 -0400
X-MC-Unique: VWKwLr4NPZCzKCt27I8sXQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7977290999C;
 Tue, 11 Jul 2023 14:08:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10C4B492B03;
 Tue, 11 Jul 2023 14:08:45 +0000 (UTC)
Date: Tue, 11 Jul 2023 15:08:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kyle Evans <kevans@freebsd.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH v2 3/3] tests/vm/freebsd: Get up-to-date package list
 from lcitool vars file
Message-ID: <ZK1ibFZ0QKvZQTIB@redhat.com>
References: <20230711140143.65818-1-philmd@linaro.org>
 <20230711140143.65818-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711140143.65818-4-philmd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Tue, Jul 11, 2023 at 04:01:43PM +0200, Philippe Mathieu-Daudé wrote:
> Get an up-to-date package list from lcitool, that way we
> don't need to manually keep this array in sync.
> 
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/vm/Makefile.include |  2 ++
>  tests/vm/freebsd          | 42 ++-------------------------------------
>  2 files changed, 4 insertions(+), 40 deletions(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index b021b344b5..84b8ad5222 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -110,6 +110,8 @@ $(SRC_PATH)/tests/vm/%.json:
>  	$(call quiet-command, \
>  		make lcitool-refresh)
>  
> +vm-build-freebsd: $(SRC_PATH)/tests/vm/freebsd.json

I don't think we need this, as we just commit the result of
lcitool as needed.

> +
>  # Build in VM $(IMAGE)
>  vm-build-%: $(IMAGES_DIR)/%.img $(VM_VENV)
>  	$(call quiet-command, \
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 11de6473f4..ac51376c82 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -31,45 +31,6 @@ class FreeBSDVM(basevm.BaseVM):
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
>  
>      BUILD_SCRIPT = """
>          set -e;
> @@ -151,8 +112,9 @@ class FreeBSDVM(basevm.BaseVM):
>          self.console_wait(prompt)
>          self.console_send("echo 'chmod 666 /dev/vtbd1' >> /etc/rc.local\n")
>  
> +        pkgs = self.get_qemu_packages_from_lcitool_json()
>          self.print_step("Installing packages")
> -        self.ssh_root_check("pkg install -y %s\n" % " ".join(self.pkgs))
> +        self.ssh_root_check("pkg install -y %s\n" % " ".join(pkgs))
>  
>          # shutdown
>          self.ssh_root(self.poweroff)
> -- 
> 2.38.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


