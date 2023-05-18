Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4230E70874F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:51:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhlX-0001Ko-OG; Thu, 18 May 2023 13:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzhlO-0001IQ-HI
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:50:06 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzhlL-0001DA-Ja
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:50:06 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-64d293746e0so546101b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684432202; x=1687024202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0gdtGOWxb8hoOofycTAB4NpoFUWgY/1viivWg/ML+do=;
 b=U6O7eaP5PguI8XETQR3gQVkeva1ysrpOtLdLgWdkBuKdDki5MGu/BFtAs2iu7ukdrw
 LsAO4q/1Gmo8AnA0V0F8E1ct/qa1mRDMMvQPBb5CooJaGXTSaJt5ePpXHys8cebZuKUm
 lCL0d0FJa07qmM0HGGIi1ae6eh2VJwPbcPyAKGAPXNEHVTzWRKZAkUzL/1tVFarqJjvR
 mce4RqbpDz6wXbpoDPciW4yNWX0CNN4no+ngwaz6UxxEYlvIkZLXl2Krmh2sHvxsIuoC
 6ZOlfuFOnN7GI9h6y/Jx9eXTD5qhD8B9RTjRRZHwmrJfYD8K5ms1rG+jQsSJFMjlE/vg
 c4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684432202; x=1687024202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0gdtGOWxb8hoOofycTAB4NpoFUWgY/1viivWg/ML+do=;
 b=Il7qGyQJG9fhI2MrZsu4UhhV5LXgyowIeDD71SUtPtpcUypb1lAV1dKGvipWLzYi74
 N79peM0oPbuZa5rF9KTMlmoVQMoOuk3x51TON/2sil4PX2VPe18NG01E7fU7yGu8OMZy
 P0jEheZfi6CB1vTvjSviTNRWkvSoUMo3c1C5YvSJWEKQyfVU2kOtt/dS2eS+nxNwouhy
 js01WcqkPHemNBSt8NGLLfahcrxMnFhdhDGNyW294l27cchBccLGC34POhoRpt+ycIjv
 2kJla+u8vYJHRZsxftm1qmDhrU7rVmELoFt9LjzVQ+uRoNPknQgF7SBOGkWNJ6AVETxi
 ujvw==
X-Gm-Message-State: AC+VfDzwgrs5GdYAhAHhcSw5HBTlZIAKdgyI7DhvKoY7q0+dWXnGtg34
 ddOBzxit8EfqF/KDiSYGyafB/A==
X-Google-Smtp-Source: ACHHUZ5hCbxTzF1nYwtId8xuu6Z6dzDe4OLHqCgxtKnlVoMsbM8Loi2vN7+fR0c8QW5sMA8jFLRGcQ==
X-Received: by 2002:a05:6a20:e189:b0:103:377e:439e with SMTP id
 ks9-20020a056a20e18900b00103377e439emr459715pzb.60.1684432201837; 
 Thu, 18 May 2023 10:50:01 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 o22-20020a634e56000000b0050f9b7e64fasm1489451pgl.77.2023.05.18.10.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 10:50:01 -0700 (PDT)
Message-ID: <623b4876-636a-e24b-76a1-124437aea137@linaro.org>
Date: Thu, 18 May 2023 10:49:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] accel/tcg: Fix append_mem_cb
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20230518145813.2940745-1-richard.henderson@linaro.org>
 <87sfbtlkk9.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87sfbtlkk9.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 08:34, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> In fcdab382c8b9 we removed a tcg_gen_extu_tl_i64 from gen_empty_mem_cb,
>> and failed to adjust the associated copy, leading to a failed assert.
>>
>> Fixes: fcdab382c8b9 ("accel/tcg: Widen plugin_gen_empty_mem_callback to i64")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Alex Bennée <alex.bennee@linaro.org>

Applied directly to master to solve the regression.

r~


