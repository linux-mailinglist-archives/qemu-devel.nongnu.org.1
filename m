Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B15F17490E9
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 00:18:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAoc-0006PU-D2; Wed, 05 Jul 2023 18:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qHAoZ-0006PF-NP
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:17:35 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qHAoX-0007dl-Sc
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:17:35 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-345c343ce29so36679375ab.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688595452; x=1691187452;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3nprQbr/r/E3E8d4nn+DrN5CjruNFkajvMkohHMcvyQ=;
 b=hVwyA28y3n+Jlwn7GLfi0fNo/WTemh0iwS9R3sEOxMJ4DpnnDjcivrptBMWJXvasCx
 QLscds+5uGElkpvv39041uOioALzI3yRqrlSSRNKMJBx3K3hGHAcF+YubdKw4EbQ1W3B
 wu1cO4AXTVG1eNkMg/br04bf/IhrS/HROEaOPQf6/Bj7UgipaBCWAlqwISNgxnuDlAGZ
 0Xt/9t04YEpBA51lallhGrnCE6y9UPnIiwbs/SoxAgpv+QMxY2tpAhC27F2OJ0IyQshl
 ckF46t8KG9qR5I8xKRaZom1EdULsW1CwuEoaFbFDL7Ln3fdC5TG48eGUgIZSkmdkO8Rz
 MFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688595452; x=1691187452;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3nprQbr/r/E3E8d4nn+DrN5CjruNFkajvMkohHMcvyQ=;
 b=BX6FuWra58WSIKUfBRh9wthi8COEIjJJMIZK2CzYijfwhhX+8THUsHo7b5ji7xRrr7
 cON5PbKlMZTZyDhE3KZyOPiIj8zbNKApRTOLxjXiQ17j7vSLmomuDPsi0oKAEU74EScR
 8t8UVfMSPyhPzcFTD13Ozeo0TwXQL0xNiuKi4BVB/mHj0+eU7RcukGudK4lSjKuG2mI+
 WimrHv71IaH04jNRbwflBuC4B5FMljH5VbMjVcgi6N68ckAPcxQfY41E54bdnDlhzX3D
 YlL1BS+oPkH+uzpxOi6jkXQhoJDtv7dmAe9YriWqX4+sIXAMWOd3et6floXdwHMhy94c
 CVpw==
X-Gm-Message-State: ABy/qLZnAdAEbvlevis3fO2DN6kh5gCXJhPvDitUgf+vHk4L9yXBvaaj
 YesIZxh2w8uC/8W8U/PZJhQ=
X-Google-Smtp-Source: APBJJlGkFQDr7Kmd/zbeI50aCfz7G3OnqVFW4gMooFulDWA5RgNhn5r8LcRVt1hf/enoQsEmxOu9Hg==
X-Received: by 2002:a05:6e02:100a:b0:345:a3c6:87ba with SMTP id
 n10-20020a056e02100a00b00345a3c687bamr408955ilj.22.1688595452357; 
 Wed, 05 Jul 2023 15:17:32 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:e850:1a78:8057:4d63:c6a5])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a92c9c9000000b00345babb873csm12136ilq.64.2023.07.05.15.17.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Jul 2023 15:17:31 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
Cc: <bcain@quicinc.com>, <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>
References: <93a2ca786530cbc8a94f7c7a6451f4f1f47c8a9b.1688581908.git.quic_mathbern@quicinc.com>
In-Reply-To: <93a2ca786530cbc8a94f7c7a6451f4f1f47c8a9b.1688581908.git.quic_mathbern@quicinc.com>
Subject: RE: [PATCH v2] Hexagon: move GETPC() calls to top level helpers
Date: Wed, 5 Jul 2023 16:17:30 -0600
Message-ID: <00a701d9af8e$7de644c0$79b2ce40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQFuHxwhguCpzCdeEvpTvLtGpI6IkbCC2QcQ
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



> -----Original Message-----
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Wednesday, July 5, 2023 12:35 PM
> To: qemu-devel@nongnu.org
> Cc: quic_mathbern@quicinc.com; bcain@quicinc.com;
> ltaylorsimpson@gmail.com; quic_mliebel@quicinc.com;
> richard.henderson@linaro.org
> Subject: [PATCH v2] Hexagon: move GETPC() calls to top level helpers
> 
> As docs/devel/loads-stores.rst states:
> 
>   ``GETPC()`` should be used with great care: calling
>   it in other functions that are *not* the top level
>   ``HELPER(foo)`` will cause unexpected behavior. Instead, the
>   value of ``GETPC()`` should be read from the helper and passed
>   if needed to the functions that the helper calls.
> 
> Let's fix the GETPC() usage in Hexagon, making sure it's always called
from
> top level helpers and passed down to the places where it's needed. There
> are two snippets where that is not currently the case:
> 
> - probe_store(), which is only called from two helpers, so it's easy to
>   move GETPC() up.
> 
> - mem_load*() functions, which are also called directly from helpers,
>   but through the MEM_LOAD*() set of macros. Note that this are only
>   used when compiling with --disable-hexagon-idef-parser.
> 
>   In this case, we also take this opportunity to simplify the code,
>   unifying the mem_load*() functions.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
> v1:
> d40fabcf9d6e92e4cd8d6a144e9b2a9acf4580dc.1688420966.git.quic_mathber
> n@quicinc.com
> 
> Changes in v2:
> - Fixed wrong cpu_ld* unification from previous version.
> - Passed retaddr down to check_noshuf() and further, as Taylor
>   suggested.
> - Reorganized macros for simplification.
> 
>  target/hexagon/macros.h    | 19 ++++++------
>  target/hexagon/op_helper.h | 11 ++-----  target/hexagon/op_helper.c | 62
> +++++++++++---------------------------
>  3 files changed, 29 insertions(+), 63 deletions(-)
> 
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h index
> 5451b061ee..e44a932434 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -173,15 +173,6 @@
>  #define fLOAD(NUM, SIZE, SIGN, EA, DST) \
> -    DST = (size##SIZE##SIGN##_t)MEM_LOAD##SIZE##SIGN(EA)
> +    DST =  (size##SIZE##SIGN##_t)({ \
> +        check_noshuf(env, pkt_has_store_s1, slot, EA, SIZE, GETPC()); \
> +        MEM_LOAD##SIZE(env, EA, GETPC()); \
> +    })
>  #endif

This should be formatted as
#define fLOAD(...) \
    do { \
        check_noshuf(...); \
        DST = ...; \
    } while (0)

> a/target/hexagon/op_helper.h b/target/hexagon/op_helper.h index
> 8f3764d15e..7744e819ef 100644
> --- a/target/hexagon/op_helper.h
> +++ b/target/hexagon/op_helper.h
> +void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
> +                  uint32_t slot, target_ulong vaddr, int size,
> +uintptr_t ra);

Are you sure this needs to be non-static?


Othersiwe
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



