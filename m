Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B205076A807
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 06:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQhKf-0005Mf-DN; Tue, 01 Aug 2023 00:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qQhKY-0005M0-Fj
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 00:49:59 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qQhKT-0004Iz-KX
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 00:49:56 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so1098373266b.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 21:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1690865392; x=1691470192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=chTFYEDDQ85UPffKdJe07epF9+RuO0CfjAe87/TD2oo=;
 b=J/FN+8o+WnHPpo9GTNdhuiSeo6MyZQVKsZ8G/+JLElBTWBH8+ORsj80V6JK5n4kn95
 e6MjWHgHSEzdQGIJh3zTXNjUVu0Uu/WNZMHsdS8vKAP4zPXQjre7TZMYqb+7mPDYXEIX
 O/J/QBc0Zwp9H8K6MuLGwVRTJdtVW9WBfXz/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690865392; x=1691470192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=chTFYEDDQ85UPffKdJe07epF9+RuO0CfjAe87/TD2oo=;
 b=alQouugU+9uu5IwYRxdIrSCqjteePIzIBS1OeRfto8TYlzrKGwQ5Uq29ogOZ8Aqt6R
 Ec7Uvzr56KWFxXli+U2G9fO6SkLpo2n+kQ27+lr3hQguhXkihlFIc1TteyQYlZ8f48vM
 2UMHJsBn6I0C1dKvkfphUKmKhu9fgWzfZcFfysAuxHrKxQRx9x6ceMtSv9Vxkko96ioQ
 p+F3+fbwxftalKQ81Pj09yE9X93EQEhcRV3Cu9YOTodUMQNVbKAqDv+/Uje7RnJ5lwey
 Ma+HcCU5MFloLwii9tvlTyOK5sR7nJuCTUVYE0/QxuPyvy0PSlErQWCAviFuYPsJOC58
 0MZw==
X-Gm-Message-State: ABy/qLbg9eyJolpznS3NsqspBMSF5Yy1t9B9+GQYRtp3EUeUbkifqpTN
 E4Jhpyw4oMy7NTLJWrFEHeVo/2qAXHxpgbK1Gq4=
X-Google-Smtp-Source: APBJJlGA56359u3E3ybq5yDIBLV4mOXPI1KVKu70MpTrNU711Ah952LV6mtFJuIB03kj3XhYBdtTn1MDqQ0dA76BY4M=
X-Received: by 2002:a17:907:a079:b0:993:f611:7c97 with SMTP id
 ia25-20020a170907a07900b00993f6117c97mr1987591ejc.33.1690865391828; Mon, 31
 Jul 2023 21:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <3088d223-64fd-9aab-3c08-000f0924607c@tls.msk.ru>
 <CACPK8XfcOkn281JZNYc7+AhDAxP_N9__G4Snxtx=ZhXgVChXgg@mail.gmail.com>
 <0643c953-bfa8-45a9-5b07-714bc18c03a6@daynix.com>
 <57d9980d-b881-b16e-844a-e651d6d09de7@gmx.de>
 <c3ed33f0-998d-5386-1880-22436af149b7@gmx.de>
 <def4abbf-ec8a-7986-1831-d9c839acff8c@gmx.de>
In-Reply-To: <def4abbf-ec8a-7986-1831-d9c839acff8c@gmx.de>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 1 Aug 2023 04:49:39 +0000
Message-ID: <CACPK8XfXMU=YyvkPTHFV6n_THkDPKfRmjYt_Ps7KJrxV9Srjbg@mail.gmail.com>
Subject: Re: [PATCH 0/5] linux-user: brk/mmap fixes
To: Helge Deller <deller@gmx.de>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, 31 Jul 2023 at 18:24, Helge Deller <deller@gmx.de> wrote:

