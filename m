Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3B974F5C4
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 18:43:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGRs-0001kk-S7; Tue, 11 Jul 2023 12:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJGRq-0001kb-Uh
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:42:46 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJGRp-0004HC-Ae
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:42:46 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fb8574a3a1so9189101e87.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689093763; x=1691685763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eejjKTh5EU8jZjvYvhzAXuEsnzasRJZa3uShskDa7JY=;
 b=MI0qyfFM1AVVYloICKDrYJ7FMt5xfRC7imMBlUhF79RwrIu5Nt+LtoaLhlCy4Zitnu
 /lM+4zaC53bh/wSNrfZhF3tEzVNvqdzpLjAtmZxnd3OF/PDcVUJdAmc4gbbLyQPm6T0w
 trZ3piF9oZTDZFJu87BAh9cmZ4+43Tgz4Ub+RAs3+zMGaFaWGL5fvZky82B5nggJdK9L
 yiOjiSLCOUNYOoVNiWhsXGf/1YDh6aHatEkLQ0oQj44v5CouZLEpsNZim6T6U0ei62xh
 u36MLVoIoeQCsH8djYUCm/y8OAg1kh3e7UeqjiQQfbF31LotjE0er3EArjxpfD+2/Qs0
 wyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689093763; x=1691685763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eejjKTh5EU8jZjvYvhzAXuEsnzasRJZa3uShskDa7JY=;
 b=Wz1xfew1gtWshHIubvUgNIto95SHLs0vbzLvzXqyeScjQfWHAWJg3RHGmAAR/qsc5a
 r0nt1z3YcSQ6D3DGr5QEy0/HTLSMOkdZCSiLDpaDJY7wf5RFY0XivV/HwSMIW7+SCZjr
 CDE6Yzt2Vu3FpmWyupKSCRMtPEsfPfqPyeQW6rDW1Lvh34ogphwDxLMhoKoQZTPhH3h4
 ol1a/QSgvy6WPQRiW1gcKFLZAFsXxwVGFX5wJsaXNpp4sMJ07L3AyLkZCfEFsba9/b+e
 /Te6gv9EJXnEArMSz4PZJSZyBQtA6qEQJeDuKfzmL+4roTByjDNyE5kPnJPymKn2wMtB
 JA9g==
X-Gm-Message-State: ABy/qLb34qpPIzQUhuj2Ob/a5QMSg85p840cIOqc8HrK343xXMdCZ9s1
 t8WzFTkun57sjOsSW0D6jHbC6u1d7Cdaf/SRUBYK8Q==
X-Google-Smtp-Source: APBJJlFRf3Xqj0KTp6aJs4souA64/p32TQWPXKN9rbXPdtZFhLxWyvNUs4nzWm2EKptFGmnfHJWcLjy96Ml2u9sz+60=
X-Received: by 2002:a19:8c44:0:b0:4fb:89f5:f6d2 with SMTP id
 i4-20020a198c44000000b004fb89f5f6d2mr12712123lfj.47.1689093763167; Tue, 11
 Jul 2023 09:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
 <20230605201548.1596865-33-richard.henderson@linaro.org>
In-Reply-To: <20230605201548.1596865-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2023 17:42:32 +0100
Message-ID: <CAFEAcA_x7GZYGd06tSXGh+sXf9R=xyP6UQPcUQgF50fZPx8TOQ@mail.gmail.com>
Subject: Re: [PULL 32/52] exec-all: Widen TranslationBlock pc and cs_base to
 64-bits
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 5 Jun 2023 at 21:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This makes TranslationBlock agnostic to the address size of the guest.
> Use vaddr for pc, since that's always a virtual address.
> Use uint64_t for cs_base, since usage varies between guests.

> index 60ca9e229e..1cf4f1fa22 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -297,7 +297,7 @@ static void log_cpu_exec(target_ulong pc, CPUState *cpu,
>  {
>      if (qemu_log_in_addr_range(pc)) {
>          qemu_log_mask(CPU_LOG_EXEC,
> -                      "Trace %d: %p [" TARGET_FMT_lx
> +                      "Trace %d: %p [%08" PRIx64
>                        "/" TARGET_FMT_lx "/%08x/%08x] %s\n",
>                        cpu->cpu_index, tb->tc.ptr, tb->cs_base, pc,
>                        tb->flags, tb->cflags, lookup_symbol(pc));

TARGET_FMT_lx zero-pads appropriately to the size of
target_ulong, which is what cs_base used to be.
Now we have an explicit %08, which will sometimes
be too small for cs_base if the guest really uses all
64 bits of it. Is that intentional ?

thanks
-- PMM

