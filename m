Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC1A71760A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ECP-0004dI-Kj; Wed, 31 May 2023 01:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1q4ECG-0004Hu-CY
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:16:32 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1q4ECE-0003WI-AK
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:16:32 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-56896c77434so22719087b3.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685510188; x=1688102188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0IO/94N8fuHa6EKiwYSveUosqi4K0437B2Tji3EmiE=;
 b=QJFuGPZhdBDjvaeaD7B/CpkbGbGRV+hNCXGBIpLmWJxMdKGjMXX2/S27bEPCpkbtvB
 Tq4F3kRf2eWeLaUVBWjogXMwZhLVNxWbFAD3BtaAuirfBLMfYneSH2cgP933GFUEDs5b
 ZHaEaAVVEePz/jh2m2ch7rlAE9qYfp3/OmA4gBaEta2N04yEb9MSL/qUTu9OjmuigbKX
 pOi7T9FSQFdUQIArs5xwoftW9cEpllWTfGfjJjgeBMMdbabndtHw4WnMp6rXfQCIzHgr
 FHNVhhbY9wdOujjGJ+GpcULDkZanZ9Fqz7iKF+MIx0uGXXUV4KaKLobEeqzn/U/kQ+4c
 BePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685510188; x=1688102188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0IO/94N8fuHa6EKiwYSveUosqi4K0437B2Tji3EmiE=;
 b=GkqKVuFkN+Lh+hpeZzQJUcZHrmBB924+0lLH5VsSZOpEiEtRLbxaurtUXcHYh16VCd
 ZskprYp3GaS6aLmHBlc+04Zx1+TSNlzmXSvT0MxCT7SmvInCNO+pHdSqhvmswGVWQw8F
 mwM94ExfoWI7BTSjuM7Ptb6Snj6DXW3cUzSNZWl3W6pbxwE5MnO3JidO7E3jceDjwW7N
 dVFncwft4PwCNUaEcHGSZaHsLHsBRow/hfcewfvNv+Sd9c3mMU5fD6rzpVGvu5tM59sf
 z9rGO3Qh//mffApGhAqKw43UnZAUCfYs2+2KjB7DcoRHCnFcxXHQxsrchlUu79tBoTxl
 HOtA==
X-Gm-Message-State: AC+VfDxuabs6kqXBOXQdahQLGlkJFuKNTxAQDvOr8WhYJb/jA6PLTE1l
 R3O+73XOuUt3QbcXSb9TquPykkNxnlNA/2I/me4j3Q==
X-Google-Smtp-Source: ACHHUZ6eS3VoTmO1ME6bPOnQiWyw6OB+v+N4qYJOeln5HgHdircLxN5ASp4faT0mYohU9hPCHM4wcSqkgVlcITQy6hc=
X-Received: by 2002:a0d:d752:0:b0:565:6634:d106 with SMTP id
 z79-20020a0dd752000000b005656634d106mr5280699ywd.2.1685510188231; Tue, 30 May
 2023 22:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230526121006.76388-1-sunilvl@ventanamicro.com>
In-Reply-To: <20230526121006.76388-1-sunilvl@ventanamicro.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 31 May 2023 10:46:17 +0530
Message-ID: <CAK9=C2VRF-QobT_-qObOAnjqk8haxOUkmnsPCtCKuRk3pL+jPw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] hw/riscv/virt: pflash improvements
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrea Bolognani <abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=apatel@ventanamicro.com; helo=mail-yw1-x1132.google.com
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

On Fri, May 26, 2023 at 5:41=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> This series improves the pflash usage in RISC-V virt machine with solutio=
ns to
> below issues.
>
> 1) Currently the first pflash is reserved for ROM/M-mode firmware code. B=
ut S-mode
> payload firmware like EDK2 need both pflash devices to have separate code=
 and variable
> store so that OS distros can keep the FW code as read-only.
>
> The issue is reported at
> https://salsa.debian.org/qemu-team/edk2/-/commit/c345655a0149f64c5020bfc1=
e53c619ce60587f6
>
> 2) The latest way of using pflash devices in other architectures and libv=
irt
> is by using -blockdev and machine options. However, currently this method=
 is
> not working in RISC-V.
>
> With above issues fixed, added documentation on how to use pflash devices
> in RISC-V virt machine.
>
> This patch series is based on Alistair's riscv-to-apply.next branch.
>
> Changes since v4:
>         1) Updated patch 2 to avoid accessing private field as per feedba=
ck from Philippe.
>         2) Updated documentation patch to add read-only for ROM usage.
>         3) Rebased to latest riscv-to-apply.next branch and updated tags.
>
> Changes since v3:
>         1) Converted single patch to a series with a cover letter since t=
here are
>            multiple patches now.
>         2) Added a new patch to enable pflash usage via -blockdev option.
>         3) Separated the documentation change into new patch and updated =
the
>            documentation to mention only -blockdev option which seems to =
be the
>            recommended way of using pflash.
>
> Changes since v2:
>         1) Reverted v2 changes and used v1 approach so that pflash0 can b=
e used
>            for code and pflash1 for variable store.
>         2) Rebased to latest riscv-to-apply.next branch.
>         3) Added documentation for pflash usage.
>
> Changes since v1:
>         1) Simplified the fix such that it doesn't break current EDK2.
>
> Sunil V L (3):
>   hw/riscv: virt: Assume M-mode FW in pflash0 only when "-bios none"
>   riscv/virt: Support using pflash via -blockdev option
>   docs/system: riscv: Add pflash usage details

In case of KVM guests, there is no M-mode so pflash0 will always
contain S-mode FW.

I suggest improving this series to consider KVM guests as well
such that the same EDK2 S-mode works for KVM and TCG guests.

Regards,
Anup

>
>  docs/system/riscv/virt.rst | 29 ++++++++++++++++++++
>  hw/riscv/virt.c            | 56 +++++++++++++++-----------------------
>  2 files changed, 51 insertions(+), 34 deletions(-)
>
> --
> 2.34.1
>
>

