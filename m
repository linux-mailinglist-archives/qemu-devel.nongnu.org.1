Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D9470E1CE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:31:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Uun-0001ai-SM; Tue, 23 May 2023 12:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Uul-0001Ys-CK
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:31:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Uuj-0000EW-S3
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:31:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f60ec45314so330365e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859468; x=1687451468;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yy0kxlCpoN1g2ZDqR4k1mjekvFzUWb+EUqa3O+LEO5w=;
 b=lBaiE/cLG4eeVI7usFCsbeEk3nqlFjm0puZo7at3ITf8R9WTUtrOwciSl57RwdK9Um
 68t+luobpBYXaWcj/JYjuWv/OO+I/Fx6X++VyOpEPvY+PRLVl2uHzcyCZWsXdjlOKK7V
 J9zAHQoMDLq8FvIBwYNiY4jc2o+dxDunWD4aNLVnT2H13BaLwVj2DdYvnq28c2ARgkd3
 z+lUHa7YvjB9u2MzrklSt2jDexJNE9q52cmVf7uJNBgIQtvRS07Y5CigaoUYVUEeBQ9I
 Y0HX6O777eiyYGHRZ7Gk93DON/tRqLxF87v6Gp6hnRF/eWXTzWZMFsqH5P4o+MtinloD
 +akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859468; x=1687451468;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yy0kxlCpoN1g2ZDqR4k1mjekvFzUWb+EUqa3O+LEO5w=;
 b=aTxOXoKKo6xpy9lZI3EUgXtaUhf7OtLZL7dIXg7Qwf6zeh+13dtTHXPf+WRBYfLHjy
 xwZswF8MQmnClIFhWSNEVoNRJthAi3cKQLPNYmQUdHJ+oNZQhQhzryxyVj0PwoSIXs5m
 XOBiFh0Uxi8HVzRqoDdLdlXrZhMCFH8dlCuDuvm8fq0AnNYeY286n1oZ76yzjYmakpV8
 V+EOgmmxUyxMNdPKEoAhNgG8OQ6sv3GtjCUdLDflDQwLNAk4zlRdlGpCFv7alYbbuYpM
 GuwxmWSPaoo4+9Q8l6w5rEM1BOPLaetu4KAOLmTcZF3PuRTF3Qp26i1O4uMiorhLmH7R
 wnLg==
X-Gm-Message-State: AC+VfDx1YJLVCmcRHno4p/C9HfVIUTD3/Ibe3xsJ5p3YWykxJ8nBi/wU
 DGpdfuqeozBsp6qc+UOFCHk46mZlci8etgmAB+o=
X-Google-Smtp-Source: ACHHUZ6dRXB9F1xgz9tUyR+4bgQZQTOvq5ZvcjA2HGMiMhz0+j5k99dM0PoSvlhclXgwTobJqqsZxQ==
X-Received: by 2002:a7b:cd1a:0:b0:3f6:97e:b45d with SMTP id
 f26-20020a7bcd1a000000b003f6097eb45dmr2639829wmj.24.1684859468040; 
 Tue, 23 May 2023 09:31:08 -0700 (PDT)
Received: from [192.168.1.102] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 s9-20020a1cf209000000b003f3e50eb606sm12259636wmc.13.2023.05.23.09.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:31:07 -0700 (PDT)
Message-ID: <a674a7fc-868d-46eb-a9b3-e5d38ad95f50@linaro.org>
Date: Tue, 23 May 2023 18:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 11/52] *: Add missing includes of tcg/tcg.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230523135322.678948-1-richard.henderson@linaro.org>
 <20230523135322.678948-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523135322.678948-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/5/23 15:52, Richard Henderson wrote:
> This had been pulled in from exec/cpu_ldst.h, via exec/exec-all.h,
> but the include of tcg.h will be removed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/monitor.c             | 1 +
>   accel/tcg/tcg-accel-ops-mttcg.c | 2 +-
>   accel/tcg/tcg-accel-ops-rr.c    | 2 +-
>   target/i386/helper.c            | 3 +++
>   target/openrisc/sys_helper.c    | 1 +
>   5 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


