Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E9745476
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 06:16:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGAyY-0004y3-0n; Mon, 03 Jul 2023 00:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qGAyV-0004xc-N2
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 00:15:43 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qGAyU-0004a0-11
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 00:15:43 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-47e3f56ec02so92083e0c.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 21:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688357741; x=1690949741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIgSAvFCpDNMbRfpqLQrKNiWMGJzaM5rmPi1iG3qgvM=;
 b=JZewX3WnXnpy49ZOFvMYy3WfgdvOb9AA4ZGmTGbcFzFl7uV5ZjrA0QyhX98xk3/66z
 YKuRMsoxua7YCfE15sgQS7Yk3CHbQs+EAOhEgyXQw3whUalBa8DOrGw7SkQ9AXKbfCKE
 V1JlpVK+StoXh1zvybLJRw7CTTsglXiYNJhe6Rszj/NQ6Tow++EYA1DJHdF3oLQvaxxd
 iUzz6CdjzNTj4rO94yAglgwUbHgIQcoATlK01s7HukfwRih7PHjnovnUWTLhLD+Pzuyb
 /C9LeNh+FnF8qY7Ox1Miyi28Q+sNl5RwbH//0nRP+CepzQ4lsjdCH7reHq1OhXREJwNG
 3Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688357741; x=1690949741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIgSAvFCpDNMbRfpqLQrKNiWMGJzaM5rmPi1iG3qgvM=;
 b=IKqDo6+IZ/RRi4CMtJ9X94Tme0CdR2yxcpssjOKee9DJYOgpK+PkBcewoXhLgLNwTK
 4TK3wdguuDjrVPmLAji989PPRSzJGc2Xs/8PJSj9n+hvQb03OA1n6MY63J5ZNLtr4hkE
 07gPFpYG/3HNt57GfKxDHvFQJLEOiDuNd/AzgYZT5MAyk4pb2SHbT6IqWX7M5fbQVzCo
 +QrLc6sdmLhQuaBdf+6+mDl4LBEVWonMg1Iv7wX8DtOSknL9nLEAuY6+envueQMs6zHC
 G5A5YZBUCQ8Sdr4yFSsEeRwMk26luAAZ95Ma4WRrgLt7CIpXRJD/91+l4AHBzUpi+am7
 BRVw==
X-Gm-Message-State: ABy/qLZZiISH7IiX9iPxnj103i4NBbpEtKDlE6WCjPmLK4li6SMZEyZ9
 N//qm6t/Scr/MymeyU4UCgvThB12XuRGJ9hH7Zz7sxemus2x0WPv
X-Google-Smtp-Source: APBJJlHzntdz9XwqcGW3QLNnbodSzw1/1Af0kZF0BljTZp5Lzxk4mTJSR5KK9AQDC7fPyTAJPGNiW6qa4XmHtqWV7VI=
X-Received: by 2002:a1f:4ec6:0:b0:47e:3f56:e91e with SMTP id
 c189-20020a1f4ec6000000b0047e3f56e91emr527894vkb.15.1688357740918; Sun, 02
 Jul 2023 21:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-FQ7uOUhAhmgqBOv5fYukFmz-hSp=XEaeyrmiAi2_UBncU0A@mail.gmail.com>
In-Reply-To: <CAK-FQ7uOUhAhmgqBOv5fYukFmz-hSp=XEaeyrmiAi2_UBncU0A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Jul 2023 14:15:13 +1000
Message-ID: <CAKmqyKO8JoN91S1n6oZGUB1BVGuat04BPjzvv1gZ1zs8QbY8tw@mail.gmail.com>
Subject: Re: QEMU RISC-V
To: Peter Samir <petersamir06423852@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sun, Jun 25, 2023 at 8:27=E2=80=AFAM Peter Samir
<petersamir06423852@gmail.com> wrote:
>
> hello,
> I built RISC-V toolchain and QEMU as follows:
> # Install prerequisites: https://github.com/riscv-collab/riscv-gnu-toolch=
ain#prerequisites
> # Install additional prerequisites: https://github.com/riscv-collab/riscv=
-gnu-toolchain/issues/1251
> git clone https://github.com/riscv-collab/riscv-gnu-toolchain
> cd riscv-gnu-toolchain
> ./configure --prefix=3D/home/RISCV-installed-Tools --with-arch=3Drv32i_zi=
csr --with-abi=3Dilp32
> make
> make build-qemu
>
>
> QEMU Version:
> qemu-riscv32 version 7.1.0 (v7.1.0)
> Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers
>
>
> i debug as follows:
> riscv32-unknown-elf-gcc -g test.S -o test
> qemu-riscv32 -g 3333 test
> // in another terminal
> riscv32-unknown-elf-gdb test -ex "target remote :3333"
>
> but Qemu reports this error when I use CSR instructions:
> Program received signal SIGILL, Illegal instruction. main () at main.S:2 =
2 main: csrw mepc, t0
>
> how to resolve this error ?

Hello,

From what you have provided it does seem like QEMU is doing the correct thi=
ng.

You are trying to run a Linux user application (test.S) which is
trying to access the mepc CSR. That is going to result in an illegal
instruction exception as only Machine mode (M-mode) firmware can
access the MEPC CSR.

If you didn't intend to run a Linux user application you should use
QEMU softMMU, which is the `qemu-system-riscv32` binary. That will
allow a full system emulation. Obviously then you need to make sure
your executable matches the machine hardware you are using (memory
addresses for example). If using the virt machine you will also want
to disable OpenSBI (-bios none) to run your own M-mode code.


Alistair

