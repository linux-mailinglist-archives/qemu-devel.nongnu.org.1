Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7364E716233
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:38:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zXU-0000hg-OB; Tue, 30 May 2023 09:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zX3-0000Sa-Dw
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:37:02 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zX1-0005FB-Cz
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:37:00 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f4f3ac389eso3545746e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453816; x=1688045816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mNjcxgptO1vtZRA+UZ7T+LHPbP0g2wNlcPNeVaO0qCM=;
 b=kVxZkY6B/cBDk4A/8ymKw4+2yUFlYc/xvEReaGnb0gTk6WrQDe4/0u5NeqSOMS/cIV
 R8Z6mg1XLyM7N4ZsIv1BzG7/IYiP9o6KV9ZjMRtkXX9G4aYnZsPGjDQXD1iGyc0KNGVK
 RhQqiL4PZJD0G2/FJtAJbjtXGrSVUjTLTJ9xxv6an9Yo4ldGKAaHhLr5dVpA2JZ1px+L
 iS6FoUM8fMQ/feFj+lj4L2yC7spgmBeezO148Jgmh5QFjDym0yo6jMROF/iQ3CSljmgq
 rXpsSitiVuEujPFnaxzuPGw1V3xZViW0xgkGf7Qn54bVEzTbY7cCMa4vSM6AazEKVyqT
 RFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453816; x=1688045816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNjcxgptO1vtZRA+UZ7T+LHPbP0g2wNlcPNeVaO0qCM=;
 b=VnV4JyjZL00v8wnnKUpKehEe8erE7lvB+EkGC26vy2/MU2lvnozaMU8O2O44B9SfpP
 lCrBuYrtmFIgutSoTQfMVODbxoWpeXwNVznhXFkMT7N5XJzSksUJQ/MzcVJvtmlADSV+
 +1opOgG0awHUSm1WIJEDxi/WvEvhMtSdSGxQAPpi2YimlLRid8VKjoRRVm/3P3R0Z14r
 8CivV6MDckWOomJ4nWOlC7NcTJsnGTChBzjEcNGrdxCkjpi8JqM4dcan67pz8fXEJxsL
 3ye9JIXZsklf+YjfCfjDGxRh2Ihg5S46l1dNfCwz8nEIVfBFYweDOCglOzBmOvy3LR2R
 9Z0w==
X-Gm-Message-State: AC+VfDwMvWkg8Bzw4Eo3AmNGNhWPg21V+aQ9nqlgDT+IjBX3s6g00tz2
 3ytQw93pcs/OEYLq3gQuy6QFeVDK7NJZ6How7lVu5UjTjjXQ5ZJO
X-Google-Smtp-Source: ACHHUZ4r3p3FtZNW6sRIIilDHupeNSohKY8ZU/NvbJ2CMKWor6Lp+XGviGgVk6zZECE0eAEBCkYBEfyEGEfBU3zq1Us=
X-Received: by 2002:ac2:4c27:0:b0:4f2:53f6:d4bf with SMTP id
 u7-20020ac24c27000000b004f253f6d4bfmr765351lfq.48.1685453816365; Tue, 30 May
 2023 06:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-2-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 14:36:45 +0100
Message-ID: <CAFEAcA8AF8+fZV7H8HnN3Zpv4w9QOMFnP9jRagHZO=CY14P8Nw@mail.gmail.com>
Subject: Re: [PATCH v4 01/16] tcg: Fix register move type in
 tcg_out_ld_helper_ret
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Fri, 26 May 2023 at 01:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The first move was incorrectly using TCG_TYPE_I32 while the second
> move was correctly using TCG_TYPE_REG.  This prevents a 64-bit host
> from moving all 128-bits of the return value.
>
> Fixes: ebebea53ef8 ("tcg: Support TCG_TYPE_I128 in tcg_out_{ld,st}_helper_{args,ret}")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c | 4 ++--

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

