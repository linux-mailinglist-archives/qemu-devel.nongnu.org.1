Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A488E74F7A9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 20:00:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJHdX-0001Jq-B6; Tue, 11 Jul 2023 13:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJHdU-0001JN-68
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJHdO-00053k-IC
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689098325;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7OSLBJ9BwkmiTeXQvCdYRuxkTKCuhd2Y+Jkl9sqRJ4I=;
 b=CjjBRu23bN+11j00IBID7GVV+56TVtEfR3zxbs0zCszj1NV+OOp3StvI/qk9yRlb7qgR6R
 BOrPnN0c3HG7wul3G4yi1hlQ/dxz33CKF8k/eJLLu1EH98yitzAPKOdhX3mL1p+c4IxVGN
 NgNa2osr08hz7rDhr8mf/P4shEB4f0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-CacN7Ri6PPmOnOWBETS16A-1; Tue, 11 Jul 2023 13:58:41 -0400
X-MC-Unique: CacN7Ri6PPmOnOWBETS16A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE96393A1AA;
 Tue, 11 Jul 2023 17:53:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94772492B01;
 Tue, 11 Jul 2023 17:58:37 +0000 (UTC)
Date: Tue, 11 Jul 2023 18:58:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v3 2/4] tests/lcitool: Refresh generated files
Message-ID: <ZK2YS0v5G3iKyXwJ@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711144922.67491-3-philmd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Tue, Jul 11, 2023 at 04:49:20PM +0200, Philippe Mathieu-Daudé wrote:
> Refresh the generated files by running:
> 
>   $ make lcitool-refresh
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-amd64.docker |  2 -
>  tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
>  tests/docker/dockerfiles/ubuntu2204.docker   |  2 -

I don't know why this would be removing xen/pmem from these files. If
I run 'lcitool-refresh' on current git master that doesn't happen

Do you have any other local changes on top ?

>  tests/vm/generated/freebsd.json              | 77 ++++++++++++++++++++
>  4 files changed, 77 insertions(+), 6 deletions(-)
>  create mode 100644 tests/vm/generated/freebsd.json

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
> index e39871c7bb..8f7521fdc2 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -70,7 +70,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                        libpam0g-dev \
>                        libpcre2-dev \
>                        libpixman-1-dev \
> -                      libpmem-dev \
>                        libpng-dev \
>                        libpulse-dev \
>                        librbd-dev \
> @@ -96,7 +95,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                        libvdeplug-dev \
>                        libvirglrenderer-dev \
>                        libvte-2.91-dev \
> -                      libxen-dev \
>                        libzstd-dev \
>                        llvm \
>                        locales \
> diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
> index 8f864d19e6..7f60143cbb 100644
> --- a/tests/docker/dockerfiles/ubuntu2004.docker
> +++ b/tests/docker/dockerfiles/ubuntu2004.docker
> @@ -69,7 +69,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                        libpam0g-dev \
>                        libpcre2-dev \
>                        libpixman-1-dev \
> -                      libpmem-dev \
>                        libpng-dev \
>                        libpulse-dev \
>                        librbd-dev \
> @@ -94,7 +93,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                        libvdeplug-dev \
>                        libvirglrenderer-dev \
>                        libvte-2.91-dev \
> -                      libxen-dev \
>                        libzstd-dev \
>                        llvm \
>                        locales \
> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
> index 1d442cdfe6..5162927016 100644
> --- a/tests/docker/dockerfiles/ubuntu2204.docker
> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
> @@ -70,7 +70,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                        libpam0g-dev \
>                        libpcre2-dev \
>                        libpixman-1-dev \
> -                      libpmem-dev \
>                        libpng-dev \
>                        libpulse-dev \
>                        librbd-dev \
> @@ -96,7 +95,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                        libvdeplug-dev \
>                        libvirglrenderer-dev \
>                        libvte-2.91-dev \
> -                      libxen-dev \
>                        libzstd-dev \
>                        llvm \
>                        locales \
> diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
> new file mode 100644
> index 0000000000..7c435cf23e
> --- /dev/null
> +++ b/tests/vm/generated/freebsd.json
> @@ -0,0 +1,77 @@
> +{
> +  "ccache": "/usr/local/bin/ccache",
> +  "cpan_pkgs": [],
> +  "cross_pkgs": [],
> +  "make": "/usr/local/bin/gmake",
> +  "ninja": "/usr/local/bin/ninja",
> +  "packaging_command": "pkg",
> +  "pip3": "/usr/local/bin/pip-3.8",
> +  "pkgs": [
> +    "alsa-lib",
> +    "bash",
> +    "bison",
> +    "bzip2",
> +    "ca_root_nss",
> +    "capstone4",
> +    "ccache",
> +    "cmocka",
> +    "ctags",
> +    "curl",
> +    "cyrus-sasl",
> +    "dbus",
> +    "diffutils",
> +    "dtc",
> +    "flex",
> +    "fusefs-libs3",
> +    "gettext",
> +    "git",
> +    "glib",
> +    "gmake",
> +    "gnutls",
> +    "gsed",
> +    "gtk3",
> +    "json-c",
> +    "libepoxy",
> +    "libffi",
> +    "libgcrypt",
> +    "libjpeg-turbo",
> +    "libnfs",
> +    "libslirp",
> +    "libspice-server",
> +    "libssh",
> +    "libtasn1",
> +    "llvm",
> +    "lzo2",
> +    "meson",
> +    "mtools",
> +    "ncurses",
> +    "nettle",
> +    "ninja",
> +    "opencv",
> +    "pixman",
> +    "pkgconf",
> +    "png",
> +    "py39-numpy",
> +    "py39-pillow",
> +    "py39-pip",
> +    "py39-sphinx",
> +    "py39-sphinx_rtd_theme",
> +    "py39-yaml",
> +    "python3",
> +    "rpm2cpio",
> +    "sdl2",
> +    "sdl2_image",
> +    "snappy",
> +    "sndio",
> +    "socat",
> +    "spice-protocol",
> +    "tesseract",
> +    "usbredir",
> +    "virglrenderer",
> +    "vte3",
> +    "xorriso",
> +    "zstd"
> +  ],
> +  "pypi_pkgs": [],
> +  "python": "/usr/local/bin/python3"
> +}
> -- 
> 2.38.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


