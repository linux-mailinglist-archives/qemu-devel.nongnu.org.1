Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE1670D495
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MBG-0000OP-Qd; Tue, 23 May 2023 03:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1MBC-0000My-WA
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:11:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1MBA-0008UH-Tw
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:11:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f606912ebaso16497145e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684825891; x=1687417891;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMPlj/g0ScaQhAg3kPb+C32LOU1uMepIqIRHzuPW26U=;
 b=ZMDuZSrkpdNoKi9V8xfMVpqPDaZvf7Utvb837AHP1MTSr9NN7L8q7Kqgcplcf5+eM6
 mtijW0/BsAvZCIqxEzjqOxU4V4a40N/h7bBI9JtAewP6yQRXTVABKzm6XeQz+K41MR/c
 h4Hi+nOLxUuwTOSSRuUk4lxZHkdqceqaok1qzQ6KbLj+GSbMxhu0XLMiQ5A4oPKafIWy
 kZxlCnjAcrH/AcBOyNOLoKUo6fIQg2hF93GzueH5Xt1QddCq4kiXEC7gnlwHPzBTCm4R
 dxpXy/C5t1poSS8xGV0dYIVLOxoiyntKZj2mMRdgHB39+wn6KPoKBCagbPD5qJXpNU9Z
 X8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684825891; x=1687417891;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IMPlj/g0ScaQhAg3kPb+C32LOU1uMepIqIRHzuPW26U=;
 b=ZQHWqwdTwELhSHEwhq6ZlhUtj2i0rKFW4JwDqTIOHDuEL7/yFoH90IUcGdKrzzDUBc
 tq1YDr42bi2nykKjky9Y0CACIk+nd1wyRd0qFaR6TwY0TJFCRh8+9mQDwJtI5m9a0GIy
 pYYo0cR82+L90Qnr0bvJn0+HZQerf9L3fawP3riCI7pkuB10/EG+IgD0CIQzcDmu6Gvm
 eCJwALR1IWmQSQfAY9s2/SvQazznShQcmN9yVS3YdOi4FOx4XMUyykN+b/MOMHgPgv2X
 l0MHgv6GaC8gCTnfMgJMAmMfiVNW7mh7tmEGF60zoGt7un5ldArJQtT9EeXL16Mxw2yr
 rQ9Q==
X-Gm-Message-State: AC+VfDyWzbVpsGXCJf205qIRbbzmPncsuoiIMjvcm8QoYKq7Z1r9bgVj
 Ia9aPzVthrECf9YoL+4WrgmtJw==
X-Google-Smtp-Source: ACHHUZ7z4yQGhIRmTBVnSORYen+KuD1SOLi74HlHqtydS3i44n6u0YYfHq91WTwGmUNSnHHlHOlW3A==
X-Received: by 2002:a1c:7415:0:b0:3f6:244:55df with SMTP id
 p21-20020a1c7415000000b003f6024455dfmr5298312wmc.29.1684825891316; 
 Tue, 23 May 2023 00:11:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 10-20020a05600c024a00b003f423dfc686sm8815346wmj.45.2023.05.23.00.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 00:11:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 799421FFBB;
 Tue, 23 May 2023 08:11:30 +0100 (BST)
References: <20230520205444.887287457E7@zero.eik.bme.hu>
 <874jo47cnd.fsf@linaro.org>
 <aaa22b3f-d548-5a69-489a-5777a7e98cef@eik.bme.hu>
 <87v8gk5m7p.fsf@linaro.org>
 <49c4781a-1e91-85ef-d9cb-6996e9bbb10c@eik.bme.hu>
 <ec9cfe5a-d5f2-466d-34dc-c35817e7e010@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] bitops.h: Compile out asserts without --enable-debug
