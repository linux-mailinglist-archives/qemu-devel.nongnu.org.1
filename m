Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E4785E53
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 19:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYrNf-0007gj-Rv; Wed, 23 Aug 2023 13:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYrNc-0007g6-Ag
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 13:10:52 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYrNY-00027Z-5i
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 13:10:49 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-26b5e737191so3296106a91.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692810646; x=1693415446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hdrk5QOfcVT5Uj54AFacY4zNVGhrfKKRgwgs0qzbHaE=;
 b=wymIEkw132yZ/6IO3v497LM0Lh5ylcM+C+uiT9NMfetn7cjXD/ghNLypdaVXVF584z
 dVTOm/YD2Uv5kzv/yw/l6CiXQMe4zePakv1kQcoDXKJ4kryfhaLZzDM60z9JjQGFSAip
 2UWvxBequjFjS3tBfHh3VDWlJfIlkflFO+Gi95hIxCKsxfUnj4F3Re/e7qJHx+743rV6
 0xpXVU9LanT5aQ655yJwpTzCptdUbEBiJu2OG3sq+FehRRnvfoe3om1/4o/8EsYONWp6
 l0f/EDCg5RzP/Jp0wlfTf4IUXmz7dNiCftVE93186Rugrcy4dOiLcOdjin4fszhFIbqy
 kIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692810646; x=1693415446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hdrk5QOfcVT5Uj54AFacY4zNVGhrfKKRgwgs0qzbHaE=;
 b=hhfFCZxGpkIu3DFwliV4+9uMBq9qlguQ7PxIXFI7MqC6w9RMjOnRhiukIuKPKtAsb9
 965dZEZS6By0t8yKAALO7h8BSF3r4oxwEkN907IKYuoZB+ustTU9dRLkze8HBvDf57AY
 acaKp8XE5vji2gJHADYYTOFQfsUPd3cht3UP3pCij8YNuIniWdxAnCeZad5eOmAdHMQk
 lA7P/0D/tV8Pwpc9cPJztyIhlxMMG+dnZw2g4ZMEeiCI4R/Naj7sFPt8Vxef7oQfYyOA
 awwfrO8CX0a39wGTUi0hpy6ZjIIM5ApaBk/dVHwy7IBKYO+18WsL3Y0FFbEW6X6ZTPq1
 KgjA==
X-Gm-Message-State: AOJu0YwTLe4y6jP6j8vbZF0lIr5nYSxPJAJBdDB4+J1pRtqQnDWamYCE
 nhLCCO21YDcZ7QdF5rme9D5C0g==
X-Google-Smtp-Source: AGHT+IGF/QP7WvHZH57I9alcsxHrZ3lDn+vv3jE1Gmz3sbpaqHeIE2XwDQ8FzgzyhLTjwOQ7sCGurQ==
X-Received: by 2002:a17:90a:eacb:b0:267:f758:15d4 with SMTP id
 ev11-20020a17090aeacb00b00267f75815d4mr8912309pjb.48.1692810646438; 
 Wed, 23 Aug 2023 10:10:46 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:72f0:1ea7:85d2:141e?
 ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 cv2-20020a17090afd0200b00267b7c5d232sm41460pjb.48.2023.08.23.10.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 10:10:46 -0700 (PDT)
Message-ID: <41e73f04-5c44-045d-8ee6-6195459587ad@linaro.org>
Date: Wed, 23 Aug 2023 10:10:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/14] tcg/ppc: Use ADDPCIS in tcg_out_tb_start
Content-Language: en-US
To: Jordan Niethe <jniethe5@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230815195741.8325-1-richard.henderson@linaro.org>
 <20230815195741.8325-6-richard.henderson@linaro.org>
 <CACzsE9rXZdXuEBqcF-fBwmBiMzavCJ7czWufT+tzwf4teNe9uw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CACzsE9rXZdXuEBqcF-fBwmBiMzavCJ7czWufT+tzwf4teNe9uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/23/23 02:39, Jordan Niethe wrote:
>     +static void tcg_out_addpcis(TCGContext *s, TCGReg dst, intptr_t imm)
>     +{
>     +    int d0, d1, d2;
>     +
>     +    tcg_debug_assert((imm & 0xffff) == 0);
>     +    tcg_debug_assert(imm == (int32_t)imm);
>     +
> 
> 
> I think you need imm >>= 16 here.
> Without that the next patch in the series crashes.
> 
>     +    d2 = imm & 1;
>     +    d1 = (imm >> 1) & 0x1f;
>     +    d0 = (imm >> 6) & 0x3ff;

Yes indeed.  Silly error.  I wonder what went wrong in my testing...


r~

