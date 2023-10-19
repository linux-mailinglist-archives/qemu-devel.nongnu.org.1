Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C0A7D0435
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtauM-0003MD-GH; Thu, 19 Oct 2023 17:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtauJ-0003LW-TP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:50:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtauI-0005Fs-38
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:50:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so1231985e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697752216; x=1698357016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4acFqOqly6NUIH9JhJu8596xse4FMCYmOHaVcVAthyc=;
 b=ZoJOj1LdFWOxJFCOpgAKaKSsHmmqaEms5xxEg7mpy4C1wyzVTOhILamA0BRMePErLP
 EY+Tm/VwtkZVw6b/wKiUYBGxMSvqmYucFhQZsg/WCl0htXvK+5bbzFa0KAWIgjxgWJ/Y
 QQwaqJk2y0V9YKc1y9ibWxHtHJdC33D6GFNgQ2OB/JdeqD8eyDA/TiH5qGvZHcjrzt9H
 YU/CR9iYVlSdoISC/pmmS0iIaB4/iDfJ0oq+1VMGV3NZy6LCVrb4ZBRblKXGGyXqQeOM
 bPPEDYvfZlm2+8+AX25pemce4uEYin2AwWym8bjsreG1nRFDzTN1g6/EUsNq81ELh/PG
 3T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697752216; x=1698357016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4acFqOqly6NUIH9JhJu8596xse4FMCYmOHaVcVAthyc=;
 b=d6cZDie1jzTOHNTuZiaUWvF7lgEQd3k2n5cyS48Vi3a+jfV1Zi3JOrcUbL7uDKNDcv
 +Ngu7JqlTfHq3KCg+qkz2MuYXexDPjkPW5ukc12EdujOQ+scjPGLNiz3ItPoo0QFcY4d
 fO0I68i+inZx2xSvHEMuGLye4ddiiiHzvyN2uYSsyTQZxwRER2E6ycpS1fBBQJn51MKW
 l7FMUL/DEAgTpy3FwTVAoau+H/N+egZ61SewqC35UztMq5DzEerudXnlyFDsn5NzWFhR
 woSTrphqht2WyFlGN1nwbeIFIxLx+B/HmKEE9rfyZpsIcQ4GbfHvbI3SF52EYwHORd97
 KMww==
X-Gm-Message-State: AOJu0YyNqRYr0LZnkMCFfbZtUioey8uknyhmofNxtdw0huIJi4WTj+Bg
 nEDUXq2iJOYttO7jrfnmoq4F7A==
X-Google-Smtp-Source: AGHT+IFXbZf0OQhcoyv6ayfM/qVhuxJ9BAQqDcL7oSy7pelXglqLkFLME/bYkCHZtM8jM/ZoZ0kK0A==
X-Received: by 2002:a05:600c:4e8c:b0:401:bf56:8ba6 with SMTP id
 f12-20020a05600c4e8c00b00401bf568ba6mr75930wmq.28.1697752216222; 
 Thu, 19 Oct 2023 14:50:16 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 g38-20020a05600c4ca600b004078d71be9csm5285343wmp.13.2023.10.19.14.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:50:15 -0700 (PDT)
Message-ID: <8b6e38d5-ebc9-e2c2-327a-ded3a50d8a51@linaro.org>
Date: Thu, 19 Oct 2023 23:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/7] tcg: Export tcg_gen_ext_{i32,i64,tl}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019182921.1772928-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/10/23 20:29, Richard Henderson wrote:
> The two concrete type functions already existed, merely needing
> a bit of hardening to invalid inputs.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  2 ++
>   include/tcg/tcg-op.h        |  2 ++
>   tcg/tcg-op-ldst.c           | 14 ++++++++++----
>   3 files changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


