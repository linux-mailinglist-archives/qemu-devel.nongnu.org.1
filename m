Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC8F79093C
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 20:45:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcVav-0005Oi-QV; Sat, 02 Sep 2023 14:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1qcVas-0005OZ-J1
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 14:43:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1qcVap-0007AN-Tj
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 14:43:38 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c3726cc45so111706f8f.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1693680214; x=1694285014;
 darn=nongnu.org; 
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=G/8E9CMQqAbvxKzVt20rZnKkbteGjhlZXXeAGumsidg=;
 b=HUGQ1in75rqAw1Jf54oO4vYYKAIamXick0NiiGdlh8lMPXHaPJUFvIQwEoXsAs+xVQ
 QLGz2kWNMz0irykoZ7o6w5oGXoJhVAhvA5W0d+FtomWuOUZEDlxj22KLk9a8/iWZOohw
 y0XMKfw228NpkxvXIX2/SijMiGLUPJjkl++FNA5T2DDM8TBbrvCW9ZnZh4xB2rHlmJ3B
 Er4hYO/ZNod91WBy4jpbsfOResUIE/XC/6lzpyOq0eQAFWQfLkcCtO8NZMAmItvoExWA
 XUGsCmAH5fr19yJUqfekGzdKDyO9BrefNYEsz8fXaFqDtlYPgbaXcKOp4w7BOLYogJdh
 l1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693680214; x=1694285014;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G/8E9CMQqAbvxKzVt20rZnKkbteGjhlZXXeAGumsidg=;
 b=A3s6HiAG7mFZSexC6dt/o9buP06W8+3pD0YVTD+lYFB65zo3w8rox2kw84Sagngk4p
 gSBc9mCSsVJaNJj6qYoThsmudXC/+KdJFkIqp8l/3IbYGkymRbtgCiqyjUKUNgsVRWUG
 vIN0++zO4KLJFjINYmdvHO3IbKi6dNT27QH2WzJHW1wbPVLLNwBLCJMUDVlT+ZrbrD/I
 eiqJrc0kcEyx7+gbGJhc43YBCLy7HPRUPZ+LxDr0h+rvx5JT3Ys9D7BtfeOVAcfUWlyk
 onkyl1og6xhSOfqR4nz9e2Wcjbvb1IlOeMgAPx54nL5KQ3uduE4x0jIP0BUX67oa8Ptx
 U7ww==
X-Gm-Message-State: AOJu0Yz5cp+PIWv7moXOUf1hAs2I/4RDGzmLNyDOIMOtOck3NU9CtnJ4
 mYmkfdNa8WIONGDxbi6OvNBFtYtrBHKjlnlGi7kAfQ==
X-Google-Smtp-Source: AGHT+IEWbhInS3Skx6kydR2DuFkiyC2CYOadnwBn5BV5Ai34QSwWpJDe55L3nl75aU7D6ZQN286hQA==
X-Received: by 2002:a05:6000:128b:b0:313:fe1b:f441 with SMTP id
 f11-20020a056000128b00b00313fe1bf441mr3818393wrx.29.1693680213677; 
 Sat, 02 Sep 2023 11:43:33 -0700 (PDT)
Received: from smtpclient.apple ([86.121.135.50])
 by smtp.gmail.com with ESMTPSA id
 h17-20020adff191000000b003180fdf5589sm9310436wro.6.2023.09.02.11.43.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Sep 2023 11:43:33 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Error: .seh_endproc used in segment '.text' instead of expected
 '.text$qemu_close_socket_osfhandle'
Message-Id: <0C1AED16-2AC0-43FE-AEA6-BF3F61B62536@livius.net>
Date: Sat, 2 Sep 2023 21:43:32 +0300
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: none client-ip=2a00:1450:4864:20::42d;
 envelope-from=ilg@livius.net; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When compiling 8.1.0 for Windows (with mingw-w64-gcc on Linux), I got =
the following error:

