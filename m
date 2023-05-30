Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44185715F18
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:24:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yOs-00069j-19; Tue, 30 May 2023 08:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3yOU-0005ts-L9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3yOS-00087F-0U
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449443;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CCB1GNbGaXAThY+smdMkigoPZbSmcZwWvegZ4UqElG4=;
 b=DDx6feaKIA7Y4FkWLR7zVtpt/8/KFFvbOlVminzNAuQ5HyjVPb6USgbKVn957lvZ8BElR8
 rVOJcz8oGFXeoJAVp5zAcHYWS/X2cdc1lUWnxg8IyV/joifUJZU+OPq8wic9d1RGr6cjDp
 ie/bhA6W4dhPlT4/KODm3Imy3EU3Vw4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-smRYLgrnNbepWIMd8o2WpQ-1; Tue, 30 May 2023 08:24:01 -0400
X-MC-Unique: smRYLgrnNbepWIMd8o2WpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C53553C11C9B;
 Tue, 30 May 2023 12:24:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA7672166B25;
 Tue, 30 May 2023 12:23:59 +0000 (UTC)
Date: Tue, 30 May 2023 13:23:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com
Subject: Re: [PATCH 3/5] meson: subprojects: replace submodules with wrap files
Message-ID: <ZHXq3fDd14O9yIcA@redhat.com>
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <20230527092851.705884-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230527092851.705884-4-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Sat, May 27, 2023 at 11:28:49AM +0200, Paolo Bonzini wrote:
> Compared to submodules, .wrap files have several advantages:
> 
> * option parsing and downloading is delegated to meson
> 
> * the commit is stored in a text file instead of a magic entry in the
>   git tree object
> 
> * we could stop shipping external dependencies that are only used as a
>   fallback, but not break compilation on platforms that lack them.
>   For example it may make sense to download dtc at build time, controlled
>   by --enable-download, even when building from a tarball.  Right now,
>   this patch does the opposite: make-release treats dtc like libvfio-user
>   (which is not stable API and therefore hasn't found its way into any
>   distros) and keycodemap (which is a copylib, for better or worse).
> 
> dependency() can fall back to a wrap automatically.  However, this
> is only possible for libraries that come with a .pc file, and this
> is not very common for libfdt even though the upstream project in
> principle provides it; it also removes the control that we provide with
> --enable-fdt={system,internal}.  Therefore, the logic to pick system
> vs. internal libfdt is left untouched.
> 
> --enable-fdt=git is removed; it was already a synonym for
> --enable-fdt=internal.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitlab-ci.d/buildtest-template.yml |  1 +
>  .gitmodules                         |  9 ----
>  configure                           | 75 ++++++++++++-----------------
>  meson.build                         | 15 +-----
>  scripts/archive-source.sh           | 11 ++++-
>  scripts/make-release                |  5 ++
>  subprojects/.gitignore              |  3 ++
>  subprojects/dtc                     |  1 -
>  subprojects/dtc.wrap                |  4 ++
>  subprojects/keycodemapdb            |  1 -
>  subprojects/keycodemapdb.wrap       |  4 ++
>  subprojects/libvfio-user            |  1 -
>  subprojects/libvfio-user.wrap       |  4 ++
>  13 files changed, 61 insertions(+), 73 deletions(-)
>  delete mode 160000 subprojects/dtc
>  create mode 100644 subprojects/dtc.wrap
>  delete mode 160000 subprojects/keycodemapdb
>  create mode 100644 subprojects/keycodemapdb.wrap
>  delete mode 160000 subprojects/libvfio-user
>  create mode 100644 subprojects/libvfio-user.wrap
> 
> diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> index c9f2e737c09a..3c997d7265b2 100644
> --- a/.gitlab-ci.d/buildtest-template.yml
> +++ b/.gitlab-ci.d/buildtest-template.yml
> @@ -44,6 +44,7 @@
>    script:
>      - scripts/git-submodule.sh update
>          $(sed -n '/GIT_SUBMODULES=/ s/.*=// p' build/config-host.mak)
> +    - meson subprojects download $(cd build/subprojects && echo *)
>      - cd build
>      - find . -type f -exec touch {} +
>      # Avoid recompiling by hiding ninja with NINJA=":"
> diff --git a/.gitmodules b/.gitmodules
> index f8b2ddf3877c..a934c85e4e40 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -13,9 +13,6 @@
>  [submodule "roms/qemu-palcode"]
>  	path = roms/qemu-palcode
>  	url = https://gitlab.com/qemu-project/qemu-palcode.git
> -[submodule "subprojects/dtc"]
> -	path = subprojects/dtc
> -	url = https://gitlab.com/qemu-project/dtc.git
>  [submodule "roms/u-boot"]
>  	path = roms/u-boot
>  	url = https://gitlab.com/qemu-project/u-boot.git
> @@ -25,9 +22,6 @@
>  [submodule "roms/QemuMacDrivers"]
>  	path = roms/QemuMacDrivers
>  	url = https://gitlab.com/qemu-project/QemuMacDrivers.git
> -[submodule "subprojects/keycodemapdb"]
> -	path = subprojects/keycodemapdb
> -	url = https://gitlab.com/qemu-project/keycodemapdb.git
>  [submodule "roms/seabios-hppa"]
>  	path = roms/seabios-hppa
>  	url = https://gitlab.com/qemu-project/seabios-hppa.git
> @@ -55,6 +49,3 @@
>  [submodule "tests/lcitool/libvirt-ci"]
>  	path = tests/lcitool/libvirt-ci
>  	url = https://gitlab.com/libvirt/libvirt-ci.git
> -[submodule "subprojects/libvfio-user"]
> -	path = subprojects/libvfio-user
> -	url = https://gitlab.com/qemu-project/libvfio-user.git
> diff --git a/configure b/configure
> index 2f908660e4f1..1d1b8736c0eb 100755
> --- a/configure
> +++ b/configure
> @@ -253,7 +253,7 @@ else
>      git_submodules_action="ignore"
>  fi
>  
> -git_submodules="subprojects/keycodemapdb"
> +git_submodules=""
>  git="git"
>  debug_tcg="no"
>  docs="auto"
> @@ -269,7 +269,6 @@ python=
>  download="enabled"
>  bindir="bin"
>  skip_meson=no
> -vfio_user_server="disabled"
>  use_containers="yes"
>  gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
>  gdb_arches=""
> @@ -281,16 +280,13 @@ unset target_list_exclude
>  
>  # The following Meson options are handled manually (still they
>  # are included in the automatically generated help message)
> -
> -# 1. Track which submodules are needed
> -fdt="auto"
> -
> -# 2. Automatically enable/disable other options
> +# because they automatically enable/disable other options
>  tcg="auto"
>  cfi="false"
>  
> -# 3. Need to check for -static-pie before Meson runs.  Also,
> -# Meson has PIE as a boolean rather than enabled/disabled/auto.
> +# Meson has PIE as a boolean rather than enabled/disabled/auto,
> +# and we also need to check for -static-pie before Meson runs
> +# which requires knowing whether --static is enabled.
>  pie=""
>  static="no"
>  
> @@ -743,14 +739,6 @@ for opt do
>    ;;
>    --disable-cfi) cfi="false"
>    ;;
> -  --disable-fdt) fdt="disabled"
> -  ;;
> -  --enable-fdt) fdt="enabled"
> -  ;;
> -  --enable-fdt=git) fdt="internal"
> -  ;;
> -  --enable-fdt=*) fdt="$optarg"
> -  ;;
>    --with-git=*) git="$optarg"
>    ;;
>    --with-git-submodules=*)
> @@ -774,10 +762,6 @@ for opt do
>    ;;
>    --gdb=*) gdb_bin="$optarg"
>    ;;
> -  --enable-vfio-user-server) vfio_user_server="enabled"
> -  ;;
> -  --disable-vfio-user-server) vfio_user_server="disabled"
> -  ;;
>    # everything else has the same name in configure and meson
>    --*) meson_option_parse "$opt" "$optarg"
>    ;;
> @@ -789,6 +773,30 @@ if test "$plugins" = "yes" -a "$tcg" = "disabled"; then
>      error_exit "Can't enable plugins on non-TCG builds"
>  fi
>  
> +if ! test -f "$source_path/subprojects/keycodemapdb/README" \
> +    && test -f "$download" = disabled
> +then
> +    echo
> +    echo "ERROR: missing subprojects"
> +    echo
> +    if test -e "$source_path/.git"; then
> +        echo "--disable-download specified but subprojects were not"
> +        echo "checked out.  Please download subprojects."

Building from tarball will be ok as we bundle everything affected. This
errror will hit anyone building from git with --disable-download though.

How should developers/users download the subprojects ? Can we tell them
what command is needed ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


