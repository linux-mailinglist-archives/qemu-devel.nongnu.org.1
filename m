Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA370E2B9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VlV-0000PC-CF; Tue, 23 May 2023 13:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q1VlS-0000OP-1m
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q1VlP-0006Ca-D2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684862733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnNzeUEChHhGHQcJGAN/w2O2fLk9AhLBKXLcGAFOJu8=;
 b=Q/E8tOpZLGRL8Sc5AB7sDqsrG/uxrfwIUvRERdFmjyYvMEiG+qXrGTjJx6gqPMPM1OTEw7
 RF16QlhAqcrzx3FucMwnl4qSpDN3tnj7aoq5nl0wlsmkfSdKnAds5yR5+9goUTwlxClcGW
 9K/KDEhNZ9ky3NUn/eKIJgn72e0cyAo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-rLFSshrPPjmMqMs77QIdbQ-1; Tue, 23 May 2023 13:25:32 -0400
X-MC-Unique: rLFSshrPPjmMqMs77QIdbQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96fe603151eso323055766b.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684862730; x=1687454730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YnNzeUEChHhGHQcJGAN/w2O2fLk9AhLBKXLcGAFOJu8=;
 b=eAiceZQ4I6L4G10isEcSNPFeqTN4J6uXhILg0ooLXGuZMeM67Ybsh2exbWF8C01ZrA
 MUIuame9gzDk7q4CLiXG80UgI2mQSMF58gZIHR7aSlsFpRNJo9Cishf+paucgnVfIvKy
 EuM1ingOygEAHQTimQRa98XHRp6kpZHNFiGPAncVyG/b3bMhDVSOd6FSf0xsxwBn2D6X
 cCBYDg8iKcByH/aK3aU5k83c2dQlLcSq6xOfJr7BQJ/Zry9MhSa7TomUFzizKV5ZhldU
 FANVODgKSqctalEW79dOMQkmficEyoNBab2nGGH/HRPv3Ekl/HCjCps2jSodKzlRakIX
 FE3A==
X-Gm-Message-State: AC+VfDyiv4RSOBDXcRYaOFdwsj9D/8egID8Heo3buJ5rMKQ/RixBRYeR
 tqh48/owEeEd3y5s4jo2Ij/XJi1ybNQdNQMdwe48hIrm755H7oUVyon8hfxU3Lo3r3EuFG5qIgL
 r/WstDujs4YyWN9g=
X-Received: by 2002:a17:907:7204:b0:972:aa30:203e with SMTP id
 dr4-20020a170907720400b00972aa30203emr1953918ejc.34.1684862730219; 
 Tue, 23 May 2023 10:25:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51MfH74NSnb8/SYflzFJWn30jtvjo7rbfNX+SbiR9yHM2A1lPcP4AQUI6WZ5tDM2SXLNXflw==
X-Received: by 2002:a17:907:7204:b0:972:aa30:203e with SMTP id
 dr4-20020a170907720400b00972aa30203emr1953904ejc.34.1684862729826; 
 Tue, 23 May 2023 10:25:29 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:8fa2:ce55:2d0c:5fa3?
 (p200300cfd723b0c78fa2ce552d0c5fa3.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:8fa2:ce55:2d0c:5fa3])
 by smtp.gmail.com with ESMTPSA id
 fy26-20020a170906b7da00b0096f920858afsm4645377ejb.102.2023.05.23.10.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 10:25:29 -0700 (PDT)
Message-ID: <5720a801-a6b7-1b9e-efdb-bceb7e55c6ce@redhat.com>
Date: Tue, 23 May 2023 19:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 04/19] test-cutils: Test more integer corner cases
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20230522190441.64278-1-eblake@redhat.com>
 <20230522190441.64278-5-eblake@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230522190441.64278-5-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22.05.23 21:04, Eric Blake wrote:
