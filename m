Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB16174AC84
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgWx-0001hj-Te; Fri, 07 Jul 2023 04:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgWw-0001hL-LU
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:09:30 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgWv-0002me-3W
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:09:30 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51e29913c35so2197833a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688717367; x=1691309367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WBo378I7rrxtuD1Z6gWA0BdIDvQ4O17uOd5MFVeweRg=;
 b=NadsfN5i+Z3oKeQ3MBX+ybm8sLrHY36v4gN2vJ6KUjDAXZZAIoq8eA+kOHx3Dn/0zh
 t+6vQ8KEA4w2KYbBjVGELbLoCLQAniNlI41zZESZ/bgjeUHYEWeeh/4HDIdSXNE76EC1
 sektdOOPrvlEeGg4Zmk+rfKicqff8lhe4H5UKETKoyUJAa/PHPHXUo9H5RjNRLSaldjl
 /9foMwj+P2OVHQb8H7wVio/fpbpaa59ywPG9Vs1ctTTitYc2oepfbCZ+UusPZwxklXZG
 HFYz1AyzKLKRlWWUzM70pEXGdoINYow7EfNArdg3SkYaWZRwG//EeApxU7MFuA/rqC13
 tPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688717367; x=1691309367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WBo378I7rrxtuD1Z6gWA0BdIDvQ4O17uOd5MFVeweRg=;
 b=JmOkm+1xAjtN6vPay56j6BQ7v4YycwTcWlzx1EBhDF50lm+l3Np+/VfLPlSxgITcb2
 8jyjcvBpCzhJol08AZ2KA1+ssbJxqIpUtjmFISLkBClJzEB4MXA7UTEfR73PCxerTz/r
 QaDORZMFYCLZCZMUSe8QriD6dk9DCx17P+Uy0id7JoZbr7pOBrc0gvowVgiUOqD6xP+n
 ZsPOB3ihu3gIBhlocUFYB6+/6tpW9hfkJFR/ijdDK9tjsh8BYHWVOyqohyPqq/XhbgK8
 9R8jseMjpPgHizVuW6CWpG5Y+zP99s6OOlN3q88D+G4ErT+N2UgZkXk2hadveyIQj7+p
 sWCQ==
X-Gm-Message-State: ABy/qLZGXA9uQtlEn/inZqAzXtiPV+3n05ltZXHqyS3zPkypb/h5YQVT
 IGolHPYP7sjJFuwDm/sclE920w==
X-Google-Smtp-Source: APBJJlFWM/hwtJw4Kz7r+WjZtw5Ww+jqSajkya65cqUu7dNaS4Gxv0kUOgJ21M5E2enhhBZ5ReYjDQ==
X-Received: by 2002:a05:6402:38d:b0:51d:dbeb:1b54 with SMTP id
 o13-20020a056402038d00b0051ddbeb1b54mr3559940edv.11.1688717367426; 
 Fri, 07 Jul 2023 01:09:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 o5-20020aa7c505000000b0051ddf53c623sm1743110edq.2.2023.07.07.01.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:09:27 -0700 (PDT)
Message-ID: <7de8bc57-ffd8-d259-8426-3d8a0c4cde44@linaro.org>
Date: Fri, 7 Jul 2023 10:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] accel/tcg: Split out cpu_exec_longjmp_cleanup
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: rjones@redhat.com, peterz@infradead.org, arnd@arndb.de,
 naresh.kamboju@linaro.org, anders.roxell@linaro.org, daniel.diaz@linaro.org,
 ben.copeland@linaro.org, pbonzini@redhat.com
References: <20230706170537.95959-1-richard.henderson@linaro.org>
 <20230706170537.95959-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230706170537.95959-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 6/7/23 19:05, Richard Henderson wrote:
> Share the setjmp cleanup between cpu_exec_step_atomic
> and cpu_exec_setjmp.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 43 +++++++++++++++++++------------------------
>   1 file changed, 19 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


