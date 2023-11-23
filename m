Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F667F5DDC
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:31:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r67um-0006pX-Ef; Thu, 23 Nov 2023 06:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r67uf-0006oY-PP
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:30:30 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r67uc-0001ZF-O9
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:30:28 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33139ecdca7so511120f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700739025; x=1701343825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5hfwJTgfPepSBxIYc4rDaXYlcdCHrwyUDRah3nHoABE=;
 b=sgQRAYE3hkgngt/7Zm9h04arj8I5cgSUBw8omvAT5ccS9LNQzca+2LYRmGWiYfVW43
 7IM6AQgKXkZ1yxT7NzZxTPRlSaZ3GDBrCHgXaGPX/nDgd4OnmTvpyR2jWWczS92XOxdn
 P47Y30btv+rUfaD0DdxUviVY6EBOG2U08oBD6YGv4Q2c+SozKxm9QXfVyZEZy0nyBcED
 /Ioftxd4KfxgOAUmokXVfRotXYb/sR99P+P02S8Z5jTagtrUrUMgt4p0hFVgFMKOc9di
 vZMHsSeBwrU57ByHI0QE8phPEa88z9ocj+tqih1iRh0oNqiL+8+Twvda46kN+ZlMeR8t
 eXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700739025; x=1701343825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5hfwJTgfPepSBxIYc4rDaXYlcdCHrwyUDRah3nHoABE=;
 b=mhf1CVFr9qfZRBh5BV/FL9kM20UHEoJMHNywAQ7BAUA0uAJ5Bx517G+JQIvhFJbTPC
 uIYxZ+M3nd1jGQYwYqCcbdFakoWlczQNEaqK3PgFHt9Oc4TtgyDok1VmUPkIEtN/WXc3
 5LJLG6OQbO5cv/o33V3BtrpDmJpnuVOKvFrAamrrt2TK0/cmu7wBYo3qti+77kEJ70aL
 5A2omjlZA9tQFc8IVllHJT6L4prlkXtluLByQeu01DcIlWkWmVgv5mC7A7cthk99ZymJ
 XBs4E01k+Y2kvk3A6bq9obkNYaAWGXzTwlL5sWMvsDHHKFa3d4PK2l7GPZDFAigU6k+s
 4gPg==
X-Gm-Message-State: AOJu0Yy7xYBqOeu6tUKHG1ieUX07LfwY0FwVf2j3OXe1zgXmrfeTFXl5
 rFFWsdvYg+nlpIVCLjRfrcifl1JP/CijJnD+Rt8=
X-Google-Smtp-Source: AGHT+IGgNctaJo+xgzSi9SBx3EGq4HTcyDCCXDKeP9y5JzFBXN2qdpjk61KLvVWZRTHi7zeo5qq3IA==
X-Received: by 2002:a5d:46d2:0:b0:332:e1c4:97c1 with SMTP id
 g18-20020a5d46d2000000b00332e1c497c1mr1065276wrs.39.1700739024925; 
 Thu, 23 Nov 2023 03:30:24 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a5d4d0b000000b00332cb23ccbdsm1381619wrt.81.2023.11.23.03.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:30:24 -0800 (PST)
Message-ID: <255a6d86-4be0-467a-b877-de5b02dd30b8@linaro.org>
Date: Thu, 23 Nov 2023 12:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] accel/kvm: Make kvm_has_guest_debug static
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 23/11/23 05:41, Richard Henderson wrote:
> This variable is not used or declared outside kvm-all.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/kvm/kvm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



