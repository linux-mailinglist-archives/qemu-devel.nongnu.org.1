Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4A5704B26
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysIu-0006St-G0; Tue, 16 May 2023 06:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pysIs-0006ST-Rt
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:53:14 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pysIr-0006y4-9u
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:53:14 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-50b383222f7so20428248a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684234391; x=1686826391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wbPbZoPr3KszxC0sOeNCbhPntyIb5xeiZgy7iVTdAls=;
 b=ta5BFtiYrlQroTmC6s2bGn+J/TyFl2xY9WLVvwS74Vo87eDleIabp7x/bK97SH5KR8
 ZbmN83E9MvWJJX2KjSCySITTHQhx2sjnar2UMqQ6YUK9GfFh0gX7YT/u4XSzdQWplEsL
 xdLS3BWHnOB5aUk4TlhGU0hGIoKmeMY8N13wfRVsjJGrOr83mY/ho4PDAJhxiD/KRNRa
 nlzFMecG9xSDxKEcKT6y+rx5GJLNoDtprwRvLq1IhU17JOKGzBxvuRSvKGVK9RnMJ894
 ihEUjV9Uc25ykkHtUtVwuvPfADJPDRdDMB5w0puW3LWgD6x5fry+i/dRFLhzjY14fHTg
 Txng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684234391; x=1686826391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wbPbZoPr3KszxC0sOeNCbhPntyIb5xeiZgy7iVTdAls=;
 b=GH4QGsf1Iau+7Y7q62rF8r0MSnNnY6R3a8yzQj9YDPP1wxY+eotZcwf0VT+noADFTd
 nA5r6VByxzvx7ATusJpMz2f7qfNq3gPv3ZltBFflNLhUqsKQ/pDXmBAhBQ5OX9MKki85
 Ux4YjtyF58Fdc74fzrd4iPbPieQdTOhcbXzpUHX5oAMqJP5NP96zgRbmwqW65YleqWmb
 FMWu4ehZ5y5rFcyNGH1J5z4/6jb517WqwAo5atlBrhLt58twvZg3aqq4/oxNv31m1Wc0
 WlrGNIsQxlD14rTkX/Ln2NtOASzh2S/bTuUbQSBvDXr6haG1GEUlfOIb2ZCrtShTH/m8
 hiNA==
X-Gm-Message-State: AC+VfDxq0Sn9+f2QBJXeczRN9HuWlV8BYwwkeprdkzQl5v1Ne0MXcvvG
 2v6k98RiY9HokdXS5xXrjDT+nUp/xcH7JPHPuFB+tg==
X-Google-Smtp-Source: ACHHUZ7U7xdamxgBLKjRHqnzZJf7W9g4DIpt6qaHA92yFBJ8r/nIPFz/IpOXmY5R9NufvOt8qlgLHpOMO1wf53BOanE=
X-Received: by 2002:aa7:ce0e:0:b0:50b:c584:527b with SMTP id
 d14-20020aa7ce0e000000b0050bc584527bmr31589592edv.29.1684234391446; Tue, 16
 May 2023 03:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-30-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 11:53:00 +0100
Message-ID: <CAFEAcA87zpyLO8JsHjNPFLO=P0QL-fHGOyA9zgUum=K1AkC5pA@mail.gmail.com>
Subject: Re: [PATCH v5 29/54] tcg/sparc64: Use standard slow path for softmmu
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 15 May 2023 at 15:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Drop the target-specific trampolines for the standard slow path.
> This lets us use tcg_out_helper_{ld,st}_args, and handles the new
> atomicity bits within MemOp.
>
> At the same time, use the full load/store helpers for user-only mode.
> Drop inline unaligned access support for user-only mode, as it does
> not handle atomicity.
>
> Use TCG_REG_T[1-3] in the tlb lookup, instead of TCG_REG_O[0-2].
> This allows the constraints to be simplified.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