```
[634/1917] Compiling C object libqemuutil.a.p/util_oslib-win32.c.obj
FAILED: libqemuutil.a.p/util_oslib-win32.c.obj=20
=
/home/ilg/Work/xpack-dev-tools/qemu-riscv-xpack.git/build/win32-x64/xpacks=
/.bin/x86_64-w64-mingw32-gcc -m64 -mcx16 -Ilibqemuutil.a.p -I. =
-I../../../sources/qemu-8.1.0.git -Iqapi -Itrace -Iui -Iui/shader =
-I/home/ilg/Work/xpack-dev-tools/qemu-riscv-xpack.git/build/win32-x64/x86_=
64-w64-mingw32/install/include -Iinclude =
-I/home/ilg/Work/xpack-dev-tools/qemu-riscv-xpack.git/build/win32-x64/x86_=
64-w64-mingw32/install/include/glib-2.0 =
-I/home/ilg/Work/xpack-dev-tools/qemu-riscv-xpack.git/build/win32-x64/x86_=
64-w64-mingw32/install/lib/glib-2.0/include =
-I/home/ilg/Work/xpack-dev-tools/qemu-riscv-xpack.git/build/win32-x64/x86_=
64-w64-mingw32/install/include/pixman-1 -fdiagnostics-color=3Dauto -Wall =
-Winvalid-pch -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wundef =
-Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes =
-Wredundant-decls -Wold-style-declaration -Wold-style-definition =
-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self =
-Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels =
-Wexpansion-to-defined -Wimplicit-fallthrough=3D2 =
-Wmissing-format-attribute -Wno-missing-include-dirs =
-Wno-shift-negative-value -Wno-psabi -iquote . -iquote =
/home/ilg/Work/xpack-dev-tools/qemu-riscv-xpack.git/build/win32-x64/source=
s/qemu-8.1.0.git -iquote =
/home/ilg/Work/xpack-dev-tools/qemu-riscv-xpack.git/build/win32-x64/source=
s/qemu-8.1.0.git/include -iquote =
/home/ilg/Work/xpack-dev-tools/qemu-riscv-xpack.git/build/win32-x64/source=
s/qemu-8.1.0.git/host/include/x86_64 -iquote =
/home/ilg/Work/xpack-dev-tools/qemu-riscv-xpack.git/build/win32-x64/source=
s/qemu-8.1.0.git/host/include/generic -iquote =
/home/ilg/Work/xpack-dev-tools/qemu-riscv-xpack.git/build/win32-x64/source=
s/qemu-8.1.0.git/tcg/i386 -mms-bitfields -D_GNU_SOURCE =
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing =
-fno-common -fwrapv -fno-pie -no-pie -ffunction-sections -fdata-sections =
-pipe -O2 -D__USE_MINGW_ACCESS -w -mms-bitfields -pthread -mms-bitfields =
-MD -MQ libqemuutil.a.p/util_oslib-win32.c.obj -MF =
libqemuutil.a.p/util_oslib-win32.c.obj.d -o =
libqemuutil.a.p/util_oslib-win32.c.obj -c =
../../../sources/qemu-8.1.0.git/util/oslib-win32.c
{standard input}: Assembler messages:
{standard input}:2859: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2860: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2862: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2863: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2867: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2868: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2872: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2873: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2875: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2876: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2882: Error: CFI instruction used without previous =
.cfi_startproc
{standard input}:2909: Error: .cfi_endproc without corresponding =
.cfi_startproc
{standard input}:2911: Error: .seh_endproc used in segment '.text' =
instead of expected '.text$qemu_close_socket_osfhandle'
{standard input}: Error: open CFI at the end of file; missing =
.cfi_endproc directive
{standard input}:19020: Error: invalid operands (.text and =
.text$qemu_close_socket_osfhandle sections) for `-'
{standard input}:19024: Error: invalid operands (.text and =
.text$qemu_close_socket_osfhandle sections) for `-'
{standard input}:19025: Error: invalid operands (.text and =
.text$qemu_close_socket_osfhandle sections) for `-'
{standard input}:19032: Error: invalid operands (.text and =
.text$qemu_close_socket_osfhandle sections) for `-'
{standard input}:19033: Error: invalid operands (.text and =
.text$qemu_close_socket_osfhandle sections) for `-'
{standard input}:19054: Error: invalid operands (.text and =
.text$qemu_close_socket_osfhandle sections) for `-'
{standard input}:19058: Error: invalid operands (.text and =
.text$qemu_close_socket_osfhandle sections) for `-'
{standard input}:19059: Error: invalid operands (.text and =
.text$qemu_close_socket_osfhandle sections) for `-'
{standard input}:24038: Error: invalid operands (.text and =
.text$qemu_close_socket_osfhandle sections) for `-'
{standard input}:10743: Error: can't resolve .text - .LFB7879
{standard input}:23588: Error: can't resolve .text - .LFB7879
[635/1917] Compiling C object =
libqemuutil.a.p/util_event_notifier-win32.c.obj
[636/1917] Compiling C object libqemuutil.a.p/util_cutils.c.obj
[637/1917] Compiling C object =
libqemuutil.a.p/util_qemu-thread-win32.c.obj
[638/1917] Compiling C object libqemuutil.a.p/util_host-utils.c.obj
[639/1917] Compiling C object libqemuutil.a.p/util_module.c.obj
[640/1917] Compiling C object libqemuutil.a.p/util_bitmap.c.obj
[641/1917] Compiling C object libqemuutil.a.p/util_bitops.c.obj
[642/1917] Compiling C object libqemuutil.a.p/util_cacheflush.c.obj
[643/1917] Compiling C object libqemuutil.a.p/util_fifo8.c.obj
[644/1917] Compiling C object libqemuutil.a.p/util_id.c.obj
[645/1917] Compiling C object libqemuutil.a.p/util_qemu-print.c.obj
[646/1917] Compiling C object libqemuutil.a.p/util_error.c.obj
[647/1917] Compiling C object libqemuutil.a.p/util_error-report.c.obj
ninja: build stopped: subcommand failed.
Makefile:162: recipe for target 'run-ninja' failed
make: *** [run-ninja] Error 1
```

I tried with two toolchains, gcc 13.2 & mingw 11.0.1, and gcc 12.2 & =
mingw 10.0.0.


With the same build scripts, compiling QEMU 7.1.0 was ok, the problem =
was introduced in the last year.

I checked the history of oslib-win32.c, and there were several changes, =
but I don't understand them to the point of being able to suggest =
changes.


Regards,

Liviu




