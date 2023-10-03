Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D68637B69B8
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:03:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnf2p-0001IN-My; Tue, 03 Oct 2023 09:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnf2Q-0001Eh-J8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:02:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnf2L-0006XD-71
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:02:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40652e570d9so9216175e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696338123; x=1696942923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ntoH5H1R+uasf7s+GRiyJf8P8r1KZwX5k4NlR69cXw=;
 b=zVKxumEBdHGkfbq9d+LZoDAnWJK+QeBINFZfOTk1dxriuVo9aXagoLAnajIbK4KxlO
 X08KDKYgm6vWTLpBK/tQTdjLJDV9LKD1qqvFyHcNmlXWVpIhQSaWPZQecsfa2oF4JEG0
 Y24yaT4ZlOHK36IuUY3nFFtvRji/J8mwZiEN48dZVcqHnGNHzfEir6fXYWSkCEj4KFw5
 05gYyNLOwB/BTSdLyWAJ5vxWd3xmeNJ2sP2FUP7J7PiDcE8gkqOGyRBKsSodXwj81Y58
 HcKJn8tl+8TSlwMI8R0kXF+2gwunapEqwK2+jI60vXD4UXxXCjUcUBo1WHpOb//VOlwD
 5I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696338123; x=1696942923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ntoH5H1R+uasf7s+GRiyJf8P8r1KZwX5k4NlR69cXw=;
 b=oJEdbbVoMGTDV/7LDhwLU5BvS/z0KgeGR7lLIjCG1bSkiEHtigtpNYUMxHX00ykZkI
 VdpfS+tVCGgmhIiB0pAQ+s7APymdEkcHLsN+SjOS3o0lNREvMnMSqiUXSMOEltdlgCmL
 HX8Wp50sima8nCzbNfJrkNVPMLN77tfljH4zRaGlNKxp/Tx59x+40ohc3AX+Sk1kNSvC
 0K3nQeVw0yqWjQ/qqRbo0DngUSNadMvKbRKtPPmRQKcaZnKebTaojQ2on5wYk2eXjtrS
 1h0rc0kw+vtqkDeaObXmkJTUBth44Xxm6jQcQj48cXF74GVjqfTtBehRaiCygQh0EmTd
 N4VQ==
X-Gm-Message-State: AOJu0Ywi1xiFQ7NAEbWnePi8lXx46gY55hd/AIG2KVrXgVbw2HzsNzd3
 RdyNCQ2EdLYojyqfdcxL7xBLDg==
X-Google-Smtp-Source: AGHT+IG6FQ2CdwPghPqMshC7I/sD4puNWNof+Sg3BfVlJWK1wr0ezrc8l64q5527vkjre34LHp9Kpw==
X-Received: by 2002:a5d:5272:0:b0:31d:74f8:fae with SMTP id
 l18-20020a5d5272000000b0031d74f80faemr11641477wrc.71.1696338123045; 
 Tue, 03 Oct 2023 06:02:03 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 q15-20020adfcd8f000000b00327297abe31sm1538995wrj.68.2023.10.03.06.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 06:02:02 -0700 (PDT)
Message-ID: <df7f0256-8220-302e-9897-c7221da23128@linaro.org>
Date: Tue, 3 Oct 2023 15:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 19/19] build: Add update-linux-vdso makefile rule
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930021529.987950-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 30/9/23 04:15, Richard Henderson wrote:
> This is not ideal, since it requires all cross-compilers
> to be present rather than a simple subset.  But since it
> is only run manually, should be good enough for now.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   Makefile | 10 ++++++++++
>   1 file changed, 10 insertions(+)


> @@ -303,6 +310,9 @@ endif
>   	$(call print-help,distclean,Remove all generated files)
>   	$(call print-help,dist,Build a distributable tarball)
>   	@echo  ''
> +	@echo  'Linux-user targets:'
> +	$(call print-help,update-linux-vdso,Build linux-user vdso images)

Maybe amend '(require all cross-compilers to be present)'? Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +	@echo  ''
>   	@echo  'Test targets:'
>   	$(call print-help,check,Run all tests (check-help for details))
>   	$(call print-help,bench,Run all benchmarks)


