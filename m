Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CC81FBF3
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 00:05:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIzQN-0003Lm-OG; Thu, 28 Dec 2023 18:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIzQF-0003LW-QN
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 18:04:16 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIzQD-0002MT-LL
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 18:04:15 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9af1f12d5so3178587b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 15:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703804652; x=1704409452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ppy/PxEem3y1iN0O/mdFmbTRo7peOiMSOmDu88x7pxA=;
 b=waxMAdySXdBoYO0fgZY5F2O+8vgG8eC3HCxIKWnWHjF38u6mobpjtbebxvo7FKFQr6
 rySoBe5S712icrhvFogSS18oFrrykpFTtcWei2C551TiyXaoDZnZORylZM7Xgc2P7S73
 eiK/kpIynX1hYXsVvrhKus8PbDU47oy56+bOjVXNLRCNlJE3B5H0ZZAaMJUkx9CdL6cm
 3vH+epg+U+rJW+EcA5HD7rwb4wYUsEo3LC9kx+zvsBJD3BNHwAGZppevUxUG2Y4wzvTc
 afcqEwnxe2klUc876e6/FE4NH+DVFKQEQNxxgnslQMworT5K/o//kcRaK5Bp4ic3Nznh
 iytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703804652; x=1704409452;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ppy/PxEem3y1iN0O/mdFmbTRo7peOiMSOmDu88x7pxA=;
 b=u1QnDkjRgBSPw6k/qm7gQXw+3WjNYOosI+XgjqgNI1AggFdA5ToMog8P0gW8DOm8Lg
 vN9Vt2DDj7ZArAH+Z+lMuCQzA4tsIam8YqlQ7hHbpoMrK6PAkI+ajMApeYIZh9wR3+fC
 CNoUKKu+73ZDnxPlnzGzTCP+izdJY4F8+4kL94cDVfYvskR8qbh3oj11OR89crs8O7om
 RT8fg5J/GprXKU3rVU5L4GRVozpUbrG6PHqqX/BQlOCZoNA4LJJYhtqaE1ALBMlm2AqQ
 Np0oVs9SpXVMHG4HBBed439zlU7M9Fkrxg+RVB9ErfuYCrmGS/ayjEiPOTk4fMAfEltv
 JReA==
X-Gm-Message-State: AOJu0Yzo591uySuXurF067jKOePnPJ3krSNOjfsDvXIB7rW/VethVpjf
 w4lMp5efhKsqEV9ceAnkQdxyxUIDdjBSFcksd8kbAjuqFpdscl2v
X-Google-Smtp-Source: AGHT+IGwiJwaRPK1bQA32N0CtyC6Fk2c+DESfIdkLmGxc5ak/Xvp5T9QKEIQcmeRIwNalpsQF8OM7g==
X-Received: by 2002:a05:6a21:a5a4:b0:196:50c0:e32 with SMTP id
 gd36-20020a056a21a5a400b0019650c00e32mr1555276pzc.50.1703804651887; 
 Thu, 28 Dec 2023 15:04:11 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 q21-20020a17090aa01500b0028bc870da3fsm14845667pjp.22.2023.12.28.15.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 15:04:11 -0800 (PST)
Message-ID: <994beaca-9a70-4594-ac97-302bf9c83211@linaro.org>
Date: Fri, 29 Dec 2023 10:04:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] target/i386: implement CMPccXADD
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-23-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-23-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 12/23/23 05:16, Paolo Bonzini wrote:
> +    case JCC_S:
> +        cmp_lhs = s->T0, cmp_rhs = tcg_constant_tl(0);
> +        break;

I think you need an sextract here, when ot != full word size, same as JCC_O.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

