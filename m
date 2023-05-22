Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FEE70CEB6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 01:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1F35-0002PR-5A; Mon, 22 May 2023 19:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1F32-0002P1-JJ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 19:34:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1F2z-0007hr-AT
 for qemu-devel@nongnu.org; Mon, 22 May 2023 19:34:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ae875bf125so26097295ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 16:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684798476; x=1687390476;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqq8LgeF9tPfw6tPVYwk5p7UNwAud6NgoNGr1cB8GVo=;
 b=mhY4YVrC+BOkcyZkKEhXCI5nfn0w1EGJ+aiZyPw5rGVrOIIFg6FO7w0CbSjNKVHZim
 Eohj9RUgYRRdvT2K1qskN2bCvnf3C/CZM0l8tzzzJ5etyep3AXZgE+stDC4k0cBB5Ddd
 pZ1Af7HcL3/5pVyubVmoat+O18Cj5NlaXIXIuXzyLPsWHAOHcZqCCZOX3srcJ9Z8pPAv
 dt6PmoJmTy16LkPgtS3paofOUjVqmdYFgUvpzGafoW4RTbCbKpzl8seHfrQxYSf8wLDw
 NinUBieX5V534LL9b6zKFl2IptGkfZZ3nhHG//35ng8lPg5+SzsqneeszdoYNYLvuSJO
 +kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684798476; x=1687390476;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bqq8LgeF9tPfw6tPVYwk5p7UNwAud6NgoNGr1cB8GVo=;
 b=OBaGC4Egp/OmqEjpnWBk1raVyoFa4DKpJh40HmzlqnaqU2JcNhuJB+KBDNff2ogV9O
 SXsYUrOmpMpg8IbD9t7ZaWtNQu4sPWgivVKcL+H+yHc5cdiX6JeUoWZsRfA0X8oMAE/U
 xDUQaQgQaOxS766rNhcea1XL/Ch1N7mqTNLNesm+hGaYM0GNsSS5OgjpEfYHZFipTalc
 xyF4E5dZ7htLlbYaUw2/En/VLZAbieTu5J5ceiC0ReXa/jN5g5qQ7a6E2SRlcx1zcEVr
 S4qa+04EqXg71/N//yUDf0c+kRbvah4WeceqLFlwjcWZ9ncZmrrEBH5g3d7EYaxQg1ee
 ZCMA==
X-Gm-Message-State: AC+VfDwJo8ZjcCDauhl9jhKAfwfeBzA5dCT9T796n97bveXzOoaOzlQ6
 EJwSXOOwptXGjBJcv+FRwJsHBw==
X-Google-Smtp-Source: ACHHUZ4TNNAAInb4/KcLM3GKJHgpWUJLwPR9+EheNXou17h036QDtXCUtIb8Dyv3lIWG+GbDxJzUXA==
X-Received: by 2002:a17:902:ab93:b0:1af:bba9:16e0 with SMTP id
 f19-20020a170902ab9300b001afbba916e0mr2498026plr.8.1684798475485; 
 Mon, 22 May 2023 16:34:35 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86fe:2b34:5897:c8ef?
 ([2602:ae:1598:4c01:86fe:2b34:5897:c8ef])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a170902b7c100b001a95c7742bbsm5407893plz.9.2023.05.22.16.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 16:34:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------UCWAQH6RMlhn58F0s0hhCddn"
Message-ID: <ec9cfe5a-d5f2-466d-34dc-c35817e7e010@linaro.org>
Date: Mon, 22 May 2023 16:34:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] bitops.h: Compile out asserts without --enable-debug
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
References: <20230520205444.887287457E7@zero.eik.bme.hu>
 <874jo47cnd.fsf@linaro.org> <aaa22b3f-d548-5a69-489a-5777a7e98cef@eik.bme.hu>
 <87v8gk5m7p.fsf@linaro.org> <49c4781a-1e91-85ef-d9cb-6996e9bbb10c@eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <49c4781a-1e91-85ef-d9cb-6996e9bbb10c@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

