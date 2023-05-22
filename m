Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387D670BEBB
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q150L-0001b2-2K; Mon, 22 May 2023 08:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q150I-0001an-AM
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:51:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q150D-0003K1-ND
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:51:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3093d10442aso3812712f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684759864; x=1687351864;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvIZJk+U/W30xHARsoBsJOAEImxthluOIX2ieX7XX8Y=;
 b=nxBlHE3bUBWztW+QvHFvHmOTQ0CJ7mRengnbjyhEdl4Oj3rwsBqyDDwoKZ4E6cuSDu
 U6HMegvZPoKUugyrDxPyI1VkutICdf4VvtQz+MlhtMnNVMzMdhT9qCeq4+3dsvSKTzzz
 OUhBvVti6Le9yI5UQdmS/cMOeJ1ar/IoFp52a+ulebQ3mEkze4tjlSHwREK4RxHgK53F
 pSX02HrkcbGWgW/M/1htGoz8gXfEKe0yoaj5yMXobHQMb8r1YCT7dsV9nz6LF6OVTEV0
 u09kSuuTY6NfFyGvMjMQqOzLYnOz/Fuyv9vSFksjub5vZCFFb7izZEshZwVk4CDOqFMa
 KssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684759864; x=1687351864;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DvIZJk+U/W30xHARsoBsJOAEImxthluOIX2ieX7XX8Y=;
 b=f4gw9iFKAuP/j8GVDE+33GB6aE+SbHzDbbfZ8qnseR0QEAVqwxwmqz1pauH7uCAA4Z
 bZ3T6+3alBOLD9Xwws5ReuaLPS3LXgO5RiJOoONgIbp+kti6jyV+ottgi3C8CMIOhQA4
 aFiOfMSbBNPx7jYMdOMXAFuorHvdurnnRe0bIEiURb5Pqmr1koEZ15OzFE1ThGFFeL5n
 rNZNK2Uy17UNruQ3QIjbcu1p7eSoaWLYfHSRiSCnTS+68DSHOfdBwvOalL2SQ+uAL9uX
 XWqcxDWphgmEja3r1RWR9k/bUxL0dwYnl20oVQs3JNhptRztWLe0ewJl6w0sBl1mjeLN
 tzww==
X-Gm-Message-State: AC+VfDxuLpabzMtbbhEoloVVh+UxYOnnwQW5gU/bDZmBJI+KRssQOQ2H
 B3+IE5WIGKnBA8+OKB1Yw65r3A==
X-Google-Smtp-Source: ACHHUZ51a99cFvquAv9b08Y7kEpFf0BLZMcwHng6YAjUGOhsCYTgNakJ4XGKCSBlbHg76fNfWyqkww==
X-Received: by 2002:a5d:4210:0:b0:306:5149:3aa8 with SMTP id
 n16-20020a5d4210000000b0030651493aa8mr6958190wrq.24.1684759863862; 
 Mon, 22 May 2023 05:51:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l18-20020adffe92000000b003093a412310sm7579657wrr.92.2023.05.22.05.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 05:51:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E55C51FFBB;
 Mon, 22 May 2023 13:51:02 +0100 (BST)
References: <20230520205444.887287457E7@zero.eik.bme.hu>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] bitops.h: Compile out asserts without --enable-debug
Date: Mon, 22 May 2023 12:26:54 +0100
In-reply-to: <20230520205444.887287457E7@zero.eik.bme.hu>
Message-ID: <874jo47cnd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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


BALATON Zoltan <balaton@eik.bme.hu> writes:

> The low level extract and deposit funtions provided by bitops.h are
> used in performance critical places. It crept into target/ppc via
> FIELD_EX64 and also used by softfloat so PPC code using a lot of FPU
> where hardfloat is also disabled is doubly affected.

Most of these asserts compile out to nothing if the compiler is able to
verify the constants are in the range. For example examining
the start of float64_add:

  Dump of assembler code for function float64_add:
  ../../fpu/softfloat.c:
  1979	{
     0x00000000007ac9b0 <+0>:	movabs $0xfffffffffffff,%r9
     0x00000000007ac9ba <+10>:	push   %rbx

  /home/alex/lsrc/qemu.git/include/qemu/bitops.h:
  396	    return (value >> start) & (~0ULL >> (64 - length));
     0x00000000007ac9bb <+11>:	mov    %rdi,%rcx
     0x00000000007ac9be <+14>:	shr    $0x34,%rcx
     0x00000000007ac9c2 <+18>:	and    $0x7ff,%ecx

  ../../fpu/softfloat.c:
  1979	{
     0x00000000007ac9c8 <+24>:	sub    $0x30,%rsp

  /home/alex/lsrc/qemu.git/include/qemu/bitops.h:
  396	    return (value >> start) & (~0ULL >> (64 - length));
     0x00000000007ac9cc <+28>:	mov    %fs:0x28,%rax
     0x00000000007ac9d5 <+37>:	mov    %rax,0x28(%rsp)
     0x00000000007ac9da <+42>:	mov    %rdi,%rax
     0x00000000007ac9dd <+45>:	and    %r9,%rdi

  ../../fpu/softfloat.c:
  588	    *r =3D (FloatParts64) {
     0x00000000007ac9e0 <+48>:	mov    %ecx,0x4(%rsp)
     0x00000000007ac9e4 <+52>:	mov    %rdi,0x8(%rsp)

  /home/alex/lsrc/qemu.git/include/qemu/bitops.h:
  396	    return (value >> start) & (~0ULL >> (64 - length));
     0x00000000007ac9e9 <+57>:	shr    $0x3f,%rax

  ../../fpu/softfloat.c:
  588	    *r =3D (FloatParts64) {
     0x00000000007ac9ed <+61>:	mov    %al,0x1(%rsp)

  589	        .cls =3D float_class_unclassified,
  590	        .sign =3D extract64(raw, f_size + e_size, 1),
     0x00000000007ac9f1 <+65>:	mov    %rax,%r8

I don't see any check and abort steps because all the shift and mask
values are known at compile time. The softfloat compilation certainly
does have some assert points though:

 readelf -s ./libqemu-ppc64-softmmu.fa.p/fpu_softfloat.c.o  |grep assert
   136: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND g_assertion_mess=
[...]
   138: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __assert_fail

but the references are for the ISRA segments so its tricky to know if
they get used or are just there for LTO purposes.

If there are hot-paths that show up the extract/deposit functions I
suspect a better approach would be to implement _nocheck variants (or
maybe _noassert?) and use them where required rather than turning off
the assert checking for these utility functions.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

