Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 153ED8377AA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 00:21:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS3ZR-0004sO-Ia; Mon, 22 Jan 2024 18:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rS3ZO-0004rR-Tj
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 18:19:10 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rS3ZN-0000kN-0y
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 18:19:10 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e60e135a7so36876645e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 15:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705965546; x=1706570346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH94KKIekKmg0psavtKvxSAB5dcPKS12lsTWyMFeUjs=;
 b=kRSAVPAxNDpJRyIK+LLRoUWFSumW/9eflosiSDVZLIK0Lv0SX+gvlOIAuGqrRb9ke7
 I+bu+nKukpCbikYSJvBNncwU93usTqaCDaaKl85HFnSBiL6OLRrITRFYE1Qp4CG1Te7n
 nBoL470ky851KBNjGBKmG2kauYmeqGfCL/JKw7gOzNXfeCxDn3Sg4S7j8gzu4PVAAF7F
 5UIBIn+zXmYIpwIh6sn811guX+Ovc7XZauZ4FKK+bTatbzTxphjieAdlf2I7A+kNGbkd
 5mQ+WUP9FzEzW0jVet+l8/f0RjQ7rYgFe+gslirtlkTt/BwVaEIyBNWwHvyEYfSEDv64
 ccMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705965546; x=1706570346;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QH94KKIekKmg0psavtKvxSAB5dcPKS12lsTWyMFeUjs=;
 b=GidHLLrQRstcL/NJFZ+yZ8zlSr4VtGnYXn0NtpMfTH1NNDnLojEXZ0scsMefBoVt/V
 1o3AJFQTJjwxj+NeuRzyzRLcCNv7nZXUiUMzNHGeqfHnbW0PCX9sJZKQRNSOrAWuEUNM
 /SQL8E+hIDs/kQLA/fBfH9ldCSi3ctWN9fw66v/Pe/4VUKAGYk9HJFVau7DNRbG6As9w
 M58WhxXBRXrMEMvOU/QGPbpf89q8PuqiEyfp6q7jc2FZiyl+fCXjF9I9yDuc1GIdikpi
 UaMBQ82lx3Gsbz9Y9u2zn8oXFNut7m54mKouwkD+SLgx0y0SkXTDbkSH0/nvNr9p8DQl
 NoBQ==
X-Gm-Message-State: AOJu0Yz2GYhezmL3B5zDawX821AJk0OJD3fUdpXSYQovubbTgCIYXmks
 0ehrvh9rHTc6Qj9DQBSU4C9JE8gPmMeaICtgsIrCROGAr92rurNZ0rWNTc5cZQ0=
X-Google-Smtp-Source: AGHT+IGDj6/PkwL8i9G7Q/WLWJjH40q+93d+ixESdnXN+K0H+GJagvoS4132gWsrdpWaLznC2ox9nQ==
X-Received: by 2002:a05:600c:3508:b0:40e:ac46:756a with SMTP id
 h8-20020a05600c350800b0040eac46756amr1624621wmq.81.1705965546221; 
 Mon, 22 Jan 2024 15:19:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q20-20020a05600c46d400b0040e395cd20bsm44319389wmo.7.2024.01.22.15.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 15:19:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81C005F794;
 Mon, 22 Jan 2024 23:19:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  David Hildenbrand <david@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v3 3/3] tests/tcg: Add the PROT_NONE gdbstub test
In-Reply-To: <aybsdiscvgcl5kici5lfupjtykvkyw4u5g3bdncmv3wufzwgou@r42zm6labldl>
 (Ilya Leoshkevich's message of "Mon, 22 Jan 2024 22:31:08 +0100")
References: <20240116003551.75168-1-iii@linux.ibm.com>
 <20240116003551.75168-4-iii@linux.ibm.com>
 <871qa9nz2f.fsf@draig.linaro.org>
 <aybsdiscvgcl5kici5lfupjtykvkyw4u5g3bdncmv3wufzwgou@r42zm6labldl>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 22 Jan 2024 23:19:05 +0000
Message-ID: <87jzo1lzx2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Mon, Jan 22, 2024 at 03:54:32PM +0000, Alex Benn=C3=A9e wrote:
>> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>>=20
>> > Make sure that qemu gdbstub, like gdbserver, allows reading from and
>> > writing to PROT_NONE pages.
>> >
>> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> > ---
>> >  tests/tcg/multiarch/Makefile.target      |  9 +++++-
>> >  tests/tcg/multiarch/gdbstub/prot-none.py | 22 +++++++++++++
>> >  tests/tcg/multiarch/prot-none.c          | 40 ++++++++++++++++++++++++
>> >  3 files changed, 70 insertions(+), 1 deletion(-)
>> >  create mode 100644 tests/tcg/multiarch/gdbstub/prot-none.py
>> >  create mode 100644 tests/tcg/multiarch/prot-none.c
>
> [...]
>
>> > +def run_test():
>> > +    """Run through the tests one by one"""
>> > +    gdb.Breakpoint("break_here")
>> > +    gdb.execute("continue")
>> > +    val =3D gdb.parse_and_eval("*(char[2] *)q").string()
>>=20
>> Better traceback:
>>=20
>>   Breakpoint 1, break_here (q=3D0x400000802fff) at /home/alex/lsrc/qemu.=
git/tests/tcg/multiarch/prot-none.c:14
>>   14      }
>>   GDB Exception:
>>   Traceback (most recent call last):
>>     File "/home/alex/lsrc/qemu.git/tests/guest-debug/test_gdbstub.py", l=
ine 42, in main
>>       test()
>>     File "./tests/tcg/multiarch/gdbstub/prot-none.py", line 14, in run_t=
est
>>       val =3D gdb.parse_and_eval("*(char[2] *)q").string()
>>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   gdb.MemoryError: Cannot access memory at address 0x400000802fff
>>   Python 3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0] on linux
>>   Type "help", "copyright", "credits" or "license" for more information.
>>   (InteractiveConsole)
>>   >>>=20
>
> Thanks for the debug output. This shows that the feature being tested
> doesn't work (the value of `q` looks sane to me). May I ask what host
> distro is this? I tried on x86_64 Fedora 38 and x86_64 Ubuntu 22.04 so
> far, and the test was successful.

Debian Bookworm (x86_64) with gdb-multiarch installed.
>
> [...]

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

