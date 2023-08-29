Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B7E78C4B6
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:01:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayKT-0001GC-Lf; Tue, 29 Aug 2023 09:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayKP-0001Eo-Tw
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:00:17 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayKN-0002HT-Gi
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:00:17 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-500b6456c7eso3764992e87.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693314012; x=1693918812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vFuwD9dkL4dLJSAGJZT3K9IX8xDvGoBK18tts9Jgm48=;
 b=ve/6/tSHuPjmIb4wUV2jdaXsCGWUZ1Dys0iYAX+0zcjuYP8RSC/hlwRH4AoWWY4UNn
 Aej7Vgp0YJrlRuDLl9WfDqLm6nIEaCNeNMEkZjw5v3n2OOwMBvRvP30XqYPZms/NU7/j
 uHeyftQYJafmKBLMY5i5PT/d+mYhXh7P8hsEOeXySiq8vR+eOaHRmNLdmjFlCQKnWM8Z
 WLlgpdzQ6kchrFak9f++Htikjv58RFuZYlt6loDTpvou7iZ4wI7mrzh7hP0F3EOm+aJJ
 BBU8bbT07V48PBqev+1Q5H3q2a6c+jytiqXrlgp2qPD/VxQsJpG59F/C7EW1vhWkc6HI
 0Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693314012; x=1693918812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vFuwD9dkL4dLJSAGJZT3K9IX8xDvGoBK18tts9Jgm48=;
 b=NTcWf1I4HK+tOsJzWY+5MQKllpBoXCAMAHgyNaZQIkO9Q1XMVQ+9OjdevNiw1eCCh0
 iG1g75nWd0qFTT72KvyDXkrgJRlPhLf8kXEdjz0IBoeJOsMy82tBVDFbDwnVedQa5Jam
 nqGdrXd1upV5KMhm+/IDEKFgCi+8McqYKbFps25uk40zVHF4GrDt9EL9wk4qCSFPlB58
 /RgRInWVS5+GmSm2/6YHcn+L8Bk231EVxXkfGqRgR5Yp1BMxZVvlDIT4BRAOD5NtFHDc
 X858KPeYO5gpilfdsaaToQbdc2E2EFyix51u/M3WiG6GW4l6YTe8RTLwfnEe/nzyiEZ9
 c3zA==
X-Gm-Message-State: AOJu0YztjkfBWEXhljZ1g/NQXhHmAjEOEP5fkws3nYq1RIb1XRgrrUpx
 uiJFbt1Of3NWBzcy0ZVM5KbgFmbfWqpsBSAfVtJBzQbokX2zi6ck
X-Google-Smtp-Source: AGHT+IEUSS4iU1WFASvZd3e1jAyWojPCe3VWJPPP11P044+rq2gTTdmGXWCSdqDK5Bp2W3gxtszEidlNCp26Vc9//rA=
X-Received: by 2002:a05:6512:3151:b0:500:adc6:141d with SMTP id
 s17-20020a056512315100b00500adc6141dmr6570552lfi.45.1693314011526; Tue, 29
 Aug 2023 06:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
 <20230822042530.1026751-4-richard.henderson@linaro.org>
In-Reply-To: <20230822042530.1026751-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 14:00:00 +0100
Message-ID: <CAFEAcA9Wi-CU9uk_p4wze9OFQuHJdg_5zjYhOx2awsOOhNdA+A@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] target/arm: Add feature detection for FEAT_Pauth2
 and extensions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Aaron Lindsay <aaron@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 22 Aug 2023 at 05:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Aaron Lindsay <aaron@os.amperecomputing.com>
>
> Rename isar_feature_aa64_pauth_arch to isar_feature_aa64_pauth_qarma5
> to distinguish the other architectural algorithm qarma3.
>
> Add ARMPauthFeature and isar_feature_pauth_feature to cover the
> other pauth conditions.
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> Message-Id: <20230609172324.982888-3-aaron@os.amperecomputing.com>
> [rth: Add ARMPauthFeature and eliminate most other predicates]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h              | 49 +++++++++++++++++++++++++++++------
>  target/arm/tcg/pauth_helper.c |  2 +-
>  2 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index fbdbf2df7f..e9fe268453 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3794,28 +3794,61 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
>  }
>
> +/*
> + * These are the values from APA/API/APA3.
> + *
> + * They must be compared '>=', except EPAC should use '=='.
> + * In the ARM pseudocode, EPAC is treated as not being implemented
> + * by larger values.
> + */

Yeah, but we use PauthFeat_EPAC in exactly one place and
deliberately in a way where it doesn't matter if we use >=...
(I think the pseudocode would be clearer if it was adjusted
to do the same, personally. This ID register field follows
the standard ID scheme which means that increasing values
are supersets, so the "only if equal" part is weird.)

> +typedef enum {
> +    PauthFeat_None         = 0,
> +    PauthFeat_1            = 1,
> +    PauthFeat_EPAC         = 2,
> +    PauthFeat_2            = 3,
> +    PauthFeat_FPAC         = 4,
> +    PauthFeat_FPACCOMBINED = 5,
> +} ARMPauthFeature;
> +
> +static inline ARMPauthFeature
> +isar_feature_pauth_feature(const ARMISARegisters *id)
> +{
> +    /*
> +     * Architecturally, only one of {APA,API,APA3} may be active (non-zero)
> +     * and the other two must be zero.  Thus we may avoid conditionals.
> +     */
> +    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) |
> +            FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, API) |
> +            FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3));
> +}
> +
>  static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
>  {
>      /*
>       * Return true if any form of pauth is enabled, as this
>       * predicate controls migration of the 128-bit keys.
>       */
> -    return (id->id_aa64isar1 &
> -            (FIELD_DP64(0, ID_AA64ISAR1, APA, 0xf) |
> -             FIELD_DP64(0, ID_AA64ISAR1, API, 0xf) |
> -             FIELD_DP64(0, ID_AA64ISAR1, GPA, 0xf) |
> -             FIELD_DP64(0, ID_AA64ISAR1, GPI, 0xf))) != 0;
> +    return isar_feature_pauth_feature(id) != PauthFeat_None;

Having said "must be compared >=" you then use a != comparison here :-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

