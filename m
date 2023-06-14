Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB6872FDD8
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:05:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9PFB-0004LW-2z; Wed, 14 Jun 2023 08:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9PF5-0004LC-4q
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:04:51 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9PF3-0002sa-Es
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:04:50 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5189f49c315so692574a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686744287; x=1689336287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X5bqRLnNnBsAF/BOxBn72OIu3fJ7hEtY4uUgo+eLKkk=;
 b=eVDPnxloPUId8fhFpzCOtd6MytsKMo93b+uV8LGKydcgWEn/LmkmGCAvG4EfLh0jUY
 +KWttmuWrGjExK1MxP+cw8pIgTMMzA6hTrQtinh4k8gsFp7qQFZaCcRYe0uvUeQ2qJlL
 jV8GsLYTJC9UnuGBrLtz9zriVcs2w58olDEwrxXM4qYniEM0hSTYaPWfUM/mxBPH2Dv9
 fIDfn/49IGsPPX6pvl0KLQo+PRq2zclg0VNAvvTuMaWc05oOtJILRR6Ny+4AvLIN5H03
 hlK09SeYVrCQ0WvJe5usYzdBFyUNEGaP353HTV2xvz3kLJf0iTUk4E5hjUFFRhskEmzL
 ec3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686744287; x=1689336287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X5bqRLnNnBsAF/BOxBn72OIu3fJ7hEtY4uUgo+eLKkk=;
 b=iRSvw1CBv4qKtz3jUNzYHOScbpLabRJbpJ5TA2vmDfr6+LHzS2PKMUR/wRQWsBoMB5
 nxjIBHCh/99BXdARYV5dpzNUmDmKv/ImLEw0eFk9tDC7nurYeMeKXcVissZjUC71SLOf
 HYImqQn6gyFTxqdZXCTP5UtP9/pQ5cRvZMfZsblpcIWTmPhywbdiJA4wtmVYZziqwtM0
 nGqzb+aZ3UiPjCAZpPk6hlXcDTqPDyTBzm3htsvfhcPZUALuDTfmC9gHRAEGGy8DkfHr
 ea5XG9zaHcQrtc7KdnZnzBMvwMRMzq2z8DBtLY8/jp80IC0P0snV4ixT3Qg2pyPZLbHy
 ZXDQ==
X-Gm-Message-State: AC+VfDxy7x83jm/xANhekR8NJ6xc5WMEzer9rglBlLregP3QMjz+XfsB
 QoJ8e48dsG7VNGL6sztwonmP0A==
X-Google-Smtp-Source: ACHHUZ7Q9gFdo6EZN46BLKoC26BL4OVxWZQMZCJrnsoBd/LbGDIWYbHzyy0v9hB4VmGo9HxU57oIiA==
X-Received: by 2002:a17:907:96a8:b0:982:45ca:ac08 with SMTP id
 hd40-20020a17090796a800b0098245caac08mr4448288ejc.8.1686744287551; 
 Wed, 14 Jun 2023 05:04:47 -0700 (PDT)
Received: from [10.14.201.121] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a170906129300b0097381fe7aaasm7917686ejb.180.2023.06.14.05.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 05:04:47 -0700 (PDT)
Message-ID: <a5408119-8113-8f48-e223-628710a033bd@linaro.org>
Date: Wed, 14 Jun 2023 14:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 7/8] target/tricore: Implement SYCSCALL insn
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230614100039.1337971-1-kbastian@mail.uni-paderborn.de>
 <20230614100039.1337971-8-kbastian@mail.uni-paderborn.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230614100039.1337971-8-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x534.google.com
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

On 6/14/23 12:00, Bastian Koppelmann wrote:
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1452
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

