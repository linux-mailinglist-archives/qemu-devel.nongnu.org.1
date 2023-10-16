Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA217C9FFB
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:53:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsHTE-00030V-QP; Mon, 16 Oct 2023 02:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsHT8-00030N-BR
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:52:50 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsHT6-0000BK-Jv
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:52:50 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9be1ee3dc86so301650466b.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697439167; x=1698043967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uIqdEfcNQkj0SODsiNMYNtmHkY8Cm2rmUnUynLgGWmg=;
 b=OxpypWKh8UM91OMVHoYsRnPqHget+ixj6DcaPFywpXg+cIM1Sgak1pdhvEnkNpVJC4
 EzIzUm90Tf/UUmH34MTu7f/zrecnTD8/UfLgYl/GYnsz6nz0OW9N+zHNq63BU42UCDPi
 KqElpuiBOOY7Us7I/5JCZZwqPQecg+zH+eWYh5wCwzq+JqqHNGQg7FRZuDfcL8fgCUgQ
 PNWCpiMkIzrXaAT9yMb5snqsnq2LGKVQPIrlTV4GaX/0ztgW3iSnS7vX8VPjYZRRWp0G
 ROLngEhDYjhEfulQBfOuLscpzs8HEXdPHTQ7CITBFYErvFEpwyW+Dmbhh84dhOq4LABK
 /Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697439167; x=1698043967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uIqdEfcNQkj0SODsiNMYNtmHkY8Cm2rmUnUynLgGWmg=;
 b=cnagBMk+xz9CWfppYX7HI7CTAC1gbamtySSanNX0jFVUDj7ew3Nz2OALClMtoj/gZ9
 BQVD97f1KwxFQXOX3jJ7hm+3h6+ILdtepySrxR1OauEQIGdjqc/3JnZclGMcY49XS859
 vu61nesLaA5t8wfXeBlaYYP63XQ0CcSuZaNzLPpBiygo1b/Od0Xrod1kYKFiTtEq9qsh
 5hXcRnssWyCZdKWHjWAi+5B93AdKfPrCOkaw0ekqJhJiGG/wPZIdWMccnbUIxAAXYpnY
 oiXtuNtb3ZqV06Mdm1nhwLWrpmwcrH0gPspJlWUmKAdnc1qRB0+zLPzR5ePmc45XvAyW
 AsxA==
X-Gm-Message-State: AOJu0YzjPYw8r+a/rd9KquRs8JNGzdRT4eNBsRQM/StPqB1XQxeAnSR7
 ZYkwX/Y/as0QT1tK/2jgy4HUDA==
X-Google-Smtp-Source: AGHT+IGyN2N+fXD+B3nnW01yC4eukCbEL/K2+51lm3iV/PTT6/59pN2eS1H/TR94Iv1l+nc/WcdCOg==
X-Received: by 2002:a17:907:d24:b0:9c3:8f7a:3e8a with SMTP id
 gn36-20020a1709070d2400b009c38f7a3e8amr2623766ejc.15.1697439166933; 
 Sun, 15 Oct 2023 23:52:46 -0700 (PDT)
Received: from [192.168.69.115]
 (mdq11-h01-176-173-171-135.dsl.sta.abo.bbox.fr. [176.173.171.135])
 by smtp.gmail.com with ESMTPSA id
 y25-20020a1709063a9900b009ae3e6c342asm3417145ejd.111.2023.10.15.23.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 23:52:46 -0700 (PDT)
Message-ID: <a2b5e2fe-711a-8159-9d2c-f3a653646e60@linaro.org>
Date: Mon, 16 Oct 2023 08:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 11/85] target/sparc: Merge gen_fcond with only caller
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20231013212846.165724-1-richard.henderson@linaro.org>
 <20231013212846.165724-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013212846.165724-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 13/10/23 23:27, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


