Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5597D8115CA
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:07:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQoT-0001W4-Oa; Wed, 13 Dec 2023 10:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQoR-0001VS-SM
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:06:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQoQ-0002nr-73
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:06:15 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so43166625e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702479972; x=1703084772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pnd7fvEzBp9PduLH7UG5Kq4cbSFP4zo96zsnjGnG5VY=;
 b=aKUvy2YYsLm8SHjtYLB7jlJPsE2w+9FRJSLHT98ZDtaTYtyR+YPxJXp05ZMf3ciUJU
 hyTCJZB6TswNGGRHA480s08IyTGvn66MbLJ0loVgvS+72IEDUiUxUuKNvHmeIti5kBlt
 Sxdlth83rkqNjbi8K0uWf8v17983NZ6aiePSTm4fInv69bAsOgzXCrhzfGeD0xqg1r/l
 +5U1G8rAnLuiAOnzyjC8+ljQlXRSc+VDiYfjhiD03K2CSR8T/Bl3Bpf4LmJcRQ1M0cEB
 Q45kvhCdwl+l91jHaz//kG7BjtPe0W9Bq7ZlSjrabpJJVRFpw0gt2Wskmy5Pzb/hNs8i
 NeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702479972; x=1703084772;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pnd7fvEzBp9PduLH7UG5Kq4cbSFP4zo96zsnjGnG5VY=;
 b=jfrhHA3rzNWrRIrY9RqZAmp2wowUGAOrZXD9SV459Kn0S6SE/cdU4h4qCgVZLMQ4xY
 fE+R3iy8h4RGN9hteU3lKADLpm8peLyWjKEYHh2ESy9+9dbs2423QaebBvo2zs0BOTGw
 JowzvFoTRng1J1EUlerJrXhPZW6zw/xiZPFhdO5GvWNY75sP0a/ANq0pewO9auIo+EO6
 X8FFthswG5C/3ipadmnVwhe4E2883XtDFbzqiKdYKbrF5/0FZlx8OCDYmyWZKbs97ud9
 EQlIwHU2w5t+Gx4ERA4ZxK1vXKv7V09WLG4WthxYtncnbSetlKwiKMQ7UgHCToy83lpQ
 mODw==
X-Gm-Message-State: AOJu0YzKVaWgpwbaPO/tgIFS6xwXzAb3zvoD/8D7EIa+nLmT9ah0GAAl
 2Z5nGTeU1lc6QJVnYaxDKeNSe4hWBytg5DXUyhsxMw==
X-Google-Smtp-Source: AGHT+IHpI4MCxM03OLIc8y8QpBfA0MW07kUGkGtSrLsc95b1YM2i9973oR48BCraOMCj9C4gmKGf7Q==
X-Received: by 2002:a05:600c:35d1:b0:40c:35b9:e2e3 with SMTP id
 r17-20020a05600c35d100b0040c35b9e2e3mr3863634wmq.101.1702479972719; 
 Wed, 13 Dec 2023 07:06:12 -0800 (PST)
Received: from [192.168.71.175] (76.red-88-28-19.dynamicip.rima-tde.net.
 [88.28.19.76]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c4e5100b0040c34cb896asm19587207wmq.41.2023.12.13.07.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 07:06:12 -0800 (PST)
Message-ID: <291951e1-0868-47eb-9b52-8b46cb09a131@linaro.org>
Date: Wed, 13 Dec 2023 15:48:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] tcg: Move vec_gen_* declarations to tcg-internal.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231029210848.78234-1-richard.henderson@linaro.org>
 <20231029210848.78234-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231029210848.78234-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 29/10/23 22:08, Richard Henderson wrote:
> These are used within tcg-op-vec.c and tcg/host/tcg-target.c.inc.
> There are no uses outside tcg/.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 4 ----
>   tcg/tcg-internal.h          | 4 ++++
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


