Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B75181F2F1
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 00:13:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rId4B-0001ZI-ML; Wed, 27 Dec 2023 18:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rId48-0001Ye-Eg
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 18:11:57 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rId44-0000Nc-9m
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 18:11:54 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d3aa0321b5so45752635ad.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 15:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703718710; x=1704323510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9KgtAhN/5fiK2u8i/qxHe/WuoM7E9YMnMGckaILBcY4=;
 b=CV9WQfyjsJl3seOsdVRGSX40UZ0p+vRE413sPVdmta9fwwRB4mwc7s5hDUyI+QROqs
 nBU3P/sfWSJwrGXv+ej1Gu0V2CnHLSJ6dbUZuybZiLn4Dr153bv4D3Vyc6hsNXOlL2Yr
 nbLcikL2ZVzB5V6fQ8T7UV9YxEQCTQxwOGXrlMZXOenSN+lvkloP1Y5U0uSQLnKYeRaI
 vDrmXIWCHeXWdEZXPTaHOsy7FGSLAezZVZyc5lZlJ9G0T50Iu7+YMf7evFwM3XP1FTud
 C/rBLBeYlWdeQ9eK9iSUykl6B4mOj/MFWoqftgnqUS02XA2RWN84BP3yNjdW/mmQhh/9
 aCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703718710; x=1704323510;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9KgtAhN/5fiK2u8i/qxHe/WuoM7E9YMnMGckaILBcY4=;
 b=vIrEyVelVaBW8I4PJSLDi9+g/7nrTTkYTUl9fOsj8Ch2xgfltet6eYfjckE1MtlvB/
 wvTdhA5Pmc/aC+LAkvLyrCSVDdOp5SMRqef7hiBAUG7ogMH8a21scHESO7AKsQmmmMC5
 luKc8y6JqR5H3wzEyri9KCIsyWYBksFp9YciBDyzs/SiBgxXgbtmmtvdmMspENS5hhAd
 MYZnmgu9DUMoIfnhexGrjCu2uZFuN78kbl1K2c2QhIBSG5OX9qj2R4sX/TvwRF2Ln3Tw
 Mvw48EoDIzBuWACDsLhkfLlPF48RjYFqTK9i0DtpzBzxuYecpC4IgxIp2Ls27/b1TFpe
 YADA==
X-Gm-Message-State: AOJu0Yy8jnDTCmw316inAW6e6z/qMHFOskawyPxhWFFq0FmokA+ZaJ+1
 eT6VS/ihfwaxlzZ87EYzvjzlUp837XB0VwqQqt1Pt6ZiYOSOcg==
X-Google-Smtp-Source: AGHT+IEYGpiHkbYfklKUH4g42Q2G0ZV/RF5uic2FWnf9Y9SCYjE74ql9yJv2CYwDTINZPC8FJGA5Mw==
X-Received: by 2002:a17:902:d508:b0:1d4:5939:51fd with SMTP id
 b8-20020a170902d50800b001d4593951fdmr6448642plg.97.1703718710423; 
 Wed, 27 Dec 2023 15:11:50 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a170902ec8500b001d04d730687sm12478731plg.103.2023.12.27.15.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 15:11:50 -0800 (PST)
Message-ID: <b67708f0-f4c4-47a8-b003-ff154136740c@linaro.org>
Date: Thu, 28 Dec 2023 10:11:45 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/35] target/arm: Handle FEAT_NV2 redirection of
 SPSR_EL2, ELR_EL2, ESR_EL2, FAR_EL2
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-26-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/18/23 22:32, Peter Maydell wrote:
> @@ -2173,7 +2174,14 @@ static void handle_sys(DisasContext *s, bool isread,
>            * for registers accessible at EL1).
>            */
>           skip_fp_access_checks = true;
> -        if (s->nv && arm_cpreg_traps_in_nv(ri)) {
> +        if (s->nv && s->nv2 && (ri->type & ARM_CP_NV2_REDIRECT)) {

You've documented and implemented that nv2 is true iff nv, thus the nv test can be dropped.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

