Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2882FBC4
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:03:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrWU-0002zO-Vv; Tue, 16 Jan 2024 17:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrWG-0002vq-OH
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:02:53 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrWE-0001zn-Ff
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:02:51 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5571e662b93so8586668a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 14:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705442568; x=1706047368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VNRP3p2HJiMm9el6Ub3FHpdTDfrNg2qmzam7Qyt3Xe4=;
 b=hS7aa09uiNoHQygcrOCzaL3ZqLqICJwTPluDoxkWWHHdJywW2v1B3WLxhM+8+7LmMD
 KXGzUuAYvdY4xKbzGPgr+qICKYJ1aU5Rlsze6guhnIbxYEFKRyVwxWDBNEzcoBlaM8KI
 EKzdJ04A4VqxtdWboPxsP4aXwF7yfQ0i13piJpAc8Dk0CaOokTvV47I/mX0SAtV1VWDK
 auNuJNIc7Ejz2Xa5btd51PUUErhFKRLGB4va4IUy/SCYdnd76v1+P3iRH7/mSvMKmfSA
 hiSPkrKz8+CwARrATw++XHxq+iwjZuY8h2N8eo3AOFuTkJFc0MZaZb1zKKk52jTrvVpW
 cWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705442568; x=1706047368;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VNRP3p2HJiMm9el6Ub3FHpdTDfrNg2qmzam7Qyt3Xe4=;
 b=NC7S9KuIaYCy9tT6gjELZQwKjufnjsq04Lt8niU1IeaRFGgqxzxQqqOduQVppN7uo2
 imHEHuRxzKSZ0JjbZ5zCBLLyBZ8lZzO5FzLrDTcWongbqliLiwzpEASsqdjeWExQo0mK
 1UKr87RECiibxUWRAdvsV9Au6BXBK//wLX5oyxR0X/wzyPT0qQ//AJY2OYxqSF/zwuGQ
 SG9/eU+3+xegb1ZRchGmbfY++PjLbyhU774VgBDg5rDoQvuTaz9GCKKyfLEdhuyLreFv
 lYF8PhIEEMYRYnd0wh6NfyUlI6QULib/ZhGHn0zETj/hpd7uH+DzefeBjiOWdn4y2l2H
 5HVg==
X-Gm-Message-State: AOJu0YyX7Vj0eCPNyAgbIZMzOE+AGg26EGOnmktDMIjIHWdqEK+xeLDF
 fxB3yf8hc9i6gchv1v9g+vbFRZLLmpc4fg==
X-Google-Smtp-Source: AGHT+IF7iBvDZ3daEX7Q3suvx34dCxC5dt7sMYnCdhg9YWf2cyBKioCeIq8OzAXliOpK98OHzEU5lg==
X-Received: by 2002:a05:6402:12c1:b0:559:36e8:e550 with SMTP id
 k1-20020a05640212c100b0055936e8e550mr2435112edx.35.1705442568653; 
 Tue, 16 Jan 2024 14:02:48 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 dj17-20020a05640231b100b00559bb146ecbsm849813edb.6.2024.01.16.14.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 14:02:48 -0800 (PST)
Message-ID: <2d31cfcc-d7f1-48eb-86db-2d6fc273d8e2@linaro.org>
Date: Tue, 16 Jan 2024 23:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/38] target/alpha: Pass immediate value to
 gen_bcond_internal()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 10/1/24 23:43, Richard Henderson wrote:
> Simplify gen_bcond() by passing an immediate value.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20231028194522.245170-33-richard.henderson@linaro.org>
> [PMD: Split from bigger patch, part 1/2]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20231108205247.83234-1-philmd@linaro.org>
> ---
>   target/alpha/translate.c | 21 +++++++--------------
>   1 file changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


