Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA36729F84
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:01:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7a4y-0007hz-At; Fri, 09 Jun 2023 07:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7a4w-0007hd-Ae
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 07:14:50 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7a4u-0007rZ-Nk
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 07:14:50 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f642a24568so2021532e87.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686309286; x=1688901286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+3LAhUxotuY5R4Iip7QpvQDuZPru9h4ppdfcex9TmXA=;
 b=h06IQQYMr9x4KpuInOeIxlJRkjOa9nV+8egs7+IacpSfXUS6mX+5N4TE6gvXQJhHfL
 V6L5PsBIT43Lc43DIUIXRMFBOi4yXidd9OGsC2gWWF+TVyzxY9nc+p2290YG6kqQ8CYF
 tQ7Fgp3TeYpHe5s9JlBX2rj29ZIZ8ucMp57nVih6IWgDbfICU1tRFtstXvj8V/haWhgw
 S6o7M07j65PEI/iJEvbbaiQANqqDdHAyg3xXKM6y99HqpSj5ilF5wmKvpt0fAw6pokUt
 gjY7He4ARSanBurbs/R6HUH9t/dkf80wrFUC0BeZVLqKfaC+IstyOBTU22e8Z8Drbf0e
 RpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686309286; x=1688901286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+3LAhUxotuY5R4Iip7QpvQDuZPru9h4ppdfcex9TmXA=;
 b=gaSeR96yS5DtAtWGNGo59VPPqZ/KU/SEVsUXLg+xOr/YnKg4eRye1L1lfPGApRaYDW
 2Nu5TVX/48ypXnCA1rgS4EcXyGZw15ObIQOVMoLHEx+wt7AsVJFmLXzIsSTAu8j/kSXQ
 OP18nXNO/pS/YkgICT5Azf82CKmHrDrE6KqGDGRRiTXiFF7rqPA5BWhpb7mpOm85QOWz
 oJzMWbdf/BD6lvQzzfQXX+D9cPadE575yR6xRDMCky+eC59pQlbThTxpMaAAa8VZZ1FX
 Fkt0CYlwOoYT6MiQtQBUD/91S6eNgKOXzYI8AX6A/ckAhfTIGPw9AQeHy3chlths/V47
 wCbg==
X-Gm-Message-State: AC+VfDw0RXXWG6V/RLeeVdHi9ZaN1cJVh9ad+WWiF7rhO9aREzedmqUe
 0KoEpI2GqS8HGCOdJlSD686z1DBZ2khoAAFJ4nveBA==
X-Google-Smtp-Source: ACHHUZ5C+o0+R84hlprOAK/Vl6hBviuBEfrdbbh6Zt9dT9oOKaMo7AzDT/YjR5ysVe+wvNKGzBdcjQ==
X-Received: by 2002:ac2:5bd1:0:b0:4f6:2852:5f56 with SMTP id
 u17-20020ac25bd1000000b004f628525f56mr754037lfn.18.1686309286638; 
 Fri, 09 Jun 2023 04:14:46 -0700 (PDT)
Received: from [192.168.192.175] (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c230800b003f7ed9dae70sm2433595wmo.0.2023.06.09.04.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 04:14:46 -0700 (PDT)
Message-ID: <12f7b5ec-708a-0dcf-f80e-58581cf66761@linaro.org>
Date: Fri, 9 Jun 2023 13:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] build: further refine build.ninja rules
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230608134314.943615-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230608134314.943615-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 8/6/23 15:43, Paolo Bonzini wrote:
> In commit b0fcc6fc7fc1 ("build: rebuild build.ninja using
> "meson setup --reconfigure"", 2023-05-19) I changed the build.ninja
> rule in the Makefile to use "meson setup" so that the Makefile would
> pick up a changed path to the meson binary.
> 
> However, there was a reason why build.ninja was rebuilt using $(NINJA)
> itself.  Namely, ninja has its own cache of file modification times,
> and if it does not know about the modification that was done outside
> its control, it will *also* try to regenerate build.ninja.  This can be
> simply by running "make" on a fresh tree immediately after "configure";
> that will trigger an unnecessary meson run.
> 
> So, apply a refinement to the rule in order to cover both cases:
> 
> - track the meson binary that was used (and that is embedded in
>    build.ninja's reconfigure rules); to do this, write build.ninja.stamp
>    right after executing meson successfully
> 
> - if it changed, force usage of "$(MESON) setup --reconfigure" to
>    update the path in the reconfigure rule
> 
> - if it didn't change, use "$(NINJA) build.ninja" just like before
>    commit b0fcc6fc7fc1.
> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   Makefile  | 17 +++++++++++++----
>   configure |  1 +
>   2 files changed, 14 insertions(+), 4 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


