Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C27F56D7
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 04:11:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r607D-00019u-NE; Wed, 22 Nov 2023 22:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r6078-00019V-F6
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 22:10:51 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r6076-0003Or-U1
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 22:10:50 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7c45acb3662so125479241.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 19:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700709048; x=1701313848; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKiqu7VIJI5IpnW5QYFZHgqNtVqLJQDInREtWu0qSn0=;
 b=GtTIlXMR7lpvhnSFQgKxgXFPtTC6Xbn5PVyLXl6FwGjqs9Jj9YDjAFmnmWTF8eV3Nr
 MEan2Lr1g8YamRfqJfHg8J+Uhg9w0d52FGEqlsN1ts1hV4i/GEAPFU3L6qWE2W4jctRa
 xodsAUww7S90n8VdXUhMgEmWx3HdQP4XZmaD+cdYqYT8kqAOBkOJwd3snuvZueNlu1Wm
 FEwMEKOuS5+yZqzYFFpxRhGoqQ+9sVNvDuNrihm2eCSUrB1E5bscUriyURTHy7+if9LI
 ZmcI2EQQgIhcq/+NWmyOTFmSYuNcge8vzJhuJ0kpt4QGdIY3sJqKqOVWjYqOzhIqIXwf
 6o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700709048; x=1701313848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKiqu7VIJI5IpnW5QYFZHgqNtVqLJQDInREtWu0qSn0=;
 b=bZmU9zIOnkxFj1sgQke3j6ovIsVPcKEMEbcMrOFUTeUyAq/47Or4eqH3pavU5rUUxB
 zmJfx4X9XY6/ai+hlyR13LMxvy+bzPXOfhbdvmUX7pmAPtrnHTajbZ9pkq4rdk0DilFf
 i/7DLTDvqka0GTJSYCCOBxRbTAG+UAOAbpX3TlOLQ3f6leCcRDNBr7IwKHvibRFg4ypb
 ef2ltxw7NoAjIL49Jtu++imbG/yIbTpkcC2TFIiuHNtXEd7JybwfcteExlU0+7z64n91
 gKmaSdxXGjKrsS6xOlLo1fQQTxP19NbNWNF+rNWBEYNu9UAP3QsBd16CjUDcvjfllgl+
 lV/w==
X-Gm-Message-State: AOJu0YzMg9La3HPgwKodZT+mSeDH4m+dSoNDLNpIy2iTRswdjLVgTzgU
 Wgzg8vn1XhVXa1NMZr6e3cd2URhqdT6S8CAeClI=
X-Google-Smtp-Source: AGHT+IHRyuk9vJ7wJpyUMPygBffKw0MeXERdHyJR/LgWgqGCKHPMeuMQ3IUMFBxy56nwWKshKrhnWh385zyZLJ5fQD8=
X-Received: by 2002:a05:6102:471b:b0:462:7ea5:e843 with SMTP id
 ei27-20020a056102471b00b004627ea5e843mr3853569vsb.4.1700709047810; Wed, 22
 Nov 2023 19:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20231030054834.39145-1-akihiko.odaki@daynix.com>
In-Reply-To: <20231030054834.39145-1-akihiko.odaki@daynix.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Nov 2023 13:10:21 +1000
Message-ID: <CAKmqyKNzYdDVQgQn-8eB_-CZtw=oobsCmOe4SQa3H_LQpczyxQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] gdbstub and TCG plugin improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov <a.anenkov@yadro.com>,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Oct 30, 2023 at 3:49=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Based-on: <20231029145033.592566-1-alex.bennee@linaro.org>
> ("[PATCH v2 00/19] Maintainer updates for testing, gdb, semihosting and
> plugins (pre-PR)")
>
> This series extracts fixes and refactorings that can be applied
> independently from "[PATCH v9 00/23] plugins: Allow to read registers".
>
> The patch "target/riscv: Move MISA limits to class" was replaced with
> patch "target/riscv: Move misa_mxl_max to class" since I found instances
> may have different misa_ext_mask.

What instances? Couldn't MXL have the same differences?

Alistair

>
> V5 -> V6:
>   Added patch "default-configs: Add TARGET_XML_FILES definition".
>   Rebased.
>
> V4 -> V5:
>   Added patch "hw/riscv: Use misa_mxl instead of misa_mxl_max".
>
> V3 -> V4:
>   Added patch "gdbstub: Check if gdb_regs is NULL".
>
> V2 -> V3:
>   Restored patch sets from the previous version.
>   Rebased to commit 800485762e6564e04e2ab315132d477069562d91.
>
> V1 -> V2:
>   Added patch "target/riscv: Do not allow MXL_RV32 for TARGET_RISCV64".
>   Added patch "target/riscv: Initialize gdb_core_xml_file only once".
>   Dropped patch "target/riscv: Remove misa_mxl validation".
>   Dropped patch "target/riscv: Move misa_mxl_max to class".
>   Dropped patch "target/riscv: Validate misa_mxl_max only once".
>
> Akihiko Odaki (5):
>   hw/riscv: Use misa_mxl instead of misa_mxl_max
>   target/riscv: Remove misa_mxl validation
>   target/riscv: Move misa_mxl_max to class
>   target/riscv: Validate misa_mxl_max only once
>   default-configs: Add TARGET_XML_FILES definition
>
>  configs/targets/loongarch64-linux-user.mak |   1 +
>  target/riscv/cpu-qom.h                     |   1 +
>  target/riscv/cpu.h                         |   3 +-
>  hw/riscv/boot.c                            |   2 +-
>  target/riscv/cpu.c                         | 139 ++++++++++++---------
>  target/riscv/gdbstub.c                     |  12 +-
>  target/riscv/kvm/kvm-cpu.c                 |  10 +-
>  target/riscv/machine.c                     |   7 +-
>  target/riscv/tcg/tcg-cpu.c                 |  42 +------
>  target/riscv/translate.c                   |   3 +-
>  10 files changed, 109 insertions(+), 111 deletions(-)
>
> --
> 2.42.0
>
>

