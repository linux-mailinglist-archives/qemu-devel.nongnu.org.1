Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F84771C46
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 10:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSvZb-0001sU-Ue; Mon, 07 Aug 2023 04:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qSvZV-0001sK-4u
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:26:37 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qSvZJ-0003XX-BV
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:26:36 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so67765851fa.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1691396773; x=1692001573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6lxac/Z6cGusMzwSeZ4RiPlf+0fXBAutxdF6RHqUGnA=;
 b=BUdwyDNQf0m6atzQfm6SGSVuo+q6PzvfjsoTxtY0A3mL7DSsOf94ABMn2d7gyhXO0W
 K9iaP9f1uhQ91aeLjg31MhS8Pbjjy3WVVvpB4cOOL4o9c//RZZId4Zfine8/u1sGYyWL
 dfLzu72B4+XCd6tPiJsd+RVuPXX7Xg1p5hjMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691396773; x=1692001573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lxac/Z6cGusMzwSeZ4RiPlf+0fXBAutxdF6RHqUGnA=;
 b=gaaH167Jcrmg2rv47y2GDQ4WVQmAxN1pIuNA/bucDPPC+3wjkU9Dc+zoBQINnm/ytx
 BGFsoSQyiRoIkUJeuDE0zKib9tb+FHrNcrXvN2qAblsVlT0S6dc/N6MU6lAOre0N7ZpA
 In21vmX7TJIxEHKFGrU8QdKgkF/DeXA+pLEDDRXWa3ir839xqhm8HUFN5BTfGHUdG4Tx
 4HTFEJ1cLedde3TFria8WKifrXaVpKCVUnIBfBcKgYp98pO468ejoDGOtQMZAdVffA7l
 6w7nutpW0ItIy8+TYBM2FJHjBslaqffxZ8bPSCTofT8wrYXEybfGuoHR6zM3Pz0p9pB/
 RSaQ==
X-Gm-Message-State: AOJu0YziQh+QIlmKwW2rFfSIh32X3Nl4jUAWPELnFqQ9USY5g0kbOSEc
 JrlDCkgAGksHpHx0hMcz6KwoKoLC780p8K32FT0=
X-Google-Smtp-Source: AGHT+IFF37js94tOFUGCzU26DN9zVIGeCmV2/ux7M8iZpH67PiwybcsOVQkHN2V7O/+5NAOcvaDx3Cwcpb42vA44zP4=
X-Received: by 2002:a2e:a312:0:b0:2b9:e831:f15f with SMTP id
 l18-20020a2ea312000000b002b9e831f15fmr6074709lje.32.1691396773111; Mon, 07
 Aug 2023 01:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230805180214.57198-1-richard.henderson@linaro.org>
In-Reply-To: <20230805180214.57198-1-richard.henderson@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 7 Aug 2023 08:26:01 +0000
Message-ID: <CACPK8XdWpOhwKrdxh+NoMMkP=63g7ib1PdXSrR8f1snAsLu8Nw@mail.gmail.com>
Subject: Re: [PATCH] configure: Fix linux-user host detection for riscv64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=joel.stan@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sat, 5 Aug 2023 at 18:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Mirror the host_arch variable from meson.build, so that we
> probe for the correct linux-user/include/host/ directory.

This broke all of the linux-user targets for me on a ppc64le host.
None show up when running configure --help, and trying to select one
with --target-list errors out:

  ERROR: Unknown target name 'aarch64-linux-user'

Reverting this patch restores the old behaviour.

This test is the one that fails with the patch applied:

if [ "$linux_user" != no ]; then
    if [ "$targetos" = linux ] && [ -d
"$source_path/linux-user/include/host/$host_arch" ]; then
        linux_user=yes

WIth your patch $host_arch is ppc64le. Previously the line was:

 if [ "$linux_user" != no ]; then
     if [ "$targetos" = linux ] && [ -d
"$source_path/linux-user/include/host/$cpu" ]; then
      linux_user=yes

The directory needs to be /linux-user/include/host/ppc64 for even for ppc64le.

You've put the new test just above the switch statement that does
normalisation of the host CPU name. Could add riscv to that switch
statement instead of adding the host_arch variable?

@@ -508,6 +501,9 @@ case "$cpu" in
     cpu="ppc64"
     CPU_CFLAGS="-m64 -mlittle-endian" ;;

+  riscv*)
+    cpu="riscv" ;;
+
   s390)
     CPU_CFLAGS="-m31" ;;
   s390x)

Cheers,

Joel

>
> Fixes: e3e477c3bca0 ("configure: Fix cross-building for RISCV host")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index afb25fd558..98dc78280e 100755
> --- a/configure
> +++ b/configure
> @@ -469,6 +469,13 @@ else
>    echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
>  fi
>
> +case "$cpu" in
> +  riscv*)
> +    host_arch=riscv ;;
> +  *)
> +    host_arch="$cpu" ;;
> +esac
> +
>  # Normalise host CPU name and set multilib cflags.  The canonicalization
>  # isn't really necessary, because the architectures that we check for
>  # should not hit the 'uname -m' case, but better safe than sorry.
> @@ -803,7 +810,7 @@ default_target_list=""
>  mak_wilds=""
>
>  if [ "$linux_user" != no ]; then
> -    if [ "$targetos" = linux ] && [ -d "$source_path/linux-user/include/host/$cpu" ]; then
> +    if [ "$targetos" = linux ] && [ -d "$source_path/linux-user/include/host/$host_arch" ]; then
>          linux_user=yes
>      elif [ "$linux_user" = yes ]; then
>          error_exit "linux-user not supported on this architecture"
> --
> 2.34.1
>
>

