Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E52370CDE3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 00:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Dyu-0006CB-2o; Mon, 22 May 2023 18:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q1Dyp-0006Bv-OL; Mon, 22 May 2023 18:26:15 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q1Dyk-0002Yx-2I; Mon, 22 May 2023 18:26:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6F4D2748A5A;
 Tue, 23 May 2023 00:26:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DA886748A56; Tue, 23 May 2023 00:26:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D8EDA748A55;
 Tue, 23 May 2023 00:26:03 +0200 (CEST)
Date: Tue, 23 May 2023 00:26:03 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: Richard Henderson <richard.henderson@linaro.org>, qemu-trivial@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] bitops.h: Compile out asserts without --enable-debug
In-Reply-To: <87v8gk5m7p.fsf@linaro.org>
Message-ID: <49c4781a-1e91-85ef-d9cb-6996e9bbb10c@eik.bme.hu>
References: <20230520205444.887287457E7@zero.eik.bme.hu>
 <874jo47cnd.fsf@linaro.org> <aaa22b3f-d548-5a69-489a-5777a7e98cef@eik.bme.hu>
 <87v8gk5m7p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-814460712-1684794363=:14582"
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

--3866299591-814460712-1684794363=:14582
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 22 May 2023, Alex Bennée wrote:
> (ajb: add Richard for his compiler-fu)
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Mon, 22 May 2023, Alex Bennée wrote:
>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>
>>>> The low level extract and deposit funtions provided by bitops.h are
>>>> used in performance critical places. It crept into target/ppc via
>>>> FIELD_EX64 and also used by softfloat so PPC code using a lot of FPU
>>>> where hardfloat is also disabled is doubly affected.
>>>
>>> Most of these asserts compile out to nothing if the compiler is able to
>>> verify the constants are in the range. For example examining
>>> the start of float64_add:
>>>
> <snip>
>>>
>>> I don't see any check and abort steps because all the shift and mask
>>> values are known at compile time. The softfloat compilation certainly
>>> does have some assert points though:
>>>
>>> readelf -s ./libqemu-ppc64-softmmu.fa.p/fpu_softfloat.c.o  |grep assert
>>>   136: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND g_assertion_mess[...]
>>>   138: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __assert_fail
>>>
>>> but the references are for the ISRA segments so its tricky to know if
>>> they get used or are just there for LTO purposes.
>>>
>>> If there are hot-paths that show up the extract/deposit functions I
>>> suspect a better approach would be to implement _nocheck variants (or
>>> maybe _noassert?) and use them where required rather than turning off
>>> the assert checking for these utility functions.
>>
>> Just to clarify again, the asserts are still there when compiled with
>> --enable-debug. The patch only turns them off for optimised release
>> builds which I think makes sense if these asserts are to catch
>> programming errors.
>
> Well as Peter said the general policy is to keep asserts in but I
> appreciate this is a hotpath case.
>
>> I think I've also suggested adding noassert
>> versions of these but that wasn't a popular idea and it may also not
>> be easy to convert all places to use that like for example the
>> register fields related usage in target/ppc as that would also affect
>> other places.
>
> Is code generation or device emulation really on the hot-path. Generally
> a well predicted assert is in the noise for those operations.

They aren't in code generation but in helpers as you can also see in the 
profile below and so they can be on hot path. Also I've noticed that 
extract8 and extract16 just call extract32 after adding another assert on 
their own in addition to the one in extract32 which is double overhead for 
really no reason. I'd delete all these asserts as the likelhood of bugs 
these could catch is very low anyway (how often do you expect somebody to 
call these with out of bound values that would not be obvious from the 
results otherwise?) but leaving them in non-debug builds is totally 
useless in my opinion.

>> So this seems to be the simplest and most effective
>> approach.
>>
>> The softfloat related usage in these tests I've done seem to mostly
>> come from unpacking and repacking floats in softfloat which is done
>> for every operation, e.g. muladd which mp3 encoding mostly uses does 3
>> unpacks and 1 pack for each call and each unpack is 3 extracts so even
>> small overheads add app quickly. Just 1 muladd will result in 9
>> extracts and 2 deposits at least plus updating PPC flags for each FPU
>> op adds a bunch more. I did some profiling with perf to find these.
>
> After some messing about trying to get lame to cross compile to a static
> binary I was able to replicate what you've seen:
>
>  11.44%  qemu-ppc64  qemu-ppc64               [.] unpack_raw64.isra.0
>  11.03%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
>   8.26%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
>   6.75%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
>   5.34%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
>   4.75%  qemu-ppc64  qemu-ppc64               [.] pack_raw64.isra.0
>   4.38%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize
>   3.62%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical
>   3.32%  qemu-ppc64  qemu-ppc64               [.] helper_todouble
>   2.68%  qemu-ppc64  qemu-ppc64               [.] float64_add
>   2.51%  qemu-ppc64  qemu-ppc64               [.] float64_hs_compare
>   2.30%  qemu-ppc64  qemu-ppc64               [.] float64r32_muladd
>   1.80%  qemu-ppc64  qemu-ppc64               [.] float64r32_mul
>   1.40%  qemu-ppc64  qemu-ppc64               [.] float64r32_add
>   1.34%  qemu-ppc64  qemu-ppc64               [.] parts64_mul
>   1.16%  qemu-ppc64  qemu-ppc64               [.] parts64_addsub
>   1.14%  qemu-ppc64  qemu-ppc64               [.] helper_reset_fpstatus
>   1.06%  qemu-ppc64  qemu-ppc64               [.] helper_float_check_status
>   1.04%  qemu-ppc64  qemu-ppc64               [.] float64_muladd

I've run 32 bit PPC version in qemu-system-ppc so the profile is a bit 
different (has more system related overhead that I plan to look at 
separately) but this part is similar to the above. I also wonder what 
makes helper_compute_fprf_float64 a bottleneck as that does not seem to 
have much extract/deposit, only a call to clz but it's hard to tell what 
it really does due to nested calls and macros. I've also seen this 
function among the top contenders in my profiling.

> what I find confusing is the fact the parts extraction and packing
> should all be known constants which should cause the asserts to
> disappear. However it looks like the compiler decided to bring in a copy
> of the whole inline function (ISRA = >interprocedural scalar replacement
> of aggregates) which obviously can't fold the constants and eliminate
> the assert.

Could it be related to that while the parts size and start are marked 
const but pulled out of a struct field so the compiler may not know their 
actual value until run time?

> Richard,
>
> Any idea of why the compiler might decide to do something like this?
>
>>
>> Regards,
>> BALATON Zoltan
>
>
> --
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
>
>
--3866299591-814460712-1684794363=:14582--

