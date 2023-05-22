Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B8270BB01
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 12:57:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q13DW-0002vV-0I; Mon, 22 May 2023 06:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q13DU-0002vE-AR
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q13DS-0003ky-LS
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684752997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRRXncr5Yx5UVKKvc1WGUFJZIpDhX3vrDDLRNpqCQf0=;
 b=BolBIhLkaS4uVUEdlhQxex6nsTrqFI8v9/WpYuVCeEexyGQWXjccZtDD2I5VG8gJxNb9we
 DpP6A8N1KXpSm7Zc2LykRejLfotPXBBXDR4wi66PXdpMqpqL0hRhCcL7CE87Y2e/ygskEa
 tMODWm6fiSNYFXd54rQyxnAyAcNuzsU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-Fk4fl4oeNOaNwUu0EzTV-A-1; Mon, 22 May 2023 06:56:36 -0400
X-MC-Unique: Fk4fl4oeNOaNwUu0EzTV-A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96fd6bd135dso123144566b.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 03:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684752995; x=1687344995;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SRRXncr5Yx5UVKKvc1WGUFJZIpDhX3vrDDLRNpqCQf0=;
 b=feMqGkHhyRJA4l6Ra0WE072RQ/xIEsuwDKAXEqjMc06qmWOnt87J6YkpFE2z7PtOvq
 KCS7JvlqTD54n2fz1QxaCGxqfnNyIhQ42CjLz8ex4/G0xrk5+GhT7VI0ly1rV6WFq5ie
 D9RZt0fhzWDTHG3mN6RRbZtcOiTfm2UQQ60wZd6fHPiH7XEnhJ8FZdZcmqEzB3g0MEEa
 UGzvxz8FQ/24SSbm4wpEwwFCsamUtriiPlExxQZIzwoPZWIwWWBoFYBf6tj9fBSygjf8
 SafKLXcM6JWMNFz0yAq5gHbaIboh57opv7vusF2pnlb8Udh7UTSGO6gag3eJCfhaDzWN
 eRzw==
X-Gm-Message-State: AC+VfDykpOA7kb7x/Z61+mDEkCvTiei1eJ2pPQiU5gceKd7I5a5ytMBb
 01bRDSBil+HMa2/uUQQFFlrtfhe0UNJ6wuEl/qoYVdL+z8ektc6XF1aqtbAgeiJT3Dtg+onTzah
 6o3RWc3lJp0N//qk=
X-Received: by 2002:a17:906:58cd:b0:96f:a39c:86d4 with SMTP id
 e13-20020a17090658cd00b0096fa39c86d4mr7737716ejs.7.1684752995076; 
 Mon, 22 May 2023 03:56:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CqJ3EgjKGFIPMdTU7eG7BP7MWYxlI4l2K/Rs5BgByb/2tLrUKR0y2hWXaRwmTwvA+gpb5JQ==
X-Received: by 2002:a17:906:58cd:b0:96f:a39c:86d4 with SMTP id
 e13-20020a17090658cd00b0096fa39c86d4mr7737704ejs.7.1684752994785; 
 Mon, 22 May 2023 03:56:34 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 m23-20020a056402051700b0050bd245d39esm2850465edv.6.2023.05.22.03.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 03:56:34 -0700 (PDT)
Message-ID: <935a5d04-5119-18c2-2b32-a77f3ac415f5@redhat.com>
Date: Mon, 22 May 2023 12:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 09/19] test-cutils: Add coverage of qemu_strtod
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-10-eblake@redhat.com>
 <2e230e7f-694f-6b4e-2fcf-7504532581ed@redhat.com>
 <uc3cbsxtikz3icrxkct2ry4xowmtxm5fvkrnmfiufjb7xt3ncw@bt2xoq3qqbiu>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <uc3cbsxtikz3icrxkct2ry4xowmtxm5fvkrnmfiufjb7xt3ncw@bt2xoq3qqbiu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19.05.23 19:52, Eric Blake wrote:
> On Fri, May 19, 2023 at 05:05:20PM +0200, Hanna Czenczek wrote:
>> On 12.05.23 04:10, Eric Blake wrote:
>>> It's hard to tweak code for consistency if I can't prove what will or
>>> won't break from those tweaks.  Time to add unit tests for
>>> qemu_strtod() and qemu_strtod_finite().
>>>
>>> Among other things, I wrote a check whether we have C99 semantics for
>>> strtod("0x1") (which MUST parse hex numbers) rather than C89 (which
>>> must stop parsing at 'x').  These days, I suspect that is okay; but if
>>> it fails CI checks, knowing the difference will help us decide what we
>>> want to do about it.  Note that C2x, while not final at the time of
>>> this patch, has been considering whether to make strtol("0b1") parse
>>> as 1 with no slop instead of the C17 parse of 0 with slop "b1"; that
>>> decision may also bleed over to strtod().  But for now, I didn't think
>>> it worth adding unit tests on that front (to strtol or strtod) as
>>> things may still change.
>>>
>>> Likewise, there are plenty more corner cases of strtod proper that I
>>> don't explicitly test here, but there are enough unit tests added here
>>> that it covers all the branches reached in our wrappers.  In
>>> particular, it demonstrates the difference on when *value is left
>>> uninitialized, which an upcoming patch will normalize.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>>> ---
>>>
>>> v2: Added g_assert_false(signbit(res)) anywhere I used
>>> g_assert_cmpfloat(res,==,0.0); add a test for strtod() hex parsing and
>>> handling of junk after ERANGE, which is major enough that I dropped
>>> R-b
>>> ---
>>>    tests/unit/test-cutils.c | 510 +++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 510 insertions(+)
>>>
>>> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
>>> index d3076c3fec1..1763839a157 100644
>>> --- a/tests/unit/test-cutils.c
>>> +++ b/tests/unit/test-cutils.c
>> [...]
>>
>>> +static void test_qemu_strtod_erange_junk(void)
>>> +{
>>> +    const char *str;
>>> +    const char *endptr;
>>> +    int err;
>>> +    double res;
>>> +
>>> +    /* EINVAL has priority over ERANGE */
>> By being placed here, this comment confused me a bit, because the first case
>> does return ERANGE.  So I’d prefer it above the second case, where we
>> actually expect EINVAL, but understand that’s a personal preference.  (Same
>> for the _finite_ variant)
> The test is what happens when both conditions apply.  For
> qemu_strtod("1e-999junk", &endptr), only ERANGE applies (because
> "junk" is returned in endptr); it is not until
> qemu_strtod("1e-999junk", NULL) where EINVAL is also possible
> (trailing junk takes precedence over underflow).

Yep; it’s just that because the comment is directly above one test case, 
I assumed it applied to just that case, and was looking for the EINVAL 
there.  Only then I realized that EINVAL won’t occur there, and the 
comment instead points out the difference between the two cases there are.

> For qemu_strtosz(),
> I made it a bit more obvious by writing a helper function that shows
> both errno values in a single line, rather than spreading out the
> boilerplate over multiple lines.
>
> Should I do a similar helper function for qemu_strtod[_finite] in v3?

I mean, from my perspective, all I can see is that it would make 
reviewing v3 more tedious…


