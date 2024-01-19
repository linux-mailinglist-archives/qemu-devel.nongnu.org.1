Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE35833179
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:27:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQyGw-0004jh-M0; Fri, 19 Jan 2024 18:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyGv-0004iu-8r
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:27:37 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyGs-0002Dn-Ns
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:27:37 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e884de7b9so16274725e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 15:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705706853; x=1706311653; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/2k+IqkBjCQUpPbkBBrrq5y423eQitb22oXeyQQMGlQ=;
 b=HZyBQWZZdbKoKArXsK/el7P9O+mOgzQbGPJqbATasfHS+S2wXyccKtv92YqV/0IXGh
 0KnSXudz2c4nOBGgOAlcXN8jnOEzcAxsPxMpiPF+MjEAd6yRSvmTUAqlm/dW/0ZuaXcz
 Z07hBq6zpgWrsgl+Dk2ULcyZxIYp6QU7OeUjcZbvudHGe2F9l04S6XoCjdIfF7B7TWL/
 vmLPO/GxL+Iy4RKqQEvYRUEHVURYavr5CzAFTlBijZLefeG3dzPLPyYqURTT/9esoXau
 Jk67IYkLVh0+WIO+gAmQ6iy2041zMoPZ6QJ3Do6OOAURZFa7+CBFCPZ8m5MJF7EaJLoK
 dIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705706853; x=1706311653;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/2k+IqkBjCQUpPbkBBrrq5y423eQitb22oXeyQQMGlQ=;
 b=MzkAWQM7lSPw4HBbp2yq/Wcb8l1VALKBdOySyPpBpfv5CwFtChzePXwXus4jsyEIs7
 6H/812V0MdwZxIVHpdrrAmyOKSM0+fUCXwTyMSjTPoAjQ2Pp5gJKDLp80T5sPkU2hJCY
 /1ZgBU1lpj3jaXyc6hUoi6nQ65OaaEdjlxZB7hlsJeuip/2kjUyvFIbibSwbdvd6cDjU
 6pnHvFQHEFc6+BIb3WtaZOuU42HEjWduMhJhZ9aqcbZoCoGZrQQ7fFkTDOFO3d+BcH+M
 /0fvf/cBQZD+bVJr4b7BV6nANBNZ2gODBe7+X6qgi/bklvvvxpJPpWNzzwM2FvT+982b
 91pg==
X-Gm-Message-State: AOJu0YyIBWIfHFl7SK34PffKUOUl2G+TiczXEhVH8VknWkOUWj0Aja4f
 baNGDIh2fUTSNHT89tmYhJ2yu3PfDLvTjbnjisquKMAN9UEPT3WExef7Sh1W8YnGWWc9g+4pPtT
 p
X-Google-Smtp-Source: AGHT+IGxyGHrGkZButFxfs4V3uy5KMNE1rikUTBhLwsjKh3JkoKC14jZ6Nk1A6FeQU++A2oM01SBJQ==
X-Received: by 2002:a05:600c:19cc:b0:40d:855c:ccef with SMTP id
 u12-20020a05600c19cc00b0040d855cccefmr276395wmq.22.1705706853054; 
 Fri, 19 Jan 2024 15:27:33 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 j21-20020a05600c1c1500b0040e9f7308f4sm2912581wms.10.2024.01.19.15.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 15:27:32 -0800 (PST)
Message-ID: <488587fc-9058-413d-9f92-08ae870451d2@linaro.org>
Date: Sat, 20 Jan 2024 00:27:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/38 6/6] target/s390x: Improve general case of
 disas_jcc
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240110224408.10444-16-richard.henderson@linaro.org>
 <20240119232302.50393-6-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240119232302.50393-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/1/24 00:23, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Avoid code duplication by handling 7 of the 14 cases
> by inverting the test for the other 7 cases.
> 
> Use TCG_COND_TSTNE for cc in {1,3}.
> Use (cc - 1) <= 1 for cc in {1,2}.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 52 +++++++++++-------------------------
>   1 file changed, 15 insertions(+), 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


