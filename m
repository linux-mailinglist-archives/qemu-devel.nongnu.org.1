Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E900810F4A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 12:02:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDMyT-000321-DJ; Wed, 13 Dec 2023 06:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rDMxW-0002oU-Lz; Wed, 13 Dec 2023 05:59:23 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rDMxT-0007iA-TL; Wed, 13 Dec 2023 05:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aEddrYkgGQER1OOkp2bRdEufjUq51d4bwJVsIHfi3MQ=; b=klMKic/qtuFI8u79wdlpNv1Iua
 JVkBVq/rElRK0qgYefUDA32irO1k8Yxf6LrZkv3/TZ7DBbm509ciOIrUdOLsFAMHwjAaEXj56dn93
 jqtpSjipOSRzxJl4gGrluf5XpQDNZfsSDvic5Un7tjAXtrjXnSXfYv5uI4RS81jMEt7w=;
Date: Wed, 13 Dec 2023 11:58:55 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>, 
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Brian Cain <bcain@quicinc.com>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH v2 07/23] semihosting/guestfd: Remove unused
 'semihosting/uaccess.h' header
Message-ID: <xynfnvhe62bcihq3hsiesfen4btym626aop3anehdbfcugx2p7@nqgttxrtfpo2>
References: <20231212123401.37493-1-philmd@linaro.org>
 <20231212123401.37493-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212123401.37493-8-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 12/12/23, Philippe Mathieu-Daudé wrote:
> Nothing in guestfd.c requires "semihosting/uaccess.h" nor "qemu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  semihosting/guestfd.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
> index 955c2efbd0..d3241434c5 100644
> --- a/semihosting/guestfd.c
> +++ b/semihosting/guestfd.c
> @@ -12,10 +12,7 @@
>  #include "gdbstub/syscalls.h"
>  #include "semihosting/semihost.h"
>  #include "semihosting/guestfd.h"
> -#ifdef CONFIG_USER_ONLY
> -#include "qemu.h"
> -#else
> -#include "semihosting/uaccess.h"
> +#ifndef CONFIG_USER_ONLY
>  #include CONFIG_DEVICES
>  #endif
>  
> -- 
> 2.41.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

-- 
Anton Johansson
rev.ng Labs Srl.

