Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2936581109E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 12:57:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDNqg-0003or-Sk; Wed, 13 Dec 2023 06:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rDNqe-0003oa-CH; Wed, 13 Dec 2023 06:56:20 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rDNqc-0001uR-Jt; Wed, 13 Dec 2023 06:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BV6K3Mm3nvgXNQo4BiKorufcdfPdeA72eRuRFOnsb0Y=; b=fChkF+tFvOlznkDok0k5Ld3BIS
 s433J27x0cW1KBIpdSOJTOTPBbZeyiuqvgmWkImHptdUFvmxMPY4p0AISEfivz5VfJDjlTaUT6kVx
 rSMeUJs+IYTG45iye/+aenpwPLkwSN1vGwd+jLWP9uwrxwI81LS/Anym4zIE3zrrx/SQ=;
Date: Wed, 13 Dec 2023 12:56:06 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>, 
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Brian Cain <bcain@quicinc.com>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH v2 09/23] host/atomic128: Include missing 'qemu/atomic.h'
 header
Message-ID: <vzzjwfq23lhpukirvss75s5tuu4vn6djbu22mlrgwvha6em4vv@irs5cx6zy674>
References: <20231212123401.37493-1-philmd@linaro.org>
 <20231212123401.37493-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212123401.37493-10-philmd@linaro.org>
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
> qatomic_cmpxchg__nocheck(), qatomic_read__nocheck(),
> qatomic_set__nocheck() are defined in "qemu/atomic.h".
> Include it in order to avoid:
> 
>   In file included from include/exec/helper-proto.h:10:
>   In file included from include/exec/helper-proto-common.h:10:
>   In file included from include/qemu/atomic128.h:61:
>   In file included from host/include/aarch64/host/atomic128-cas.h:16:
>   host/include/generic/host/atomic128-cas.h:23:11: error: call to undeclared function 'qatomic_cmpxchg__nocheck'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
>           ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  host/include/generic/host/atomic128-cas.h  | 2 ++
>  host/include/generic/host/atomic128-ldst.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/host/include/generic/host/atomic128-cas.h b/host/include/generic/host/atomic128-cas.h
> index 6b40cc2271..4824f14659 100644
> --- a/host/include/generic/host/atomic128-cas.h
> +++ b/host/include/generic/host/atomic128-cas.h
> @@ -11,6 +11,8 @@
>  #ifndef HOST_ATOMIC128_CAS_H
>  #define HOST_ATOMIC128_CAS_H
>  
> +#include "qemu/atomic.h"
> +
>  #if defined(CONFIG_ATOMIC128)
>  static inline Int128 ATTRIBUTE_ATOMIC128_OPT
>  atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
> diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
> index 691e6a8531..12e4aca2da 100644
> --- a/host/include/generic/host/atomic128-ldst.h
> +++ b/host/include/generic/host/atomic128-ldst.h
> @@ -11,6 +11,8 @@
>  #ifndef HOST_ATOMIC128_LDST_H
>  #define HOST_ATOMIC128_LDST_H
>  
> +#include "qemu/atomic.h"
> +
>  #if defined(CONFIG_ATOMIC128)
>  # define HAVE_ATOMIC128_RO 1
>  # define HAVE_ATOMIC128_RW 1
> -- 
> 2.41.0
> 

What about the int128.h includes? I guess those definitions are acquired 
from atomic128.h that includes -cas.h/-ldst.h?

