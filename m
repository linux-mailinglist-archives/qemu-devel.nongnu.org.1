Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD055807558
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:39:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAuvY-0006M4-6D; Wed, 06 Dec 2023 11:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAuvW-0006La-9U
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:39:10 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAuvU-0003tV-NQ
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:39:10 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6cda22140f2so10040b3a.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701880747; x=1702485547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EUZWHHAwXpAAevZaTujXzayyM/Rg83+ExbJL6VPIziY=;
 b=UHIo2co9+QpZhX+lTBVhRoUHMBfQYtuW/UB4Mtb6CPO1Hj2M42jfmfhx5d1Gj8gAXV
 ktXadiG5Bgnso3pvFUo2FQm8afAqtG4IWGdcHZNEL3u6ntTyhZIQ9OLLCwPGw4yBMeJz
 6LFttk4mND2W0HKQNAb0uznnrZeootZnbw/WBB+pkV5dvGMtvl+I7PJT5XNby1/nm/F9
 R2b2fLFyIUsw1xyXMdVgKQn9HUjCUU6YSSFH76dabwzVaQl7YQAaSpbfyNZdgjSvS+Cz
 3hUOVMC3gxUyWaU8aztih7PF/Iqc1z64/AOHf1zPo3MQ2QMEXw+22pv0wbF6sJp6tE+6
 zlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701880747; x=1702485547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EUZWHHAwXpAAevZaTujXzayyM/Rg83+ExbJL6VPIziY=;
 b=BCJ4nxhyKdUO4KkKJgNCzJNe6inBECC1vfb5XSkPQvplkwUewM7NyKdEOw3S77PyQi
 5GrAAD+X5C2zVX/pjNL2pbDRxjKwSIlTrEp+LgLSLiVeBinZDv8VkLX+AFmj88zfxcPi
 3xzc6B50Z+FhZ1Zb2RropQfPO+/fjQcIHPkm70IZ86MiJcr+YP8pJeObMSrL0vjCVb+4
 eBq4KbMg3IsC1Kcx+hscpFT603c2Pj9K03ZoztB/DCgDHZ2KQ5v/b421MoLwJ5D2fqKc
 gfEq8ZAWsethRlYap94KAktAn3pQDDBx+UBFIr7w+udn66Rvcc8LiR3WFzknfpGje1/Z
 an7w==
X-Gm-Message-State: AOJu0YzaY5xdfYwh1G1nvPZ9M1HEjvfr6quGWXX3UuInNk8lIGZUrPnr
 CedK+CzZQyjarl1AO+xUfmjhhw==
X-Google-Smtp-Source: AGHT+IHEr80+C4vePjZkQvTTmY6+NdtN2e5nes3dPDaA7t8g88PK2oCByV73yAhuFQ9mBzU2/4bJCQ==
X-Received: by 2002:a05:6a00:1345:b0:6ce:4018:a726 with SMTP id
 k5-20020a056a00134500b006ce4018a726mr1455295pfu.62.1701880747345; 
 Wed, 06 Dec 2023 08:39:07 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a63b801000000b005c19c586cb7sm124320pge.33.2023.12.06.08.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 08:39:06 -0800 (PST)
Message-ID: <1adaabfd-3451-4f51-9479-7153c9642dab@linaro.org>
Date: Wed, 6 Dec 2023 08:39:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] replay: remove host_clock_last
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231205204106.95531-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/5/23 12:41, Alex Bennée wrote:
> Fixes: a02fe2ca70 (replay: Remove host_clock_last)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   replay/replay-internal.h | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

