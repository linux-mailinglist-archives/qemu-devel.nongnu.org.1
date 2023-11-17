Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C77EF29C
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 13:26:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3xuW-0005oz-Gr; Fri, 17 Nov 2023 07:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3xuN-0005oo-1Q
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 07:25:16 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3xuJ-0006kO-4j
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 07:25:14 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083f613275so15690485e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 04:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700223906; x=1700828706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GU+xc1oUHc+h5UIuTWYMkcyJPsT6IpVMFF2tIH0q1SA=;
 b=XU24PTHnz185tlUgGaru13xeizhnFR49S8HZKOaKDn2q7wddKJ/BcpVk+PhqcnN25g
 iB64xHVEtqmrgEZgvXJvY6gFRxYJcdwIOivKFxX4F3RZ5jgohOoHxipinqEwvtbiBNQe
 8Ef6NNPt8zI3u/fAO0209XY16ZRisDTcrjq3wpxU0LLh76mBHbC4mSxZPqFzQalThRQo
 3DRfiwPWXIzpv3KU0QcGKeRZUfMUfqnrQDXT1mBspBSmMbSlYpASrOmbKx8xU9t684xs
 EPlPAZrJWlNp3hKzhr505LVMlgkugY+kJUFXk3uNnBMrKB+Ek+S9AwYMEHfxFmKN+9O1
 80Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700223906; x=1700828706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GU+xc1oUHc+h5UIuTWYMkcyJPsT6IpVMFF2tIH0q1SA=;
 b=dMrPCAFRTQaWhaxWRu8VtFRTUZs1KEx0pLtX9BLXdKSbf7NdYuPjdCbwz0ZoEXCVmG
 UQ0nfvcAjqKPN3e0s+FxmBa44z0Ro5YQys0ozVzrrOT/0maHP3Eb+CW6KJbI0wGnfJnh
 uqZCF2vx0zCitOrCeO0k1JQOologPuhEkxHs7PIJhVSONm8CpNYd7VbayTYFuBxW/AJD
 hmH/LuPAO8Ep2t6yKhNK2e27asZt2i6ZrDbJxjjZe+FlFhkzwxRzB3CLfKUqYTAWuRUj
 GfLBu2wfc4XIPw3Kr7ISV5jYc8lT3LxnRiF9bPK6/NtB7jiVPP/V+zsBpRJ19vsPxZWk
 QJ9Q==
X-Gm-Message-State: AOJu0YyWf3cHoMX+i0f6yyHX8RXMrBaj97l98TK6heTCQPMNfK0kh4xE
 BJUC0e2fUlJJZjUjxYx9761miA==
X-Google-Smtp-Source: AGHT+IGPun2VlStVvmP31uyS80RExhed/JpXwA8ewI8xcnv6ErG2ngW+yqi+pT1RqEJa2R+Xz3gyNA==
X-Received: by 2002:a05:6000:18ae:b0:331:6a11:d209 with SMTP id
 b14-20020a05600018ae00b003316a11d209mr1455626wri.57.1700223906084; 
 Fri, 17 Nov 2023 04:25:06 -0800 (PST)
Received: from [192.168.69.100] (bd137-h02-176-184-46-187.dsl.sta.abo.bbox.fr.
 [176.184.46.187]) by smtp.gmail.com with ESMTPSA id
 m17-20020adfe0d1000000b0033130644c87sm2178185wri.54.2023.11.17.04.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 04:25:05 -0800 (PST)
Message-ID: <a774e56e-cac9-40e8-b8d0-cedce6a1bc7e@linaro.org>
Date: Fri, 17 Nov 2023 13:25:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] qom/object: Limit type names to alphanumerical and
 some few special characters
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231117114457.177308-1-thuth@redhat.com>
 <20231117114457.177308-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231117114457.177308-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 17/11/23 12:44, Thomas Huth wrote:
> QOM names currently don't have any enforced naming rules. This
> can be problematic, e.g. when they are used on the command line
> for the "-device" option (where the comma is used to separate
> properties). To avoid that such problematic type names come in
> again, let's restrict the set of acceptable characters during the
> type registration.
> 
> Ideally, we'd apply here the same rules as for QAPI, i.e. all type
> names should begin with a letter, and contain only ASCII letters,
> digits, hyphen, and underscore. However, we already have so many
> pre-existing types like:
> 
>      486-x86_64-cpu
>      cfi.pflash01
>      power5+_v2.1-spapr-cpu-core
>      virt-2.6-machine
>      pc-i440fx-3.0-machine
> 
> ... so that we have to allow "." and "+" for now, too. While the
> dot is used in a lot of places, the "+" can fortunately be limited
> to two classes of legacy names ("power" and "Sun-UltraSparc" CPUs).
> 
> We also cannot enforce the rule that names must start with a letter
> yet, since there are lot of types that start with a digit. Still,
> at least limiting the first characters to the alphanumerical range
> should be way better than nothing.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   qom/object.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 95c0dc8285..654e1afaf2 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -138,9 +138,50 @@ static TypeImpl *type_new(const TypeInfo *info)
>       return ti;
>   }
>   
> +static bool type_name_is_valid(const char *name)
> +{
> +    const int slen = strlen(name);
> +    int plen;
> +
> +    g_assert(slen > 1);
> +
> +    /*
> +     * Ideally, the name should start with a letter - however, we've got
> +     * too many names starting with a digit already, so allow digits here,
> +     * too (except '0' which is not used yet)
> +     */
> +    if (!g_ascii_isalnum(name[0]) || name[0] == '0') {
> +        return false;
> +    }
> +
> +    plen = strspn(name, "abcdefghijklmnopqrstuvwxyz"
> +                        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
> +                        "0123456789-_.");
> +
> +    /* Allow some legacy names with '+' in it for compatibility reasons */
> +    if (name[plen] == '+') {
> +        if (plen == 6 && g_str_has_prefix(name, "power")) {
> +            /* Allow "power5+" and "power7+" CPU names*/
> +            return true;
> +        }
> +        if (plen >= 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) {
> +            /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
> +            return true;
> +        }
> +    }
> +
> +    return plen == slen;
> +}
> +
>   static TypeImpl *type_register_internal(const TypeInfo *info)
>   {
>       TypeImpl *ti;
> +
> +    if (!type_name_is_valid(info->name)) {
> +        fprintf(stderr, "Registering '%s' with illegal type name\n", info->name);

Shouldn't we use error_report() instead of fprintf()? Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        abort();
> +    }
> +
>       ti = type_new(info);
>   
>       type_table_add(ti);