This is a multi-part message in MIME format.
--------------UCWAQH6RMlhn58F0s0hhCddn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/22/23 15:26, BALATON Zoltan wrote:
> On Mon, 22 May 2023, Alex Bennée wrote:
>> (ajb: add Richard for his compiler-fu)
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>> On Mon, 22 May 2023, Alex Bennée wrote:
>>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>>
>>>>> The low level extract and deposit funtions provided by bitops.h are
>>>>> used in performance critical places. It crept into target/ppc via
>>>>> FIELD_EX64 and also used by softfloat so PPC code using a lot of FPU
>>>>> where hardfloat is also disabled is doubly affected.
>>>>
>>>> Most of these asserts compile out to nothing if the compiler is able to
>>>> verify the constants are in the range. For example examining
>>>> the start of float64_add:
>>>>
>> <snip>
>>>>
>>>> I don't see any check and abort steps because all the shift and mask
>>>> values are known at compile time. The softfloat compilation certainly
>>>> does have some assert points though:
>>>>
>>>> readelf -s ./libqemu-ppc64-softmmu.fa.p/fpu_softfloat.c.o  |grep assert
>>>>   136: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND g_assertion_mess[...]
>>>>   138: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __assert_fail
>>>>
>>>> but the references are for the ISRA segments so its tricky to know if
>>>> they get used or are just there for LTO purposes.
>>>>
>>>> If there are hot-paths that show up the extract/deposit functions I
>>>> suspect a better approach would be to implement _nocheck variants (or
>>>> maybe _noassert?) and use them where required rather than turning off
>>>> the assert checking for these utility functions.
>>>
>>> Just to clarify again, the asserts are still there when compiled with
>>> --enable-debug. The patch only turns them off for optimised release
>>> builds which I think makes sense if these asserts are to catch
>>> programming errors.
>>
>> Well as Peter said the general policy is to keep asserts in but I
>> appreciate this is a hotpath case.
>>
>>> I think I've also suggested adding noassert
>>> versions of these but that wasn't a popular idea and it may also not
>>> be easy to convert all places to use that like for example the
>>> register fields related usage in target/ppc as that would also affect
>>> other places.
>>
>> Is code generation or device emulation really on the hot-path. Generally
>> a well predicted assert is in the noise for those operations.
> 
> They aren't in code generation but in helpers as you can also see in the profile below and 
> so they can be on hot path. Also I've noticed that extract8 and extract16 just call 
> extract32 after adding another assert on their own in addition to the one in extract32 
> which is double overhead for really no reason. I'd delete all these asserts as the 
> likelhood of bugs these could catch is very low anyway (how often do you expect somebody 
> to call these with out of bound values that would not be obvious from the results 
> otherwise?) but leaving them in non-debug builds is totally useless in my opinion.
> 
>>> So this seems to be the simplest and most effective
>>> approach.
>>>
>>> The softfloat related usage in these tests I've done seem to mostly
>>> come from unpacking and repacking floats in softfloat which is done
>>> for every operation, e.g. muladd which mp3 encoding mostly uses does 3
>>> unpacks and 1 pack for each call and each unpack is 3 extracts so even
>>> small overheads add app quickly. Just 1 muladd will result in 9
>>> extracts and 2 deposits at least plus updating PPC flags for each FPU
>>> op adds a bunch more. I did some profiling with perf to find these.
>>
>> After some messing about trying to get lame to cross compile to a static
>> binary I was able to replicate what you've seen:
>>
>>  11.44%  qemu-ppc64  qemu-ppc64               [.] unpack_raw64.isra.0
>>  11.03%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
>>   8.26%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
>>   6.75%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
>>   5.34%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
>>   4.75%  qemu-ppc64  qemu-ppc64               [.] pack_raw64.isra.0
>>   4.38%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize
>>   3.62%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical
>>   3.32%  qemu-ppc64  qemu-ppc64               [.] helper_todouble
>>   2.68%  qemu-ppc64  qemu-ppc64               [.] float64_add
>>   2.51%  qemu-ppc64  qemu-ppc64               [.] float64_hs_compare
>>   2.30%  qemu-ppc64  qemu-ppc64               [.] float64r32_muladd
>>   1.80%  qemu-ppc64  qemu-ppc64               [.] float64r32_mul
>>   1.40%  qemu-ppc64  qemu-ppc64               [.] float64r32_add
>>   1.34%  qemu-ppc64  qemu-ppc64               [.] parts64_mul
>>   1.16%  qemu-ppc64  qemu-ppc64               [.] parts64_addsub
>>   1.14%  qemu-ppc64  qemu-ppc64               [.] helper_reset_fpstatus
>>   1.06%  qemu-ppc64  qemu-ppc64               [.] helper_float_check_status
>>   1.04%  qemu-ppc64  qemu-ppc64               [.] float64_muladd
> 
> I've run 32 bit PPC version in qemu-system-ppc so the profile is a bit different (has more 
> system related overhead that I plan to look at separately) but this part is similar to the 
> above. I also wonder what makes helper_compute_fprf_float64 a bottleneck as that does not 
> seem to have much extract/deposit, only a call to clz but it's hard to tell what it really 
> does due to nested calls and macros. I've also seen this function among the top contenders 
> in my profiling.
> 
>> what I find confusing is the fact the parts extraction and packing
>> should all be known constants which should cause the asserts to
>> disappear. However it looks like the compiler decided to bring in a copy
>> of the whole inline function (ISRA = >interprocedural scalar replacement
>> of aggregates) which obviously can't fold the constants and eliminate
>> the assert.
> 
> Could it be related to that while the parts size and start are marked const but pulled out 
> of a struct field so the compiler may not know their actual value until run time?
> 
>> Richard,
>>
>> Any idea of why the compiler might decide to do something like this?

