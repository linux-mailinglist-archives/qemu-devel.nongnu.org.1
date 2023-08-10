Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD0C77744C
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 11:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU1pK-0005MU-EI; Thu, 10 Aug 2023 05:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU1pI-0005MF-Ln
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:19:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU1pH-0000Wt-9O
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:19:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso6166755e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691659165; x=1692263965;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wok+Pb9fiOkZwEwM1AKW0JzsbHPjqCpjF/vuHCX2Jds=;
 b=xCpHOCI9wSYk/oK5s2Gf07WLLu/MZ/7xbbGChV1cmi4d6A3Mbt7dD7d1XFeYZp0sI0
 EoTlVfzmidlBdU/NNaGCMkr+wI/hh2S+UeZ9pgcnd8sVuWaZfYseiH66lnbR72kxZ+x6
 vgQnEbVSlfhgDzLUpXemwKdvDQODnzvi+IxFkP5IExDDTBvWZNywAvoQTEu9hQSP16Zn
 QPE/onzWoU/9VsN+XGXdByMJQXb7ktgAs6kHz8xI/B3CmQxOh/pE5NltRsaQohWc8ImN
 spRTE4kFIRY1D+/8ELP8u+48TFGuewhcyMx1VF9w8fvLz8QIcugpNAFb+vc3BEIOGJ9e
 Pvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691659165; x=1692263965;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wok+Pb9fiOkZwEwM1AKW0JzsbHPjqCpjF/vuHCX2Jds=;
 b=gocUrZsHQ14flyF7ZhigGvmG3h5purara/aXgQHZFPDltS1I3GhHQtce4FAYg5fgpi
 A59PnRlN6foKzu1V+8qCrPwsSYRyHvCDP2Jp8AstWvciglkThpR1vHUMujbRwmezUw7o
 1M1FnU/GRY8Ywcd5VHzD5Bqz2sdjCJUsil8ni9A+CxCdnZpieZEo4ee4XlWDEiD53t3a
 3uOpbmqm29PIFh4lVyhOBNbYnCNU/tf/KheecWjmOYgxsq/q8gQ/5eLV5U9a0gMQqn8x
 s+Ibx6T8oIRYc23PdVbV4VN1Leb46DqH9OE9Y8MwBf5y1abu7zdnVz07qHV4rYwsWRsU
 cb1w==
X-Gm-Message-State: AOJu0YwRimXhWnwSlwJXY3E9cR1ocDlx7vZzrNJ2bMyc2wI66+RdQpUZ
 EoBTsYtPPDK/AlbLag99EKnEgA==
X-Google-Smtp-Source: AGHT+IE362b2UK8VE7RTczunKk4zqBdLbV31VFFDAuFXwcp8VaZT9hDI/K29iqBr27EqdeoAqP89Lg==
X-Received: by 2002:a5d:5150:0:b0:317:618a:c72 with SMTP id
 u16-20020a5d5150000000b00317618a0c72mr1748150wrt.64.1691659165318; 
 Thu, 10 Aug 2023 02:19:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a5d4388000000b0030647449730sm1499723wrq.74.2023.08.10.02.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 02:19:24 -0700 (PDT)
Message-ID: <509ea8c8-a9bd-ca90-ee07-832039a5bd25@linaro.org>
Date: Thu, 10 Aug 2023 11:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v5 4/6] accel/kvm: Use negative KVM type for error
 propagation
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-5-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230727073134.134102-5-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
> On MIPS, kvm_arch_get_default_type() returns a negative value when an
> error occurred so handle the case. Also, let other machines return
> negative values when errors occur and declare returning a negative
> value as the correct way to propagate an error that happened when
> determining KVM type.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   accel/kvm/kvm-all.c | 5 +++++
>   hw/arm/virt.c       | 2 +-
>   hw/ppc/spapr.c      | 2 +-
>   3 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


