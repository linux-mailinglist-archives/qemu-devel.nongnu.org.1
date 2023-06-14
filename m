Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D172F3AA
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:41:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IId-0004Hq-Ds; Wed, 14 Jun 2023 00:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IIM-0004GX-QO
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:39:48 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9III-000284-WB
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:39:46 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-98276e2a4bbso11132566b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686717581; x=1689309581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QwvFqXH3uw/2BnIRWW3Ck/eHrFGzj+dudoOcpeED37Y=;
 b=uWMpqQU4VCQUrFWqd3Zb6hyzVVjIdhZqz+x/48rgPP422n192FqZqjNwCmYXkWpveG
 tZJe6iwPOuWrOwPjAz0hNUg6vsniE0n9EwdTJeZbwLSC5PObjQCj0KlZJWNJP/lvr1FI
 r18KCb4g/xk7Ej2+6muud/rl5wZe1a3VoyvGkG0kuQKZcl8KURzQd3wZuOeo+AQ+JSHM
 wo86rIIc07fHCCQnQn4EUg2GZ/aEvajdOV4FlSYKEfuk5kwXJP+kzta2IAkE6gTw3r8L
 JmUgQ04npi33zhpw0Y4vV2lLvqb6wbtC0YZErBr+6kFfoCJ7oCgGVCfo5bg+12Th7nzC
 GPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686717581; x=1689309581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QwvFqXH3uw/2BnIRWW3Ck/eHrFGzj+dudoOcpeED37Y=;
 b=cI6ux/YLE425ZmDKWxgw5QYK2P9mulzbuj18YMW7wdCkuJ3op4BGr67PN+zB0cMRVx
 VcCFvQKshJvIsM72msv4fkIyuvTldE+hA+C76knroMHyM09G1GkEfhJgwypE+/kyFj0e
 +cVfaw2TOTrO3UPqQUThvb6wVif66hCM+KH5K6T4BBISaVv46oKKgNIxo8UbTKjHkmGR
 3BwQnETb7+l1ENUYyIeIjaPaVar+HuZmDYZZpNR7N6pNCPzo7EShtnZolwsFuhIoX22f
 pUUghetCDVOtv0iaSFTwpdruAl+NCCHr136lsKml08mRZpaeTr2AD6XZkG3xrM/aT32O
 XAMw==
X-Gm-Message-State: AC+VfDyPREgH6+V5wm/zMXWoK1n9ql6GAJKVatAl9VcEx2ApsNs+9hvd
 1rWG364j30rUUUTh4X7g7JvaYw==
X-Google-Smtp-Source: ACHHUZ5NattMoTZcL8GHM6Fap4cF/YJBF3kEAiNzgyJxBl5bdtcmkYUV8LlWTSva3RdGbGbzGFzVcA==
X-Received: by 2002:a17:907:1ca9:b0:982:3d5e:3242 with SMTP id
 nb41-20020a1709071ca900b009823d5e3242mr4413333ejc.62.1686717580923; 
 Tue, 13 Jun 2023 21:39:40 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a5d5482000000b0030fbc96bdffsm9120610wrv.25.2023.06.13.21.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:39:40 -0700 (PDT)
Message-ID: <cfb54c2e-bebe-f87a-e604-2d658472dfc6@linaro.org>
Date: Wed, 14 Jun 2023 06:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/17] Misc patches for 2023-06-13
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20230613093822.63750-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/13/23 11:38, Philippe Mathieu-Daudé wrote:
> Misc patches, some accumulated since too long.
> 
> The following changes since commit fdd0df5340a8ebc8de88078387ebc85c5af7b40f:
> 
>    Merge tag 'pull-ppc-20230610' ofhttps://gitlab.com/danielhb/qemu  into staging (2023-06-10 07:25:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/misc-20230613
> 
> for you to fetch changes up to b0182e537e5aba38031a5009cb16d5e924342458:
> 
>    exec/memory: Introduce RAM_NAMED_FILE flag (2023-06-13 11:28:58 +0200)
> 
> ----------------------------------------------------------------
> Misc patches queue
> 
> - user emulation: Preserve environment variable order
> - macos/darwin/hvf: Fix build warnings, slighly optimize DCache flush
> - target/i386: Minor cleanups, rename  template headers with '.inc' suffix
> - target/hppa: Avoid building int_helper.o on user emulation
> - hw: Add 'name' property to pca954x, export ISAParallelState, silent warnings
> - hw/vfio: Trace number of bitmap dirty pages
> - exec/memory: Introduce RAM_NAMED_FILE to distinct block without named backing store

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


