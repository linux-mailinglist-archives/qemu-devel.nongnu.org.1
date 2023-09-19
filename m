Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C75067A697D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:18:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qieMd-00005A-KW; Tue, 19 Sep 2023 13:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qieMc-000052-0D
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:18:18 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qieMa-0007kE-5U
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:18:17 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57359e85e9bso3139057eaf.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695143895; x=1695748695; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L78bHgSwZDTuPNDYVZ/KQqWykhlBpnETgNyzdUqvX8A=;
 b=QkCSju1HpNRZ3ZjUMSu3CA6ExJ1zmYyzo7CJfbHO/0YxMZyera8YL6m/BUVeT1xBA2
 gqVf+dXa4GM3lHDqMHjBodEdOQc+QBLi2Er5AvT5xwlGOPQYrHDRR/8X97Hc9BjAoiEe
 1lDMRT1pCQmWvyQp7FeGLPwjAcJ9wS8GaNZEIdyqPUanlgNVL99HeC0DixU5xV7usb6f
 WkYJmtxNTlitQe7nwfjiFbmbJaYBKGJPDNQp2xIu7Ux+OEpTktS3v7lb32JWLeeYbJjc
 0zR3O/7Y8sPYDYumLtSE3Vu9hNdvVWmmnXr+z0T1Tfl0HiSJOFNr+rijtTbkGB3omcQk
 q6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695143895; x=1695748695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L78bHgSwZDTuPNDYVZ/KQqWykhlBpnETgNyzdUqvX8A=;
 b=gBxPPuJ4rVaQR6MvH6+uU+TKbeP99Zruu+ibIy7kcPrDmbH3T6weQ5hYkUBovivSxJ
 nrc74/+YNCkqKJUPeze+ggJy96AmyrE2Suvv83lfejRYE6joxI/Fo2sG1RqY21x25Gmo
 xRx4mRWtB2RCArRNv+Ib7UcFA72CS+E/JAbe6Uc5Vi/rPiMyS7smREaj1iz4WHiiTsOM
 zFE4NPzcqgbcJSd+FUhve7u8dSyMmyP85SMHXm1vzeFr9N0iOJhnD10ANvc82pSoyBon
 doC0dY18H3oyvbiz+K3XuHbIT/cXdL1rdKap2lMoDLlDzktIwZh4/m8xgswR1J0lxeQY
 tI5A==
X-Gm-Message-State: AOJu0Yx7RLAJ4s3HtDby3K++poQ4HkXQspZZxlPXnwc2mRZ2ztO6FhHX
 DCkCkaMuEUU15VV8ufwxDZr90Ruu6qadF7aDaUY=
X-Google-Smtp-Source: AGHT+IGLDRSENCk5pjW9HE6QN26O9x1q2ymSjxE2f/pie3TMnJnHnS0/u/mi8W8zM64hTxHvQ6GyfbYqhaPzesvX3Wk=
X-Received: by 2002:a4a:3102:0:b0:571:1fad:ebd7 with SMTP id
 k2-20020a4a3102000000b005711fadebd7mr166405ooa.7.1695143894755; Tue, 19 Sep
 2023 10:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230916193235.169988-1-deller@kernel.org>
In-Reply-To: <20230916193235.169988-1-deller@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Sep 2023 13:18:02 -0400
Message-ID: <CAJSP0QVykDpDoH8UVWR+ONv04AFcc91Tx5S5z9VCRXaoRW2paw@mail.gmail.com>
Subject: Re: [PULL 0/8] Hppa btlb patches
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Please take a look at the following CI failure and resend when you
have fixed the error:

