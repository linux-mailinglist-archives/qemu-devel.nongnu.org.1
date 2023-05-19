Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD41F709A2E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:42:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01JH-0004Bl-1P; Fri, 19 May 2023 10:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01JE-0004BL-Qg
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01JD-00022x-71
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/QTO1WYaffsfyPtUIUiwHUnhi82SBkep340tA+v9ok=;
 b=GuCvDsYOkRAchEpiRCgAan0gqbHNInl2yxK5IryzUzLYsebgPP/YR4U2rHHaeFkvnjRQ6b
 bkSwU5rsXHDN7oCKccLSSRnCjaVzm4ZHHo1+ym2TPhroBjJTjpFDMhSrWQunHwWCJpg9IJ
 +LwFM6RNFh3a+1eiQaQioxVsgFauM3I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-SjMupShhM4m162-B0VcP9Q-1; Fri, 19 May 2023 10:42:14 -0400
X-MC-Unique: SjMupShhM4m162-B0VcP9Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96f6944c529so85780466b.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507333; x=1687099333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M/QTO1WYaffsfyPtUIUiwHUnhi82SBkep340tA+v9ok=;
 b=dY3B6IXltIxuctX611vus/cl5WvnVCV1dRydwPTKMpK3pdzjxD/PRM9M6WFcV1xtkR
 Pct07YaAX0oIptGQval5sHO3V4hE7uCpo3dUW8XJJbg8molGFnQpF/rqyCSijKkzS7b2
 eOZ3jA5X+33GUewDP8OHZQf/28mW2jAUpWxBjkrt0wBDXGyz5Lk9exRVUAwKEvePdu2i
 heLZfRc8KJbSBy8Ecp6H+tFAYGr+xDqJ04d8jy8xtrqHFfSWl+iTT66Vmj1IyWOzbMDJ
 kwRN1DDYAnUEiOfsXp75vmo9hSgWYI0wW09k6NXF90SHCLJXgXC50p9orScu7vghQMm+
 KoJg==
X-Gm-Message-State: AC+VfDxYQ1H/AkhZCzTww7meRVI1W5BAG2kLlv+lh1zUVx1kiNKBpIts
 b/9NkbJ496d8Xlz8OtF+7O82f2X9kalO+y9EfSy0anxodFPMuSjBTrpg5jNblHjVeuCPMJHrRyU
 CjOHGI5K7mDq0r+A=
X-Received: by 2002:a17:907:1c8b:b0:958:489f:d050 with SMTP id
 nb11-20020a1709071c8b00b00958489fd050mr2372904ejc.43.1684507333497; 
 Fri, 19 May 2023 07:42:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zaOFcoK9tTo5N6B+LyEUvD2Khomo8ffUhfL/rQvZ2MCRuNjWqMH0vTiHJrKTawXaz1nFkSA==
X-Received: by 2002:a17:907:1c8b:b0:958:489f:d050 with SMTP id
 nb11-20020a1709071c8b00b00958489fd050mr2372888ejc.43.1684507333238; 
 Fri, 19 May 2023 07:42:13 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 my48-20020a1709065a7000b009664e25c425sm2375400ejc.95.2023.05.19.07.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 07:42:12 -0700 (PDT)
Message-ID: <af74699e-9ce2-b9f9-2fef-e0b862e32833@redhat.com>
Date: Fri, 19 May 2023 16:42:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 05/19] cutils: Fix wraparound parsing in qemu_strtoui
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-6-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-6-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12.05.23 04:10, Eric Blake wrote:
> While we were matching 32-bit strtol in qemu_strtoi, our use of a
> 64-bit parse was leaking through for some inaccurate answers in
> qemu_strtoui in comparison to a 32-bit strtoul.  Fix those, and update
> the testsuite now that our bounds checks are correct.
>
> Our int wrappers would be a lot easier to write if libc had a
> guaranteed 32-bit parser even on platforms with 64-bit long.
>
> Fixes: 473a2a331e ("cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int types", v2.12.0)
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/unit/test-cutils.c | 11 +++++------
>   util/cutils.c            | 14 ++++++++++----
>   2 files changed, 15 insertions(+), 10 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

> diff --git a/util/cutils.c b/util/cutils.c
> index 5887e744140..997ddcd09e5 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -466,10 +466,16 @@ int qemu_strtoui(const char *nptr, const char **endptr, int base,
>       if (errno == ERANGE) {
>           *result = -1;
>       } else {
> -        if (lresult > UINT_MAX) {
> -            *result = UINT_MAX;
> -            errno = ERANGE;
> -        } else if (lresult < INT_MIN) {
> +        /*
> +         * Note that platforms with 32-bit strtoul accept input in the
> +         * range [-4294967295, 4294967295]; but we used 64-bit
> +         * strtoull which wraps -18446744073709551615 to 1.  Reject
> +         * positive values that contain '-', and wrap all valid
> +         * negative values.
> +         */
> +        if (lresult > UINT_MAX ||
> +            lresult < -(long long)UINT_MAX ||
> +            (lresult > 0 && memchr(nptr, '-', ep - nptr))) {
>               *result = UINT_MAX;
>               errno = ERANGE;
>           } else {

Just a question whether I guessed correctly, because there’s no comment 
on the matter: We store the (supposedly unsigned) result of strtoull() 
in a signed long long because e.g. -1 is mapped to ULLONG_MAX, so the 
valid unsigned ranges would be [0, UINT_MAX] \cup [ULLONG_MAX - UINT_MAX 
+ 1, ULLONG_MAX], which is more cumbersome to check than the [-UINT_MAX, 
UINT_MAX] range?  (And we’d need to exclude strings with - in them if 
ullresult > UINT_MAX rather than > 0, probably)

Hanna


