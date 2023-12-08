Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 570F280AB7E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 19:00:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBf8F-0005q6-JR; Fri, 08 Dec 2023 12:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBf8C-0005pT-T3
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:59:20 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBf87-0008VU-OU
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:59:20 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-59063f8455eso1183072eaf.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702058354; x=1702663154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s+eYlpVxarqnvC/OBXxHqC1a/jnI7fUpXf6HXX5KFTs=;
 b=t66XESNjvI1myUb3Udh5jNU+AgHprjoEVX2YnSyX9xiqQy552sLURzdJcsnFH/m0So
 2PuedGSpFXUtTtGKcU/2fv6rNGhvy83/NHaeAH8oyacRNSky+5R0YLWil3tk4AusKu6c
 orwjGo03aW7zBZJcTwTdjdp3eE/kd2irr2UADiAOgjpMrvCJuZ0dbmdgxc9yh4J94PHH
 W8fM4O8cjgA5i/ropxhk7xyzImBoyv8l+QCnZCqK9IFmkg9JmPPeKIM7YEYB8b9Nt8sh
 DlP+ejdBVHMJBvW6fF98MTANDXqTKZWUg7h6FpGtqQrJ9h2Ta+AmRx1dSjUeRCCcHT4+
 vtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702058354; x=1702663154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s+eYlpVxarqnvC/OBXxHqC1a/jnI7fUpXf6HXX5KFTs=;
 b=RyvXpcStGAAFfmtQ5EblME6pSDbjzjhMyFIQCtQmMugzuiJpGMsmH/HkNCnsNqZQVU
 OYnRVumJPmet4byS21sq0//orGCi3o5H3u/L3Kgr1JNpm3Je5mCaBHekoNUbd5gQeK8I
 tdmK0aPdE+nVZ/SZrlx9WVMHSr1omjqhSWXcasipzwgIfycA0+065GQukxxdRD+mVUa1
 l/9uy9JKAiDEoeCMoYzXS0IDDJXXLsfZ8j+LG5kiYf9Rz+CvTJb7VXI1UWCOPFMAXezc
 gtX5dFi3qG3mwpW6y++sz/pwaufkCnEOlb8z80o810PWZeaqwnsivZZ2dRv/+aKSuXha
 5Fdg==
X-Gm-Message-State: AOJu0YzvrQMSWgyc9+Ht9C13mGz+tQYzl0SeeLYP1eaY4AwdgVi3H+bH
 Eo2bzZENUkBP4fG2bGm7IOUaHw==
X-Google-Smtp-Source: AGHT+IGXOKf+wMim/ZnlA2fMLlTTeDr44cAxOxH7gC/N3UpHL8tGlMiPCU9Ra/REPi9acUbevQcf/A==
X-Received: by 2002:a05:6358:c6a9:b0:170:17eb:2038 with SMTP id
 fe41-20020a056358c6a900b0017017eb2038mr251332rwb.33.1702058354341; 
 Fri, 08 Dec 2023 09:59:14 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 v189-20020a6389c6000000b005c6801efa0fsm1827365pgd.28.2023.12.08.09.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 09:59:13 -0800 (PST)
Message-ID: <29557d5d-4d3a-4192-9c76-e26ac312cb77@linaro.org>
Date: Fri, 8 Dec 2023 09:59:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] target/arm: Ensure icount is enabled when
 emulating INST_RETIRED
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231208113529.74067-1-philmd@linaro.org>
 <20231208113529.74067-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231208113529.74067-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 12/8/23 03:35, Philippe Mathieu-Daudé wrote:
> pmu_init() register its event checking the pm_event::supported()
> handler. For INST_RETIRED, the event is only registered and the
> bit enabled in the PMU Common Event Identification register when
> icount is enabled as ICOUNT_PRECISE.
> 
> PMU events are TCG-only, hardware accelerators handle them
> directly. Unfortunately we register the events in non-TCG builds,
> leading to linking error such:
> 
>    ld: Undefined symbols:
>      _icount_to_ns, referenced from:
>        _instructions_ns_per in target_arm_helper.c.o
>    clang: error: linker command failed with exit code 1 (use -v to see invocation)
> 
> As a kludge, give a hint to the compiler by asserting the
> pm_event::get_count() and pm_event::ns_per_count() handler will
> only be called under this icount mode.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> As discussed in
> https://lore.kernel.org/qemu-devel/CAFEAcA-HVf8vWLzmdStEo2NrSKQdZV612rBjiaj-gLW4vXyvpA@mail.gmail.com/
> better would be to restrict the PMU events to TCG, but this is
> out of the scope of this series.


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

