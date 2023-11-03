Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A307E0931
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 20:09:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyzWI-00046l-5u; Fri, 03 Nov 2023 15:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyzWF-00046N-1R
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 15:07:47 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyzWD-0000dO-Ei
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 15:07:46 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo3925354a12.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699038462; x=1699643262; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jGvw9CTqwNw3d96vCVMZAxQ3AuajvTx8HfDFwKr1rIQ=;
 b=f+SZkxHFajlUv5QI+YTqEEynFUjkx0kY0UJq/xvHv7z0VENo+b8o0Ltk6k0d2ypax2
 8Gz38lbAsQFEsoafMAVkKR+tGc1e/RyOs6i4jFYsNVeTnSWxREr2cLxOaCh8ZtOCkaoc
 ozaEaLRaINY7pTljFDiNIU9kdreushrLTrhp6wv5ZPPR1UcM8SY5CztmKW8/bX9ELbnl
 J3MRY0MtdO78D4Wih0gfm+Y+x51/RO5cC82R9A7MXnx0Mb9HndTO6Gm/SAVKJ/V8WByd
 1AyK7eRHRjJlgB4vfoyl14Mldqqi4mK2oMzF92zXYQR5P1yrG54Q9se4IqFUAMMZ+mRW
 yNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699038462; x=1699643262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGvw9CTqwNw3d96vCVMZAxQ3AuajvTx8HfDFwKr1rIQ=;
 b=RSkfCY83G6pfEMifnzCowq/YMXU3q2ILLrvWYk0sJ2yYg7/1Ql+cZJJvqsCEws/cyY
 ZplkjzZBp6UtvpayriE8Ht2U3YrKMrF2OhFVQAdBUqrgbFWQDLgxWQ1SSyFCYPPPiPCH
 pLmcum2DTWOy1gobThfPcUo4CCC1bxUc0h7KzeBORk8wgLZy/mRVZWzXjFUmAleacbEI
 Uv6klT7jubFqflj9phNhQ9DZ64eguOcVXP0LsvIa6wPLTIvf4tuoZOa3/a3PyGMMH25O
 E1V22AXMZMST8EdHB6W2UyBxPr0s6jt+eWnJ6gNFw38HyLk9XdeTMPlRRMTxlIq/Bzx3
 xlvw==
X-Gm-Message-State: AOJu0YysOX1OGKW+DXQtwW5XMxhncQS25TphBCpk93c1QP4VUkYNosWb
 XwGGnfT2wDZHtcxSLEQY9RqwDTl9fkUuZSTam/dzrw==
X-Google-Smtp-Source: AGHT+IEfW292xGLlwykPxJyMDLJ9AY9Y4tCnWqBdGG2vmaU3xvzf3W+6ffC2QbTcbQ9VdseQxGkzrj7rkRI7iAb73/w=
X-Received: by 2002:a50:8d12:0:b0:543:5886:71c3 with SMTP id
 s18-20020a508d12000000b00543588671c3mr9979144eds.25.1699038462191; Fri, 03
 Nov 2023 12:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
 <20231026001542.1141412-44-richard.henderson@linaro.org>
In-Reply-To: <20231026001542.1141412-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2023 19:07:30 +0000
Message-ID: <CAFEAcA-eyWiRFD_h+CFJC1vyouUSGroQ27iLxnF--B6HhXkM8A@mail.gmail.com>
Subject: Re: [PULL 22/94] target/sparc: Move RDASR, STBAR, MEMBAR to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 26 Oct 2023 at 01:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +static TCGv do_rdgsr(DisasContext *dc, TCGv dst)
> +{
> +    gen_trap_ifnofpu(dc);
> +    return cpu_gsr;
> +}
> +
> +TRANS(RDGSR, 64, do_rd_special, true, a->rd, do_rdgsr)

Hi; Coverity complains (CID 1523706) that we don't check
the return value from this call to gen_trap_ifnofpu(),
whereas we do check it on all but one other call.
Is this OK?

(Similarly in do_wrgsr(), CID 1523707.)

thanks
-- PMM

