Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D40802439
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 14:30:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9mWv-0006QU-1Q; Sun, 03 Dec 2023 08:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1r9mWr-0006QF-0x
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 08:29:01 -0500
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1r9mWo-00033a-8g
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 08:28:59 -0500
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MFba4-1r2h7i31Ly-00H89v; Sun, 03 Dec 2023 14:28:52 +0100
Message-ID: <6b56a4ca-4b4d-4149-b20a-a4857b67404e@vivier.eu>
Date: Sun, 3 Dec 2023 14:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user: Define TARGET_O_LARGEFILE for aarch64
Content-Language: fr
To: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20231201032140.2470599-1-scw@google.com>
 <20231201032140.2470599-2-scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20231201032140.2470599-2-scw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:w9yTliDamNiYZyLJsaaXJGFTzfkIzUZB8Fm7unWYkQWaHXgQMVV
 2oj4xCvPel5g5zJLcDz2NbLs2l62fwy2Blm3k6shj2NnG07Uf1jzKNWvGNUZg6xgQ68Yu7/
 kXw3X9YWFWETaDIPOa20wELUOYdY/zQ/Duc8d5Ud/qMwK0I3AIG488ZDX7kSlEc2EHkWbP4
 LZCFMozOoQQOt3i/vWaNA==
UI-OutboundReport: notjunk:1;M01:P0:kx+M5hztDl0=;jiTvK/3ob4UW2HcfuPVvXG5Kz05
 Pw/Tf3uca9Y7c2pEfLryW1cMmWSkiCZbRJpRn/pcJ1oUOoxPxTHbwb/JedCLJ2orxSHiTEyJ3
 tnVtZFf4kKQKWh8LTdmPbekM+OgNtcGeVq1rM9e1Op868VTswCxn6WH0u+zSGUC0AHzGESeiM
 GB48cM+t6/rHHw+SpIgk4v45aEbdDiuy8K4Txw6Ef+BT7dY3HbAb5GkuuCJA4lyXnuLzvArFH
 DP1zhCrfn1n6VtjqlXFDmTJhsva2Mb9aqrNYA18536cTZu5fVNrfenY5TEnc9COOvZXDXEnTb
 hGTnYQSGdf8mZgYWzq2WRrGH3KzaKhOGDnhrlnw1J9XrSVQvnql1CNDRJVlW+z22lBGYdr3BA
 trXLwGJvixZrTVbndavZhTi/4NHD8hpvfT5/RhQsviATRtIR87FqyGQ9J16Pl2PIq9bUnKbEY
 uj+X/JVoIA9De/ocLSP0qds9zVF1AtqMZk4md+Xq00m0FSCL8yKdAOtFBhpoNHfBCXuBpkeIt
 KLUECM4f9STjMf3zrNWaXtV6DcRRfAgFP8dMXFHQ+WLA4bYK7ojsKjRSTMMM/qAiVtL1e/hI/
 ye2qtSb8p6o+KAvDxfhItHHF8d7ftO8CCiYTmRHSUAA4gX51mnAp2deAANtly0v6Ji8obvZKF
 hNZFjYcZpEl/BSfsbnz29waqczgnKlS3j8SkAi6K3DTDFpZHtY9sypy2LxdMnf6iVT/70dNEi
 mVoTCNCBZSMKzc3DGOQc+pW4ruWXI6Ivm4TIAnB186xVNiKQajAz7+rvK6Zukpi3Cj+bldvQd
 9M59zjLtKHi1arCtX9xvJfewvVZf+9JbIcDAK3dUlMR4DW0/3NvBLkDjxFksZGfbJWLYiFM2d
 hE6hQxJyvo4dQOg==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 01/12/2023 à 04:21, Shu-Chun Weng a écrit :
> In 050a1ba, when moving the macros from preprocessor-guarding to
> file-based definition, TARGET_O_LARGEFILE appeared to have been
> accidentally left off.
> 
> This may have correctness implication, but so far I was only confused by
> strace's output.
> 
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>   linux-user/aarch64/target_fcntl.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
> index efdf6e5f05..55ab788a7c 100644
> --- a/linux-user/aarch64/target_fcntl.h
> +++ b/linux-user/aarch64/target_fcntl.h
> @@ -11,6 +11,7 @@
>   #define TARGET_O_DIRECTORY      040000 /* must be a directory */
>   #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
>   #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
> +#define TARGET_O_LARGEFILE     0400000
>   
>   #include "../generic/fcntl.h"
>   #endif

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