Try this.


r~

--------------UCWAQH6RMlhn58F0s0hhCddn
Content-Type: text/x-patch; charset=UTF-8; name="z.patch"
Content-Disposition: attachment; filename="z.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZwdS9zb2Z0ZmxvYXQuYyBiL2ZwdS9zb2Z0ZmxvYXQuYwppbmRleCAx
MDhmOWNiMjI0Li40MmU2YzE4OGI0IDEwMDY0NAotLS0gYS9mcHUvc29mdGZsb2F0LmMKKysr
IGIvZnB1L3NvZnRmbG9hdC5jCkBAIC01OTMsMjcgKzU5MywyNyBAQCBzdGF0aWMgdm9pZCB1
bnBhY2tfcmF3NjQoRmxvYXRQYXJ0czY0ICpyLCBjb25zdCBGbG9hdEZtdCAqZm10LCB1aW50
NjRfdCByYXcpCiAgICAgfTsKIH0KIAotc3RhdGljIGlubGluZSB2b2lkIGZsb2F0MTZfdW5w
YWNrX3JhdyhGbG9hdFBhcnRzNjQgKnAsIGZsb2F0MTYgZikKK3N0YXRpYyB2b2lkIFFFTVVf
RkxBVFRFTiBmbG9hdDE2X3VucGFja19yYXcoRmxvYXRQYXJ0czY0ICpwLCBmbG9hdDE2IGYp
CiB7CiAgICAgdW5wYWNrX3JhdzY0KHAsICZmbG9hdDE2X3BhcmFtcywgZik7CiB9CiAKLXN0
YXRpYyBpbmxpbmUgdm9pZCBiZmxvYXQxNl91bnBhY2tfcmF3KEZsb2F0UGFydHM2NCAqcCwg
YmZsb2F0MTYgZikKK3N0YXRpYyB2b2lkIFFFTVVfRkxBVFRFTiBiZmxvYXQxNl91bnBhY2tf
cmF3KEZsb2F0UGFydHM2NCAqcCwgYmZsb2F0MTYgZikKIHsKICAgICB1bnBhY2tfcmF3NjQo
cCwgJmJmbG9hdDE2X3BhcmFtcywgZik7CiB9CiAKLXN0YXRpYyBpbmxpbmUgdm9pZCBmbG9h
dDMyX3VucGFja19yYXcoRmxvYXRQYXJ0czY0ICpwLCBmbG9hdDMyIGYpCitzdGF0aWMgdm9p
ZCBRRU1VX0ZMQVRURU4gZmxvYXQzMl91bnBhY2tfcmF3KEZsb2F0UGFydHM2NCAqcCwgZmxv
YXQzMiBmKQogewogICAgIHVucGFja19yYXc2NChwLCAmZmxvYXQzMl9wYXJhbXMsIGYpOwog
fQogCi1zdGF0aWMgaW5saW5lIHZvaWQgZmxvYXQ2NF91bnBhY2tfcmF3KEZsb2F0UGFydHM2
NCAqcCwgZmxvYXQ2NCBmKQorc3RhdGljIHZvaWQgUUVNVV9GTEFUVEVOIGZsb2F0NjRfdW5w
YWNrX3JhdyhGbG9hdFBhcnRzNjQgKnAsIGZsb2F0NjQgZikKIHsKICAgICB1bnBhY2tfcmF3
NjQocCwgJmZsb2F0NjRfcGFyYW1zLCBmKTsKIH0KIAotc3RhdGljIHZvaWQgZmxvYXR4ODBf
dW5wYWNrX3JhdyhGbG9hdFBhcnRzMTI4ICpwLCBmbG9hdHg4MCBmKQorc3RhdGljIHZvaWQg
UUVNVV9GTEFUVEVOIGZsb2F0eDgwX3VucGFja19yYXcoRmxvYXRQYXJ0czEyOCAqcCwgZmxv
YXR4ODAgZikKIHsKICAgICAqcCA9IChGbG9hdFBhcnRzMTI4KSB7CiAgICAgICAgIC5jbHMg
PSBmbG9hdF9jbGFzc191bmNsYXNzaWZpZWQsCkBAIC02MjMsNyArNjIzLDcgQEAgc3RhdGlj
IHZvaWQgZmxvYXR4ODBfdW5wYWNrX3JhdyhGbG9hdFBhcnRzMTI4ICpwLCBmbG9hdHg4MCBm
KQogICAgIH07CiB9CiAKLXN0YXRpYyB2b2lkIGZsb2F0MTI4X3VucGFja19yYXcoRmxvYXRQ
YXJ0czEyOCAqcCwgZmxvYXQxMjggZikKK3N0YXRpYyB2b2lkIFFFTVVfRkxBVFRFTiBmbG9h
dDEyOF91bnBhY2tfcmF3KEZsb2F0UGFydHMxMjggKnAsIGZsb2F0MTI4IGYpCiB7CiAgICAg
Y29uc3QgaW50IGZfc2l6ZSA9IGZsb2F0MTI4X3BhcmFtcy5mcmFjX3NpemUgLSA2NDsKICAg
ICBjb25zdCBpbnQgZV9zaXplID0gZmxvYXQxMjhfcGFyYW1zLmV4cF9zaXplOwpAQCAtNjUw
LDI3ICs2NTAsMjcgQEAgc3RhdGljIHVpbnQ2NF90IHBhY2tfcmF3NjQoY29uc3QgRmxvYXRQ
YXJ0czY0ICpwLCBjb25zdCBGbG9hdEZtdCAqZm10KQogICAgIHJldHVybiByZXQ7CiB9CiAK
LXN0YXRpYyBpbmxpbmUgZmxvYXQxNiBmbG9hdDE2X3BhY2tfcmF3KGNvbnN0IEZsb2F0UGFy
dHM2NCAqcCkKK3N0YXRpYyBmbG9hdDE2IFFFTVVfRkxBVFRFTiBmbG9hdDE2X3BhY2tfcmF3
KGNvbnN0IEZsb2F0UGFydHM2NCAqcCkKIHsKICAgICByZXR1cm4gbWFrZV9mbG9hdDE2KHBh
Y2tfcmF3NjQocCwgJmZsb2F0MTZfcGFyYW1zKSk7CiB9CiAKLXN0YXRpYyBpbmxpbmUgYmZs
b2F0MTYgYmZsb2F0MTZfcGFja19yYXcoY29uc3QgRmxvYXRQYXJ0czY0ICpwKQorc3RhdGlj
IGJmbG9hdDE2IFFFTVVfRkxBVFRFTiBiZmxvYXQxNl9wYWNrX3Jhdyhjb25zdCBGbG9hdFBh
cnRzNjQgKnApCiB7CiAgICAgcmV0dXJuIHBhY2tfcmF3NjQocCwgJmJmbG9hdDE2X3BhcmFt
cyk7CiB9CiAKLXN0YXRpYyBpbmxpbmUgZmxvYXQzMiBmbG9hdDMyX3BhY2tfcmF3KGNvbnN0
IEZsb2F0UGFydHM2NCAqcCkKK3N0YXRpYyBmbG9hdDMyIFFFTVVfRkxBVFRFTiBmbG9hdDMy
X3BhY2tfcmF3KGNvbnN0IEZsb2F0UGFydHM2NCAqcCkKIHsKICAgICByZXR1cm4gbWFrZV9m
bG9hdDMyKHBhY2tfcmF3NjQocCwgJmZsb2F0MzJfcGFyYW1zKSk7CiB9CiAKLXN0YXRpYyBp
bmxpbmUgZmxvYXQ2NCBmbG9hdDY0X3BhY2tfcmF3KGNvbnN0IEZsb2F0UGFydHM2NCAqcCkK
K3N0YXRpYyBmbG9hdDY0IFFFTVVfRkxBVFRFTiBmbG9hdDY0X3BhY2tfcmF3KGNvbnN0IEZs
b2F0UGFydHM2NCAqcCkKIHsKICAgICByZXR1cm4gbWFrZV9mbG9hdDY0KHBhY2tfcmF3NjQo
cCwgJmZsb2F0NjRfcGFyYW1zKSk7CiB9CiAKLXN0YXRpYyBmbG9hdDEyOCBmbG9hdDEyOF9w
YWNrX3Jhdyhjb25zdCBGbG9hdFBhcnRzMTI4ICpwKQorc3RhdGljIGZsb2F0MTI4IFFFTVVf
RkxBVFRFTiBmbG9hdDEyOF9wYWNrX3Jhdyhjb25zdCBGbG9hdFBhcnRzMTI4ICpwKQogewog
ICAgIGNvbnN0IGludCBmX3NpemUgPSBmbG9hdDEyOF9wYXJhbXMuZnJhY19zaXplIC0gNjQ7
CiAgICAgY29uc3QgaW50IGVfc2l6ZSA9IGZsb2F0MTI4X3BhcmFtcy5leHBfc2l6ZTsK

--------------UCWAQH6RMlhn58F0s0hhCddn--

