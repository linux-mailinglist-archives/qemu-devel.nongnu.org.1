Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 575EBA01E86
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Jan 2025 05:30:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUek1-0003Ua-8J; Sun, 05 Jan 2025 23:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUejz-0003UI-F1; Sun, 05 Jan 2025 23:29:23 -0500
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUejx-0007Q0-Ef; Sun, 05 Jan 2025 23:29:23 -0500
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4aff1c57377so7587800137.0; 
 Sun, 05 Jan 2025 20:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736137760; x=1736742560; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuFI7RkRmxxwoshLH40eINkSPkT//bM3qf+i04U9X9Q=;
 b=ih6S74Irsgl0RDXwgWamZ8viqq5D9Qsr76dS4/kgngIukM6MO7V3PknBkp529e6t5P
 gpCOYPxAd6F7pauYfytbBdj8U1tNMWh09Imql9DOGaW+d+7jq8kFJ7ZI30KamrnqZ+N3
 2odcxQGXst+ke0wGB1P66IlneqnPKiakSCGS7FFdMjnbQNWNwLbUB98dTwfbamDpCnrg
 7Z0bHnz1+D3mOnoci8/WopZ+dNFs3ECRBINmNif3fRT+ki6YIFWcyq6MBFPLK+YjcDkE
 GVeUby8/4Cdsn+S2PQuFlQqEqpcoEbZYoADIVZWp3vEKQ019YxQgv0E3LJiFa8L+OCGr
 kzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736137760; x=1736742560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fuFI7RkRmxxwoshLH40eINkSPkT//bM3qf+i04U9X9Q=;
 b=M2cFwFikS01d0WE9UabdOVoScJNFifl6cUCKaR42PSnhGvoVHsJozwbYI0p+dAxDo6
 XYDHNZuuvLWyHc+xeqn9p87TGKxJNP+eyulRYDlhgmq7QrnQXdjvV7vA/ztg/5my/gl7
 bW5qlTCqFN8t61LDRdjvvwTAUWJFrV6fZexMfbyzgUX/admzsrS1VdhLmaLbeTQh0FZs
 4lSlXHQQmNitMGX9rz+tikn6T8eC/jvBLIAnCkD7GRn+wNe7USbjdCX6It90aJWz9bpp
 CnEErwAU6aHEiNSqE8L4N7M5MW3XBOb2QkdH3mXzdE/EYk2eyYUUu5bsFOrnwwR83Udj
 tw6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEGDhtXSjryqXaAKXCvCjyP0H8YUKUiymwdOiG11a/umrsHfWqk31ZhVe6Yl/IGrlgAHZsUsnCQvgZ@nongnu.org
X-Gm-Message-State: AOJu0YwDkUEDHHZEbLF1c3qWsntH9XeHyy+6rflW6ndN17hCiG6ehXjg
 hv9G6FGr3RBtWiEjHveHJzZ5hyXi7Xb1ngoWTfm9fHeC52MqOoc2FcAbTTsKL9iXAvVkiKhcSyl
 S5Q7Pc7/lIXAr9I8+HIlJEfRZ41Cjy/tW
X-Gm-Gg: ASbGncvtOJYje8bJMSbAgiFitzUCeFRCgwZzmJLeK2qkDpCYr2+P3Z0Yk+eHGO7u1G1
 G0Yk5eH3yRODECkvb3KZOleNudG2l/iRyK4lx6ia+E45l9PFIy8gw9zax9ACGf+uxNEY=
X-Google-Smtp-Source: AGHT+IFuQPl+oTA/qf9naQ2ZJjBUBvnjxfQD1YHX/YxHWHU6Jv/FA4NwdKxNTnxx50/ctmKIuBMLStwo6Q3ic0qLC9I=
X-Received: by 2002:a05:6102:5e8c:b0:4b2:9e8b:1e7a with SMTP id
 ada2fe7eead31-4b2cd6a0882mr43788965137.2.1736137759815; Sun, 05 Jan 2025
 20:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20241231032654.133039-1-frank.chang@sifive.com>