> We have quite a few undertested and underdocumented integer parsing
> corner cases.  To ensure that any changes we make in the code are
> intentional rather than accidental semantic changes, it is time to add
> more unit tests of existing behavior.
>
> In particular, this demonstrates that parse_uint() and qemu_strtou64()
> behave differently.  For "-0", it's hard to argue why parse_uint needs
> to reject it (it's not a negative integer), but the documentation sort
> of mentions it; but it is intentional that all other negative values
> are treated as ERANGE with value 0 (compared to qemu_strtou64()
> treating "-2" as success and UINT64_MAX-1, for example).
>
> Also, when mixing overflow/underflow with a check for no trailing
> junk, parse_uint_full favors ERANGE over EINVAL, while qemu_strto[iu]*
> favor EINVAL.  This behavior is outside the C standard, so we can pick
> whatever we want, but it would be nice to be consistent.
>
> Note that C requires that "9223372036854775808" fail strtoll() with
> ERANGE/INT64_MAX, but "-9223372036854775808" pass with INT64_MIN; we
> weren't testing this.  For strtol(), the behavior depends on whether
> long is 32- or 64-bits (the cutoff point either being the same as
> strtoll() or at "-2147483648").  Meanwhile, C is clear that
> "-18446744073709551615" pass stroull() (but not strtoll) with value 1,
> even though we want it to fail parse_uint().  And although
> qemu_strtoui() has no C counterpart, it makes more sense if we design
> it like 32-bit strtoul() (that is, where "-4294967296" be an alternate
> acceptable spelling for "1", but "-0xffffffff00000001" should be
> treated as overflow and return 0xffffffff rather than 1).  We aren't
> there yet, so some of the tests added in this patch have FIXME
> comments.
>
> However, note that C2x will (likely) be adding a SILENT semantic
> change, where C17 strtol("0b1", &ep, 2) returns 0 with ep="b1", but
> C2x will have it return 1 with ep="".  I did not feel like adding
> testing for those corner cases, in part because the next version of C
> is not standard and libc support for binary parsing is not yet
> wide-spread (as of this patch, glibc.git still misparses bare "0b":
> https://sourceware.org/bugzilla/show_bug.cgi?id=30371).
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> v3: use cmpuint in more places [Hanna], expose another strtoui flaw
> and add compaanion tests to strtoul, expand commit message, R-b dropped
> ---
>   tests/unit/test-cutils.c | 929 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 864 insertions(+), 65 deletions(-)

[...]

> @@ -1020,7 +1365,50 @@ static void test_qemu_strtol_max(void)
>
>   static void test_qemu_strtol_overflow(void)
>   {

[...]

> +    if (LONG_MAX == INT_MAX) {
> +        str = "0xffffffff00000001"; /* ULLONG_MAX - UNIT_MAX + 1 (not 1) */

s/UNIT/UINT/

> +        endptr = "somewhere";
> +        res = 999;
> +        err = qemu_strtol(str, &endptr, 0, &res);
> +        g_assert_cmpint(err, ==, -ERANGE);
> +        g_assert_cmpint(res, ==, LONG_MIN);
> +        g_assert_true(endptr == str + strlen(str));
> +    }

[...]

> @@ -1325,31 +1799,87 @@ static void test_qemu_strtoul_max(void)

[...]

>   static void test_qemu_strtoul_underflow(void)
>   {
> -    const char *str = "-99999999999999999999999999999999999999999999";
> -    char f = 'X';
> -    const char *endptr = &f;
> -    unsigned long res = 999;
> +    const char *str;
> +    const char *endptr;
> +    unsigned long res;
>       int err;
>
> +    /* 1 less than -ULONG_MAX */
> +    str = ULONG_MAX == UINT_MAX ? "-4294967296" : "-18446744073709551616";
> +    endptr = "somewhere";
> +    res = 999;
>       err = qemu_strtoul(str, &endptr, 0, &res);
> +    g_assert_cmpint(err, ==, -ERANGE);
> +    g_assert_cmpint(res, ==, ULONG_MAX);

Should be g_assert_cmpuint().

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


