Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3237273F7FD
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4X5-00050q-FX; Tue, 27 Jun 2023 04:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4X2-00050d-O1
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:58:40 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4X1-0008QR-4Y
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:58:40 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-98bcc533490so514606666b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687856317; x=1690448317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lTkFsMFL8CFY8Jn/2f8V7sFGv37JQm4tx8kMvD2VQxI=;
 b=qjx/+fct5ogr6kV6RLuKLwVT+31ygDqUCKPqvzA+nobBK7cOTItwjZZnNxbN49fn+A
 mpUcdhZCUzN2/bioOi7K0QiMSSxJbhBRN0WvkW7tjaYVPEe9BUx0nQsrLW05qFRdxuLx
 och0Hf+zyeTL0zyrqiSO4m8SgMIRX8/nXD/YX7fkUQ4mRSsm2oejOHtvYYMQNwqb35HC
 rtC2VUMYM1wQsmdyFy3tzVcBOGi16g0Up3GwcppDJLJDvUYeOTk4KeMwGImXAzMoMUQv
 fMAlWCfn2csuKZEeyWvVQAKCAoKwirv6Qj35lV1r2fdwTxUeyT4DD85i/tjWfYrBPsMq
 wQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687856317; x=1690448317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lTkFsMFL8CFY8Jn/2f8V7sFGv37JQm4tx8kMvD2VQxI=;
 b=gaFHlDgiFqUzmHXbN3wP4MeclDyj++8qaiNR8a5q1KmK32/ipzmshydHeHXzU6om3V
 BU3V5LZTrMgKAzx7Cxcc0Q0CypCWK7iu4hwzXCA/aHclhjnCNAh6/47F0fUqwJLNgT2f
 QO+DgAk3iVkPN5kgS5ETN4vqqoxehYETBxr565kgyJFk1E6hz1eiV6OxxvwIw95PjmOh
 En8mGgnaAPmldUn9RfLDILs94nJohjlONRGXdGvIUws6PNX3ljpTuVvz7ytjXCFzF9Ud
 Oph5/YDYkMORoaYaVBTp+RouZ/H0j4tlJ67g6khyCUNRQCWve9xxELl+LFNdiqWkpy08
 z8xw==
X-Gm-Message-State: AC+VfDxq6TWt71FiMKFZj0v9Cvi8YERdYEtM149SZw+CVkgZcB0QoxvI
 9Mvy+pnJMn++RX5v/tLrxBKZAU5+Dtv49bd289o=
X-Google-Smtp-Source: ACHHUZ5xhJvGRAiANWreS7bFUNotSS0zUaddKCv8ayB4kk75wXJIiwkS9t06Gy1ioHINR8lkRkwfDA==
X-Received: by 2002:a17:907:da1:b0:992:1bb2:61d6 with SMTP id
 go33-20020a1709070da100b009921bb261d6mr983316ejc.8.1687856317159; 
 Tue, 27 Jun 2023 01:58:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 k21-20020a170906055500b009890e402a6bsm4234670eja.221.2023.06.27.01.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 01:58:36 -0700 (PDT)
Message-ID: <1a3fefd1-fb3a-1e38-8938-ff3de9cc4dc8@linaro.org>
Date: Tue, 27 Jun 2023 10:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/8] target/sparc: Drop inline markers from translate.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <20230621180607.1516336-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621180607.1516336-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 21/6/23 20:06, Richard Henderson wrote:
> Let the compiler decide about inlining.

Should we clean that automatically with scripts and forbid via
checkpatch?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 237 ++++++++++++++++++---------------------
>   1 file changed, 111 insertions(+), 126 deletions(-)