Date: Tue, 23 May 2023 07:43:41 +0100
In-reply-to: <ec9cfe5a-d5f2-466d-34dc-c35817e7e010@linaro.org>
Message-ID: <87o7mb5xp9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/22/23 15:26, BALATON Zoltan wrote:
>> On Mon, 22 May 2023, Alex Benn=C3=A9e wrote:
>>> (ajb: add Richard for his compiler-fu)
>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>> On Mon, 22 May 2023, Alex Benn=C3=A9e wrote:
>>>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>>>
>>>>>> The low level extract and deposit funtions provided by bitops.h are
>>>>>> used in performance critical places. It crept into target/ppc via
>>>>>> FIELD_EX64 and also used by softfloat so PPC code using a lot of FPU
>>>>>> where hardfloat is also disabled is doubly affected.
>>>>>
>>>>> Most of these asserts compile out to nothing if the compiler is able =
to
>>>>> verify the constants are in the range. For example examining
>>>>> the start of float64_add:
>>>>>
>>> <snip>
>>>>>
>>>>> I don't see any check and abort steps because all the shift and mask
>>>>> values are known at compile time. The softfloat compilation certainly
>>>>> does have some assert points though:
>>>>>
>>>>> readelf -s ./libqemu-ppc64-softmmu.fa.p/fpu_softfloat.c.o=C2=A0 |grep=
 assert
>>>>> =C2=A0 136: 0000000000000000=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYPE=C2=A0 G=
LOBAL DEFAULT=C2=A0 UND g_assertion_mess[...]
>>>>> =C2=A0 138: 0000000000000000=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYPE=C2=A0 G=
LOBAL DEFAULT=C2=A0 UND __assert_fail
>>>>>
>>>>> but the references are for the ISRA segments so its tricky to know if
>>>>> they get used or are just there for LTO purposes.
>>>>>
>>>>> If there are hot-paths that show up the extract/deposit functions I
>>>>> suspect a better approach would be to implement _nocheck variants (or
>>>>> maybe _noassert?) and use them where required rather than turning off
>>>>> the assert checking for these utility functions.
>>>>
>>>> Just to clarify again, the asserts are still there when compiled with
>>>> --enable-debug. The patch only turns them off for optimised release
>>>> builds which I think makes sense if these asserts are to catch
>>>> programming errors.
>>>
>>> Well as Peter said the general policy is to keep asserts in but I
>>> appreciate this is a hotpath case.
>>>
>>>> I think I've also suggested adding noassert
>>>> versions of these but that wasn't a popular idea and it may also not
>>>> be easy to convert all places to use that like for example the
>>>> register fields related usage in target/ppc as that would also affect
>>>> other places.
>>>
>>> Is code generation or device emulation really on the hot-path. Generally
>>> a well predicted assert is in the noise for those operations.
>> They aren't in code generation but in helpers as you can also see in
>> the profile below and so they can be on hot path. Also I've noticed
>> that extract8 and extract16 just call extract32 after adding another
>> assert on their own in addition to the one in extract32 which is
>> double overhead for really no reason. I'd delete all these asserts
>> as the likelhood of bugs these could catch is very low anyway (how
>> often do you expect somebody to call these with out of bound values
>> that would not be obvious from the results otherwise?) but leaving
>> them in non-debug builds is totally useless in my opinion.
>>=20
>>>> So this seems to be the simplest and most effective
>>>> approach.
>>>>
>>>> The softfloat related usage in these tests I've done seem to mostly
>>>> come from unpacking and repacking floats in softfloat which is done
>>>> for every operation, e.g. muladd which mp3 encoding mostly uses does 3
>>>> unpacks and 1 pack for each call and each unpack is 3 extracts so even
>>>> small overheads add app quickly. Just 1 muladd will result in 9
>>>> extracts and 2 deposits at least plus updating PPC flags for each FPU
>>>> op adds a bunch more. I did some profiling with perf to find these.
>>>
>>> After some messing about trying to get lame to cross compile to a static
>>> binary I was able to replicate what you've seen:
>>>
>>> =C2=A011.44%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] unpack_raw=
64.isra.0
>>> =C2=A011.03%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] parts64_un=
canon_normal
>>> =C2=A0 8.26%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] helper_com=
pute_fprf_float64
>>> =C2=A0 6.75%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] do_float_c=
heck_status
>>> =C2=A0 5.34%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] parts64_mu=
ladd
>>> =C2=A0 4.75%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] pack_raw64=
.isra.0
>>> =C2=A0 4.38%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] parts64_ca=
nonicalize
>>> =C2=A0 3.62%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] float64r32=
_round_pack_canonical
>>> =C2=A0 3.32%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] helper_tod=
ouble
>>> =C2=A0 2.68%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] float64_add
>>> =C2=A0 2.51%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] float64_hs=
_compare
>>> =C2=A0 2.30%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] float64r32=
_muladd
>>> =C2=A0 1.80%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] float64r32=
_mul
>>> =C2=A0 1.40%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] float64r32=
_add
>>> =C2=A0 1.34%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] parts64_mul
>>> =C2=A0 1.16%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] parts64_ad=
dsub
>>> =C2=A0 1.14%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] helper_res=
et_fpstatus
>>> =C2=A0 1.06%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] helper_flo=
at_check_status
>>> =C2=A0 1.04%=C2=A0 qemu-ppc64=C2=A0 qemu-ppc64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.] float64_mu=
ladd
>> I've run 32 bit PPC version in qemu-system-ppc so the profile is a
>> bit different (has more system related overhead that I plan to look
>> at separately) but this part is similar to the above. I also wonder
>> what makes helper_compute_fprf_float64 a bottleneck as that does not
>> seem to have much extract/deposit, only a call to clz but it's hard
>> to tell what it really does due to nested calls and macros. I've
>> also seen this function among the top contenders in my profiling.
>>=20
>>> what I find confusing is the fact the parts extraction and packing
>>> should all be known constants which should cause the asserts to
>>> disappear. However it looks like the compiler decided to bring in a copy
>>> of the whole inline function (ISRA =3D >interprocedural scalar replacem=
ent
>>> of aggregates) which obviously can't fold the constants and eliminate
>>> the assert.
>> Could it be related to that while the parts size and start are
>> marked const but pulled out of a struct field so the compiler may
>> not know their actual value until run time?
>>=20
>>> Richard,
>>>
>>> Any idea of why the compiler might decide to do something like this?
>
> Try this.

