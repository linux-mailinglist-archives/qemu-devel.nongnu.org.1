Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 486DD782D60
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 17:36:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY6wO-00046l-AJ; Mon, 21 Aug 2023 11:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY6wM-00046Q-IB
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 11:35:38 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY6wJ-0004dB-35
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 11:35:38 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-56b2e689828so968113a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692632133; x=1693236933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q2l6UNXdtK+jyC/R+QKTInrYGYMkqySzNPx1uNlBl3I=;
 b=J/bt/fkJ55BJbI7pKPh+/Dgq8X/KXu80ORtW19QTtcPMhNqnnBRsBktJjxJROS/MWd
 zfkvwBG9hzCx6EQiVpZOrkpMGUf/r/EC1xg5A8AjZGZIDLBH+RzTd8PK66qxOF1byEps
 HXMF0rnHOZyWMCmBKszM86YVKEFRNcytY7s1REIAdEgFYdSxVvPT0BWzAjpbyshlmWql
 hHHiY+8O1D2FJfbOfHhMbe6x8u5+xmqz5x5ZzNNQh6wCbsg+SbezkRW8PauFsriRTpyF
 Oua8RtGKIln2zsE5F0qIoj1Ui0h5wp59AaQ++uEOMWsYRwL5a5t82/Zr8IR2yTPqUw4R
 BRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692632133; x=1693236933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q2l6UNXdtK+jyC/R+QKTInrYGYMkqySzNPx1uNlBl3I=;
 b=feZy9ZmP5bd+Qm/yd83aDF+QoZKd1uT3plb6+JkGid5rXiYP1Yd0PmYVlmP4BCUftP
 r1UnGf/movJjZ4YRAXn/QaaV8GxVZ/Xh+nZM8UyRnivS6MvnmhAhLXfOH1NZjPWwXPef
 t6qS7Ec3qizrlrl7heeo+8blLBZqvyahRB3uZ5isu8po5reLZXlBDap+X3P1GMOe41bf
 9u485jd3zf+m8SCJRUYokhxJSg3cbgY8PcnxtVQ2q1Fu2XnGdHMoDjNGnOEZ6aX/JcDt
 p/SogPOcyKbX80J5FWEATh/oE3HYXsCX0VYItJsKClMVILF7xKSZc44KZ5Vue7TqmUyt
 tblA==
X-Gm-Message-State: AOJu0Yx4TqTmJox7AZ2cjgabQQsxLpA5KHeCA7UXix/TcMlEVbqO4GfX
 ocUXckhrBQbb06Qib2j+ywextA==
X-Google-Smtp-Source: AGHT+IEFPPh5A37pBqgxuwgcGpeiIxxjHPoapQfEaX3F/ZIWM6LXoqkhib4rjuAzk5aSqt40XSVxlA==
X-Received: by 2002:a05:6a20:160b:b0:132:f61e:7d41 with SMTP id
 l11-20020a056a20160b00b00132f61e7d41mr10536129pzj.5.1692632133311; 
 Mon, 21 Aug 2023 08:35:33 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:2c08:e710:4459:46f1?
 ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a170902ce8f00b001bdc9daadc9sm7246884plg.89.2023.08.21.08.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 08:35:32 -0700 (PDT)
Message-ID: <69ea3d48-71b3-253e-0e51-58476ff764e2@linaro.org>
Date: Mon, 21 Aug 2023 08:35:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/ppc: Fix LQ, STQ register-pair order for big-endian
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Ivan Warren
 <ivan@vmfacility.fr>, qemu-stable@nongnu.org
References: <20230821153051.93658-1-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230821153051.93658-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 8/21/23 08:30, Nicholas Piggin wrote:
> LQ, STQ have the same register-pair ordering as LQARX/STQARX., which is
> the even (lower) register contains the most significant bits. This is
> not implemented correctly for big-endian.
> 
> do_ldst_quad() has variables low_addr_gpr and high_addr_gpr which is
> confusing because they are low and high addresses, whereas LQARX/STQARX.
> and most such things use the low and high values for lo/hi variables.
> The conversion to native 128-bit memory access functions missed this
> strangeness.
> 
> Fix this by changing the if condition, and change the variable names to
> hi/lo to match convention.
> 
> Cc:qemu-stable@nongnu.org
> Reported-by: Ivan Warren<ivan@vmfacility.fr>
> Fixes: 57b38ffd0c6f ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ")
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1836
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
> Hi Ivan,
> 
> Thanks for your report. This gets AIX7.2 booting for me again with TCG,
> if you would be able to confirm that it works there, it would be great.
> 
> Thanks,
> Nick
> 
>   target/ppc/translate/fixedpoint-impl.c.inc | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Thanks for the catch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

