Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E04272DDDA
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 11:37:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90QY-0003R0-44; Tue, 13 Jun 2023 05:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90QV-0003Q2-MH
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:34:59 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Oo-0004lc-5G
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:34:59 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so778566966b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686648788; x=1689240788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4MNXdi7MGKpJNYenS9OX8BFrtPE9E2iUOovnT/tyKXE=;
 b=cl1o3mr4/EmLos4XxLkl97dBnqU6jhjst5oqtVa0vmY5xX8ZCoRfx36/BNTJxLfXt2
 kaN6ga+BnE/BWPnEpD4J7yPDu5Vh5oUmMJYv1n5lxlQRSoLe5q7qmrW3/HAquWK5bBth
 MAy2xFr/uWMEvwesNHj5XBu9fsycBYe+0+NE7lVADaxQSpCU0aCKjqVqrQua8fxYljSq
 wtmBa2q8wj+MSWq3NIeIRzsYNR4iqwRelqST9vDbo4ClEmkjA+vjE+djjFkXmtJUR/n1
 0g3tCanr587P7S/BSUJCt/KKEMNx2WTy5ETaBl9n/pd7h/vm+mn19DlDzVJ9lQ3k0JTK
 ia7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686648788; x=1689240788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4MNXdi7MGKpJNYenS9OX8BFrtPE9E2iUOovnT/tyKXE=;
 b=ZbjbVpNhhvP1ESxreJOm0mm5XIK2A5Ib/4kzz7qZ80Z0YK7Zj9bX4fP1anIrsO7Bfm
 qXUiLYFxubpkvzFnoPrl17u0J/kM9W0OIsm1gpIHKPqLptyor61vQkBCINqcraj68VVM
 t4/mJiL3DpBXlf7JsO+lz/3H62MYelc0NPanRPzwRvWQ0+DeKr6tyZyJNHcp6QEy8oFC
 zkplFhNoMPzdgSMWywJ1SIzlda7JYEsQwxltu2CeiX97/UkZ6o40oUkIdfsE+q2vH8LJ
 6rVgP3Cbmwe+mhdYPqqFbCZ9LaRXnu3N9QUm9heiQ4yg8S81Jx0utY6Wf0IOfWF3PGWo
 65yw==
X-Gm-Message-State: AC+VfDwo5tPUEAnKo8PXzGMrlzCi3gd/LjLjIvh5ye+xrRj5jT82pPK0
 WD8cLWu8W24Ymp67rIcuKK8FtA==
X-Google-Smtp-Source: ACHHUZ4drShZBpM60M5Kw24DqXNi0fRsgivQaQoInh9rO0XUBhdmdIbneU/eIuL0nrifoH4XlMijLA==
X-Received: by 2002:a17:907:78c:b0:96a:ee54:9f20 with SMTP id
 xd12-20020a170907078c00b0096aee549f20mr11026477ejb.37.1686648788002; 
 Tue, 13 Jun 2023 02:33:08 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a170906500800b009663582a90bsm6485879ejj.19.2023.06.13.02.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 02:33:07 -0700 (PDT)
Message-ID: <e51d0bb0-38bc-806d-e54a-68d4f3a9e564@linaro.org>
Date: Tue, 13 Jun 2023 11:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3] hvf: Report HV_DENIED error
Content-Language: en-US
To: Antonio Caggiano <quic_acaggian@quicinc.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>
References: <20230608123014.28715-1-quic_acaggian@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230608123014.28715-1-quic_acaggian@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 8/6/23 14:30, Antonio Caggiano wrote:
> On MacOS 11 and subsequent versions, in case the resulting binary is not
> signed with the proper entitlement, handle and report the HV_DENIED
> error.
> 
> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> ---
> v2: Use architecture specific defines from AvailabilityMacros.h to enable the
>      HV_DENIED case only on MacOS 11 and subsequent versions.
> v3: Fix ifdef guard.
> 
>   accel/hvf/hvf-all.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Queued, thanks!


