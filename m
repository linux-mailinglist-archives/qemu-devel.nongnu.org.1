Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88312771119
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 19:44:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSLIw-0003LJ-HY; Sat, 05 Aug 2023 13:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSLIu-0003L5-Eq
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 13:43:04 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSLIs-0000vA-RV
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 13:43:04 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5646f8ac115so1844200a12.2
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691257381; x=1691862181;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4C/XfVA0L5whV04YMYnQZ3hJqVZQgJqXP06rMiiVB8U=;
 b=YkG6Q7i6Qq81Vsi8RkvAzQM/yLp0RUZZRTHsbbhB9tapZUVXyFF+daUKkXuR+5dtez
 UlH5/Lgsahaz4uvAo9PdlNm7HT1Pcu2r9CiWbXWiFRCzkw8pfl5bX4xpFrqwZWoAQd//
 BF+oZmp2cIejnp9AUCsiF1gvs5N+8K7iAZ1iKUj2eeqzYDiUGtyijLhS5LBihEYVc8tM
 IbxJ/L/Uposb1DRd0o4YiAsE5eGPZG7YoVba5YfhQCrOPkCnFvyuh+3Mv51CDc9EIJYs
 fcAr0+L1oWx3WEyST9HAxcMVUm8ZS7jTjtCF7eMfi3GmpxtyLKkVpNJCrpa+bIu69D9T
 tYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691257381; x=1691862181;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4C/XfVA0L5whV04YMYnQZ3hJqVZQgJqXP06rMiiVB8U=;
 b=YawJ0/DSIqBXysnu3PuZxOjS0bzu/H64G1btpzkYQK9C6Td9aKcCxDNU6up+JHug/s
 AROeKxxaD/68q2UW6o/PpgOVTQi7OS53jzjCDSkWx8q6Pqe62M7OPiHSznc0A7JavmoQ
 V7u/qCfCegM6OVy3awwzsMusRWlP/i+3Zeu64tSCxld6Yv3UTGkGq0/gTnEuot7z9z8J
 Tv4bXHQgYg8JqcKzf6/l2Kb8cZzdFN6PE4l3m+3sB3mSnQGJ3mclG2qZRXTKrLBGwqjv
 80qFtb4EdZXg8FIMQYCBjyjWuKPQ6z2NrVE6ZYdZvquEUMXCfrwHjy1twT+3YxouvBPX
 ckpw==
X-Gm-Message-State: AOJu0YzL7tFtJoZn6OEOIWVPkiwg5e0rKa6OjJRSUxQntffsCo9rJBF4
 lR4qn/uzc+inlrSEByjdfxx35g==
X-Google-Smtp-Source: AGHT+IHq47mWF3Cg4bCXhTIfVvmQVbDcJEmU3OYUTRTV86LzX+SCCyasiXH6lPoj1B+FlOcMOGLvMw==
X-Received: by 2002:a17:90b:ed4:b0:262:df91:cdce with SMTP id
 gz20-20020a17090b0ed400b00262df91cdcemr3608334pjb.23.1691257380721; 
 Sat, 05 Aug 2023 10:43:00 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:9454:a46f:1c22:a7c6?
 ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 30-20020a17090a005e00b0025023726fc4sm6462913pjb.26.2023.08.05.10.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Aug 2023 10:43:00 -0700 (PDT)
Message-ID: <a607f987-b6cf-47ef-f483-05748c573431@linaro.org>
Date: Sat, 5 Aug 2023 10:42:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/2] Fixes for x86 TCG and CirrusCI
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230804200715.430592-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230804200715.430592-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 8/4/23 13:07, Paolo Bonzini wrote:
> The following changes since commit c26d005e62f4fd177dae0cd70c24cb96761edebc:
> 
>    Merge tag 'hppa-linux-user-speedup-pull-request' ofhttps://github.com/hdeller/qemu-hppa  into staging (2023-08-03 18:49:45 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to d9ab1f1f4d79683b2db00b0995fa65530c535972:
> 
>    ci: install meson in CirrusCI KVM build environment (2023-08-04 13:56:17 +0200)
> 
> ----------------------------------------------------------------
> * fix VM build jobs on CirrusCI
> * fix MMX instructions clobbering x87 state before raising #NM

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


