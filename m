Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF679F8A9
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcib-0004Tc-UF; Wed, 13 Sep 2023 23:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qgcia-0004TO-8V
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:08:36 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qgciY-0006zd-Jc
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:08:36 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-493545b4eaeso228116e0c.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694660913; x=1695265713; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76pSeW29aii9BtU07A07+KgKtagOHBGoY6ubCKtyyBc=;
 b=lLGeF8Ljq3/A3wsUloXmYudLyu1AECRjLjap/xfvnVAuRRHYqR7ocRWvtRcqkORqlI
 luCLTXcWKGnwvm8UPjkrSKq3CRNAOa2KO0PYSjS8EwG0hhwQjxQ7q3CzFwYGCIhr4C/L
 dy2mxESVyyKgcQj7oh/VVLxUz1pwCWcqMJy+nr81f+/p14l5NY01beuzOiYStpzf0HKZ
 BJ63OOdIHfMDbStGBZlmXmH5EIcHIB3R/5/8nK3uwD6rrj/mGd+nkkBA8WCXiSaiXEKI
 bqImUOjyr/6soyaL0umu0DdhmpgAbyBx0pGYSeSoOzGZKCBnR817mA0qjvhDT1e6ZtNo
 s/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694660913; x=1695265713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76pSeW29aii9BtU07A07+KgKtagOHBGoY6ubCKtyyBc=;
 b=mdEO2gYVJPys/12e5CSe5bVLKB9vs4uuitVeFnLqfNGhC+S2Tt47xLxk/OqjlDQEEs
 bcV9JMSPyWQ50gsrrvUi1f3EhHq+bxoZFA1oWR3T3aAspIYSGaj356LPZBfsC8lWGdYW
 pynXxyawD+Pw2AqKgfj/G3BsDLpD5et0rXzq2Z3ajsUbhZSmIvXXcZQ+bt0H2jSWV4ko
 OlgQrj++N0Z8s4fufASGhxK838ALL2uhLGxnbY64SzVIxxIrL7lY2qjRq43cWxsEmMZu
 MDjnIK6Ik7FziTLIV75zmeHOYhpVcE3YDqZtuu6jenr9TX78ogF15vC2wSq3UXoeFWqf
 LzaQ==
X-Gm-Message-State: AOJu0YyDgPcyN9pCfLNZYgsq1IUl/iyOJ0xQAHhh6t45BU5c5Ra76ua5
 YdIiFkMuPcTzPyQiKuH2xA22z/uznPz4meXpfl4=
X-Google-Smtp-Source: AGHT+IHX0YS4l5GVbyLfs+KH5CaeN9fuaJxc0VgNeRC+cR3c5bMw0QEfDJqMuJbYh1W3sEOtIpcPtePPEEyDxtsSKgM=
X-Received: by 2002:a67:f1cc:0:b0:445:202:d278 with SMTP id
 v12-20020a67f1cc000000b004450202d278mr3689275vsm.32.1694660911736; Wed, 13
 Sep 2023 20:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230911064320.939791-1-alistair.francis@wdc.com>
 <a4e6217f-8d83-944d-6852-b85c276b05f4@tls.msk.ru>
In-Reply-To: <a4e6217f-8d83-944d-6852-b85c276b05f4@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 14 Sep 2023 13:08:04 +1000
Message-ID: <CAKmqyKM4zvpjYCvCak4M2zA8vz+ya=oJpc01xDTXSJDsPoLoUQ@mail.gmail.com>
Subject: Re: [PULL v2 00/45] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Sep 12, 2023 at 8:27=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 11.09.2023 09:42, Alistair Francis:>    target/riscv: don't read CSR in r=
iscv_csrrw_do64 (2023-09-11 11:45:55 +1000)
> 2 more questions about this pull-req and -stable.
>
>
> commit 50f9464962fb41f04fd5f42e7ee2cb60942aba89
> Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Date:   Thu Jul 20 10:24:23 2023 -0300
>
>      target/riscv/cpu.c: add zmmul isa string
>
>      zmmul was promoted from experimental to ratified in commit 6d00ffad4=
e95.
>      Add a riscv,isa string for it.
>
>      Fixes: 6d00ffad4e95 ("target/riscv: move zmmul out of the experiment=
al properties")
>
> Does this need to be picked for -stable (based on the "Fixes" tag)?
> I don't know the full impact of this change (or lack thereof).
>
>
> commit 4cc9f284d5971ecd8055d26ef74c23ef0be8b8f5
> Author: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Date:   Sat Jul 29 11:16:18 2023 +0800
>
>      target/riscv: Fix page_check_range use in fault-only-first
>
>      Commit bef6f008b98(accel/tcg: Return bool from page_check_range) con=
verts
>      integer return value to bool type. However, it wrongly converted the=
 use
>      of the API in riscv fault-only-first, where page_check_range < =3D 0=
, should
>      be converted to !page_check_range.
>
> This one also catches an eye, the commit in question is in 8.1, and it is
> a clear bugfix (from the patch anyway).

These two are also good candidates if it isn't too late.

Alistair

>
>
> I probably should stop making such questions and rely more on Cc: qemu-st=
able@
> instead. It just so happened that I had a closer look at this patchset/pu=
llreq
> while trying to cherry-pick already agreed-upon changes from there.
>
> So far, I picked the following changes for -stable from this pullreq:
>
> c255946e3d hw/char/riscv_htif: Fix printing of console characters on big =
endian hosts
> 058096f1c5 hw/char/riscv_htif: Fix the console syscall on big endian host=
s
> 50f9464962 target/riscv/cpu.c: add zmmul isa string
> 4cc9f284d5 target/riscv: Fix page_check_range use in fault-only-first
> eda633a534 target/riscv: Fix zfa fleq.d and fltq.d
> e0922b73ba hw/intc: Fix upper/lower mtime write calculation
> 9382a9eafc hw/intc: Make rtc variable names consistent
> ae7d4d625c linux-user/riscv: Use abi type for target_ucontext
> 9ff3140631 hw/riscv: virt: Fix riscv,pmu DT node path
> 3a2fc23563 target/riscv: fix satp_mode_finalize() when satp_mode.supporte=
d =3D 0
> 4e3adce124 target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes
> a7c272df82 target/riscv: Allocate itrigger timers only once
>
> Thanks,
>
> /mjt

