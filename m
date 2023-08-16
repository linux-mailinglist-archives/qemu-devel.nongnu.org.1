Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE2F77E549
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWIaU-0002N4-Ao; Wed, 16 Aug 2023 11:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWIaN-0002Mu-UQ
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:37:28 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWIaL-0003zj-HI
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:37:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so45049625ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692200244; x=1692805044;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ny01xjgAm9RYsEWQnojBp886CYPq/8gjuIIg6E41MM=;
 b=UHz6G9ee5dI6e5Z0jQgEQXbmXBNpBsKRRs1mJWT7sxKfls2h68i6AVTjk1fmTmkT08
 EaZG2h9rcdPVnFFV0gfwosS182sajoiE7DO4xFyTrDJDwrNqE/UA+Wksq78vfauHLxwv
 jbstgLMTOqHvvuz6oJtrZPTVL1dyzXke2IZzNLDXBsEXYprD07Kcyi6z0Y0dUd8yMbVY
 3qHJlb6FH3U7eZHcE2h6ZYGb2GK2LajHg9eOnsqQvyukcbR+Odf7eyV7RKEq5DZ0Lm83
 e92VAC/QbziNN7vLit3AuFERe45fxGN3b7K4mRIf1LEncLxTNddUST9Mc9pJTfI7pqxQ
 7XCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692200244; x=1692805044;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ny01xjgAm9RYsEWQnojBp886CYPq/8gjuIIg6E41MM=;
 b=lVF1c12QoVxM6x3lkyWX0iW8PDpVkrdzCsc4oGMLu4NJ4kRd8vNsGL28H8533l2Grv
 2o32Zf3gOYiW7lQmOBPDe2fUrZIGd9US74zcLK38xecbD7VK/BjSg83iACsc5ccnh/3Y
 itPFaPV/7aePpGdSqNSv/dsZcWz/5Cw3sS5OZi2snQJb5QVKZZVfzDCFil19TGdfS0nK
 RXHwhk77TzrxtvpxtHqOmBoUZ1lD7oiUhtlFPSPMsUYgpch9weuuuiAKCQQGMwy+j9TR
 HwniaaNm9hqH6Aw2jb6T0xxkAKbGeqpAljM+au3nC50PhuqbUh+LUTLR7TIuhIvssXqT
 2tgw==
X-Gm-Message-State: AOJu0YxGVaYQO3qcVh+pQwHT5n9aoYcjVp95b2QlVYhxS0haP6cVDwH3
 avZ4unUDhbpmASEtJwu2LpAm/w==
X-Google-Smtp-Source: AGHT+IEjdXDiC0xRjSILa9A/ycYDxkPNyut4lGVjlwFJp2ltmgZQeCwwkzaISiiU+/mutS3FyDTWQQ==
X-Received: by 2002:a17:90a:c901:b0:262:d7db:2520 with SMTP id
 v1-20020a17090ac90100b00262d7db2520mr1630281pjt.26.1692200243953; 
 Wed, 16 Aug 2023 08:37:23 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a064:e3f9:a812:973b?
 ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a17090a950e00b0026b4d215627sm6233331pjo.21.2023.08.16.08.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 08:37:23 -0700 (PDT)
Message-ID: <6736976a-237b-821a-189c-558e50f6e993@linaro.org>
Date: Wed, 16 Aug 2023 08:37:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 04/25] gdbstub: Introduce gdb_find_static_feature()
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
 <20230816145155.21049-5-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230816145155.21049-5-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 8/16/23 07:51, Akihiko Odaki wrote:
> +const GDBFeature *gdb_find_static_feature(const char *xmlname)
> +{
> +    const GDBFeature *feature;
> +
> +    for (feature = gdb_static_features; feature->xmlname; feature++) {
> +        if (!strcmp(feature->xmlname, xmlname)) {
> +            return feature;
> +        }
> +    }
> +
> +    abort();

g_assert_not_reached().  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

