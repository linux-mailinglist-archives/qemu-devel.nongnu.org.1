Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7F709AD8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:06:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01fk-00051g-V4; Fri, 19 May 2023 11:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01fb-00051T-1S
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01fZ-0002cB-EG
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684508724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5UGTMhfmXFlc1C4FOVC0LptcPSumr0TEd8672utOHw=;
 b=eBH9C96TYSnRd5ZrkZe+tEszSk/zN+N9SaB3XK8kw7Iymeb+pzv7NUhus8O+PEe0d336WK
 rR/Tww93OIKBZtcMtfabL+h7AVleD6AN0NZX2ntHoI+zubIksGreMmEvUKIC7ecQNJFm94
 qzQw2FK8ApquDJyYujHFC061GFmiUdY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-FpQ3W0f3Nqy0wV3uns1VVg-1; Fri, 19 May 2023 11:05:23 -0400
X-MC-Unique: FpQ3W0f3Nqy0wV3uns1VVg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-510eb233a81so1809426a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684508722; x=1687100722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v5UGTMhfmXFlc1C4FOVC0LptcPSumr0TEd8672utOHw=;
 b=c3i0zg8zm+M8KztH55/veO+gFvrOzcGwf/9iQlO3hRGR5gg9ji3l8bbWudHWEA83++
 jl9ggmhuVyb7J78fOY70v59ZXNQBJNnA3AzQMx3JuPXK0XcXBqXuNYoon4cZp9FCU340
 4zkof7BHyOE/Q8Sc+DnWZyjODwD6SnfFlOh5xqmG/WNdpG5WXegIN0CfS7fpnYE+VkS5
 0XT1m12vLOPYfJJGUxaxNBQVfHT0Z7N8hEW0K1grXdIAHw05t8pYkBCXcP0BZZDoHypm
 VhFX2+W4zjmiOTusjVdNkZ3FgiFrLZiE8UF+rLIgcq/vbq3bDcR3mPcYtLsZxBp3Tchs
 Mijw==
X-Gm-Message-State: AC+VfDx+4oYn86L8phEe6A0nf+RNDNLHsA79V9jZIwsFGzSYrZXn7Tyd
 wWEGMO0Jcm+efMlVT5vlEOkdbI94GMvNHulEctoZIvK4x7sHD3ULy5OH6ynw6sTW/WUQkTGC/BN
 SETSOgMAm28T7sAc=
X-Received: by 2002:a17:906:ef0e:b0:969:dda1:38a4 with SMTP id
 f14-20020a170906ef0e00b00969dda138a4mr1747837ejs.38.1684508722192; 
 Fri, 19 May 2023 08:05:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4J+A+InFFPFZxw/7D5sZx82SYzjl/Qd46HU2NhglDGeIN5LgWvz5I6qrerRY1zaE9pXKvYuQ==
X-Received: by 2002:a17:906:ef0e:b0:969:dda1:38a4 with SMTP id
 f14-20020a170906ef0e00b00969dda138a4mr1747816ejs.38.1684508721818; 
 Fri, 19 May 2023 08:05:21 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a170906649000b0096f6647b5e8sm932289ejm.64.2023.05.19.08.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:05:21 -0700 (PDT)
Message-ID: <2e230e7f-694f-6b4e-2fcf-7504532581ed@redhat.com>
Date: Fri, 19 May 2023 17:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 09/19] test-cutils: Add coverage of qemu_strtod
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-10-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-10-eblake@redhat.com>
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
> It's hard to tweak code for consistency if I can't prove what will or
> won't break from those tweaks.  Time to add unit tests for
> qemu_strtod() and qemu_strtod_finite().
>
> Among other things, I wrote a check whether we have C99 semantics for
> strtod("0x1") (which MUST parse hex numbers) rather than C89 (which
> must stop parsing at 'x').  These days, I suspect that is okay; but if
> it fails CI checks, knowing the difference will help us decide what we
> want to do about it.  Note that C2x, while not final at the time of
> this patch, has been considering whether to make strtol("0b1") parse
> as 1 with no slop instead of the C17 parse of 0 with slop "b1"; that
> decision may also bleed over to strtod().  But for now, I didn't think
> it worth adding unit tests on that front (to strtol or strtod) as
> things may still change.
>
> Likewise, there are plenty more corner cases of strtod proper that I
> don't explicitly test here, but there are enough unit tests added here
> that it covers all the branches reached in our wrappers.  In
> particular, it demonstrates the difference on when *value is left
> uninitialized, which an upcoming patch will normalize.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
>
> v2: Added g_assert_false(signbit(res)) anywhere I used
> g_assert_cmpfloat(res,==,0.0); add a test for strtod() hex parsing and
> handling of junk after ERANGE, which is major enough that I dropped
> R-b
> ---
>   tests/unit/test-cutils.c | 510 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 510 insertions(+)
>
> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
> index d3076c3fec1..1763839a157 100644
> --- a/tests/unit/test-cutils.c
> +++ b/tests/unit/test-cutils.c

[...]

> +static void test_qemu_strtod_erange_junk(void)
> +{
> +    const char *str;
> +    const char *endptr;
> +    int err;
> +    double res;
> +
> +    /* EINVAL has priority over ERANGE */

By being placed here, this comment confused me a bit, because the first 
case does return ERANGE.  So I’d prefer it above the second case, where 
we actually expect EINVAL, but understand that’s a personal preference.  
(Same for the _finite_ variant)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

> +    str = "1e-999junk";
> +    endptr = "somewhere";
> +    res = 999;
> +    err = qemu_strtod(str, &endptr, &res);
> +    g_assert_cmpint(err, ==, -ERANGE);
> +    g_assert_cmpfloat(res, <=, DBL_MIN);
> +    g_assert_cmpfloat(res, >=, 0.0);
> +    g_assert_false(signbit(res));
> +    g_assert_true(endptr == str + 6);
> +
> +    endptr = "somewhere";
> +    res = 999;
> +    err = qemu_strtod(str, NULL, &res);
> +    g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert_cmpfloat(res, ==, 0.0);
> +    g_assert_false(signbit(res));
> +}


