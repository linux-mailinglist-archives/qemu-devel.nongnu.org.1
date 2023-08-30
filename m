Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE18B78D505
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:07:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbI6I-0004wC-Ow; Wed, 30 Aug 2023 06:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbI6H-0004w4-Pt
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:07:01 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbI6F-0006zh-Dt
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:07:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31c71898109so4636655f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693390017; x=1693994817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Tosg2bCh1Z5JRIhogsxRv9PUtR83ZMoBZc3GMQdgYY=;
 b=QEmqNplLspPgtzPxs5juZwLPw/rsi2EP+VBk7xWbM9oLj2Jpb/DIH2Hdc2EKzeOLxO
 rEBTR4nbSnxsuxwaS2wGJ5atZYDkKo6tnZBnsaZSKx2WcmU3Ao30W5yIENA1wK3uCq9m
 FjuK0C1qgfBFhp/0UwomBGSZzQ4zcalI7nvOHL7VmwJZNcB6TC7SBLAuIjf22NcyE02l
 PuTXsD8QSxk1A8F7G7hqNqz4wzxISt1Hf6HDAVgZcqmsAY0oFeychPQHVlgCvwNqXzjf
 85OQBBuNrYcxg4F+G3fqAdqGkIGsjZ/2wd5dit9/gxzdPICqdOBLvSufHDHUQmA6ZFMb
 vYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693390017; x=1693994817;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Tosg2bCh1Z5JRIhogsxRv9PUtR83ZMoBZc3GMQdgYY=;
 b=YYvYQI8QiCqqpDm6jPO3BK6nPhQ1rY03Fp7mksxKkylqemhWib3sOjkq+FXihD6x0G
 DE4QjbQmJk6rdB4UO+zDYhKeWhXmLNBXjJU4yCZE75Gtiz6Z0neOrhG+KWolx+bwFod+
 T4EGuey14hJhm7V/Fhxh882xFpZ70wM9RuaVxUg3gB9dSxIu5YOAB6SheCuw9u+mB+67
 TANrZcrxBRgeWhWIi5CuX8nkB6DA95IR42lafY8i8tk/cQjqv0JeHjsAlg4Y/WOxR60Z
 ajOAvq3OYdKKke9I9OS7gKwLamEIoFh5/OeixC+dPyEAjdm+63DAKf2ErkrTvHD4bMGR
 uh6Q==
X-Gm-Message-State: AOJu0YyJ0PDDr3yuxKF9x4oD/E7mrNzDHX2eIDYf/5mYA7u2eQ8eUJ7b
 myPhqtiv15mnau9TAscGLEqxZ2wms/djHwS7OEVZHm1Z
X-Google-Smtp-Source: AGHT+IGEsNRiaITq7HESs/ZqSh+WwpOYYNG2zynWl0SlC29OzOePl9NfRZv33AtwhdwL52AdoK/Lxg==
X-Received: by 2002:a5d:608c:0:b0:31a:d8c0:cb8b with SMTP id
 w12-20020a5d608c000000b0031ad8c0cb8bmr1518861wrt.25.1693390017377; 
 Wed, 30 Aug 2023 03:06:57 -0700 (PDT)
Received: from [192.168.18.115] ([91.219.21.246])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a5d6a88000000b0031431fb40fasm16126658wru.89.2023.08.30.03.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 03:06:57 -0700 (PDT)
Message-ID: <36dd3488-a20f-d000-a92e-1da9d57688fb@linaro.org>
Date: Wed, 30 Aug 2023 12:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] meson: test for CONFIG_TCG in config_all
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230830095347.132485-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830095347.132485-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 30/8/23 11:53, Paolo Bonzini wrote:
> CONFIG_TCG is not included in *-config-devices.h, so the test is
> always failing.
> 
> Fixes: 74884cb1a6d ("qtest/meson.build: check CONFIG_TCG for boot-serial-test in qtests_ppc", 2022-03-14)
> Fixes: 44d827ea69e ("qtest/meson.build: check CONFIG_TCG for prom-env-test in qtests_ppc", 2022-03-14)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/qtest/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


