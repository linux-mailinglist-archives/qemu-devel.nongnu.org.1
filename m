Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4409F7CB037
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:49:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQmW-0007Md-J6; Mon, 16 Oct 2023 12:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQmB-0007Ku-Uf
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:49:07 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQm9-0006DK-8Y
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:49:07 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53da72739c3so7987203a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697474943; x=1698079743; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gxoOtV8LW3y4o404KQc9Wo/aX2aY114NNMVZTDq1t/Q=;
 b=P3zyvkkNnbFWRoTu4og1emQ2FnKPJpdt58ozDfnaa8/RFn9l2nosrNqN8NYF3Yzfd7
 FOsgVQ2g4vYk/NbQp79Sk6DjE4x8YfkXmff63K3omAJwwUQ4pqHMOM+CeeKUWg213OAi
 Kse9nJSzwo9V1C7RHni/DqH2yt6CQCrt1OTdgYL+/Y2AZUP17ezv2HFIyVq3T0wmYgwD
 hkRlFzFPVpj88/d/HNZfFmTe9Q24WlfMkeYyBSC/T7DbtLhpMNrbOdu0atbM2ltE1+8L
 scGMSMOnP1QR6JHA3g/L6OqSN5V1uaXMp5xjTJJRzL1Y3lP92o24CwwGIl/9dcCbBeMm
 wGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697474943; x=1698079743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxoOtV8LW3y4o404KQc9Wo/aX2aY114NNMVZTDq1t/Q=;
 b=SJ17286d9Iv8egoTFcyFgmVxGHiksCWx6Ks1xQ4jbbWRKAodD8A7ilxj4RTTgvlpMb
 7p+UpTfLQc9FVG8EYRNpzkmhB/SOjARS2t0AUFMgA/lRnldyESXMZVaQRk7fcvaqHHwD
 UytDknqJJ6vSw7NTAjYxu0HvuZWm7XQac6J4xiUv3csdUfEAA1xtWSCStWHMmNzxJdzS
 w2kYZBe4geZiBgwMF6A2RRFskSzAIuQ0U1nMv3k3UFgf+TdCzLorUQBMlRFUBrwVtHsL
 0ahIr30MbmChE/4C1lQJnFBp/hRyx02F5nLkMQ/6wvSwbqxEKM5/5FsjC+R4F/IHsF+Q
 KeQQ==
X-Gm-Message-State: AOJu0Yy0oIMpVuvGqD/5HQOrU6Extdm4La84dw5bn9BUIFjYGVxzuvrm
 fVccN7I0UqunfPADKPxuWkrAGsYtvZVHwt43ynioDQ==
X-Google-Smtp-Source: AGHT+IEDECBFvYkOAheAAhjBMvEi6r5DLv7fMVzC5Foe174Eb67NCqp2TtVH4LBq9mp6svwDus2wBmUu1qx/PU6B1Ro=
X-Received: by 2002:a05:6402:4306:b0:53d:e5d7:4148 with SMTP id
 m6-20020a056402430600b0053de5d74148mr15482766edc.1.1697474943345; Mon, 16 Oct
 2023 09:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <169635378817.28428.8916197505999208589-0@git.sr.ht>
 <169635378817.28428.8916197505999208589-1@git.sr.ht>
In-Reply-To: <169635378817.28428.8916197505999208589-1@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 17:48:52 +0100
Message-ID: <CAFEAcA9ziEdL3JFYS6b1zY8cNaS=1imYWS6byOhHraA2kfVJ7A@mail.gmail.com>
Subject: Re: [PATCH qemu 1/1] Switch memory management calls to new coding
 conventions
To: "~h0lyalg0rithm" <surajshirvankar@gmail.com>
Cc: qemu-devel@nongnu.org, trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 3 Oct 2023 at 18:23, ~h0lyalg0rithm <h0lyalg0rithm@git.sr.ht> wrote:
>
> From: Suraj Shirvankar <surajshirvankar@gmail.com>
>
> Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>

