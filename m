Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F32877147E
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 13:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSbZs-000263-SC; Sun, 06 Aug 2023 07:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qSbZr-00025q-NN; Sun, 06 Aug 2023 07:05:39 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qSbZp-0001rT-Vr; Sun, 06 Aug 2023 07:05:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B5552184E;
 Sun,  6 Aug 2023 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691319935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFO/1m6YgKTlEb/JNvdj2fPiDgn5eCHjC4DyrY9GYgU=;
 b=di6H6OaFRF3aADtffkZEfLHnl/68X2dfJrdbpodtbZ98+C3O8vZ/SwGhImZJkbSyRIQD+y
 JFh331XIHLVHvgshLAr1S1LGxmlpwOKg37eVUSbwCFRbZt2d//xdrZr0F07re+blhvwAM7
 09Y4H9dTNlsFaxdE7CHORm+TENhyaPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691319935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFO/1m6YgKTlEb/JNvdj2fPiDgn5eCHjC4DyrY9GYgU=;
 b=Z15IIPlDmXMKqUVQrwuiPeNW/9ShmPF3QYIZDLaOytaWxKb91e72AM6nruGDfwh01Rv+Ib
 V0qwwUT8ZAUbYLCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EE5D13421;
 Sun,  6 Aug 2023 11:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lg4gAn9+z2TTNAAAMHmgww
 (envelope-from <cfontana@suse.de>); Sun, 06 Aug 2023 11:05:35 +0000
Message-ID: <85745fff-825c-0084-00ff-9875fe1a6f5a@suse.de>
Date: Sun, 6 Aug 2023 13:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] tests/tcg/s390x: Test VSTRS
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230804233748.218935-1-iii@linux.ibm.com>
 <20230804233748.218935-4-iii@linux.ibm.com>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230804233748.218935-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/23 01:03, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tests/tcg/s390x/Makefile.target |  1 +
>  tests/tcg/s390x/vxeh2_vstrs.c   | 88 +++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
>  create mode 100644 tests/tcg/s390x/vxeh2_vstrs.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 1fc98099070..8ba36e5985b 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -73,6 +73,7 @@ ifneq ($(CROSS_CC_HAS_Z15),)
>  Z15_TESTS=vxeh2_vs
>  Z15_TESTS+=vxeh2_vcvt
>  Z15_TESTS+=vxeh2_vlstr
> +Z15_TESTS+=vxeh2_vstrs
>  $(Z15_TESTS): CFLAGS+=-march=z15 -O2
>  TESTS+=$(Z15_TESTS)
>  endif
> diff --git a/tests/tcg/s390x/vxeh2_vstrs.c b/tests/tcg/s390x/vxeh2_vstrs.c
> new file mode 100644
> index 00000000000..313ec1d728f
> --- /dev/null
> +++ b/tests/tcg/s390x/vxeh2_vstrs.c
> @@ -0,0 +1,88 @@
> +/*
> + * Test the VSTRS instruction.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include "vx.h"
> +
> +static inline __attribute__((__always_inline__)) int
> +vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
> +      const S390Vector *v4, const uint8_t m5, const uint8_t m6)
> +{
> +    int cc;
> +
> +    asm("vstrs %[v1],%[v2],%[v3],%[v4],%[m5],%[m6]\n"
> +        "ipm %[cc]"
> +        : [v1] "=v" (v1->v)
> +        , [cc] "=r" (cc)
> +        : [v2] "v" (v2->v)
> +        , [v3] "v" (v3->v)
> +        , [v4] "v" (v4->v)
> +        , [m5] "i" (m5)
> +        , [m6]  "i" (m6)
> +        : "cc");
> +
> +    return (cc >> 28) & 3;
Following the POp, I am puzzled by the use of an "int" to contain the register result of the IPM instruction, should it not be a 64bit variable?
bits 0-31 are left unchanged / are uninteresting, is that enough to avoid having to use a properly sized variable?

I see that this is done elsewhere in the tests (sometimes a 64bit variable is used, sometimes just 'int'), so I assume it's probably fine.

Otherwise lgtm,

Claudio


> +}
> +
> +static void test_ignored_match(void)
> +{
> +    S390Vector v1;
> +    S390Vector v2 = {.d[0] = 0x222000205e410000ULL, .d[1] = 0};
> +    S390Vector v3 = {.d[0] = 0x205e410000000000ULL, .d[1] = 0};
> +    S390Vector v4 = {.d[0] = 3, .d[1] = 0};
> +
> +    assert(vstrs(&v1, &v2, &v3, &v4, 0, 2) == 1);
> +    assert(v1.d[0] == 16);
> +    assert(v1.d[1] == 0);
> +}
> +
> +static void test_empty_needle(void)
> +{
> +    S390Vector v1;
> +    S390Vector v2 = {.d[0] = 0x5300000000000000ULL, .d[1] = 0};
> +    S390Vector v3 = {.d[0] = 0, .d[1] = 0};
> +    S390Vector v4 = {.d[0] = 0, .d[1] = 0};
> +
> +    assert(vstrs(&v1, &v2, &v3, &v4, 0, 0) == 2);
> +    assert(v1.d[0] == 0);
> +    assert(v1.d[1] == 0);
> +}
> +
> +static void test_max_length(void)
> +{
> +    S390Vector v1;
> +    S390Vector v2 = {.d[0] = 0x1122334455667700ULL, .d[1] = 0};
> +    S390Vector v3 = {.d[0] = 0, .d[1] = 0};
> +    S390Vector v4 = {.d[0] = 16, .d[1] = 0};
> +
> +    assert(vstrs(&v1, &v2, &v3, &v4, 0, 0) == 3);
> +    assert(v1.d[0] == 7);
> +    assert(v1.d[1] == 0);
> +}
> +
> +static void test_no_match(void)
> +{
> +    S390Vector v1;
> +    S390Vector v2 = {.d[0] = 0xffffff000fffff00ULL, .d[1] = 0x82b};
> +    S390Vector v3 = {.d[0] = 0xfffffffeffffffffULL,
> +                     .d[1] = 0xffffffff00000000ULL};
> +    S390Vector v4 = {.d[0] = 11, .d[1] = 0};
> +
> +    assert(vstrs(&v1, &v2, &v3, &v4, 0, 2) == 1);
> +    assert(v1.d[0] == 16);
> +    assert(v1.d[1] == 0);
> +}
> +
> +int main(void)
> +{
> +    test_ignored_match();
> +    test_empty_needle();
> +    test_max_length();
> +    test_no_match();
> +    return EXIT_SUCCESS;
> +}


