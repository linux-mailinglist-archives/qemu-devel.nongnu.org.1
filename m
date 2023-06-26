Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A673E18A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:05:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmpm-0001Rp-Dn; Mon, 26 Jun 2023 10:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDmpi-0001Ou-1R
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:04:46 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDmpg-0000Vg-6H
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:04:45 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f867700f36so4466035e87.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687788282; x=1690380282;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8SH1fd1ZVPL4DsZ+5IhpMSIMdCrm9ATYK6CHM+nnvvI=;
 b=Aacq2u/1WiH0BLjKSmrQtyHnbgBaP7dbuv9JSB/46uuLq6pN8ZaJ7zFIRJItk43nRA
 Zv/n9ATTc2x/7ZEQMjKfzczuTgitg+e1ArpveoMwV+hE/8jB75kGfGdUj4y9NcbqWDi4
 uglhaGhIMDvjCDI2W48UFYT+3Cba3otWN5kEnnv2sZs5M0hVYgqtH1P7uEwcyt0/K8g4
 FTZnHmnPjR0gyI6HlzV0cScRiicON8ld7ujX+nL02+rneJioxd3SYFOMFuXgHe2/djhJ
 jL0l0kC4kCtjUUDmF9pAMQI3a/SK5qeYB5JmiUClZ6nFTYmMkb83etcVMrzuwx/OztSm
 pmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687788282; x=1690380282;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8SH1fd1ZVPL4DsZ+5IhpMSIMdCrm9ATYK6CHM+nnvvI=;
 b=CjFvK8aHTKOAG5xfreNhF6Ji/QNgPtb+7VdPLtE4CQE4E1C4Mtnllc3kLMZTm9IAhO
 l4goRXpkzwSV314b+AiLiDTAp+5YCGFenKdPnkyUp4jD3MIUJMiez7p6Ij9mmhIRQYkQ
 qCUlu4B0LDbk0k1tCTv13McIu/GWoeNryBSFRov4fZJszGORp5IXS9YZ4JaTJKuVgwem
 DhEAX7XfNZgAXYjNksS7cDD3DKI3/BVldEJnWaTgrzttGx8+SlgJwP9+SsY2VeiXK+vs
 OghLbUgwru7ylaadJptwIOonciRQyqIcu51FqMB6S/ljIZ0hobq1dfL/Zc88SaeXOsg6
 ZObg==
X-Gm-Message-State: AC+VfDy+b7tmJzlczWup0yayTw4xo75FTWlobuBLLn22Fw5sOpJk4rmb
 Ih06opsSxPk6VwNlBXwX43hF3KkjZT65fmF4fHfe+bsI
X-Google-Smtp-Source: ACHHUZ5tibWX3NqzVJ0k5akQtDunV73JZWIX1iDt5G0WsrW2TC/3OEQkJRXayWp4o9FHlhtCwE8MdQ==
X-Received: by 2002:a19:661a:0:b0:4f8:418e:1e49 with SMTP id
 a26-20020a19661a000000b004f8418e1e49mr15160245lfc.16.1687788282229; 
 Mon, 26 Jun 2023 07:04:42 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a7bc399000000b003fa96fe2bebsm2902815wmj.41.2023.06.26.07.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 07:04:41 -0700 (PDT)
Message-ID: <d9d51a8f-9914-2416-40c1-eb0ddc1b4650@linaro.org>
Date: Mon, 26 Jun 2023 16:04:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/18] Misc, i386 patches for 2023-06-26
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230626111445.163573-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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

On 6/26/23 13:14, Paolo Bonzini wrote:
> The following changes since commit 79dbd910c9ea6ca38f8e1b2616b1e5e885b85bd3:
> 
>    Merge tag 'hppa-boot-reboot-fixes-pull-request' ofhttps://github.com/hdeller/qemu-hppa  into staging (2023-06-25 08:58:49 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 8edddaa23d75c57e093d99bf098a39f8cbd227c7:
> 
>    git-submodule.sh: allow running in validate mode without previous update (2023-06-26 10:23:56 +0200)
> 
> ----------------------------------------------------------------
> * kvm: reuse per-vcpu stats fd to avoid vcpu interruption
> * Validate cluster and NUMA node boundary on ARM and RISC-V
> * various small TCG features from newer processors
> * Remove dubious 'event_notifier-posix.c' include
> * fix git-submodule.sh in releases

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


