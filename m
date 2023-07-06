Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDAF74A25A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHS0S-0006Et-VB; Thu, 06 Jul 2023 12:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qHS0R-0006EJ-DF
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:38:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qHS0O-0000eP-VE
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:38:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3142860734aso1899551f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688661535; x=1691253535;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=U7xXdNB40/K680n7T99wTqBVhWHJISv/bcehHzHAZWk=;
 b=zJrEQT29k+IfpqzwOVClBSREw7cHQTm+SG1AT2XGOdZLmnma1n2W8bXx27EjPjB9B8
 yxOWQ03CGJy//H5aK8oy9xmF30LMBFx3n63V59etXeB+dzMH5F2TWzNp5mt2O8w29Seg
 JgQLuDM+vyIc57c9CmKlzeRegxNi9OOYs1P3j2oQyif/z/DMHvrASwwqyPIbizF9vG1b
 HJHpXr30T07MwAe+a8VJM2AuWpkQ8GGOSdVi4W4DdKVyaXgHBJlC5IgoybGdbfFp0E7o
 nI3NLrtXKY6BuaEjCEor/yEnU5YBBs3ZFAyNEkKz2Ml0CQ3E7908rSQFnfWTy4Gg/CG4
 2rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688661535; x=1691253535;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U7xXdNB40/K680n7T99wTqBVhWHJISv/bcehHzHAZWk=;
 b=lXgWfv+WUHVJ6Yz/Pyi4x6xKwZ7Ftqa21TWOW4HEzywsYcE1eRgwqga4TSe60Ka18P
 eocLoEy9hAWWSSYX8TATBWXyAvA0F0iQ9Bu5GIWOQoHUUL+GPwGnuqY1FWqzUcbxaRIM
 C/tnjhhGcBBugpqDq8ImvNywnb6lX+piMlwjbnMuQT1Nec7ZaNPFByuzFfNbO2JLq8Tx
 RaS1PQJdrQUmXAiKXcUEKEXsA1pRlReXe5DWHqIUN4UIPCRwDigSc+hDkkdP4AebGyGL
 hxDtUZRuHdqBxZbOzkIlJCK/OlPrCTiOJpo8ddugIqLFirQUVZRLfUYJfLhvoC0Cc/dm
 bcrQ==
X-Gm-Message-State: ABy/qLY6Oo0q6OrUfRLjrC+g0cWI2XapA+L+esqWoc44kuTDoSUiiwCe
 c0B6ZEY4/uO0SSUonh0oWyF9/g==
X-Google-Smtp-Source: APBJJlE7wvtZD/CMvgAUfhweUpg6wEjMksWYw5HUJQzj6JXR5gcCw8z0PrEkF4HUA0cICmHXxwa8ew==
X-Received: by 2002:adf:f30c:0:b0:314:1b87:b76d with SMTP id
 i12-20020adff30c000000b003141b87b76dmr2375499wro.30.1688661534855; 
 Thu, 06 Jul 2023 09:38:54 -0700 (PDT)
Received: from [192.168.200.206] (83.21.151.197.ipv4.supernova.orange.pl.
 [83.21.151.197]) by smtp.gmail.com with ESMTPSA id
 l8-20020a5d5608000000b003142c85fbcdsm2317816wrv.11.2023.07.06.09.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 09:38:54 -0700 (PDT)
Message-ID: <7128e56b-0f52-3ec3-f4f0-34a6f11de308@linaro.org>
Date: Thu, 6 Jul 2023 18:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/arm: Fix ptw parameters in S1_ptw_translate() for
 debug contexts
Content-Language: pl-PL, en-GB, en-HK
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230706140850.3007762-2-jean-philippe@linaro.org>
 <CAFEAcA8h-VXZkD0SBrjOYg-FFVk5AW0RrAs4AL4w6RXWZzWUsQ@mail.gmail.com>
 <20230706152543.GB2570588@myrica>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230706152543.GB2570588@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

W dniu 6.07.2023 o 17:25, Jean-Philippe Brucker pisze:

> (Note that there is an issue with TF-A missing ENABLE_FEAT_FGT for qemu at
> the moment, which prevents booting Linux with -cpu max. I'll send the fix
> to TF-A after this, but this reproducer should at least boot edk2.)

Which reminds me that qemu/qemu_sbsa targets are still out of sync in 
TF-A when it comes to enabled features ;(

