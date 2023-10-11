Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D627C47F0
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 04:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqPDG-0001MS-8B; Tue, 10 Oct 2023 22:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqPDE-0001Lz-B6
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 22:44:40 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqPDC-0004wi-Re
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 22:44:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9ad810be221so1069982166b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696992277; x=1697597077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0r+nZWjXBLko/PJ79KzGJfGzh06JS4c3rSs5rvlxLDw=;
 b=lynSyrV0imCi3PFCd6wLwUkxyjZxrHLNa3Z6731ujvS2ujIzIAxdUp3a0l9te0G/of
 s6HqcGCqyFUgr4kZ0e/u76aicvOYSs3RCZFEc9XLZlUrdaDyAjIY91+8Zny1b9NXN2Au
 l7PzyRhsYhY1xLAUauUWH/xdQ5E8uCJfpdQ3zAH/SCs0NkjO5kpGjuWNYtdbwbFgvTi+
 DWF0SSBJriV3yILeKaH3SR1aJuoyltd3rjUPXZXnQUBQeljZ50GYy3O8quhyoJB4hPVj
 icsqEKP4rBYCrEYCQoboDRGQP741U0JxCn9YbcflRRLcdOXmpcpr94KDLcwoetB6JZpA
 f5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696992277; x=1697597077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0r+nZWjXBLko/PJ79KzGJfGzh06JS4c3rSs5rvlxLDw=;
 b=d9uF2M9FeIShLJjnbtPkrelpzpF454QHGl3aNWP77o9bsa8w6sDIEUrm0oZ13hHDK0
 W3bhoDLYLdvWwrwFepgIG+v6VBYxEPcrSG2kxzUemWPhXtG3YjEVHv2vf14fR+d36bzJ
 AUNeatlJEOxnJ29ntdL+NQc7n5VLoPdU1Ry1TFdVh/YUfMMHNHjJJJY6dsgNHAK0SYI6
 VrAKYS+WikLo0vSNHYTkVhL1Wtj55aCI3o5VFm29QFRnoMaTuHwg0DNCj5mPkp74cEJ0
 HSKq3qLGE3aAd1NtCMlltW+Gqdjd1Egr63xtebe5cE+GhK0seC+r4sGtqI2SPadgjrfx
 Evig==
X-Gm-Message-State: AOJu0YyHnd3aMiw0QRycm9i6px7mdgirpC7SsSKssk5e3mz4xgYGT5P+
 scLOEynEnwxluFx8E8JbJasAiw==
X-Google-Smtp-Source: AGHT+IHn5OjHsqC+pVhmsNeJfFsxD6RA15qMrzm8K/7dPbCAKIz/7HIjI++t9SZcxMCe+yc7oUTVag==
X-Received: by 2002:a17:906:3012:b0:9a2:225a:8d01 with SMTP id
 18-20020a170906301200b009a2225a8d01mr17885725ejz.7.1696992277404; 
 Tue, 10 Oct 2023 19:44:37 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 gq7-20020a170906e24700b009adc5802d08sm9208149ejb.190.2023.10.10.19.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 19:44:37 -0700 (PDT)
Message-ID: <e3e0a6c6-8125-f010-de73-7fb3ce2d8a88@linaro.org>
Date: Wed, 11 Oct 2023 04:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] arm/kvm: convert to kvm_get_one_reg
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20231010142453.224369-1-cohuck@redhat.com>
 <20231010142453.224369-3-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231010142453.224369-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 10/10/23 16:24, Cornelia Huck wrote:
> We can neaten the code by switching the callers that work on a
> CPUstate to the kvm_get_one_reg function.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/kvm.c   | 15 +++---------
>   target/arm/kvm64.c | 57 ++++++++++++----------------------------------
>   2 files changed, 18 insertions(+), 54 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


