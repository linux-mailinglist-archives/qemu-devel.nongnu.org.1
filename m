Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD7746C45
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:47:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbgc-0003eM-M7; Tue, 04 Jul 2023 04:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbgY-0003do-CK
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:46:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbgV-0001lN-NL
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:46:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc59de009so54175655e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688460414; x=1691052414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NQUekMYR/qr6ehKahDOktOXGRqd7DxRNpSnlmlnml64=;
 b=mirmKG9Neva0ZBpzIYKLhYm0yRVuII+KoH2t83fqr+9g2P/C6OogvQwzlnJjIVcBec
 1svQsYo8S+emP0FCVe75VO9urozSO8TOe88VdnX0VcRolATJCYl6ruFGvTKwaf3lajGS
 4t6xTDl1amYqWxbWT2UJyTL7GTtS/tDBXE3o4qMo1c/suSxGkf3M7OzP1yyL3nueguKh
 WIbH7WzN8QbjkO4U4+H1cFWQe1Rn7DbOFJ/ov2EvTC4VaONBEmRN0JI+DTuQbtdC4Wr2
 pJ1Y5fAd7vrGZ7RaxD/etkw4dzCzJNCDjqQokcgAikdy/tlMiRwg/xIr5RVENVpmGIfa
 rU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688460414; x=1691052414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NQUekMYR/qr6ehKahDOktOXGRqd7DxRNpSnlmlnml64=;
 b=S8d+3wgLSsuRXIaGMDwMNK0A/Pq0pL6DMfSKjOsSNdbGZOYgZKm9pGU8A+cnXSB86+
 Uf9AQ2ZYoYLeWVBqf6MDZopAZAxoVvGXOFhSAjwqhfGqH53TVWE3Ne+ln6XVrPggLJYA
 POxiusbHS03NXziS8wEz0bDdGoUsvtgZT2iW0WQD2dsj+LwE2s97Cj2ui4Q1hl1bnAOQ
 t+yhbwrYYBL3yiI/PPrXSOPNUCvfN77l+//W0UX0ssdrl3sv8/pzW5aUN3YjzlFf2egl
 oo5nBcAZ6BJuY8sAqJLPpsWRAcTafMTA+bsTHXm0jj2UDcuAlaskMh5jPwypglUcD5OC
 RbpA==
X-Gm-Message-State: AC+VfDwLIpJLM7fWBXQi0ULJKh76uSGaUMM2pQ8C/+hQlr3ETYkmzKsK
 NWaPRpt4ZIpNO/eYdtdwXWqReA==
X-Google-Smtp-Source: ACHHUZ5NH321yjt/GOBoRZxzeOnQwF+WI9Ul/AOim6PSEr4ssPHgBZB7m0SC7xgc23mOraJDIs6xew==
X-Received: by 2002:a05:600c:b53:b0:3fb:416d:6358 with SMTP id
 k19-20020a05600c0b5300b003fb416d6358mr10371955wmr.16.1688460413958; 
 Tue, 04 Jul 2023 01:46:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a7bc7c6000000b003fbda7d2d41sm4756137wmk.48.2023.07.04.01.46.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:46:53 -0700 (PDT)
Message-ID: <d450c973-bbbb-f135-8c63-ec201bcfdb09@linaro.org>
Date: Tue, 4 Jul 2023 10:46:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 02/13] ppc440: Add cpu link property to PCIe controller
 model
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <3b368d0887bc3cfb56ccb70c893f3317e420efe6.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <3b368d0887bc3cfb56ccb70c893f3317e420efe6.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/7/23 00:02, BALATON Zoltan wrote:
> The PCIe controller model uses PPC DCRs but cannot be modeled with
> TYPE_PPC4xx_DCR_DEVICE as it derives from TYPE_PCIE_HOST_BRIDGE. Add a
> cpu link property to it similar to other DCR devices to allow
> registering DCRs from the device model.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_uc.c | 114 ++++++++++++++++++++++++---------------------
>   1 file changed, 62 insertions(+), 52 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



