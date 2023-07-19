Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4EE759E99
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 21:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMCsq-0006iM-PZ; Wed, 19 Jul 2023 15:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMCsh-0006g4-9W
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 15:30:39 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMCsd-0001fE-MA
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 15:30:37 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51e57870becso9655821a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689795032; x=1690399832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8sZKxKxkUef7QA6XAWQT1AIq7ODq+rKc1RUUSb0TP2k=;
 b=qLYG42Tw+brymMcewhkNrC2u4CX01KrT1+Rva3WUgPjaQmV8FHs4ou7dsko+aamnYB
 QtTjQxaFQTFwapqjiBHD3irKG+ukB8H95ruR0C6QNyYdnjOinyfCKPWEUQs6iY5NZAzg
 gKVT8Y2W0Se4ItI9RAdpDpb9NobLb6apsbKWCAxxqUCOlCMprE+Akl5PWPfVYfR6x7/v
 88+CCQMoW0xSvibV7HonmA+UIFIUTqHudEvAmd1grifTM+NVsJD07scXBcha68Z5rpFj
 IfQHASMKVnJqh/8grNTKhmFt99VD+JhwXKLH5J6p54McDBzM957nlKfDc4eAGVDbCaP/
 5cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689795032; x=1690399832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8sZKxKxkUef7QA6XAWQT1AIq7ODq+rKc1RUUSb0TP2k=;
 b=a3A7vyF4svodZ+Uw8apUFxd01pnM1KfryjFOV6ueC5ccX6MVTjTkodhwNyzd84zkTw
 +6H+37WhKlxW0ux6U2BcP5/6ZEul5LSg09CBc00ytkgRM4ce/Li+kqzYQERFO8R4TrRN
 fz5eg76QWr8GwzjPkYnvcgzhboR3mYdh1m5p9gI/offg0SjlRg83bw4vjeXbJzLYcG8Q
 yOWU6S7LSnd+v0tcQA9aZUm/phVUU/PBKAYETs6Ey/snHlRISu1ZnEfiYOe/iHnxOIb1
 ejzat4SrBdyhOsj1o3WuyhNOOM3/yZcCto0a1ue+QpC4qckRjXh2++8eRv5DDaUmnCmC
 FMQA==
X-Gm-Message-State: ABy/qLYHNkgelZXaEJHTRIZLkVTr2eObo9DQzDus3MmAaPDFWGm9Iwru
 gBtCSjylmZWMJJ7SjZgAdOSn1NFK4Lnoqax9L7RBduS9VW+ZGyNs
X-Google-Smtp-Source: APBJJlG2ZVcCTIjvhfFrThmU74MBq415t4t7F+8LZM/xQAyzoSQMvYu6AzxW37lfkWusSxOxbp9GEN8HB+d7VSMBWiU=
X-Received: by 2002:aa7:d9d2:0:b0:521:a4bb:374f with SMTP id
 v18-20020aa7d9d2000000b00521a4bb374fmr255856eds.5.1689795032362; Wed, 19 Jul
 2023 12:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230719044538.2013401-1-alistair.francis@wdc.com>
In-Reply-To: <20230719044538.2013401-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2023 20:30:21 +0100
Message-ID: <CAFEAcA__KiWdB_c2pXsj1hiQEtXp=xykzaVZqkFuLFR2iEetyQ@mail.gmail.com>
Subject: Re: [PULL 0/5] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 19 Jul 2023 at 05:46, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit 361d5397355276e3007825cc17217c1e4d4320f7:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-17 15:49:27 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230719-1
>
> for you to fetch changes up to 32be32509987fbe42cf5c2fd3cea3c2ad6eae179:
>
>   target/riscv: Fix LMUL check to use VLEN (2023-07-19 14:37:26 +1000)
>
> ----------------------------------------------------------------
> Fourth RISC-V PR for 8.1
>
> * Fix LMUL check to use VLEN
> * Fix typo field in NUMA error_report
> * check priv_ver before auto-enable zca/zcd/zcf
> * Fix disas output of upper immediates
> * tidy CPU firmware section
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