That seems to have done the trick, translated code is now dominating the
profile:

+   14.12%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000=
619420
+   13.30%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000=
616850
+   12.58%    12.19%  qemu-ppc64  qemu-ppc64               [.] parts64_unca=
non_normal
+   10.62%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000=
61bf70
+    9.91%     9.73%  qemu-ppc64  qemu-ppc64               [.] helper_compu=
te_fprf_float64
+    7.84%     7.82%  qemu-ppc64  qemu-ppc64               [.] do_float_che=
ck_status
+    6.47%     5.78%  qemu-ppc64  qemu-ppc64               [.] parts64_cano=
nicalize.constprop.0
+    6.46%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000=
620130
+    6.42%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000=
619400
+    6.17%     6.04%  qemu-ppc64  qemu-ppc64               [.] parts64_mula=
dd
+    5.85%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000=
6167e0
+    5.74%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000b693fc=
ffffd3
+    5.45%     4.78%  qemu-ppc64  qemu-ppc64               [.] float64r32_r=
ound_pack_canonical
+    4.79%     0.00%  qemu-ppc64  [unknown]                [.] 0xfaff203940=
fe8240
+    4.29%     3.82%  qemu-ppc64  qemu-ppc64               [.] float64r32_m=
uladd
+    4.20%     3.87%  qemu-ppc64  qemu-ppc64               [.] helper_todou=
ble
+    3.51%     2.98%  qemu-ppc64  qemu-ppc64               [.] float64r32_m=
ul
+    3.12%     2.97%  qemu-ppc64  qemu-ppc64               [.] float64_hs_c=
ompare
+    3.06%     2.95%  qemu-ppc64  qemu-ppc64               [.] float64_add
+    2.88%     2.35%  qemu-ppc64  qemu-ppc64               [.] float64r32_a=
dd
+    2.65%     0.00%  qemu-ppc64  [unknown]                [.] 0x6c555e9100=
004039
+    2.55%     1.30%  qemu-ppc64  qemu-ppc64               [.] helper_float=
_check_status

eyeballing the float functions and I can't see any asserts expressed.

Before:

Executed in  721.65 secs    fish           external
   usr time  721.38 secs  561.00 micros  721.38 secs
   sys time    0.20 secs  261.00 micros    0.20 secs

After:

Executed in  650.38 secs    fish           external
   usr time  650.11 secs    0.00 micros  650.11 secs
   sys time    0.20 secs  989.00 micros    0.20 secs



>
>
> r~
>
> [2. text/x-patch; z.patch]...


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

