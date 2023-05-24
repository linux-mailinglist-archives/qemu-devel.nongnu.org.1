Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2F570F2B4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:25:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kkL-0004LA-Q5; Wed, 24 May 2023 05:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kjz-0004Gu-Ja
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:25:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kju-0004Bc-2u
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:25:06 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-309553c5417so530564f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684920300; x=1687512300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cO0vhEGfHnOnT71l0MBhUVFt/2Ckcj1BwmnV7jssmEw=;
 b=bsatXrpie+xW0XqmkvlmFo0gVYAVar2/zez3JNUhYP2pKuPV3SzNmr+NnJxnaP/H95
 7QL9DmKiLybEr8JxagGeiCQTjb4sh9uNt+7OnGADn7mjbvhwA+bdDxdhARLUd53PV3cz
 p2Yqz0D7mkf6n6CSEHQRR3zEGxpeGDAw6m9/yxs8Dm0rGRWkDlw2l+7WgRFqRGJwlHp3
 9NpYJnyGkiZqMwOI3P2fhI9fbrE4PmF3DHRKKno3QCRCDLeAUXH1lRNZ8MYcnjuAteRt
 5OAO1Ry+iwkWy4o8ytp8/fYEWziJLU/B6vqnzRcmw6GicDoDIVrCpcpsJv9QX5LK3SPy
 TTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684920300; x=1687512300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cO0vhEGfHnOnT71l0MBhUVFt/2Ckcj1BwmnV7jssmEw=;
 b=GKEXoGC0WiaXBAsOLzpW68iVvZX9HdSvZmFvbzYapKIkfGtgb6u6TvL7ryBZGoX1jl
 c0iSncEISvupR0yOMppj1wcsgEeUYklMtonIY7N7YSDsapHiW+QcGnxzvANGFMOuznY7
 JB8SjJoJNVM22Z0s2VRZ/5qZYsGg7aX95yTu6lqqlSgbFqxww+lAxsHfneJWSI/a+TFL
 Zv1X33bstYvNp8gM/ZtrC1zKegsK/kHOK7LFCZ0WD9LugMRaeEqQ9tRLLCoGWdhvRSKm
 lGuJK9w+b64hxnoPYuvs3uiEPBqn8CavPcn5eL+aeBRtT/2sgME5XMCSl88HAsaiKw+o
 bDhg==
X-Gm-Message-State: AC+VfDyfmGRnuKTF8gUyzYP9+aSJcFloW7hA4hI4hAgVe53GJf4keSNt
 ATM+8Dxt36JAzUF4hDrnqQLUEQ==
X-Google-Smtp-Source: ACHHUZ75pAVnZMH2npF8qm7Gr+h1T15LTsEERw+UZ7v9rOcjzwhXHTfJQ5dzcV5j8lSDAeigWSwXHw==
X-Received: by 2002:a5d:4b89:0:b0:309:398e:de7d with SMTP id
 b9-20020a5d4b89000000b00309398ede7dmr11632951wrt.62.1684920300512; 
 Wed, 24 May 2023 02:25:00 -0700 (PDT)
Received: from [192.168.69.115] (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr.
 [176.184.31.246]) by smtp.gmail.com with ESMTPSA id
 b9-20020a5d4b89000000b00304b5b2f5ffsm13732096wrt.53.2023.05.24.02.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:24:59 -0700 (PDT)
Message-ID: <9b9f8f88-60f5-1f8e-454e-a189bdd55350@linaro.org>
Date: Wed, 24 May 2023 11:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/10] trace-events: remove the remaining vcpu trace
 events
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Riku Voipio <riku.voipio@iki.fi>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
 <20230523125000.3674739-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523125000.3674739-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 23/5/23 14:49, Alex Bennée wrote:
> While these are all in helper functions being designated vcpu events
> complicates the removal of the dynamic vcpu state code. TCG plugins
> allow you to instrument vcpu_[init|exit|idle].
> 
> We rename cpu_reset and make it a normal trace point.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230503091756.1453057-3-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20230505155336.137393-3-alex.bennee@linaro.org>
> ---
>   hw/core/cpu-common.c   |  4 ++--
>   trace/control-target.c |  1 -
>   trace/control.c        |  2 --
>   hw/core/trace-events   |  3 +++
>   trace-events           | 31 -------------------------------
>   5 files changed, 5 insertions(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


