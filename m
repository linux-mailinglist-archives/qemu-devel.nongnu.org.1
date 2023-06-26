Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C04173D998
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:25:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhWu-0004Gj-Re; Mon, 26 Jun 2023 04:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhWn-0004DS-Gd
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:24:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhWl-00036V-Jy
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:24:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so4553250f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687767889; x=1690359889;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zcBe/ebsOLQN72bYbrS/GmNXysCYA99WVd4VPPPo64k=;
 b=b+X3o5sFFugUJ7e1FKljnsUVAFc8YD/bj30Vp5gt4HOrSudMgxFenqjNVhN7Rw4nlR
 WQuXrMNtJMpP5cYtpzFyqjvX7I2YIgEWuGq6omElGPcRqJwOge9pn86pGOEtob17oedQ
 ueVj8ZxnB+6ZmkMY4yIbqoyYyabhtBDBGZZ7rGLMzgUm4L3bk2pMeO92Sc4DEiU7pl2R
 ibW5RZYpoAuIPNOeDnlmnasEbkOHHruC6J1Dhvs0esMg/6cxKorMFspKAd1mOsQ4bwAh
 OpWW87funpqUQQOmJt/N3a+tIJjLZWuB9/02Ce15nFWseH0wPB76Z2NnvBuYMRtuZHRR
 3dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687767889; x=1690359889;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zcBe/ebsOLQN72bYbrS/GmNXysCYA99WVd4VPPPo64k=;
 b=UdVBar0DI5WuulWDgQLSbhm5Cgzd+Ckf/qLa1aR3B7BE0QgN2vXZBpp6cUYbDwpuL5
 tKMcQoYiHZZ06fwm1BZHRiTnMfMGq9++sFwQ532hk+dLfXcCCbd3KWGAXfw5A6uznoeM
 ST/PDxevpA7kPM3ZVNps+EMUbgYEDEuqdLetXZYnnUPgircb7qnBanxmVu8bw3vkmeai
 nSeRUsbFJpMjNLQEKUBHCtIkdJQM5B1+9n8i8FG2+vRcXM6YLNhLUlCIFqv5Bo1+1G8p
 +9qXO7Lt1axiv1tw1LSIiW4OTNpFbAcNP23eRpSTdxKUiL1OU9kRgXbIMQG5w4/cPWsA
 typg==
X-Gm-Message-State: AC+VfDxwxjSHMzOuglWPFzKL4rkKkq6F3BratUOmn10blOQmy9bPJlBe
 Fcbgp6yqubNcxflzsUffgWVfkw==
X-Google-Smtp-Source: ACHHUZ6tI8CMsbVqUUKMSjidqDzBGzIuXPg8YZiq9oMkb8N+YngQrj0DGeM+Nv1LueijURU4444qig==
X-Received: by 2002:a5d:5968:0:b0:313:f5cd:d761 with SMTP id
 e40-20020a5d5968000000b00313f5cdd761mr776357wri.45.1687767889220; 
 Mon, 26 Jun 2023 01:24:49 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a5d4649000000b0031118d80246sm6592845wrs.29.2023.06.26.01.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:24:48 -0700 (PDT)
Message-ID: <cfb2b668-c1c9-7596-619c-454b366685ae@linaro.org>
Date: Mon, 26 Jun 2023 10:24:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 19/26] plugins: fix memory leak while parsing options
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 14:20, Alex Bennée wrote:
> It was hard to track down this leak as it was an internal allocation
> by glib and the backtraces did not give much away. The autofree was
> freeing the allocation with g_free() but not taking care of the
> individual strings. They should have been freed with g_strfreev()
> instead.
> 
> Searching the glib source code for the correct string free function
> led to:
> 
>    G_DEFINE_AUTO_CLEANUP_FREE_FUNC(GStrv, g_strfreev, NULL)
> 
> and indeed if you read to the bottom of the documentation page you
> will find:
> 
>    typedef gchar** GStrv;
> 
>    A typedef alias for gchar**. This is mostly useful when used together with g_auto().
> 
> So fix up all the g_autofree g_strsplit case that smugly thought they
> had de-allocation covered.
> 
> Message-Id: <20230519170454.2353945-3-alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

