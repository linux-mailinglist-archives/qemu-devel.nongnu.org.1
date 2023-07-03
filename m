Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5D745FAE
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLMU-0002M6-2E; Mon, 03 Jul 2023 11:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGLMO-0002KR-NT
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:21:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGLMM-00013h-HI
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:21:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so32430775e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688397661; x=1690989661;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ra4KIy9NqL0W942egTc64T5ywUCYgEKPmQKp642YuHM=;
 b=KLvGoHT+FBC7l+NPfqUXC25I/OM77C0RnHy6PF1eHz63gaY5AW3e0H0Gbp+p6JeIbk
 NtxSjS2RtdgkXuGLV+d2x/RjT5L6EYpZYpcM4ZuRsi+Fjz4vVm7WVk4RUZvzYZB6LZVG
 K/oskZtmjrbG2y5+FsxV16jMA8SO0gIticJRaGm0Oq820ZBSfam3nF9tn+6IAygHab1c
 oMQE9JRreMrS/kuV8RZs0B4pjISkyL5FmMf16q4XJh6U7L1/DH03rbIFTC0i2+1Wf7nF
 0QXVaBVHTbu/HJWWifsEUib47Rdx/v/CnBYWNZhhiOhMV8BTBpgoXFVeQ0Gfw+aczoaI
 KgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688397661; x=1690989661;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ra4KIy9NqL0W942egTc64T5ywUCYgEKPmQKp642YuHM=;
 b=jmi80xawwjFkhQPWKpemod9lR6d0349gioRZQqc1GCZxwGEbUX+se1f+zXleeB4PMW
 z6acdoL9rVJhmLbrOg88ghPm1Cp+a/o0m3gom1D3Smx1kRn+Tgbuk2/eKudDp/y+gwu0
 8aus64205ITBRPO5KU45P/M831YkqOEl7nMDGcxmdyk+cKAk8SeA04m43Hm7f9RkK9qi
 84oHs2BtaWbEIg45x2sP8JgLkPJFUK5BZjzME8IsrFSqGShth14KCCnDKNMFGbw9Cu5L
 4kau53tSCUTa3zT4v6WD8a0OyJcprQYbosT1txP6sboCC8EraTGiIYnDWYfsfnkvAz1c
 /bew==
X-Gm-Message-State: ABy/qLaMwmW4F+sgdVg26gaSh9sxqEafRaqiAlpimZONjm/HA1MtazdD
 mxd2u0WCa/1EwqqHeTPqhSSMZA==
X-Google-Smtp-Source: APBJJlE74QVCWD/tIxXeYAQ7aJK56TIkSjxTHU9F3BWZrknWzNgo/zxs9KrQhc06MmmEXDW6l/t1QA==
X-Received: by 2002:a7b:c8d3:0:b0:3fb:df34:1766 with SMTP id
 f19-20020a7bc8d3000000b003fbdf341766mr29880wml.1.1688397660720; 
 Mon, 03 Jul 2023 08:21:00 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a1c770f000000b003fbd1a78697sm6610934wmi.5.2023.07.03.08.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 08:21:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D58AF1FFBB;
 Mon,  3 Jul 2023 16:20:59 +0100 (BST)
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
 <20230625212707.1078951-2-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Subject: Re: [RFC v3 01/10] docs: Add specification for native library calls
Date: Mon, 03 Jul 2023 16:04:33 +0100
In-reply-to: <20230625212707.1078951-2-fufuyqqqqqq@gmail.com>
Message-ID: <874jmlhvhg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  docs/native_calls.txt | 70 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 docs/native_calls.txt
>
> diff --git a/docs/native_calls.txt b/docs/native_calls.txt
> new file mode 100644
> index 0000000000..8906566b13
> --- /dev/null
> +++ b/docs/native_calls.txt

We try not to add plain text files to docs now. The preferred format is
rst so we can render the docs:

  https://qemu.readthedocs.io/en/latest/

I would suggest putting this in docs/user/native_calls.rst and adding a
reference in docs/user/index.rst

> @@ -0,0 +1,70 @@
> +Native Library Calls Optimization for QEMU Linux-User
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

newline and also for rst a different underline is needed to make
description a sub-heading (e.g. -----------)

> +When running under the linux-user mode in QEMU, the entire program,
> +including all library calls, is translated. Many well-understood
> +library functions are usually optimized for the processor they run
> +on.

Maybe instead of "Many..."

  Because many library functions are tuned specifically for the guest
  architecture the result of translating them will not be as efficient
  as it could be.

  When the semantics of a library function are well defined we can take
  advantage of that fact by replacing the translated version with a call
  to the native equivalent function. As the runtime of library functions....


> For example, the semantics of memcpy are well-defined and
> +optimized. Instead of translating these library functions, we can
> +call their native versions, as the runtime of library functions
> +is generally biased towards a few core functions. Thus, only a
> +small subset of functions (such as mem* and str*) would need to
> +be hooked to be useful.
> +
> +
> +Implementation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

newline

> +This feature introduces a set of specialized instructions for native
> +calls and provides helpers to translate these instructions to
> +corresponding native functions. A shared library is also implemented,
> +where native functions are rewritten as specialized instructions.
> +At runtime, user programs load the shared library, and specialized
> +instructions are executed when native functions are called.

I would switch it around. Describe the LD_PRELOAD library first and then
describe how the library uses a special sequence of instructions to
encode the ABI data in a way the translator can pick it up during
execution.

> +
> +The specialized instructions are implemented using architecture-
> +specific macros. These macros utilize unused or invalid opcodes or
> +instruction fields to embed the necessary information for native
> +function calls. This approach ensures that the specialized
> +instructions do not conflict with existing instructions.
> +
> +For x86 and x86_64, the implementation uses an unused opcode.
> +For arm and aarch64, the HLT instruction is used, as it is invalid in
> +userspace and has 16 bits of spare immediate data.
> +For mips and mips64, the implementation takes advantage of unused
> +bytes in the syscall instruction.

I think this paragraph can be split into each architecture and listed as
a sub-heading for each. This can replace the "Supported Architectures" head=
ing.

> +
> +Supported Architectures
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This feature is applicable to user programs with the following
> +architectures now:
> +- x86
> +- x86_64
> +- arm
> +- aarch64
> +- mips
> +- mips64
> +
> +
> +Usage
> +=3D=3D=3D=3D=3D
> +1. Install Cross-Compilation Tools
> +Cross-compilation tools are required to build the shared libraries
> +that can hook the necessary library functions. For example, a viable
> +command on Ubuntu is:
> +```
> +apt install libc6:i386 gcc-arm-linux-gnueabihf \
> +gcc-aarch64-linux-gnu gcc-mips-linux-gnu gcc-mips64-linux-gnuabi64
> +```

I guess libc6:i386 is there because the default x86 host compiler
already supports building 32 bit but we just need the lib bits?

> +2. Locate the Compiled libnative.so
> +After compilation, the libnative.so file can be found in the
> +`./build/common-user/native/<target>-linux-user` directory.
> +
> +3. Run the Program with the `--native-bypass` Option
> +To run your program with native library bypass, use the
> +`--native-bypass` option to import libnative.so:
> +```
> +./build/qemu-<target> --native-bypass \

You can drop the ./build here as there should be a qemu-<target> in the
top level build directory.

> +./build/common-user/native/<target>-linux-user/libnative.so ./program
> +```


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

