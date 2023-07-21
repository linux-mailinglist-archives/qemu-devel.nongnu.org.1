Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E778975BFC2
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 09:31:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMkc3-0006Ql-50; Fri, 21 Jul 2023 03:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMkbw-0006EX-5P
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:31:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMkbu-0002Rk-MA
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:31:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso13520885e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 00:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689924693; x=1690529493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uQIm7uYenjZmyjjSRk64DJrLqfepX4T6j3z768nF+78=;
 b=LdtjuQXkvv4BoW2QNfbVqMWkMg5BLX7NbIYYjMScjkvIh7lflGS0JDFs0D2jvMQw/d
 G5l1nl9vS0GgI5xeBSLlu8Dy8SzKekkRSzaohzR1bocl22Ngk3YWw9hNxGJg0KbYEccy
 qAzB5tIazyhniShOWox010IAoUYn2nt/M9yK4K66JY10f6sgSOsLaJutuXWaRnKk5OVD
 ISejcrKtPScZLnohSvFNPeZm9ctGTkyJzj2UCdvFWjkcKlIXiT1e5ngAKBW5GZWNHOXC
 dtwix6be6Tt/7Eqc0N0uvEJczYWpTuFHlAyThdKEiIa+lgSWwraUTpWHikmIgy/q4BXV
 sg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689924693; x=1690529493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uQIm7uYenjZmyjjSRk64DJrLqfepX4T6j3z768nF+78=;
 b=Ik8wBIGdubXDM11BR3bsHirMRG0dfOyw+KzaaHKHKtGiIdzkT9Ai+jF1PZNeqG1hvv
 FseNiL0RLJsaSR34J/BvyhdOJ9izhRTT2RiEl2da2yLMujqufb0bnETF5C44jr3a0EWw
 Un/GEUlx+IXwRIGCPAEM0roUm1NXwOawIe6Y5c6EG2gWNdKqyhQSOkOx24z5Qs51FZj4
 it8WyMM+IPbUXgUmfzAXlgc89TH/EbXjLsAiPVXnyiN2ubmFq6yl7PF10Wv7+Nkg7BuZ
 A2yOARNq4Ln1/PeeF2wz4uiMIsUAKVxy+mxWL3hkO2eLIejONUTquZqeTiOdVXCx79Oh
 6cIw==
X-Gm-Message-State: ABy/qLb7t1Su2sk/GsjCQWZG8ClZPWGn6kZ7sSH1EOnZBDsHp0sabsSk
 nKEnkkc+1e4malUXbYzRfXbLUQ==
X-Google-Smtp-Source: APBJJlHTykD5oSO4Ugc2k5h9FkGUBtUGNHiCj3nF47K38f3111bOqK04QQuC+5CzuChB3/M/sSGEjA==
X-Received: by 2002:a05:600c:2948:b0:3fa:96db:7b7c with SMTP id
 n8-20020a05600c294800b003fa96db7b7cmr716003wmd.35.1689924692889; 
 Fri, 21 Jul 2023 00:31:32 -0700 (PDT)
Received: from [192.168.96.175] (97.red-88-29-184.dynamicip.rima-tde.net.
 [88.29.184.97]) by smtp.gmail.com with ESMTPSA id
 x3-20020adfdd83000000b00314398e4dd4sm3397960wrl.54.2023.07.21.00.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 00:31:32 -0700 (PDT)
Message-ID: <e30200d0-0c0f-c652-e926-fb305b515abe@linaro.org>
Date: Fri, 21 Jul 2023 09:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/tricore: Rename tricore_feature
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: chenrui333@gmail.com
References: <20230721060605.76636-1-kbastian@mail.uni-paderborn.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230721060605.76636-1-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 21/7/23 08:06, Bastian Koppelmann wrote:
> this name is used by capstone and will lead to a build failure of QEMU,
> when capstone is enabled. So we rename it to tricore_has_feature(), to
> match has_feature() in translate.c.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1774
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/cpu.c       | 8 ++++----
>   target/tricore/cpu.h       | 2 +-
>   target/tricore/helper.c    | 4 ++--
>   target/tricore/op_helper.c | 4 ++--
>   4 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


