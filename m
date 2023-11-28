Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 259887FBC14
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:01:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ydY-0003fi-BA; Tue, 28 Nov 2023 09:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7ydC-0003ck-8o
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:00:09 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7yd6-0003kv-7T
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:00:03 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-58d52e0065fso1445942eaf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701179996; x=1701784796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3SjKfuFYTY/mxOG+u2Dtw248AAIeHfRAB7xWDJc9Dec=;
 b=iec/1zxV12XtUwwRdJpo5/JJKuLPEM1EhTDu85KB3ARAJe+RCOllU8YpPB0SE2KbHv
 nKOl9yUs2XgN/7NUWSwYqTDD5jNvbCoye1TsU8vMLONQB2YZNImCrUfYUoWN2CTQdBh5
 E1hDSe2RzkazmdnLr798sTzcAN41p1TM5Qaw0oZu8q8hpYZG7Zbr1+ee2dJB7ClOfoaf
 ilC9SG3mxr+4Zobc7DMlPDuIRwIkH/av6vGPBmJQW4Lv1UB+uxldHc0/Pv0/YzbTGYwC
 2sIB0Wic9u2+gi2zjFloIgVjdWio6rxOFHKrWEsJmjNwDxiaZ8pxQ7A7oT6LbDOArcA8
 dKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701179996; x=1701784796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3SjKfuFYTY/mxOG+u2Dtw248AAIeHfRAB7xWDJc9Dec=;
 b=BwRW1qfyxDJsdTm2GdGw8SHQEyXQ/VGzdPfSAU+6PmMTEd5AM6I2SS4KTXraJW/Nt8
 IKyGBY6vl1bGyjEAueM5ZouNMZtkJF/Oow1hxujqkHxLY4Ns5CyGziQRFmMH6LAa2bZt
 PIrDkHqUhxmhXdOXkcaekvmGTsBSuHK9KvOk7GdDQE5g41E1aG9dAhvU0albMul4II57
 dcX2TNxkrW+SgSQRdQI2IRWtklySMVcC1ymFNd3FdvRE4XIifWMBPr4wGTNVuE6evqaM
 B5Z4ipDs+9VViZ2iyKvhVjCDQtF7tmY6Uqudx2skaZgSFvBA0g7/Jbs9PmgJTOMAo74u
 vHGA==
X-Gm-Message-State: AOJu0YwWXxUShkFh2JXPYBBWRVN1yNPKWcbaQl1Mvmli682mb89nX98X
 oUhgbZ9HmCRGBlD77bvEsIZx5Q==
X-Google-Smtp-Source: AGHT+IHJTLTGV5zkPcsqTcvMES7nj8znt++o6Y2jWEqkx0qOT6SdX9eKNkZxXctb4Hv3vAd0u+biug==
X-Received: by 2002:a05:6871:e803:b0:1fa:2cee:bb1f with SMTP id
 qd3-20020a056871e80300b001fa2ceebb1fmr5346811oac.20.1701179996237; 
 Tue, 28 Nov 2023 05:59:56 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a056830164e00b006ce2e1a6cb2sm1678579otr.44.2023.11.28.05.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 05:59:55 -0800 (PST)
Message-ID: <e96c8677-5cf8-489b-b27d-9d8c1c30e2a9@linaro.org>
Date: Tue, 28 Nov 2023 07:59:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 03/11] target/arm: Declare
 ARM_CPU_TYPE_NAME/SUFFIX in 'cpu-qom.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
 <20231122183048.17150-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231122183048.17150-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/22/23 12:30, Philippe Mathieu-Daudé wrote:
> Missed in commit 2d56be5a29 ("target: Declare
> FOO_CPU_TYPE_NAME/SUFFIX in 'cpu-qom.h'"). See
> it for more details.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu-qom.h | 3 +++
>   target/arm/cpu.h     | 2 --
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

