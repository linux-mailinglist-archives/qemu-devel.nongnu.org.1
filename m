Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F6830864
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:47:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7CM-0001X1-1Y; Wed, 17 Jan 2024 09:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ7CH-0001V4-Fa
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:47:17 -0500
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ7CF-0000gY-2X
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:47:16 -0500
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-36199ab6ef5so959915ab.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 06:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705502833; x=1706107633; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jnxJ2SKjg/C0oevn7LS27uiXnr6vXIw55OfakDi2fP0=;
 b=GlArTEBKNW5Fbvq8KAga7XArZ4q9O8qYOKKD/SiIzXNUbz2Xe0/mxvG0Tl1g2oXYWZ
 8yCI5e0IPvTrbxO5dum/bhTn/a/46Is09xHGf7IXcQrLzUVw5XfdU1HOTlQ5yUpgtsZl
 YabzFKO8nk5+u1+D19mQI3AX1Sd0sDba/shRNOaXEcJh1POB9mnZ2H6+aiyVVQkjjR8h
 QPRghUpqusHhL89ICOMiPEVa4LHNL9gWyt90rGPC/if6w46a/zEjCPcQ1O6XwEh6wkK3
 baZLtyGSS5EE1jjJodaq9rfY3I/mBAk5wwxEESefi/r71QFJfDoO3c67PqslN1LN8HQV
 mu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705502833; x=1706107633;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jnxJ2SKjg/C0oevn7LS27uiXnr6vXIw55OfakDi2fP0=;
 b=oEhE9sBVw1GlSIQPrVXU/L6F4f7Te/25EWESMPYU+H4XTtJ7GccPuha59dbwAgTP+K
 2mG5LS8cyqlLu8y2b3HZ0eKdba9RcOV18Cr7TTapXDoPmHU4uUCO3FGOMnwuGmJN4mZs
 aJ4FX0YG5Yg2tHChGpACoQBKEGLoJRGrI1taT2Ge70mEvOIf+1Lh3uorIYTnsRHDsn0J
 rBlyzROUf1I2GkOJMQxIveHc1Sts+crXNHOksivGZrHrcP06JisDaNqFR/NeGujr72oM
 5X7xg8eXx7XvwTcjS5vssF0358YftlbunpB6rZ/0LS+X0BCdS9YYOxC9/XGZs2+GNpGD
 BOwA==
X-Gm-Message-State: AOJu0YwtHZLNmdzfrWcV9RKvQkQJjqjt/Z3E8SSyjO2gkaVWDxhrlwW+
 WQtgRUvTlwxvEeHIPBrF/JSFz0qPi1Phwu6OVyI=
X-Google-Smtp-Source: AGHT+IHRYIZRjEumR8bfklVV4+ZyBXCYROzq7JOU/m4hf9CGncQqLmiMyUzNiC8pJ2iv4HSe1ltgzGo2SF9c22PFC9M=
X-Received: by 2002:a92:c564:0:b0:35f:ea35:c284 with SMTP id
 b4-20020a92c564000000b0035fea35c284mr11258261ilj.38.1705502833676; Wed, 17
 Jan 2024 06:47:13 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mkL6EzLgRvYZ2gp=dmF_5gxD-9cJBTODAb8UtjurZuBKg@mail.gmail.com>
 <37ef47fc-92a5-4ffe-9677-2bc013cfe20b@linaro.org>
 <CAHP40mkNb5EH_Js02LpENMc2CA2pj7fEJY_S1sTMNWh_3rcUEQ@mail.gmail.com>
 <20240117143306.lnycf2ijwkzycowj@begin>
In-Reply-To: <20240117143306.lnycf2ijwkzycowj@begin>
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 15:47:09 +0100
Message-ID: <CAHP40mkk4aRG+9PGjoW2U38WXSvd1NpvDgMet4AQASg3=H=UdA@mail.gmail.com>
Subject: Re: [PATCH 2/4] Avoid multiple definitions of copy_file_range
To: Manolo de Medici <manolodemedici@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, bug-hurd@gnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hello Samuel,
the presence of the qemu stub causes the following compilation error:

FAILED: libblock.fa.p/block_file-posix.c.o
cc -m32 -Ilibblock.fa.p -I. -I../../.. -Iqapi -Itrace -Iui -Iui/shader
-Iblock -I/usr/include/glib-2.0 -I/usr/lib/i386-gnu/glib-2.0/include
-fdiagnostics-color=auto -Wall -Winvalid-pch -std=gnu11 -O0 -g
-fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes
-Wstrict-prototypes -Wredundant-decls -Wold-style-declaration
-Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
-Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
-Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=2
-Wmissing-format-attribute -Wno-missing-include-dirs
-Wno-shift-negative-value -Wno-psabi -Wshadow=local -iquote . -iquote
/root/qemu -iquote /root/qemu/include -iquote
/root/qemu/host/include/i386 -iquote /root/qemu/host/include/generic
-iquote /root/qemu/tcg/i386 -pthread -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
-fno-common -fwrapv -fPIE -MD -MQ libblock.fa.p/block_file-posix.c.o
-MF libblock.fa.p/block_file-posix.c.o.d -o
libblock.fa.p/block_file-posix.c.o -c ../../../block/file-posix.c
../../../block/file-posix.c: In function 'probe_logical_blocksize':
../../../block/file-posix.c:310:13: warning: implicit declaration of
function 'ioctl' [-Wimplicit-function-declaration]
  310 |         if (ioctl(fd, ioctl_list[i], &sector_size) >= 0) {
      |             ^~~~~
../../../block/file-posix.c:310:13: warning: nested extern declaration
of 'ioctl' [-Wnested-externs]
../../../block/file-posix.c: At top level:
../../../block/file-posix.c:2003:14: error: conflicting types for
'copy_file_range'; have 'off_t(int,  off_t *, int,  off_t *, size_t,
unsigned int)' {aka 'long long int(int,  long long int *, int,  long
long int *, unsigned int,  unsigned int)'}
 2003 | static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
      |              ^~~~~~~~~~~~~~~
In file included from /root/qemu/include/qemu/osdep.h:122,
                 from ../../../block/file-posix.c:25:
/usr/include/unistd.h:1142:9: note: previous declaration of
'copy_file_range' with type 'ssize_t(int,  __off64_t *, int,
__off64_t *, size_t,  unsigned int)' {aka 'int(int,  long long int *,
int,  long long int *, unsigned int,  unsigned int)'}
 1142 | ssize_t copy_file_range (int __infd, __off64_t *__pinoff,
      |         ^~~~~~~~~~~~~~~

the current patch fixes this compilation error.

The resulting binary is the same as it would have been with only the qemu patch,
so I'm assuming that it is fully functional. Although I cannot be 100%
sure about that.

