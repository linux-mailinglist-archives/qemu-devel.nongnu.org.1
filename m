Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 419BD75B039
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:40:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTsa-0006zg-EC; Thu, 20 Jul 2023 09:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMTsB-0006jM-Ai
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMTs7-0007ZM-6w
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso7020345e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689860348; x=1690465148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5hkkAHvXezrZtw+GwF2dvdzf8mp86KSzi3hVev5n3LQ=;
 b=FxGZ3mnvDUU2JBGp+RoSjoAMR3ARaWrLsBFl0pxHsqRvHv203UBdAjJJanznI/58ww
 6URTh870NN04zg4DsWUaQsOM0Cjx0mio3xc744GmRGfoB+N53XvwEjqDRdvqzyILlN5U
 AW8LsStqPTMyeyqhs6KqpnXxzFJkxfk5lknW2I9ayu08I7A24dm9z9ZQtQJTOpNXlxNN
 oA8kcOL4t82I+mIuzMfk8nneDo4qzwruJyi8uFMI8GcuoRLMpepSAD/QHXTkRvJXd4GR
 jOlVuvYjU5E5G/P/p1hzc9m1dGsTK/MxsdO0kBJGb4PyOcG9aRrmEdRECto2nJDVGBZI
 RWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689860348; x=1690465148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5hkkAHvXezrZtw+GwF2dvdzf8mp86KSzi3hVev5n3LQ=;
 b=CfX1DUuQ7ba1j6JTCtVrYGUoJg7ihFHiJ+wiNTEU4PTxVxOTtI1GE5r/HIqQQ5pdT/
 Zy7gI6OMV2B2TmT4rYb5pDm3B0dNAIPVgK8BUtOyBJTpcBsEC64o5nku4WEjSUtcqnA5
 lnfu6frWaOsa62oI6mZqLPSEeTCDWW0xF6uP0qCSOlHb/hmzd3VAwa6p+cyBhsrnGYPZ
 +OIo7u6iVlC2RF44POyWdMU2JSe7636+/Y4tBrFfU52g3ATcNATUqKa15QhixGU49NTZ
 QzXE7563L1PPXvP16G1473pTwYPqPYKRMf2omHbYgBMUMyJxe+A+pt7u9gLGjYEbCY/J
 ftcQ==
X-Gm-Message-State: ABy/qLZTB+VQ8smSnWCNanj9ViMhWaogMf8n/F8AG02cTaJcXQ0Y7Pag
 z2sUtaWVSSCB6L+H4tqe37+8xNO8fyEu1TGfgJM=
X-Google-Smtp-Source: APBJJlHU2OE8PUH15pFuO/2gcsNO3CCS5LkruoAWDQ+aMwj2zz783dXNZY7d/4UvCuwDIrOmRHmc+g==
X-Received: by 2002:a05:600c:220b:b0:3fb:e2af:49f6 with SMTP id
 z11-20020a05600c220b00b003fbe2af49f6mr1744699wml.39.1689860348549; 
 Thu, 20 Jul 2023 06:39:08 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.214.178])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a7bc448000000b003fb40ec9475sm1239376wmi.11.2023.07.20.06.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 06:39:08 -0700 (PDT)
Message-ID: <04a0c38e-5551-25fb-cee6-9f977a2250fa@linaro.org>
Date: Thu, 20 Jul 2023 15:39:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/nvme: use stl/ldl pci dma api
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230720094223.27767-2-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720094223.27767-2-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 20/7/23 11:42, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Use the stl/ldl pci dma api for writing/reading doorbells. This removes
> the explicit endian conversions.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 42 +++++++++++++-----------------------------
>   1 file changed, 13 insertions(+), 29 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


