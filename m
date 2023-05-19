Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE8709300
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:25:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwMj-0000BR-Nw; Fri, 19 May 2023 05:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzwMY-0000Ab-TP
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzwMW-00058v-99
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684488323;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wTFB2Uvk1/XS6ztbNDkDvlALzdUmeOqYlzwgzEjaH9I=;
 b=IC5m4sl9NAScq/9eIakthE2YZ1IDWcxqTQLcueXRblx1UMTjI4275c6+K/Z+9UANAHpfK8
 PLOxwL2/7EPbDYnCcHcH7ywqzzBCHUdw4XUcN3Jg+MnAR8p+hmzLXxMSbF9H6l/2NLWpzm
 xpmYV+No9nic6Z7/OXhyAR0LrAEOcdo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-hjPLHZNpPMWhAWOIdbJQZQ-1; Fri, 19 May 2023 05:25:20 -0400
X-MC-Unique: hjPLHZNpPMWhAWOIdbJQZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B028185A78F;
 Fri, 19 May 2023 09:25:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 539D940D1B60;
 Fri, 19 May 2023 09:25:17 +0000 (UTC)
Date: Fri, 19 May 2023 10:25:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Subject: Re: [PATCH 6/6] meson: subprojects: replace submodules with wrap files
Message-ID: <ZGdAezBL/QBX2DzX@redhat.com>
References: <20230519085647.1104775-1-pbonzini@redhat.com>
 <20230519085647.1104775-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519085647.1104775-7-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, May 19, 2023 at 10:56:46AM +0200, Paolo Bonzini wrote:
> Compared to submodules, .wrap files have several advantages:
> 
> * option parsing and downloading is delegated to meson
> 
> * the commit is stored in a text file instead of a magic entry in the
>   git tree object

This avoids one of the big pain points with submodules, in that
when switching branches you often end up with dirty submodules,
which then get accidentally added to the commit. IIUC, with wrap,
when switching branches, meson should automatically update the
wrap to the right git hash and re-buld as needed. I think most
people would consider this along to be sufficient reason to
drop submodules.

> * we could stop shipping external dependencies that are only used as a
>   fallback, but not break compilation on platforms that lack them.
>   For example it may make sense to download dtc at build time,
>   controlled by --enable-download, even when building from a tarball.
>   This is _not_ done in this patch.

IIUC, you actually added code to make-release to avoid doing this.

Considering each lib

 * dtc - the distro should always have it anyway
 * libvfio-user - don't think this has found its way
                  into any distros yet. So if we don't
		  bundle it, distros have to pacakge it
		  or re-bundle with their QEMU bulds
 * keycodemapdb - has always been intended to be a copylib,
                  not packaged separately by distros. In
		  retrospect I think this wa probably a
		  mistake. None the less today, it will
		  need to be re-bundled by distros if we
		  omitted it.

I think there's a decent case to be made for 'dtc' to be dropped
from 'make-release', but keep the other two.

> dependency() can fall back to a wrap automatically.  However, this
> is only possible for libraries that come with a .pc file, and this
> is not very common for libfdt even though the upstream project in
> principle provides it; it also removes the control that we provide with
> --enable-fdt={system,internal}.  Therefore, the logic to pick system
> vs. internal libfdt is left untouched.
> 
> It is possible to use subprojects also for berkeley-softfloat-3
> and berkeley-testfloat-3, but this is left for later.
>mak 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitlab-ci.d/buildtest-template.yml |  1 +
>  .gitmodules                         |  9 -----
>  configure                           | 54 +++++------------------------
>  meson.build                         | 17 ++-------
>  meson_options.txt                   |  1 +
>  scripts/archive-source.sh           | 11 ++++--
>  scripts/make-release                |  5 +++
>  subprojects/.gitignore              |  3 ++
>  subprojects/dtc                     |  1 -
>  subprojects/dtc.wrap                |  4 +++
>  subprojects/keycodemapdb            |  1 -
>  subprojects/keycodemapdb.wrap       |  4 +++
>  subprojects/libvfio-user            |  1 -
>  subprojects/libvfio-user.wrap       |  4 +++
>  14 files changed, 41 insertions(+), 75 deletions(-)
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

Why is this addition needed ?  Isn't meson supposd to automatically
download the wrapped subprojects it needs without explicit user
action ?

> diff --git a/meson_options.txt b/meson_options.txt
> index 972c458b80b4..635a2bfd351f 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -296,6 +296,7 @@ option('capstone', type: 'feature', value: 'auto',
>         description: 'Whether and how to find the capstone library')
>  option('fdt', type: 'combo', value: 'auto',
>         choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
> +       deprecated: { 'git': 'internal' },
>         description: 'Whether and how to find the libfdt library')

Do we need to deprecate this, as opposed to removing it ?

We've considered build time options to not be subject to a deprecation
process, just documenting changes in the release notes.

>  
>  option('selinux', type: 'feature', value: 'auto',
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index dba5ae05b67e..b99cb66e4122 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -26,8 +26,8 @@ sub_file="${sub_tdir}/submodule.tar"
>  # independent of what the developer currently has initialized
>  # in their checkout, because the build environment is completely
>  # different to the host OS.
> -submodules="subprojects/dtc subprojects/keycodemapdb"
> -submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
> +subprojects="dtc keycodemapdb libvfio-user"
> +submodules="tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
>  sub_deinit=""
>  
>  function cleanup() {
> @@ -70,4 +70,11 @@ for sm in $submodules; do
>      tar --concatenate --file "$tar_file" "$sub_file"
>      test $? -ne 0 && error "failed append submodule $sm to $tar_file"
>  done
> +
> +for sp in $subprojects; do
> +    meson subprojects download $sp
> +    test $? -ne 0 && error "failed to download subproject $sp"
> +    tar --append --file "$tar_file" --exclude=.git subprojects/$sp
> +    test $? -ne 0 && error "failed to append subproject $sp to $tar_file"
> +done
>  exit 0
> diff --git a/scripts/make-release b/scripts/make-release
> index 44a9d86a04a7..0604e61b8143 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -16,6 +16,9 @@ if [ $# -ne 2 ]; then
>      exit 0
>  fi
>  
> +# Only include wraps that are invoked with subproject()
> +SUBPROJECTS="dtc libvfio-user keycodemapdb"
> +
>  src="$1"
>  version="$2"
>  destination=qemu-${version}
> @@ -26,6 +29,8 @@ git clone --single-branch -b "v${version}" -c advice.detachedHead=false \
>  pushd ${destination}
>  
>  git submodule update --init --single-branch
> +meson subprojects download $SUBPROJECTS
> +
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
>  (cd roms/skiboot && ./make_version.sh > .version)
>  # Fetch edk2 submodule's submodules, since it won't have access to them via

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


