Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC44B7099AC
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:29:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q014n-0002QP-Nv; Fri, 19 May 2023 10:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q014k-0002QA-V2
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q014h-0007VN-La
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684506436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSuzkv7JlO5qLbQd09Z2/5mVfeE/LmY+NyroADKuR64=;
 b=DtI/i69Xv/mTG8ju1Gvr0B6KrOyrIBgghbfNYzFjyP0UNT0trVWzGwto05ttfXtGhuXPYM
 5gtX1atIqCCcS+NXUgQsFQMFiZXhxBmEdH2Hta0Xu/xS+PDZn8mfpKVGwaa2A38RYnR46h
 vm7UFohhY4U9Af7tUwiBiDBhg01ioaI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-5-nfxOn_OpOtqelMS7nnjw-1; Fri, 19 May 2023 10:27:13 -0400
X-MC-Unique: 5-nfxOn_OpOtqelMS7nnjw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50c064801a3so4184666a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684506432; x=1687098432;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hSuzkv7JlO5qLbQd09Z2/5mVfeE/LmY+NyroADKuR64=;
 b=cT1qxhzAT2O5M5JsVEiIGhI9wc2VGqW/jg8bQk0A1Vh1k3YgvwIaJaXiThfgkNf6Mp
 Eu4GYEpJgTdmedJg6NkXVf/uveruLhVAoLWviTWXMzGSGyexWBQ5NsyGSMS3aDEHGYiq
 cJsIr/+QdhsnY9LiyipXw+V5YsA9kPqm1C5xLjx2jV7xJkQgbohCcuD6Avr6NWmDnrQx
 c7fbd41l38zos1xdZ0obZ0yvFEj/b1st12eiQf0UpRTaDvyedIom5lfWLRIo/YJh4S/v
 pxeOrhP48+gocArr8N+5q0+9bgKNsQ1Bgg/w7F7aV0BGEFZorsnStDKYoYDThNRE90bi
 KbuQ==
X-Gm-Message-State: AC+VfDwUvwxSOA9TK9SoGuqkfiVcpDGlEdAIxCcv0ooyBeP+khI4ewck
 E77Z5MTGPiw8ys1/rYBIZdrMM9W77D0wyXNYtUmtlni5P7zFFLW221MQOv6JE9QTdZyor17+uJK
 GzIwvpE/1WI+FAwI=
X-Received: by 2002:aa7:d1c6:0:b0:50b:c72a:2b1b with SMTP id
 g6-20020aa7d1c6000000b0050bc72a2b1bmr2067417edp.19.1684506432151; 
 Fri, 19 May 2023 07:27:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AaFSKO4tzuyvxF1Yj4DlvUN/9ymxBFC2ztx/deoRQW0yOmhiUAAtKn0vPW7+GWq2wgSI/6Q==
X-Received: by 2002:aa7:d1c6:0:b0:50b:c72a:2b1b with SMTP id
 g6-20020aa7d1c6000000b0050bc72a2b1bmr2067408edp.19.1684506431843; 
 Fri, 19 May 2023 07:27:11 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 dy1-20020a05640231e100b0050bc4600d38sm1734278edb.79.2023.05.19.07.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 07:27:11 -0700 (PDT)
Message-ID: <0fd2fa2b-dfd5-7c22-e6de-7e018868c8ce@redhat.com>
Date: Fri, 19 May 2023 16:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 04/19] test-cutils: Test more integer corner cases
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-5-eblake@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-5-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12.05.23 04:10, Eric Blake wrote:
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
> acceptable spelling for "1".  We aren't there yet, so some of the
> tests added in this patch have FIXME comments.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/unit/test-cutils.c | 799 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 738 insertions(+), 61 deletions(-)
>
> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
> index 1eeaf21ae22..89c10f5307a 100644
> --- a/tests/unit/test-cutils.c
> +++ b/tests/unit/test-cutils.c

[...]

> @@ -717,34 +890,75 @@ static void test_qemu_strtoui_max(void)
>
>   static void test_qemu_strtoui_overflow(void)
>   {
> -    char *str = g_strdup_printf("%lld", (long long)UINT_MAX + 1ll);
> -    char f = 'X';
> -    const char *endptr = &f;
> -    unsigned int res = 999;
> +    const char *str;
> +    const char *endptr;
> +    unsigned int res;
>       int err;
>
> +    str = "4294967296"; /* UINT_MAX + 1ll */
> +    endptr = "somewhere";
> +    res = 999;
>       err = qemu_strtoui(str, &endptr, 0, &res);
> +    g_assert_cmpint(err, ==, -ERANGE);
> +    g_assert_cmpint(res, ==, UINT_MAX);

Why cmpint and not cmpuint here?  (I see you’re using cmpint instead of 
cmpuint in many strtou* test functions below, too.)

[...]

> @@ -1325,31 +1697,67 @@ static void test_qemu_strtoul_max(void)

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
> +    str = ULONG_MAX == UINT_MAX ? "-4294967297" : "-18446744073709551617";

Technically these are 2 less than -ULONG_MAX, not 1 less.

Hanna