mipsel-linux-gnu-gcc -Ilibqemu-hppa-softmmu.fa.p -I. -I..
-Itarget/hppa -I../target/hppa -Iqapi -Itrace -Iui -Iui/shader
-I/usr/include/pixman-1 -I/usr/include/capstone
-I/usr/include/spice-server -I/usr/include/spice-1
-I/usr/include/glib-2.0 -I/usr/lib/mipsel-linux-gnu/glib-2.0/include
-fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g
-fstack-protector-strong -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -Wundef
-Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes
-Wredundant-decls -Wold-style-declaration -Wold-style-definition
-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels
-Wexpansion-to-defined -Wimplicit-fallthrough=3D2
-Wmissing-format-attribute -Wno-missing-include-dirs
-Wno-shift-negative-value -Wno-psabi -isystem
/builds/qemu-project/qemu/linux-headers -isystem linux-headers -iquote
. -iquote /builds/qemu-project/qemu -iquote
/builds/qemu-project/qemu/include -iquote
/builds/qemu-project/qemu/host/include/generic -iquote
/builds/qemu-project/qemu/tcg/mips -pthread -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
-fno-common -fwrapv -fPIE -isystem../linux-headers
-isystemlinux-headers -DNEED_CPU_H
'-DCONFIG_TARGET=3D"hppa-softmmu-config-target.h"'
'-DCONFIG_DEVICES=3D"hppa-softmmu-config-devices.h"' -MD -MQ
libqemu-hppa-softmmu.fa.p/target_hppa_mem_helper.c.o -MF
libqemu-hppa-softmmu.fa.p/target_hppa_mem_helper.c.o.d -o
libqemu-hppa-softmmu.fa.p/target_hppa_mem_helper.c.o -c
../target/hppa/mem_helper.c
In file included from ../target/hppa/mem_helper.c:21:
../target/hppa/mem_helper.c: In function =E2=80=98helper_diag_btlb=E2=80=99=
:
../target/hppa/mem_helper.c:461:36: error: format =E2=80=98%lx=E2=80=99 exp=
ects
argument of type =E2=80=98long unsigned int=E2=80=99, but argument 4 has ty=
pe
=E2=80=98uint64_t=E2=80=99 {aka =E2=80=98long long unsigned int=E2=80=99} [=
-Werror=3Dformat=3D]
461 | qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_INSERT "
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
......
466 | virt_page, phys_page, len, slot);
| ~~~~~~~~~
| |
| uint64_t {aka long long unsigned int}
../include/qemu/log.h:55:22: note: in definition of macro =E2=80=98qemu_log=
_mask=E2=80=99
55 | qemu_log(FMT, ## __VA_ARGS__); \
| ^~~
cc1: all warnings being treated as errors

Thanks,
Stefan

On Sat, 16 Sept 2023 at 15:33, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 9ef497755afc252fb8e060c9ea6b0987abfd20=
b6:
>
>   Merge tag 'pull-vfio-20230911' of https://github.com/legoater/qemu into=
 staging (2023-09-11 09:13:08 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/hppa-btlb-pull-request
>
> for you to fetch changes up to 303b1febe3dcd519314d6ed80d97a706cdd21f64:
>
>   linux-user/hppa: lock both words of function descriptor (2023-09-16 21:=
13:08 +0200)
>
> ----------------------------------------------------------------
> Block-TLB support and linux-user fixes for hppa target
>
> All 32-bit hppa CPUs allow a fixed number of TLB entries to have a
> different page size than the default 4k.
> Those are called "Block-TLBs" and are created at startup by the
> operating system and managed by the firmware of hppa machines
> through the firmware PDC_BLOCK_TLB call.
>
> This patchset adds the necessary glue to SeaBIOS-hppa and
> qemu to allow up to 16 BTLB entries in the emulation.
>
> Two patches from Mikulas Patocka fix signal delivery issues
> in linux-user on hppa.
>
> ----------------------------------------------------------------
>
> Helge Deller (6):
>   target/hppa: Update to SeaBIOS-hppa version 9
>   target/hppa: Allow up to 16 BTLB entries
>   target/hppa: Report and clear BTLBs via fw_cfg at startup
>   target/hppa: Add BTLB support to hppa TLB functions
>   target/hppa: Extract diagnose immediate value
>   target/hppa: Wire up diag instruction to support BTLB
>
> Mikulas Patocka (2):
>   linux-user/hppa: clear the PSW 'N' bit when delivering signals
>   linux-user/hppa: lock both words of function descriptor
>
>  hw/hppa/machine.c         |  10 +--
>  linux-user/hppa/signal.c  |   6 +-
>  pc-bios/hppa-firmware.img | Bin 720216 -> 732376 bytes
>  roms/seabios-hppa         |   2 +-
>  target/hppa/cpu.h         |  11 ++-
>  target/hppa/helper.h      |   1 +
>  target/hppa/insns.decode  |   2 +-
>  target/hppa/int_helper.c  |   2 +-
>  target/hppa/mem_helper.c  | 179 ++++++++++++++++++++++++++++++++------
>  target/hppa/op_helper.c   |   3 +-
>  target/hppa/translate.c   |  15 +++-
>  11 files changed, 188 insertions(+), 43 deletions(-)
>
> --
> 2.41.0
>
>

