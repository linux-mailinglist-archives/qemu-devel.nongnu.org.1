Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4386A830CD2
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 19:40:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQAoK-0002qC-ET; Wed, 17 Jan 2024 13:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1rQAoH-0002pb-Vp; Wed, 17 Jan 2024 13:38:46 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1rQAoF-0000LW-Fw; Wed, 17 Jan 2024 13:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+GwkXegJg/2FZ09lDUPPwEuFTapfYQO7T4kairmDjco=; b=RT1XGaamWTPKs/7yi+NJbMeMkH
 7INVkPLyl2W8fWt0r2oBrIZ9D7Ak5cm/6zVpExEeeq9UOd2Xnn7LPECJov6/74d/e9ZLsc9D7cD3J
 /H2U5AwZRfV+TUgXmNOR0yAK0om7lfR5mSzgBlIe1x2xCeg88RkmHj3b4L0tq2JQ5EwUkOmljChGX
 Cpkx/MXRhcE6lxVQa8+mtQqpdH5+gjmtZG9g7KGpBMA4jU86kfcxKQEbHmNkpbBFuwymEvyJxpm+7
 zY/fGko9LcnOr66rqRw2HdT/AW9p/g6hQv1qvobhR7WngOzvoZcsbd+G5BQU5/f2+ULlh5tx+dpNA
 J2tjEHpQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1rQAoA-0028Ox-01;
 Wed, 17 Jan 2024 18:38:38 +0000
Date: Wed, 17 Jan 2024 18:38:37 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 devel@lists.libvirt.org, Laurent Vivier <laurent@vivier.eu>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/3] hmp: Remove deprecated 'singlestep' command
Message-ID: <ZagerX_8kO6GRBMi@gallifrey>
References: <20240117151430.29235-1-philmd@linaro.org>
 <20240117151430.29235-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117151430.29235-3-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 18:38:15 up 14 days, 21:27, 1 user, load average: 0.10, 0.03, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> This command has been deprecated before the 8.1 release,
> in commit e9ccfdd91d ("hmp: Add 'one-insn-per-tb' command
> equivalent to 'singlestep'"). Time to drop it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  docs/about/deprecated.rst       |  9 ---------
>  docs/about/removed-features.rst |  6 ++++++
>  tests/qtest/test-hmp.c          |  1 -
>  hmp-commands.hx                 | 13 -------------
>  4 files changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 25527da423..316a26a82c 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -167,15 +167,6 @@ points was removed in 7.0. However QMP still exposed the vcpu
>  parameter. This argument has now been deprecated and the remaining
>  remaining trace points that used it are selected just by name.
>  
> -Human Monitor Protocol (HMP) commands
> --------------------------------------
> -
> -``singlestep`` (since 8.1)
> -''''''''''''''''''''''''''
> -
> -The ``singlestep`` command has been replaced by the ``one-insn-per-tb``
> -command, which has the same behaviour but a less misleading name.
> -
>  Host Architectures
>  ------------------
>  
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index a8546f4787..855d788259 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -635,6 +635,12 @@ Use ``migrate-set-parameters`` instead.
>  
>  This command didn't produce any output already. Removed with no replacement.
>  
> +``singlestep`` (removed in 9.0)
> +'''''''''''''''''''''''''''''''
> +
> +The ``singlestep`` command has been replaced by the ``one-insn-per-tb``
> +command, which has the same behaviour but a less misleading name.
> +
>  Guest Emulator ISAs
>  -------------------
>  
> diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
> index fc9125f8bb..1b2e07522f 100644
> --- a/tests/qtest/test-hmp.c
> +++ b/tests/qtest/test-hmp.c
> @@ -64,7 +64,6 @@ static const char *hmp_cmds[] = {
>      "qom-get /machine initrd",
>      "screendump /dev/null",
>      "sendkey x",
> -    "singlestep on",
>      "wavcapture /dev/null",
>      "stopcapture 0",
>      "sum 0 512",
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 765349ed14..fc5f5c57ad 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -398,19 +398,6 @@ SRST
>    If called with option off, the emulation returns to normal mode.
>  ERST
>  
> -    {
> -        .name       = "singlestep",
> -        .args_type  = "option:s?",
> -        .params     = "[on|off]",
> -        .help       = "deprecated synonym for one-insn-per-tb",
> -        .cmd        = hmp_one_insn_per_tb,
> -    },
> -
> -SRST
> -``singlestep [off]``
> -  This is a deprecated synonym for the one-insn-per-tb command.
> -ERST
> -
>      {
>          .name       = "stop|s",
>          .args_type  = "",
> -- 
> 2.41.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

