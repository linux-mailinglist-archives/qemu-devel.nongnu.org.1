Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4075746C6F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbnB-0002DV-CB; Tue, 04 Jul 2023 04:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbn9-0002D7-NH
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:53:47 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbn8-00041Z-6R
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:53:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc54cab6fso45501775e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688460824; x=1691052824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=njBAkQXU2/DgvxA1JFBBAZ7QbVtOKqK9DvRXtxpC6Mg=;
 b=Qp9Pw0vn62VZUFik10MAoqQjK02EShFbDfo0QgB85FWLyJfrvd61z2GmUlzdS8G6VO
 4vqd/yTadh8/h8djuU8pwxmj3lqjSEoTA0zAyJvfV4QriKtC5ijywSUkAGI1CUTAHzRw
 aRLqIgyLy2okKr1il4AJ9Tz+CQRKUjsGOLj10ua7GWLED7YjnJbybvfhXEZY6F2uch1a
 EEk2PrxCH55kp5lAx1+6STIGGvNOeHNBmxSGVN6obhK8eIE47nf9yMLPPNcBoAcxF+8g
 p0hhclHK/rZU7zwypjJXOHCXw1YPmSfPaHz6jbWv5sZiwsXYSHMcXf0Do1UOO49z/whz
 AcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688460824; x=1691052824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=njBAkQXU2/DgvxA1JFBBAZ7QbVtOKqK9DvRXtxpC6Mg=;
 b=Cw9BI2ojQdyvxTtRTuYZY/x4Yyevw51aZrfjYc9dcjC/hVR8n+IK7+RyZ0Z/yY8NEN
 dnR7OUQLHN80SK/vVoP1wqqk8SAs+3t4Wsp7vXnpVT0/KGlU63gg1DI21zgTx9Pj2DWo
 4yt0VeMoIHekRswCwR//watQK/lDMs8GIz1gMnHvHs2mxpr31Gxy/1e629nyl3CuqnOR
 slh4huSa2jUn8Kq7FEGyfTWdNgcRxGlCbkDecelA02ZK+11lbi5+6CCJBc+BxkNdHh8R
 j674LFdtwV4o9PNhjgTKuGWkXcAfMzp3B6dxBBGGrTZw4sgb40gjATLgrE6RrK2os4LN
 T8bg==
X-Gm-Message-State: AC+VfDxl93+Lp0pbdZxq4I3jeZO9g4zxPAOk7oidRph8hsHrHACHPpcN
 f8Lfv++KOMJuzdf70Yf8+szi6w==
X-Google-Smtp-Source: ACHHUZ7J2QwcvRWMDnQ+bYAS5I3BOyfM6REll36m6ObrVROy7xPQIROb4+LFjAAyAiZFmeFdiN347A==
X-Received: by 2002:a05:600c:d2:b0:3fa:d167:5348 with SMTP id
 u18-20020a05600c00d200b003fad1675348mr9868890wmm.1.1688460824648; 
 Tue, 04 Jul 2023 01:53:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bcd0a000000b003fa99969e61sm23760123wmj.45.2023.07.04.01.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:53:44 -0700 (PDT)
Message-ID: <33b0af67-c0dd-01d0-9fc3-04ad38d8de38@linaro.org>
Date: Tue, 4 Jul 2023 10:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 08/13] ppc440: Remove ppc460ex_pcie_init legacy init
 function
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <9b24ce79c6181a9cd49eab09a1291eb1f039a26a.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <9b24ce79c6181a9cd49eab09a1291eb1f039a26a.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
> After previous changes we can now remove the legacy init function and
> move the device creation to board code.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440.h         |  1 -
>   hw/ppc/ppc440_uc.c      | 21 ---------------------
>   hw/ppc/sam460ex.c       | 17 ++++++++++++++++-
>   include/hw/ppc/ppc4xx.h |  1 +
>   4 files changed, 17 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



