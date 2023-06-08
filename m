Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 973A172882F
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 21:21:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7LCE-0007XK-3a; Thu, 08 Jun 2023 15:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7LCB-0007X5-UR
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:21:20 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7LC9-0000KA-Tb
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aaNccF/afK+nDJGb/pDCMzn3v9+EIYGe617yjRt8M4c=; b=gPxiD13C3lU4uTTzKMRvJnu3Vk
 X1ShQE11iqOLRq7/6Gnl1XfJnX2pAN+iiQqkcmcxpp3+YfaMeKgNWPZxDxjfu5nAeQpkv4MV+HgYr
 38k2j45fwuhl/vAKfDU7P9Oz6k0vXDq32Ma9tVgz4c7fm0lD5VSiHUAspLbU2z/2kHnaFLt37sWRE
 W8TqFQ8ucZZYTEVnq/KauK49Iy7ufsKe0gSua4oCuIxu1cpMLw4iAXRR2dM2auLavj8pZs9znmp4Z
 IMxutPv8v0ze7zYvfxdUEdXxX7/f+FQgMj7OONArX67HqeoZN0QQj8jXCHHygKeRQh4TWOz75OLtz
 RZCUwFRFXOGRo3d+acVVNdvfxb6GvI62Rit64dtQFyXtRowqd8gDFVv+flusUrVuSLls45tYkOj5o
 /o4MaMw+46efoP4r/0z7rIuRu4vYzYv0PF/wEucW47Gbef6V5Ze4tEZyByTp5RO1JqSsDuhADTnpQ
 5Xb/iyBQ+lAB7/D8w8qbgGsTlrWsIs5QCA1mnWtWkR9nAshCOxmmjRjU8djfXv9F3UivLRXweVPk2
 CrqpbvWvStuYn7k0nfZ56yYpA5sfVXViy40jaRaZ2TQjK4VebV1kOC4n8FWGsysT35T7C5eQYkmM1
 Rp5fSjCMThlMVFHydui5scWCp7/svHuj+uSLqFz0A=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7LC1-0002yZ-HH; Thu, 08 Jun 2023 20:21:13 +0100
Message-ID: <5f5fb945-1410-ec9e-a888-821935b3e06a@ilande.co.uk>
Date: Thu, 8 Jun 2023 20:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230608134314.943615-1-pbonzini@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230608134314.943615-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] build: further refine build.ninja rules
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 08/06/2023 14:43, Paolo Bonzini wrote:

> In commit b0fcc6fc7fc1 ("build: rebuild build.ninja using
> "meson setup --reconfigure"", 2023-05-19) I changed the build.ninja
> rule in the Makefile to use "meson setup" so that the Makefile would
> pick up a changed path to the meson binary.
> 
> However, there was a reason why build.ninja was rebuilt using $(NINJA)
> itself.  Namely, ninja has its own cache of file modification times,
> and if it does not know about the modification that was done outside
> its control, it will *also* try to regenerate build.ninja.  This can be
> simply by running "make" on a fresh tree immediately after "configure";
> that will trigger an unnecessary meson run.
> 
> So, apply a refinement to the rule in order to cover both cases:
> 
> - track the meson binary that was used (and that is embedded in
>    build.ninja's reconfigure rules); to do this, write build.ninja.stamp
>    right after executing meson successfully
> 
> - if it changed, force usage of "$(MESON) setup --reconfigure" to
>    update the path in the reconfigure rule
> 
> - if it didn't change, use "$(NINJA) build.ninja" just like before
>    commit b0fcc6fc7fc1.
> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   Makefile  | 17 +++++++++++++----
>   configure |  1 +
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index b22bf6fba12..804a5681e0a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -83,16 +83,17 @@ config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh
>   	@if test -f meson-private/coredata.dat; then \
>   	  ./config.status --skip-meson; \
>   	else \
> -	  ./config.status && touch build.ninja.stamp; \
> +	  ./config.status; \
>   	fi
>   
>   # 2. meson.stamp exists if meson has run at least once (so ninja reconfigure
>   # works), but otherwise never needs to be updated
> +
>   meson-private/coredata.dat: meson.stamp
>   meson.stamp: config-host.mak
>   	@touch meson.stamp
>   
> -# 3. ensure generated build files are up-to-date
> +# 3. ensure meson-generated build files are up-to-date
>   
>   ifneq ($(NINJA),)
>   Makefile.ninja: build.ninja
> @@ -106,11 +107,19 @@ Makefile.ninja: build.ninja
>   endif
>   
>   ifneq ($(MESON),)
> -# A separate rule is needed for Makefile dependencies to avoid -n
> +# The path to meson always points to pyvenv/bin/meson, but the absolute
> +# paths could change.  In that case, force a regeneration of build.ninja.
> +# Note that this invocation of $(NINJA), just like when Make rebuilds
> +# Makefiles, does not include -n.
>   build.ninja: build.ninja.stamp
>   $(build-files):
>   build.ninja.stamp: meson.stamp $(build-files)
> -	$(MESON) setup --reconfigure $(SRC_PATH) && touch $@
> +	@if test "$$(cat build.ninja.stamp)" = "$(MESON)" && test -n "$(NINJA)"; then \
> +	  $(NINJA) build.ninja; \
> +	else \
> +	  echo "$(MESON) setup --reconfigure $(SRC_PATH)"; \
> +	  $(MESON) setup --reconfigure $(SRC_PATH); \
> +	fi && echo "$(MESON)" > $@
>   
>   Makefile.mtest: build.ninja scripts/mtest2make.py
>   	$(MESON) introspect --targets --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
> diff --git a/configure b/configure
> index 8a638dd82ae..cbdb389dc95 100755
> --- a/configure
> +++ b/configure
> @@ -1894,6 +1894,7 @@ if test "$skip_meson" = no; then
>     if test "$?" -ne 0 ; then
>         error_exit "meson setup failed"
>     fi
> +  echo "$meson" > build.ninja.stamp
>   else
>     if test -f meson-private/cmd_line.txt; then
>       # Adjust old command line options that were removed

Thanks Paolo!

I just tried a complete fresh build, make, a few changes followed by another make and 
everything built without running reconfigure so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


