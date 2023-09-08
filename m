Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D77EF79909C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 21:54:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qehXe-00007r-Am; Fri, 08 Sep 2023 15:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qehXc-00007C-Nz
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 15:53:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qehXZ-0000LI-Vu
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 15:53:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf6ea270b2so18675845ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694202795; x=1694807595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6JqJRk2/gSMGWvfvRuCmQwxhY37zdCiRPduWW9ZXVU4=;
 b=Z88IQJmFfpCY7paexd5t9NZ2Wh3UmD0kngXdK19RNa1NM6cYW7j7uhsvotsjDhSdal
 5l8qUvvKZfTyr5FVfxrAjB8pma22bW7yHcZcTy+NB+fGKtjjZMOgUPCqplcihCSOjmi1
 WQejNuEyOuoi1dnmL9K7XOVhCSL1cCVEeGnBcPyienw0+cmnmeAy822wEkNW1dCrJ2Kd
 2kGI7CynUibwFtGyrsYjpltNfmsOubwu4LeIpv9ge5oUgM8T4a7LkPXEhkRlemAez7/e
 b6h8dnk1Tm7GzcjZoqrS3zletzgtoPaz5rQo/A2CegBcv/EneRrIYdIDWCM2NUOqJJun
 LJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694202795; x=1694807595;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6JqJRk2/gSMGWvfvRuCmQwxhY37zdCiRPduWW9ZXVU4=;
 b=vu/2J7zJMAyp5wxulGbt0CGYzvSPsuiNi5jXkZqBf8Cav0Fn1pAemdwGK39AWRsLQl
 CLlqU4bzO1f5/4qYyyHwm2XQy0vjFDf1e1STWZaaMWqTJKa94+4vLZcaFkgWQUeWMSb6
 DhzjMSrqx9fxveb/Pn9KOzKnD3DPAETZ2oAkpLWPfDAhiI4+iqKfJ+7RF+zHBXGU0cDU
 ILk5Hk551/FjQnpTiAkxCyBHppLftta+P03rIvtKNijWQt8wQvReake7p2i4meuAqTvk
 9Fy1Hp3GyCpnD+HZsqxrTW2D/WkrxDc8WBqIUc2frFlAgHmdvtdexweWb1YWEwyTiMKj
 oEUg==
X-Gm-Message-State: AOJu0Yz4C6n/C2NgtBVENs6wQHsA6ms+fCgRE25PuWACU9m/zP8Xns5t
 lIyYhXccIgxQV59dKxg5BhoaQg==
X-Google-Smtp-Source: AGHT+IE6qhe4qnN3K92iFQfg0zCfOXGl/5uylTRzcfpFVOhQUAAxk6wHcl/u5rFtZ6BHK3xqmi4WNw==
X-Received: by 2002:a17:902:9f98:b0:1bd:ca21:c83 with SMTP id
 g24-20020a1709029f9800b001bdca210c83mr2967237plq.68.1694202795069; 
 Fri, 08 Sep 2023 12:53:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a170902a5cb00b001bdd68b3f52sm1929218plq.302.2023.09.08.12.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 12:53:14 -0700 (PDT)
Message-ID: <efa7d7e7-1a64-45b3-d76e-1ce1508a3be4@linaro.org>
Date: Fri, 8 Sep 2023 12:53:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 02/14] target/arm: Don't skip MTE checks for LDRT/STRT at
 EL0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 09:03, Peter Maydell wrote:
> The LDRT/STRT "unprivileged load/store" instructions behave like
> normal ones if executed at EL0. We handle this correctly for
> the load/store semantics, but get the MTE checking wrong.
> 
> We always look at s->mte_active[is_unpriv] to see whether we should
> be doing MTE checks, but in hflags.c when we set the TB flags that
> will be used to fill the mte_active[] array we only set the
> MTE0_ACTIVE bit if UNPRIV is true (i.e.  we are not at EL0).
> 
> This means that a LDRT at EL0 will see s->mte_active[1] as 0,
> and will not do MTE checks even when MTE is enabled.
> 
> To avoid the translate-time code having to do an explicit check on
> s->unpriv to see if it is OK to index into the mte_active[] array,
> duplicate MTE_ACTIVE into MTE0_ACTIVE when UNPRIV is false.
> 
> (This isn't a very serious bug because generally nobody executes
> LDRT/STRT at EL0, because they have no use there.)
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/hflags.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

