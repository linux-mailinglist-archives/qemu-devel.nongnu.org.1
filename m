Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A275E299
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 16:23:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNZz1-0001Nh-Np; Sun, 23 Jul 2023 10:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNZz0-0001NZ-9H
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 10:22:50 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNZyy-0002Tx-Ob
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 10:22:50 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso566434366b.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690122167; x=1690726967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fd2MZ9DmCBSHGcW2VWwKiypeKtl8OXjtkASqTPjr7QQ=;
 b=JvkvX6HEnPwTiyeKsWKvSTa6eCP+WWqJkrVrfGBALCOi38C5Aq5FErgYXLrk3qCa2F
 hZYgudhlZDC8VILa/7SFXgvMM/QgiNj5cPPCyicLoTNke4CFRCvz448XZfWEZzmEEjnj
 l7BUOfG73PcSz3pNLwT8NunvXN00J/6RtTFAKG8EAQ94o5XpbXpeyZ7L4pJh03ebshm8
 +k9bgp1R0wOVY452Vx9pBRl7jMAFCdb2Gvz7qRlYeajhfvCpA80lIRGsEUj5cB3fVfV4
 HKCqxz958UBKkLQvdyPcU8Eny5tgA6u8QM1YgewVbe7yFE9rmy1n2CHVG1Q3nr0jmHEq
 I78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690122167; x=1690726967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fd2MZ9DmCBSHGcW2VWwKiypeKtl8OXjtkASqTPjr7QQ=;
 b=lRVbt+8iiCVpJt7CuY+nHP3kzOv2S/wT+imcTRM1AC5cc5ZRfvi6NZnPaIiruVKBA8
 baa7QEhxyC+Yt9XJZrWYE8spv7UcPVHss27Wv0VGn0j7R9BXB0lez6j4YEjTXXrhuyK7
 AVMfRJkmEoT/F4+cMLbWlMsz3c7KtlPPqnY/vD+KO8gSgwrTGyX3qQhDRwsTGh/QhTs+
 NQZ/GG2e3NCXJ5jHznTLlIR+ASPIFhFB1zVLlC1+X3eNymoCyJ4ilTF1igEBdxJu3Bu7
 lcv9OXjUF2JRfxhMCUQMIob08VlcCrcEdHFWukz4rFh+BqANAVDIJfd/ZsfQXarxDRnm
 ai7A==
X-Gm-Message-State: ABy/qLYuaN+/nUQWNA/9+y1glhxed+DSFXiM//mdN8O3/ryb3jlFr8mj
 CYNO55x64UlES9bsebEqCZqk/cKkTeoEIS79s3o72Z6U8VVqVTgn
X-Google-Smtp-Source: APBJJlFQQl/BOPZwOQWDBT+D/Hih5lK+7MLVYF7vCL82DWezvrICL5o1oPkZdL3TOnGggxjemP/NYg6QQhFsyVkbN38=
X-Received: by 2002:a17:906:64cf:b0:994:4be4:a106 with SMTP id
 p15-20020a17090664cf00b009944be4a106mr6567132ejn.10.1690122167093; Sun, 23
 Jul 2023 07:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230722113507.78332-1-richard.henderson@linaro.org>
 <20230722113507.78332-4-richard.henderson@linaro.org>
In-Reply-To: <20230722113507.78332-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Jul 2023 15:22:36 +0100
Message-ID: <CAFEAcA8jdpiCuTtDfo7rKD=fQUgo7SZFuGLZ8UXe-7PdaaASKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] accel/tcg: Take mmap_lock in load_atomic*_or_exit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Sat, 22 Jul 2023 at 12:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For user-only, the probe for page writability may race with another
> thread's mprotect.  Take the mmap_lock around the operation.  This
> is still faster than the start/end_exclusive fallback.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/ldst_atomicity.c.inc | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

