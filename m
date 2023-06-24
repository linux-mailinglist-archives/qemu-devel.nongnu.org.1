Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 740D173CD46
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 00:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDBiC-0001IC-Gc; Sat, 24 Jun 2023 18:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <petersamir06423852@gmail.com>)
 id 1qDBVw-0007es-CZ
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 18:13:52 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <petersamir06423852@gmail.com>)
 id 1qDBVu-00075g-Ms
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 18:13:52 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-25eee11a9f1so934297a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687644828; x=1690236828;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8Z4/camMzfyyHAhrgARMgS1UZg6viBuFlu5avSpNLB4=;
 b=c0oHzyaxbJGuEu9bm7xrHnGv/ddBq1rYip7daAjJdRq3mYqMe6mCl6b31zwaPOESxX
 /TpriKD/vLJp6gJtRh1RXfJGdK11UVmkm6P3hu1tpwU/huI//3C+vdqqfxP6hXtX+yu5
 y+HJTQYCqn8JkSrOw0I48CroEbetpfPaRIQ+48CzMf42jMWMgMsOCa8O4ban7sPCgyff
 YyRkucW+twNWnNi+2RtXmycDbgHysw9t58BQMfr0J4XDhUJ7kG9WAIWMJ5IdH9N10lDe
 4mYXdnUo3JYfHSYMFepF5B+3DgpcmkunwTrJ6I2RfFvdQGb8ucskjZ16LuTPerDj8QFL
 vGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687644828; x=1690236828;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Z4/camMzfyyHAhrgARMgS1UZg6viBuFlu5avSpNLB4=;
 b=FUIUBev/sgJ7gnWZtXMb4ZOPNN7nVFtXLuAnRrZu/ZyZNzmiW+jok8EVr3NtE0FKdO
 7CbNw1Z8goLDwd+YUyWCxLp0bxFFJaEuFqbUy3XSuHr9EJB5ncwmmHpu/GtgTPJdVDLh
 jeCozwvwDM4GDl8OhQ9iHHYBIWgDS1xlOQD1DiyGQKL7DlBybVe8W3WF+CfptSwHB1D0
 /U0/HQ2lWxJ3wXjCAVXEUN9AXmyrus8mopzglxYVWWQ56wxRzLpgsn0e35WtsPh7LT3P
 iUXU4TxEW6xKKIstfZZhRBPXpboJ7E4mVQcYocy4hHFrj1836BVO61LhkrBk/2G4FPon
 T1CA==
X-Gm-Message-State: AC+VfDxwXsFufy/t16DzHJwTS3tpAMOW2KOHWihK1a5lCIvQ7EKetoby
 vVZ21ieGlL33IOQWSTDPGnBpl2jmW5YXdU6gsxuSx+1MT+g=
X-Google-Smtp-Source: ACHHUZ6fkXY6IlLx3D47JVKBKW+Aabf47HroaWTMszO4lH15RL9Z0JLMDhhjJzZ4GP8qFHdDHnATz/6H7T1uOae6whs=
X-Received: by 2002:a17:90a:8a8d:b0:23d:286:47d3 with SMTP id
 x13-20020a17090a8a8d00b0023d028647d3mr19602675pjn.40.1687644828356; Sat, 24
 Jun 2023 15:13:48 -0700 (PDT)
MIME-Version: 1.0
From: Peter Samir <petersamir06423852@gmail.com>
Date: Sun, 25 Jun 2023 01:16:21 +0300
Message-ID: <CAK-FQ7uOUhAhmgqBOv5fYukFmz-hSp=XEaeyrmiAi2_UBncU0A@mail.gmail.com>
Subject: QEMU RISC-V
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000080571405fee76ed0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=petersamir06423852@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 24 Jun 2023 18:26:29 -0400
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

--00000000000080571405fee76ed0
Content-Type: text/plain; charset="UTF-8"

hello,
I built RISC-V toolchain and QEMU as follows:
# Install prerequisites:
https://github.com/riscv-collab/riscv-gnu-toolchain#prerequisites
# Install additional prerequisites:
https://github.com/riscv-collab/riscv-gnu-toolchain/issues/1251
git clone https://github.com/riscv-collab/riscv-gnu-toolchain
cd riscv-gnu-toolchain
./configure --prefix=/home/RISCV-installed-Tools --with-arch=rv32i_zicsr
--with-abi=ilp32
make
make build-qemu


QEMU Version:
qemu-riscv32 version 7.1.0 (v7.1.0)
Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers


i debug as follows:
riscv32-unknown-elf-gcc -g test.S -o test
qemu-riscv32 -g 3333 test
// in another terminal
riscv32-unknown-elf-gdb test -ex "target remote :3333"

but Qemu reports this error when I use CSR instructions:
Program received signal SIGILL, Illegal instruction. main () at main.S:2 2
main: csrw mepc, t0

how to resolve this error ?

--00000000000080571405fee76ed0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">hello,=C2=A0</div><div dir=3D"auto">I b=
uilt RISC-V toolchain and QEMU as follows:</div><div dir=3D"auto"># Install=
 prerequisites: <a href=3D"https://github.com/riscv-collab/riscv-gnu-toolch=
ain#prerequisites">https://github.com/riscv-collab/riscv-gnu-toolchain#prer=
equisites</a></div><div dir=3D"auto"># Install additional prerequisites: <a=
 href=3D"https://github.com/riscv-collab/riscv-gnu-toolchain/issues/1251">h=
ttps://github.com/riscv-collab/riscv-gnu-toolchain/issues/1251</a></div><di=
v dir=3D"auto">git clone <a href=3D"https://github.com/riscv-collab/riscv-g=
nu-toolchain">https://github.com/riscv-collab/riscv-gnu-toolchain</a></div>=
<div dir=3D"auto">cd riscv-gnu-toolchain</div><div dir=3D"auto">./configure=
 --prefix=3D/home/RISCV-installed-Tools --with-arch=3Drv32i_zicsr --with-ab=
i=3Dilp32</div><div dir=3D"auto">make</div><div dir=3D"auto">make build-qem=
u</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">QEMU Version:=C2=A0=C2=A0</div><div dir=3D"auto">qemu-riscv32 version=
 7.1.0 (v7.1.0)</div><div dir=3D"auto">Copyright (c) 2003-2022 Fabrice Bell=
ard and the QEMU Project developers</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">i debug as follows:</div><div dir=
=3D"auto">riscv32-unknown-elf-gcc -g test.S -o test</div><div dir=3D"auto">=
qemu-riscv32 -g 3333 test</div><div dir=3D"auto">// in another terminal</di=
v><div dir=3D"auto">riscv32-unknown-elf-gdb test -ex &quot;target remote :3=
333&quot;</div><div dir=3D"auto"><br></div><div dir=3D"auto">but Qemu repor=
ts this error when I use CSR instructions:</div><div dir=3D"auto">Program r=
eceived signal SIGILL, Illegal instruction. main () at main.S:2 2 main: csr=
w mepc, t0</div><div dir=3D"auto"><br></div><div dir=3D"auto">how to resolv=
e this error ?=C2=A0</div><div dir=3D"auto"></div></div>

--00000000000080571405fee76ed0--

