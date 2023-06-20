Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4D736731
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:11:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXOJ-0002ZA-LN; Tue, 20 Jun 2023 05:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOH-0002WS-C8
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:09 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOF-0000U6-Op
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:09 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-987c932883bso504096066b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687252266; x=1689844266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZ14pyMfLjQ2gYFabJGMOyXBTV/gVOv3t7OesN8fFaI=;
 b=u8Y4Saq0CeJXQcEG4x8obGSnU5TpRElBdrkagV80xqs86nUQ1Fit6NLtjvtyud+zKC
 f2pDbNMV9R9rucf62YQe/KbzQqYWgSTHmNymTiVDRVze6ifTXKXpuje35udZ+AU+WkIg
 U2Y62qp/vJmWvA4ph6l2OIQugNKnEedPJ0c9tS8mPEoFYTooZZe2VaLXqIOan+IVViUC
 xIRSdJLkgr+mOnZvnFWVc9ogHJwfNh5TlWIqfB3+HL4LogscZJl/fJDf2cCtwHejth7s
 DzeX+CejqehPQ+vHTVoU6OPyKIXv2WKrp5GB997yPr8RF72Qes7Dus41bgxf2bTE6wBe
 wqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687252266; x=1689844266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZ14pyMfLjQ2gYFabJGMOyXBTV/gVOv3t7OesN8fFaI=;
 b=YefaLg/CldINhBCRj+CZyOAFPlyERObrvmAnYwMdjSRmqCOCNvGeDAZyv7WIZMYj6o
 23lVqP8Jq9ezdDxFAbj5tHtwGWYV0EGzOVWnjj3OuQT2MbaPQmht0mC8kqMtqgFGruTY
 xspx3MlDssF0L6ArePr0KU0ZGaoJRe8YV9UtbbIrmzVAJg4enfCyVaFfXTYG63OD6ueN
 Jr9xKTHnyHIWCA7A4xnapo+CJ9dVo/YcZxhyGYcGg0B9fI4TrE952kMz+9lrc8bkXVkR
 Cu0arGyb5Qo8HLCJx3RFvJ3vVnoLaEp0XiXK/Kcg0lrkXXFNBw9EJLmvXwHnybqV4XyM
 jCdA==
X-Gm-Message-State: AC+VfDxgea6b9AkbBdtcdG/L7/2Jx40KeFQp4b6jBDHsqknwn4d5HuOe
 x2f03SK7sp7RhR9dHw6r4pAn00nMPNhciwa2JaZkzAL9
X-Google-Smtp-Source: ACHHUZ7tzJfcy+7SfzFn54YQ4EMriBVicCur4jELPPkcW/ghPI4ASfGqBJenuZxqRfkgNqmFF0X0rQ==
X-Received: by 2002:a17:906:6a0c:b0:988:bb33:53a8 with SMTP id
 qw12-20020a1709066a0c00b00988bb3353a8mr4250340ejc.9.1687252266368; 
 Tue, 20 Jun 2023 02:11:06 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a170906245500b009828dac8425sm1006110ejb.105.2023.06.20.02.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:11:06 -0700 (PDT)
Message-ID: <c0b6bd75-8239-ccf1-1604-668e6d3ffacd@linaro.org>
Date: Tue, 20 Jun 2023 11:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/9] MAINTAINERS: Add reviewers for PowerNV baremetal
 emulation
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-2-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620055911.187065-2-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

On 6/20/23 07:59, Cédric Le Goater wrote:
> Fred and Nick have been hacking baremetal POWER systems (OPAL) for
> many years. They use and modify the QEMU models regularly. Add them as
> PowerNV reviewers.
> 
> Cc: Frédéric Barrat<fbarrat@linux.ibm.com>
> Cc: Nicholas Piggin<npiggin@gmail.com>
> Signed-off-by: Cédric Le Goater<clg@kaod.org>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

