Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A27037135CE
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 18:50:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2x6p-0000pA-06; Sat, 27 May 2023 12:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q2x6m-0000ob-2N
 for qemu-devel@nongnu.org; Sat, 27 May 2023 12:49:36 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q2x6k-0001OU-3T
 for qemu-devel@nongnu.org; Sat, 27 May 2023 12:49:35 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C636E74638A;
 Sat, 27 May 2023 18:49:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8330774633D; Sat, 27 May 2023 18:49:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 816C9745720;
 Sat, 27 May 2023 18:49:27 +0200 (CEST)
Date: Sat, 27 May 2023 18:49:27 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, 
 berrange@redhat.com
Subject: Re: [PATCH 2/5] configure: rename --enable-pypi to --enable-download, 
 control subprojects too
In-Reply-To: <20230527092851.705884-3-pbonzini@redhat.com>
Message-ID: <923f7d6b-73c8-eeb0-2e3c-1c129126a950@eik.bme.hu>
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <20230527092851.705884-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1077911004-1685206167=:93563"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1077911004-1685206167=:93563
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 27 May 2023, Paolo Bonzini wrote:
> The behavior of --{enable,disable}-pypi is similar to that of
> -Dwrapmode={default,nodownload} respectively.  In particular,
> in both cases a feature needs to be explicitly enabled for the
> dependency to be downloaded.
>
> So, use a single option to control both cases.  Now, --enable-slirp
> will trigger cloning and building of libslirp if the .pc file
> is not found on the machine.
>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> configure              | 17 +++++++----------
> subprojects/.gitignore |  3 +++
> 2 files changed, 10 insertions(+), 10 deletions(-)
> create mode 100644 subprojects/.gitignore
>
> diff --git a/configure b/configure
> index 370e038e63d7..2f908660e4f1 100755
> --- a/configure
> +++ b/configure
> @@ -266,7 +266,7 @@ bsd_user=""
> plugins="$default_feature"
> ninja=""
> python=
> -pypi="enabled"
> +download="enabled"

Is this the default? Can it default to disabled so it won't download 
anytihng unless asked to do that? By default it should just report if 
something is missing and let the users decide how they want to install it.

Regards,
BALATON Zoltan

> bindir="bin"
> skip_meson=no
> vfio_user_server="disabled"
> @@ -756,9 +756,9 @@ for opt do
>   --with-git-submodules=*)
>       git_submodules_action="$optarg"
>   ;;
> -  --disable-pypi) pypi="disabled"
> +  --disable-download) download="disabled"
>   ;;
> -  --enable-pypi) pypi="enabled"
> +  --enable-download) download="enabled"
>   ;;
>   --enable-plugins) if test "$mingw32" = "yes"; then
>                         error_exit "TCG plugins not currently supported on Windows platforms"
> @@ -962,7 +962,7 @@ python="$(command -v "$python")"
> # - venv is allowed to use system packages;
> # - all setup can be performed offline;
> # - missing packages may be fetched from PyPI,
> -#   unless --disable-pypi is passed.
> +#   unless --disable-download is passed.
> # - pip is not installed into the venv when possible,
> #   but ensurepip is called as a fallback when necessary.
>
> @@ -979,7 +979,7 @@ python="$python -B"
> mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
>
> mkvenv_flags=""
> -if test "$pypi" = "enabled" ; then
> +if test "$download" = "enabled" ; then
>     mkvenv_flags="--online"
> fi
>
> @@ -1002,7 +1002,7 @@ meson="$(cd pyvenv/bin; pwd)/meson"
> # Conditionally ensure Sphinx is installed.
>
> mkvenv_flags=""
> -if test "$pypi" = "enabled" -a "$docs" = "enabled" ; then
> +if test "$download" = "enabled" -a "$docs" = "enabled" ; then
>     mkvenv_flags="--online"
> fi
>
> @@ -1942,11 +1942,8 @@ if test "$skip_meson" = no; then
>
>   rm -rf meson-private meson-info meson-logs
>
> -  # Prevent meson from automatically downloading wrapped subprojects when missing.
> -  # You can use 'meson subprojects download' before running configure.
> -  meson_option_add "--wrap-mode=nodownload"
> -
>   # Built-in options
> +  test "$download" = "disabled" && meson_option_add "--wrap-mode=nodownload"
>   test "$bindir" != "bin" && meson_option_add "-Dbindir=$bindir"
>   test "$default_feature" = no && meson_option_add -Dauto_features=disabled
>   test "$static" = yes && meson_option_add -Dprefer_static=true
> diff --git a/subprojects/.gitignore b/subprojects/.gitignore
> new file mode 100644
> index 000000000000..7560ebb0b1a0
> --- /dev/null
> +++ b/subprojects/.gitignore
> @@ -0,0 +1,3 @@
> +/packagecache
> +
> +/slirp
>
--3866299591-1077911004-1685206167=:93563--

