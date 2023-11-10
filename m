Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA57E7B1F
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 11:01:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1OK2-0007AH-Uo; Fri, 10 Nov 2023 05:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r1OJw-00078b-I7
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:01:02 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r1OJp-0003Ll-0J
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:00:56 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DE60975A4C1;
 Fri, 10 Nov 2023 11:01:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D25EC75A4C0; Fri, 10 Nov 2023 11:01:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D0F3D75A4B8;
 Fri, 10 Nov 2023 11:01:08 +0100 (CET)
Date: Fri, 10 Nov 2023 11:01:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, jsnow@redhat.com
Subject: Re: [PATCH] tests: respect --enable/--disable-download for Avocado
In-Reply-To: <20231110093325.917900-1-pbonzini@redhat.com>
Message-ID: <95788d03-b854-996c-b8e3-981c79a1bb6c@eik.bme.hu>
References: <20231110093325.917900-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
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

On Fri, 10 Nov 2023, Paolo Bonzini wrote:
> Pass the content of $mkvenv_flags (which is either "--online"
> or empty) down to tests/Makefile.include.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> configure              | 9 +++++----
> tests/Makefile.include | 2 +-
> 2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/configure b/configure
> index abcb199aa87..2da3c278db6 100755
> --- a/configure
> +++ b/configure
> @@ -968,14 +968,14 @@ meson="$(cd pyvenv/bin; pwd)/meson"
>
> # Conditionally ensure Sphinx is installed.
>
> -mkvenv_flags=""
> -if test "$download" = "enabled" -a "$docs" = "enabled" ; then
> -    mkvenv_flags="--online"
> +mkvenv_online_flag=""
> +if test "$download" = "enabled" ; then
> +    mkvenv_online_flag=" --online"

Is leading space before -- intended? It does not seem to matter at usees 
below.

Regards,
BALATON Zolatn

> fi
>
> if test "$docs" != "disabled" ; then
>     if ! $mkvenv ensuregroup \
> -         $mkvenv_flags \
> +         $(test "$docs" = "enabled" && echo "$mkvenv_online_flag") \
>          ${source_path}/pythondeps.toml docs;
>     then
>         if test "$docs" = "enabled" ; then
> @@ -1631,6 +1631,7 @@ if test "$container" != no; then
> fi
> echo "SUBDIRS=$subdirs" >> $config_host_mak
> echo "PYTHON=$python" >> $config_host_mak
> +echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
> echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
> echo "MESON=$meson" >> $config_host_mak
> echo "NINJA=$ninja" >> $config_host_mak
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index dab1989a071..c9d1674bd07 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -111,7 +111,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
>
> $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
> 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> -	$(PYTHON) python/scripts/mkvenv.py ensuregroup --online $< avocado
> +	$(MKVENV_ENSUREGROUP) $< avocado
> 	$(call quiet-command, touch $@)
>
> $(TESTS_RESULTS_DIR):
>

