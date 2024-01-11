Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA3282B705
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 23:16:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO3L5-0000WZ-3t; Thu, 11 Jan 2024 17:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3Ku-0000Vu-4S
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:15:46 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3Kq-0001fA-KG
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:15:38 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso48535755ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 14:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705011334; x=1705616134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d7gAYJykKQ/fYtOQplOD/RZNPEedVWBgdy/6LNIzcq4=;
 b=jrL5FOYOxFTGGm+YNkRFT2uNZdPU4FQIxnORXfc8eiaCKLJLlRRRk4cNUPWShn+KLj
 SYF6cLwgSj9j7yw0qPaRdHcIGgUsjp+lqfpLpYs9CBbzsbIP1z2KyvLCal/awO5jN0Xb
 65HROvzLgx5378Hv+zoAYcKniURqYU8/jDEP1xDFmCcA8ac+D+8V+yheWdU0z2clmXZA
 /coNk8GVZZPUDM10DEZKidoPzi5+iHU2jrOglT+lYJvUEJc5aGR3vS0Fk5CSKMrdhXYj
 vU3fwl9rcAv+Kw4CglDR2MG3Mm7GfjF5QIjo154BZVSgyd3qy1zsMaSJKnhofA7cA+sv
 L1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705011334; x=1705616134;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d7gAYJykKQ/fYtOQplOD/RZNPEedVWBgdy/6LNIzcq4=;
 b=uqLK4yiBvV8c4bxpM60FVlGk5YMJtsIW2sEY8Gmc1OJi1SM9VSoNiWQbCRak7ct5Fb
 PHciYZJd2lXU+T2hyIeOZtYwvJMBRczZ54NLj3AP6VBHHlS+7sQbB7XiWZMQXEAzCLkT
 0Uu2sjsRn3GL9W9CWwHe69OuP6o5kT+9W8byDmuN65XUx3pBCAzWSjj/hJTDazPD1lB7
 VYpReNwwnkcXXXuo8dkaz5WfFxq5OiNmReAKLookzYuis13kHCW21mLxGgXkNKpQy14g
 idHvUGDZSz8nLAaNxnJXoHJajyhF/Uw6S+EpAHoHOQKBurxn3CjVCjb87ycOIL5f3MZP
 mhdg==
X-Gm-Message-State: AOJu0Yzl47RznhlPCqy8l7SxwpSnrw6P0tfzZBUYGs+MV9VAOlz9dGsQ
 UgRFLvuxADwK0pAdKYDtJofNyX0+PMloug==
X-Google-Smtp-Source: AGHT+IGIke57I6Z8bhFLdtGeqAUr/zzungzQqkPRR+jAfMLzT/wwYLA8h4An2U+KYpYlQ05aLx6EOA==
X-Received: by 2002:a17:902:c44b:b0:1d4:6732:1ab8 with SMTP id
 m11-20020a170902c44b00b001d467321ab8mr396814plm.83.1705011334630; 
 Thu, 11 Jan 2024 14:15:34 -0800 (PST)
Received: from [192.168.5.64] (ericne.lnk.telstra.net. [203.45.18.161])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a170902dac300b001d49a08495esm1632482plx.118.2024.01.11.14.15.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 14:15:34 -0800 (PST)
Message-ID: <0ea64257-ea62-4018-a561-5e146932c1f9@linaro.org>
Date: Fri, 12 Jan 2024 09:15:30 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] tests/plugin/bb: migrate to new per_vcpu API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-9-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111142326.1743444-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/12/24 01:23, Pierrick Bouvier wrote:
> Since we need a fixed offset between count memory location, we now need
> a contiguous array of CPUCount (instead of array of pointers).
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   tests/plugin/bb.c | 54 +++++++++++++++++++++++------------------------
>   1 file changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

