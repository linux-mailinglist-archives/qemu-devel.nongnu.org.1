Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 616F877743C
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 11:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU1oJ-00048v-3a; Thu, 10 Aug 2023 05:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU1o9-00042G-I0
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:18:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU1o7-0000Oe-LF
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:18:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so6074115e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691659093; x=1692263893;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MBdVHirNXgRmSuVF99QvdHBq0xUrRZDq/GlpbFzl0yA=;
 b=szSpctEef+yzg8vnVsIk+G7f4iPEkbBusXqJuwrqh9b03dTJymgcaOuMQUf7o5daai
 3mQJzk2eoV0p40LsbXT6ulnW6gh/xS2hRju4HEFszr62cXp7vL4m2C1l6ifBzQiXRQdk
 SSfpO1aKIHQhrzs6OsUFbwnMlqLMtKazH5OukZEeZuSrqkPuqNIU2c9kdZ74qutXy+6Y
 Mhr+elzS1ccBnnSmeiwc3SI34UN9eHNXnTP7qnvxgJ+eDbh9WIaneG5a4N0fCiiCfOTu
 BhUXH//U05ZkIC9oLyYkRqjZxa8T9FgESAAX0IjVN9mJbkPP5CVh9UgIfRZ3pXDmCYay
 EGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691659093; x=1692263893;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MBdVHirNXgRmSuVF99QvdHBq0xUrRZDq/GlpbFzl0yA=;
 b=c8qqXTf/xRVSSbJuD5+zwRvWLxiy30Q92Cp+vyIJ+E90PI/HDVsui1JJAWG1GjRmhO
 3FEwGz34MkEXwU56Tn+GxtnN/jLUVOEt1natkw8UJ2tOo1+rrDyEO+tRUvgDnVdGeO6N
 cqchZ0qcsrFB5XIadBD5BQZu2SzGeZX6Gs75kEI4PABGrJXRT5Ocbeyk5A3sGO2RiTGQ
 KK/YAN99+9mdEbK3pSq0Q8nAURpOY/ZS9NOK8UWqya/sFySFqIdSJ8mPg8B7W6WXLWYM
 WqIWnECEBkkgE5W6j35ZdLZ/bnV1vMUeH7qcLo8U2k1q+Co7H52pCQiwEHPxnOogoAPA
 O8pg==
X-Gm-Message-State: AOJu0YwR+LEudLkbBOWk7R5GvV471Vs5weO8PgHYHEDH/cSHx8x3wP7g
 C+jr/tY7XutYwWVHrezekfPbVg==
X-Google-Smtp-Source: AGHT+IFUctqjaHhL7Sxzl5O5+Ihcltgpb96DKiLbiut+qEN4QllxYZxYdpSpWwOt8OzRCc2oRm9d4w==
X-Received: by 2002:a1c:7714:0:b0:3fd:30cb:18bd with SMTP id
 t20-20020a1c7714000000b003fd30cb18bdmr1548286wmi.15.1691659093234; 
 Thu, 10 Aug 2023 02:18:13 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003fbfef555d2sm4341476wmf.23.2023.08.10.02.18.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 02:18:12 -0700 (PDT)
Message-ID: <5ecc9d84-bf6a-22f5-fc06-996dc5bec334@linaro.org>
Date: Thu, 10 Aug 2023 11:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v5 6/6] accel/kvm: Make kvm_dirty_ring_reaper_init() void
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-7-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230727073134.134102-7-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 27/7/23 09:31, Akihiko Odaki wrote:
> The returned value was always zero and had no meaning.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   accel/kvm/kvm-all.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


