Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494570BFAF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15Y0-0006sv-I1; Mon, 22 May 2023 09:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q15Xw-0006sL-Qx; Mon, 22 May 2023 09:25:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q15Xt-0001cX-Pm; Mon, 22 May 2023 09:25:56 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D2CD2748A56;
 Mon, 22 May 2023 15:25:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A5D16748A4D; Mon, 22 May 2023 15:25:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A3FAE748A59;
 Mon, 22 May 2023 15:25:50 +0200 (CEST)
Date: Mon, 22 May 2023 15:25:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] bitops.h: Compile out asserts without --enable-debug
In-Reply-To: <874jo47cnd.fsf@linaro.org>
Message-ID: <aaa22b3f-d548-5a69-489a-5777a7e98cef@eik.bme.hu>
References: <20230520205444.887287457E7@zero.eik.bme.hu>
 <874jo47cnd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1053451517-1684761950=:76570"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1053451517-1684761950=:76570
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 22 May 2023, Alex Bennée wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>
>> The low level extract and deposit funtions provided by bitops.h are
>> used in performance critical places. It crept into target/ppc via
>> FIELD_EX64 and also used by softfloat so PPC code using a lot of FPU
>> where hardfloat is also disabled is doubly affected.
>
> Most of these asserts compile out to nothing if the compiler is able to
> verify the constants are in the range. For example examining
> the start of float64_add:
>
>  Dump of assembler code for function float64_add:
>  ../../fpu/softfloat.c:
>  1979	{
>     0x00000000007ac9b0 <+0>:	movabs $0xfffffffffffff,%r9
>     0x00000000007ac9ba <+10>:	push   %rbx
>
>  /home/alex/lsrc/qemu.git/include/qemu/bitops.h:
>  396	    return (value >> start) & (~0ULL >> (64 - length));
>     0x00000000007ac9bb <+11>:	mov    %rdi,%rcx
>     0x00000000007ac9be <+14>:	shr    $0x34,%rcx
>     0x00000000007ac9c2 <+18>:	and    $0x7ff,%ecx
>
>  ../../fpu/softfloat.c:
>  1979	{
>     0x00000000007ac9c8 <+24>:	sub    $0x30,%rsp
>
>  /home/alex/lsrc/qemu.git/include/qemu/bitops.h:
>  396	    return (value >> start) & (~0ULL >> (64 - length));
>     0x00000000007ac9cc <+28>:	mov    %fs:0x28,%rax
>     0x00000000007ac9d5 <+37>:	mov    %rax,0x28(%rsp)
>     0x00000000007ac9da <+42>:	mov    %rdi,%rax
>     0x00000000007ac9dd <+45>:	and    %r9,%rdi
>
>  ../../fpu/softfloat.c:
>  588	    *r = (FloatParts64) {
>     0x00000000007ac9e0 <+48>:	mov    %ecx,0x4(%rsp)
>     0x00000000007ac9e4 <+52>:	mov    %rdi,0x8(%rsp)
>
>  /home/alex/lsrc/qemu.git/include/qemu/bitops.h:
>  396	    return (value >> start) & (~0ULL >> (64 - length));
>     0x00000000007ac9e9 <+57>:	shr    $0x3f,%rax
>
>  ../../fpu/softfloat.c:
>  588	    *r = (FloatParts64) {
>     0x00000000007ac9ed <+61>:	mov    %al,0x1(%rsp)
>
>  589	        .cls = float_class_unclassified,
>  590	        .sign = extract64(raw, f_size + e_size, 1),
>     0x00000000007ac9f1 <+65>:	mov    %rax,%r8
>
> I don't see any check and abort steps because all the shift and mask
> values are known at compile time. The softfloat compilation certainly
> does have some assert points though:
>
> readelf -s ./libqemu-ppc64-softmmu.fa.p/fpu_softfloat.c.o  |grep assert
>   136: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND g_assertion_mess[...]
>   138: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __assert_fail
>
> but the references are for the ISRA segments so its tricky to know if
> they get used or are just there for LTO purposes.
>
> If there are hot-paths that show up the extract/deposit functions I
> suspect a better approach would be to implement _nocheck variants (or
> maybe _noassert?) and use them where required rather than turning off
> the assert checking for these utility functions.

Just to clarify again, the asserts are still there when compiled with 
--enable-debug. The patch only turns them off for optimised release builds 
which I think makes sense if these asserts are to catch programming 
errors. I think I've also suggested adding noassert versions of these but 
that wasn't a popular idea and it may also not be easy to convert all 
places to use that like for example the register fields related usage in 
target/ppc as that would also affect other places. So this seems to be the 
simplest and most effective approach.

The softfloat related usage in these tests I've done seem to mostly come 
from unpacking and repacking floats in softfloat which is done for every 
operation, e.g. muladd which mp3 encoding mostly uses does 3 unpacks and 1 
pack for each call and each unpack is 3 extracts so even small overheads 
add app quickly. Just 1 muladd will result in 9 extracts and 2 deposits at 
least plus updating PPC flags for each FPU op adds a bunch more. I did 
some profiling with perf to find these.

Regards,
BALATON Zoltan
--3866299591-1053451517-1684761950=:76570--

