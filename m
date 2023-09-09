Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E02799C0F
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 01:32:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf7Qt-00037X-AT; Sat, 09 Sep 2023 19:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7Qm-0002va-KF
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:32:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7Qk-0008V5-91
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:32:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a410316a2so2734435b3a.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694302317; x=1694907117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ny/3tzKYbYh+LHv2XK3yr3VU7m4zenC2g/xsHVCwMbk=;
 b=NOqgMBvR92XPoXSCSjboFHbFZEdRVoAp7AFfMzn/FMf9pNUu4hlW4EckjGKVx5aB/L
 x2R2CV33W+gnIM3T/i6fHEIFXrTp7CzSmKXv37OOpflMthQl1gDiXbpwir++/tR8l2GF
 cxX4HRyQkDWIYXXWPQtoaJicoNCkwb+M2uhvsF2IGUVH3vdnT2zyfgi9vZ3w/Rowow54
 4L8B47KxiPnK6TKe3zwyNUodNtJ3JQw+yZJPWf9nCmC5dY7zQGXMKKuOKH1e7JFFNT7I
 weNyq3F5RFDUZDDXJsuWNf2BRI2h05Nb5eElV0IyOKCNIC73eRUjCJl2yBQILEP6CnH2
 KB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694302317; x=1694907117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ny/3tzKYbYh+LHv2XK3yr3VU7m4zenC2g/xsHVCwMbk=;
 b=GQmbGomzxIDU3PcWK6b+lvZW4GGogRVo7GRpXR0E95m5xEJrpCmAmVFwcQhwoFPEji
 gTsK8Sys/lDUGHfyzfvWeKuc/KGP4MoLcL4QE6dvyCHQ0iRgl4Mzk77ZLeiKXV8plHzw
 miNAN2pYbR5QE9EIuZIpqI5lVpTbnpPdZel7CBOdnaRrwgTHx4I3kIFEfxJWFM3qk2xV
 p9W4h9cjJ2/s/DbkoyMMo3giZUfivQQ2OjRfboC7dOuirsWArBN/tP92NCBi1a87PZUR
 A5nXcwyvOKBdKMscUt3H9QARQoW/eVMW7BwnolvFhVDa5IHsMQLuW8j4m2H8K6XCvYwY
 inRw==
X-Gm-Message-State: AOJu0YwR8ZJVqwyjYo8+BvO45dHhDpOEAWW1Ec+t0vC67xRgqDgFLo+D
 p+0MJ6k0VCcBlL2ESNDe4EW8sg==
X-Google-Smtp-Source: AGHT+IHqTIFUGEBUNTYDjhdnD1TPnSJ+B+rGt3q2m891+GFIwAMI9Qe/tFPqSeZ+MgBx5O2U9BpUjg==
X-Received: by 2002:a17:90a:528f:b0:26d:1eec:1fc4 with SMTP id
 w15-20020a17090a528f00b0026d1eec1fc4mr5109945pjh.19.1694302316739; 
 Sat, 09 Sep 2023 16:31:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 bt22-20020a17090af01600b002612150d958sm5036595pjb.16.2023.09.09.16.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 16:31:56 -0700 (PDT)
Message-ID: <a800682c-19c6-904b-d087-df90591a3927@linaro.org>
Date: Sat, 9 Sep 2023 16:31:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 04/13] target/i386/helper: Restrict KVM declarations to
 system emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org
References: <20230904124325.79040-1-philmd@linaro.org>
 <20230904124325.79040-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230904124325.79040-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/4/23 05:43, Philippe Mathieu-Daudé wrote:
> User emulation doesn't need any KVM declarations.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

