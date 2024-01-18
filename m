Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C2831C3A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:21:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUBw-00059c-Ug; Thu, 18 Jan 2024 10:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQUBv-00059K-15
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:20:27 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQUBt-0005qM-HI
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:20:26 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-337c4ec9e46so1297199f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 07:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705591224; x=1706196024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WlkvkmGu3v052Jxiy0qSWoXaSU2xt7d1c5IMx6XOSLw=;
 b=AUnec7WzuqyJ4qusSg23qgGil8iyl6fQxVnZ1GNo2iY5b+rgxeREJSzikLQOkRGBfP
 7bSQ9zTd4JW8KIbIR8RUz+rqEX+aya6kXTqx4Dun3i98JDnoBvpciNLNQT1N0OYtLyqG
 9NhnoBPBlXMMU4R+8zVi3qTDOBq7GrzYvydkFQ3KTkZ2MA2k5CAe/4Jbs8QFBagJNqaE
 8H0vcY72oox16Oaqe0LMTnsSyylnAIHmdF/oqxG4tOkoJiTfo+YM6kezw1+JfTeAe2bL
 hZCbkqe2Vo5Mt4X0DYbMZ272ox987DHMn3T675D7247vTVatbr9aHR7vdZFy6NF2Glrb
 FGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705591224; x=1706196024;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WlkvkmGu3v052Jxiy0qSWoXaSU2xt7d1c5IMx6XOSLw=;
 b=CSjcvmvSvGom06JKefjuopxKNigXXy+XZjem9Sm3r5brb9Jhh+EwbSu/Ngt6dCXe1E
 23pNoNlN7bzP+gpGzip5a8MG8pJTgv042DJG8lngpCnw1GzB9+2ml14Sj8JvtJFrCBRv
 RFjUftGpxPLdyz0rTLF1THORIQ552LfAZ21M0PSTH3X2q1l9L0kowPyNW9ZQmPM9RB5A
 b8ShTMEB5qERFEsC+1ArDFZfsS0QtDIaW/pb/pfY2nVxrpROBfprCG1JC+pgemnc/qwT
 EEMudw/CGplV19QFNPpOYsS3ZlzBfo5aeXO+Rw9uSJS3aIKXDNruXOZ4Tt1zNx1rKdH3
 uIEQ==
X-Gm-Message-State: AOJu0YzPbBXCGsUPKmzoIMdjY2JY33E04GWKT+BcEKXmBo46Qw/zmGl1
 +WONIlIz/OjG5rTsURAGQySXOFIWrYZouH790TjqI5YHYfAix/dVYtNDOYIP0Xc=
X-Google-Smtp-Source: AGHT+IHeGCqMhm8u5mxJyycuiGl+UMxtZzZ3LuhhxZfbcQFpJR9/vb9DuPLTxXicJKX1Bna05w/zfg==
X-Received: by 2002:adf:ed02:0:b0:333:2fd2:7699 with SMTP id
 a2-20020adfed02000000b003332fd27699mr304313wro.138.1705591224201; 
 Thu, 18 Jan 2024 07:20:24 -0800 (PST)
Received: from [192.168.108.175] (33.red-95-127-38.staticip.rima-tde.net.
 [95.127.38.33]) by smtp.gmail.com with ESMTPSA id
 d6-20020adff846000000b0033725783839sm4256057wrq.110.2024.01.18.07.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 07:20:23 -0800 (PST)
Message-ID: <1f34e941-5b0a-4091-95f9-0d0c8e302aa9@linaro.org>
Date: Thu, 18 Jan 2024 16:17:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt.c: Remove newline from error_report() string
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240118131649.2726375-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240118131649.2726375-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 18/1/24 14:16, Peter Maydell wrote:
> error_report() strings should not include trailing newlines; remove
> the newline from the error we print when devices won't fit into the
> address space of the CPU.
> 
> This commit also fixes the accidental hardcoded tabs that were in
> this line, since we have to touch the line anyway.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


