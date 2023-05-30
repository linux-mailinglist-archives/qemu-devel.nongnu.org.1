Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD559716270
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zeT-0004iG-1w; Tue, 30 May 2023 09:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zeF-0004Tw-VC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:44:33 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zeD-0007dA-Gi
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:44:27 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4effb818c37so4857427e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685454264; x=1688046264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CXbqrfrcLCfjuCYFtuZW8CIeDUIIoXco0fzPzfIjM2A=;
 b=ZohZRWgGwDsDGZZmd5/JlYEwgpQpOVHAoxnkttiJcWfdJwaTwGPiuHJN9CqNz/uf+A
 WYPbERRfDWWUIRTar5Q0netvwyUXmn4mKI4H7UtaQXhFlEPO7tfKD0I6ntfoByyTxcWq
 ITM9+moLfIemR3M37qiifH2AnY5YusTo7hacB9gHUrBeo01LuOLGpfqXkOCdXXTM/atT
 TvEB5QcnBMu7e2Rn6AGDzZ7+rlzRcYPWTKq3BO/vOiPf1OKJXGJWq+SnK/ezX9AgOSsi
 iXqb40ZrLTOHdT2yB3rc7nl29UR8+g4UoDCK1MEEDh1wcISBHTKlD8IelPOZq0oZBT8G
 yHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685454264; x=1688046264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CXbqrfrcLCfjuCYFtuZW8CIeDUIIoXco0fzPzfIjM2A=;
 b=LK2jsAtfCIOLcw8auJPd0ibvq3OFaLnR0OC5Dg+sTRFcUfKDOjQEONSGkSuuGYwAHf
 tAmsMuBPjfziy7BFs6AIyXC7oMX/lkiPSlEkWV39GXEfqiEjSGRjM30YtI6LdyIOfzqO
 BLWCBo7RZ1Iuk2ORV9oZy8XdgVtaSySAkEVAOqmfbbniOXF7zEH8G8ub4QszCMKvddnZ
 K5p+yfbLLQ1QxTLPZ1V7D6ez+jog9LN6b8d5IFl4BOq7Zz607GdFOQdbJONO2XIw6wmL
 TBGG/57bZQD68tjOWProLUJWkuiTgIuIxf5ELsOjjal4QQxZEticY2HQcdl8YNFgrvIO
 wk1Q==
X-Gm-Message-State: AC+VfDwx594w/voAXei534yG5CplNF7cDjKuySYX4fxB4bI8uqnSKTGa
 YTcfknTBcHpBwei2+vaUNhz54e0avhfzvQA95KQjyQ==
X-Google-Smtp-Source: ACHHUZ5Rt8VUunivj5HMEbm+VKXMc+gVNpDTu8KV/s2PpOHCQMlJ9SiaSafyyB4ydf7KZ46bYlkZ5hQGXgyUCmEoook=
X-Received: by 2002:ac2:4859:0:b0:4f3:9930:5b8c with SMTP id
 25-20020ac24859000000b004f399305b8cmr795825lfy.25.1685454263888; Tue, 30 May
 2023 06:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-3-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 14:44:13 +0100
Message-ID: <CAFEAcA8E_wbiL=xxc=qzfbhBjTsGVxpMGYex_Ezsn_=47DJP3w@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 26 May 2023 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> PAGE_WRITE is current writability, as modified by TB protection;
> PAGE_WRITE_ORG is the original page writability.
>
> Fixes: cdfac37be0d ("accel/tcg: Honor atomicity of loads")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/ldst_atomicity.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
> index 0f6b3f8ab6..57163f5ca2 100644
> --- a/accel/tcg/ldst_atomicity.c.inc
> +++ b/accel/tcg/ldst_atomicity.c.inc
> @@ -191,7 +191,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
>       * another process, because the fallback start_exclusive solution
>       * provides no protection across processes.
>       */
> -    if (!page_check_range(h2g(p), 16, PAGE_WRITE)) {
> +    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
>          return *p;
>      }
>  #endif
> --
> 2.34.1

load_atomic8_or_exit() has a similar condition, so
we should change either both or neither.

So, if I understand this correctly, !PAGE_WRITE_ORG is a
stricter test than !PAGE_WRITE, so we're saying "don't
do a simple non-atomic load if the page was only read-only
because we've translated code out of it". Why is it
not OK to do the non-atomic load in that case? I guess
because we don't have the mmap lock, so some other thread
might nip in and do an access that causes us to invalidate
the TBs and move the page back to writeable?

thanks
-- PMM