> > I re-read the thread again. As it seems Joel already tried the latest
> > version from me? Sadly I can't test myself on ppc64le (static binary
> > needs klibc-PupSAGgtpafMlSLXOLgje1kXFo8.so in /usr/lib which I can't
> > install on a debian porterbox).
> >
> > I still believe we need to track host and target brk page, but I'll give
> > your patch a try.
>
> As suggested, I've based my patches on top of yours and the tree can be
> pulled from:
> git pull https://github.com/hdeller/qemu-hppa/   brk-fixes-akihiko-2
>
> My patches are neccessary to fix an arm-static testcase:
>         /usr/bin/qemu-arm-static ./fstype
>
> Let's try this patch series...

The armhf static binary works with expected output.

The arm static binary causes qemu to segfault:

$ gdb -quiet --args ./build/qemu-arm -d guest_errors,page,strace ~/hello
Reading symbols from ./build/qemu-arm...
(gdb) r
Starting program: build/qemu-arm -d guest_errors,page,strace
/home/joel/hello
Using host libthread_db library "/lib/powerpc64le-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff762ece0 (LWP 118359)]
host mmap_min_addr=0x10000
pgb_find_hole: base @ 140420000 for 4294967296 bytes
pgb_static: base @ 140420000 for 4294967295 bytes
pgb_reserved_va: base @ 0x140420000 for 4294967296 bytes
Locating guest address space @ 0x140420000
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 ---
00090000-0009b000 0000b000 ---
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-0009b000 0000b000 ---
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
e0000000-e0810000 00810000 rw-
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
e0000000-e0010000 00010000 ---
e0010000-e0811000 00801000 rw-
ffff0000-00000000 00010000 r-x
guest_base  0x140420000
page layout changed following binary load
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
e0000000-e0010000 00010000 ---
e0010000-e0810000 00800000 rw-
e0810000-e0811000 00001000 r-x
ffff0000-00000000 00010000 r-x
start_brk   0x00000000
end_code    0x00084f7c
start_code  0x00010000
start_data  0x00095098
end_data    0x00098394
start_stack 0xe080f410
brk         0x0009b000
entry       0x00010418
argv_start  0xe080f414
env_start   0xe080f41c
auxv_start  0xe080f4a0
118357 brk(NULL) = 0x0009b000
118357 brk(0x0009b8fc) = 0x0009b000

Thread 1 "qemu-arm" received signal SIGSEGV, Segmentation fault.
0x00007fffeed9bb74 in code_gen_buffer ()
(gdb)
(gdb) bt
#0  0x00007fffeed9bb74 in code_gen_buffer ()
#1  0x0000000100169e3c in cpu_tb_exec (cpu=cpu@entry=0x1003d4aa0,
    itb=itb@entry=0x7fffeed9ba60 <code_gen_buffer+47512>,
tb_exit=tb_exit@entry=0x7fffffffe50c)
    at ../accel/tcg/cpu-exec.c:457
#2  0x000000010016a564 in cpu_loop_exec_tb (tb_exit=0x7fffffffe50c,
last_tb=<synthetic pointer>,
    pc=<optimised out>, tb=0x7fffeed9ba60 <code_gen_buffer+47512>,
cpu=<optimised out>)
    at ../accel/tcg/cpu-exec.c:919
#3  cpu_exec_loop (cpu=cpu@entry=0x1003d4aa0, sc=<optimised out>) at
../accel/tcg/cpu-exec.c:1040
#4  0x000000010016aa0c in cpu_exec_setjmp (cpu=cpu@entry=0x1003d4aa0,
sc=<optimised out>)
    at ../accel/tcg/cpu-exec.c:1057
#5  0x000000010016b0d0 in cpu_exec (cpu=0x1003d4aa0) at
../accel/tcg/cpu-exec.c:1083
#6  0x000000010004d780 in cpu_loop (env=0x1003d4fb0) at
../linux-user/arm/cpu_loop.c:323
#7  0x0000000100047534 in main (argc=<optimised out>,
argv=0x7ffffffff178, envp=<optimised out>)
    at ../linux-user/main.c:975

I tested 74a22a175c4340a01f6f860f72307093e3307681.