In-Reply-To: <20241231032654.133039-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 14:28:53 +1000
Message-ID: <CAKmqyKN19OWFHKuMW-nYpO4CGKERotBhFySAP=_mcn_s9JjAKA@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] Add Smrnmi support
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Tue, Dec 31, 2024 at 1:28=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> This patchset added support for Smrnmi Extension in RISC-V.
>
> There are four new CSRs and one new instruction added to allow NMI to be
> resumable in RISC-V, which are:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   * mnscratch (0x740)
>   * mnepc     (0x741)
>   * mncause   (0x742)
>   * mnstatus  (0x744)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   * mnret: To return from RNMI interrupt/exception handler.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> RNMI also has higher priority than any other interrupts or exceptions
> and cannot be disabled by software.
>
> RNMI may be used to route to other devices such as Bus Error Unit or
> Watchdog Timer in the future.
>
> The interrupt/exception trap handler addresses of RNMI are
> implementation defined.
>
> If anyone wants to test the patches, we can use the customized OpenSBI[1]=
,
> and the customized QEMU[2].
>
> We implemented a PoC RNMI trap handler in the customized OpenSBI.
> In the customized QEMU, we use the Smrnmi patches and the patch from
> Damien Hedde[3]. The patch from Damien Hedde can be used to inject
> the RNMI signal with the qmp command.
>
> [1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
> [2] https://github.com/sifive/qemu/tree/upstream-smrnmi-v11
> [3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html
>
> Test commands :
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=3Dtrue,
> rnmi-interrupt-vector=3D{Offset of the RNMI handler in the customized
> OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
> -bios fw_jump.elf -kernel Image -initrd rootfs.cpio
> -qmp unix:/tmp/qmp-sock,server,wait=3Doff
>
> Use qmp command to inject the RNMI.
>
> Assert RNMI:
> $ ./scripts/qmp/qmp-shell /tmp/qmp-sock
> (QEMU) gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi numbe=
r=3D0 value=3Dtrue
>
> De-assert RNMI:
> (QEMU) gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi numbe=
r=3D0 value=3Dfalse
>
> Changelog:
>
> v11
>   * Squash patch 7 into patch 5.
>   * Remove "DEFINE_PROP_END_OF_LIST()" from "riscv_harts_props[]" for
>     the upcoming "DEFINE_PROP_END_OF_LIST()" removal.
>
> v10
>   * Disable Smrnmi for the 'max' type CPU.
>
> v9
>   * Add Zicfilp support for Smrnmi.
>   * Change the existence checks for 'rnmi-interrupt-vector' and
>     'rnmi-exception-vector' to use 'num_rnmi_irqvec' and 'num_rnmi_excpve=
c'.
>   * Add warn_once messages for cases where the user sets
>     'rnmi-interrupt-vector' or 'rnmi-exception-vector' property without
>     enabling Smrnmi.
>
> v8
>   * Set virt to false when trapping to M-mode by RNMI.
>   (Thanks to Cl=C3=A9ment for the suggestions.)
>
> v7
>   * Rename 'nmi_execp' to 'nnmi_excep' and refactor RNMI exception
>     checking codes.
>   (Thanks to Cl=C3=A9ment for the suggestions.)
>   * Add the missing REQUIRE_SMRNMI() check and remove the redundant
>     check in 'helper_mnret'.
>   * Rebase to riscv-to-apply.next.
>   (Thanks to Alistair for the suggestions.)
>
> v6
>   * Delete the redundant code in 'riscv_cpu_do_interrupt'.
>   (Thank Alvin for the suggestion.)
>   * Split the shared code in 'helper_mret' and 'helper_mnret' into a
>     helper function 'check_ret_from_m_mode'.
>   (Thank Alistair for the suggestion.)
>
> v5
>   * Move the patch that adds the Smrnmi extension to the last patch.
>   (Thank Alistair for the suggestion.)
>   * Implement an M-mode software PoC for this with implemented handlers.
>   (Thank Andrew Jones for the suggestion.)
>   * Add a commit message to all patches of the series.
>   (Thank Andrew Jones for the suggestion.)
>
> v4
>   * Fix some coding style issues.
>   (Thank Daniel for the suggestions.)
>
> v3
>   * Update to the newest version of Smrnmi extension specification.
>
> v2
>   * split up the series into more commits for convenience of review.
>   * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.
>
> Frank Chang (1):
>   target/riscv: Add Zicfilp support for Smrnmi
>
> Tommy Wu (5):
>   target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
>   target/riscv: Add Smrnmi CSRs
>   target/riscv: Handle Smrnmi interrupt and exception
>   target/riscv: Add Smrnmi mnret instruction
>   target/riscv: Add Smrnmi cpu extension

Do you mind rebasing on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?

Alistair

>
>  hw/riscv/riscv_hart.c                         | 42 +++++++-
>  include/hw/riscv/riscv_hart.h                 |  4 +
>  target/riscv/cpu.c                            | 18 ++++
>  target/riscv/cpu.h                            | 10 ++
>  target/riscv/cpu_bits.h                       | 24 +++++
>  target/riscv/cpu_cfg.h                        |  1 +
>  target/riscv/cpu_helper.c                     | 96 +++++++++++++++++--
>  target/riscv/csr.c                            | 82 ++++++++++++++++
>  target/riscv/helper.h                         |  1 +
>  target/riscv/insn32.decode                    |  3 +
>  .../riscv/insn_trans/trans_privileged.c.inc   | 20 ++++
>  target/riscv/op_helper.c                      | 54 ++++++++++-
>  target/riscv/tcg/tcg-cpu.c                    |  6 ++
>  13 files changed, 349 insertions(+), 12 deletions(-)
>
> --
> 2.34.1
>
>