Hi; thanks for this patch. Mostly it looks good, but I
have a couple of review comments; details below.

> ---
>  contrib/elf2dmp/addrspace.c | 4 ++--
>  contrib/elf2dmp/main.c      | 4 ++--
>  contrib/elf2dmp/pdb.c       | 4 ++--
>  contrib/elf2dmp/qemu_elf.c  | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
> index 64b5d680ad..3bfbb5093c 100644
> --- a/contrib/elf2dmp/addrspace.c
> +++ b/contrib/elf2dmp/addrspace.c
> @@ -72,7 +72,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
>          }
>      }
>
> -    ps->block = malloc(sizeof(*ps->block) * ps->block_nr);
> +    ps->block = g_new(struct pa_block, ps->block_nr);
>      if (!ps->block) {
>          return 1;
>      }

Unlike malloc(), g_new() can never fail. So the error check
for NULL becomes redundant, and we can remove it. Similarly
in the other cases below (including the g_malloc() call).

> @@ -97,7 +97,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
>  void pa_space_destroy(struct pa_space *ps)
>  {
>      ps->block_nr = 0;
> -    free(ps->block);
> +    g_free(ps->block);
>  }
>
>  void va_space_set_dtb(struct va_space *vs, uint64_t dtb)
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index 5db163bdbe..97baf0c0c1 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -120,14 +120,14 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb,
>          }
>      }
>
> -    kdbg = malloc(kdbg_hdr.Size);
> +    kdbg = g_malloc(kdbg_hdr.Size);
>      if (!kdbg) {
>          return NULL;
>      }
>
>      if (va_space_rw(vs, KdDebuggerDataBlock, kdbg, kdbg_hdr.Size, 0)) {
>          eprintf("Failed to extract entire KDBG\n");
> -        free(kdbg);
> +        g_free(kdbg);
>          return NULL;
>      }

This isn't the only place where we free the memory we
allocate here. The other place is the "free(kdbg)" at the
bottom of the main() function. So for consistency we should
change that also to g_free().

> diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
> index 6ca5086f02..625001d1cf 100644
> --- a/contrib/elf2dmp/pdb.c
> +++ b/contrib/elf2dmp/pdb.c
> @@ -116,7 +116,7 @@ static void *pdb_ds_read(const PDB_DS_HEADER *header,
>
>      nBlocks = (size + header->block_size - 1) / header->block_size;
>
> -    buffer = malloc(nBlocks * header->block_size);
> +    buffer = g_malloc(nBlocks * header->block_size);
>      if (!buffer) {
>          return NULL;
>      }

Similarly here the buffer we allocated is usually returned
from this function, assigned to some struct field, and then
free()d much later on. So we should also switch all the other
free() calls in this file to g_free().

We should end up with no calls to free() left at all in
the contrib/elf2dmp/ source files, I think.

> @@ -201,7 +201,7 @@ static int pdb_init_symbols(struct pdb_reader *r)
>      return 0;
>
>  out_symbols:
> -    free(symbols);
> +    g_free(symbols);
>
>      return err;
>  }
> diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
> index de6ad744c6..9aa8715108 100644
> --- a/contrib/elf2dmp/qemu_elf.c
> +++ b/contrib/elf2dmp/qemu_elf.c
> @@ -94,7 +94,7 @@ static int init_states(QEMU_Elf *qe)
>
>      printf("%zu CPU states has been found\n", cpu_nr);
>
> -    qe->state = malloc(sizeof(*qe->state) * cpu_nr);
> +    qe->state = g_new(QEMUCPUState*, cpu_nr);
>      if (!qe->state) {
>          return 1;
>      }
> @@ -115,7 +115,7 @@ static int init_states(QEMU_Elf *qe)
>
>  static void exit_states(QEMU_Elf *qe)
>  {
> -    free(qe->state);
> +    g_free(qe->state);
>  }
>
>  static bool check_ehdr(QEMU_Elf *qe)
> --
> 2.38.5

thanks
-- PMM

