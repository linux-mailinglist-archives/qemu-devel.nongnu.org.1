Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA5881FB44
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 21:59:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIxSk-0006KR-RY; Thu, 28 Dec 2023 15:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxSj-0006KJ-KJ
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 15:58:41 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxSe-00077K-LX
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 15:58:39 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6dc00dbb560so1295196a34.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 12:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703797115; x=1704401915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2C3KXdJ8I42K/uQHH1OOJ/LI3wMECPof/+zxppJkLME=;
 b=r/LNQbpwLpx9eXtuehRV1DR2iPcPELDbD6IP97Fo1hCoqTf+iAYwASAm2fvtjnElyC
 EKgrfxN2l7WK7N2IfnwD3hzQKLF17Kihyprtps14vPjmwL+ieghtbGDVWHVPzrdOxhDR
 3ZQ/+rGQzKHK5r1pgCGkLgk+eYAkekDmIQ3ESyGQvaCSE7q2ud71ziv5HBaEuSlnGMjT
 ybJXYBf4vK11rLPXLk36ilWEKIoe8MA6U/LWhM2ptt3wUWGH+vAIj7yyvuB/UU6dUHqZ
 SxeB2JOtGf5v1o+esGwSVE/WNyxk9Wxf4AdnqHk4CR7OgbkBK/CzBvYz5xY+eSnhKe7l
 Dj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703797115; x=1704401915;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2C3KXdJ8I42K/uQHH1OOJ/LI3wMECPof/+zxppJkLME=;
 b=RXWffMIkyPTBmUOTtSUTpM3Z6eA/2Zjnu64kjl0VJfw6zRLO/Tg6Fw/ZeZzu54D2FR
 e4sWAnWVTmtseJM/uTfoNsvPKkVxoW/UXIK5dM3nSrFxKxj/WB2NQOVuW8z45tebuKc6
 HRulnnrlnTiALdbvEB8JjD5yaU0VR8f37eMUHAYot7F7KV8ibYbH8DN/9tbaWup6LQqJ
 tZ2uagmMcAb2EhBoqaCfz0uDZRFs2XK3ekzXRcqLmveVuBiOrmgTepEeYO8vkGrWV5zL
 J21E5PZR9Rxw7XDv6bk33jtqchLcpJtGPenZeM+OgQV3GTWk0Ure+F7EWUb+gkjAJJvt
 uuYQ==
X-Gm-Message-State: AOJu0Yxc0KSoctCysjEPidKTjd8oRysTn3kv0y1W0+P/Xl+QNLz94wRw
 b/k/CCxiWNiZ0DkuHWiefRp5vIZ49VKU4w==
X-Google-Smtp-Source: AGHT+IE3N1Imbi9HgSzlGbU1QlRJvbGWpZnSXVIUVuU0tFXBYIm5S++UmtWdY6nDbrjyG9ckTPmbFg==
X-Received: by 2002:a05:6871:68c:b0:1fb:75b:2fab with SMTP id
 l12-20020a056871068c00b001fb075b2fabmr12659559oao.66.1703797114998; 
 Thu, 28 Dec 2023 12:58:34 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 z65-20020a636544000000b005b856fab5e9sm13339651pgb.18.2023.12.28.12.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 12:58:34 -0800 (PST)
Message-ID: <62dc48ee-e807-4b3d-aee4-e39964b417a6@linaro.org>
Date: Fri, 29 Dec 2023 07:58:30 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] target/i386: remove unnecessary arguments from
 raise_interrupt
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> is_int is always 1, and error_code is always zero.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/excp_helper.c | 7 +++----
>   target/i386/tcg/helper-tcg.h  | 3 +--
>   target/i386/tcg/misc_helper.c | 2 +-
>   3 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

