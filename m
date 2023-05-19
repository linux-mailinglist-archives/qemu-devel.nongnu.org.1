Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04320709B4C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0209-0001oX-3J; Fri, 19 May 2023 11:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q0201-0001o7-P3
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01zl-0006Dq-7w
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684509976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEzHAPidfG2O/PYzapW/gtmQyz6/6bJtRMyEQAnaz6A=;
 b=PGFm4O4wa9/osZg5E2ikCSTIYWO/yjr9VRt10Y3Xnt3/GskmvLatAlXEg39k1itcMtTofl
 7bzRwFRNwjX+QQ5rFylfwEWBSKNF7Q9sCe9W0fgj0TrVi6e84518u1Snj6M6DVYtnTsKs2
 toPfvzgn9Lgg1o+Tivwg4r5fDajuxyM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-y8h8SfwEPXqZnfxK7wGJAQ-1; Fri, 19 May 2023 11:26:15 -0400
X-MC-Unique: y8h8SfwEPXqZnfxK7wGJAQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-96a0ce9215bso358020466b.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684509973; x=1687101973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sEzHAPidfG2O/PYzapW/gtmQyz6/6bJtRMyEQAnaz6A=;
 b=Y3y9Ejy2zfXCmRpJW1MfKJK2qPttyi0Yd9UewP0XGtQXa8hc64R0zkF/8aUVUHd9kp
 tFeREib6ePxrPtHuH8v2bz1PR0JPnBCziJu46ciaOVac+cCEmZ4kZqqUwg6Re325CGgx
 qTzbq1CaVFeB7i8gKMchra8ULm0NYm/3xE61ByHmsUsLbiCgDLIJbain6wdElBRjdCXR
 0HrIWFGqPwd9bBOnRxlnUpHklKNF2uOz+Cyajiypn1xVfrHnta9ZT83E5BAXUGz2Kou1
 jJLG3OBvqyFjFqzwTzEwtrEBiqWKuaGD9wGOJypJSFCmYQSGnVcgFY2EJ+PR3Rt9iH1/
 aVAw==
X-Gm-Message-State: AC+VfDx8lrsZQn/kWxXdrl9o/nXWDM3Syiv6PLrm6XanYUoShrM7XI0/
 HMjWohBE/tQgXNvnt0/S+td0FMYuzvv+NRbWcBuyhDB2sFAhDz/faeh7EpTluKU7mrkcq5Yxmhz
 drPn4+QhV9vwMqWg=
X-Received: by 2002:a17:906:9743:b0:96a:bdb0:5744 with SMTP id
 o3-20020a170906974300b0096abdb05744mr2283207ejy.26.1684509973778; 
 Fri, 19 May 2023 08:26:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xcCzMkWulnirlSqR1uE1znja7mMiRcuaF5bUvj87lTZdRYSy0ncW7Mf3Dv8C6p0LL7u+/DA==
X-Received: by 2002:a17:906:9743:b0:96a:bdb0:5744 with SMTP id
 o3-20020a170906974300b0096abdb05744mr2283181ejy.26.1684509973472; 
 Fri, 19 May 2023 08:26:13 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 ju4-20020a17090798a400b0094f698073e0sm2372384ejc.123.2023.05.19.08.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:26:12 -0700 (PDT)
Message-ID: <bbea3ac2-2890-0606-3f0f-f1b80ec27ad7@redhat.com>
Date: Fri, 19 May 2023 17:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 14/19] test-cutils: Add more coverage to
 qemu_strtosz11;rgb:1e1e/1e1e/1e1e
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-15-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-15-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Add some more strings that the user might send our way.  In
> particular, some of these additions include FIXME comments showing
> where our parser doesn't quite behave the way we want.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
>
> v2: even more tests added, pad a string to avoid out-of-bounds
> randomness [Hanna]
> ---
>   tests/unit/test-cutils.c | 147 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 135 insertions(+), 12 deletions(-)

The subject line appears as if it contained an ANSI escape sequence.

> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
> index 1936c7b5795..7800caf9b0e 100644
> --- a/tests/unit/test-cutils.c
> +++ b/tests/unit/test-cutils.c
> @@ -3162,7 +3162,12 @@ static void do_strtosz_full(const char *str, qemu_strtosz_fn fn,
>       ret = fn(str, &endptr, &val);
>       g_assert_cmpint(ret, ==, exp_ptr_ret);
>       g_assert_cmpuint(val, ==, exp_ptr_val);
> -    g_assert_true(endptr == str + exp_ptr_offset);
> +    if (str) {
> +        g_assert_true(endptr == str + exp_ptr_offset);
> +    } else {
> +        g_assert_cmpint(exp_ptr_offset, ==, 0);
> +        g_assert_null(endptr);
> +    }

This patch adds no new cases that call do_strtosz*() with a NULL str – 
did you intent for this to go into patch 12?

Regardless (with the subject fixed, though):

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


