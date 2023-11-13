Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8FA7E99CF
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 11:07:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2TpG-0000kW-QS; Mon, 13 Nov 2023 05:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Tp9-0000g9-NH
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:05:45 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Toy-00071R-T9
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:05:38 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso6433935a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 02:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699869928; x=1700474728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F0YvJCE9F0OYTvhxbgp0GCWLE4YxR69AD1kqgeQ2RUE=;
 b=bQKbK8qrwCJAvVNxiLX4HPvosUXNdXdCd84cX+A6CTAD4SXl+C7XapZoAN4rVjgpEZ
 gs83h6JG2REEdgFLJfIXwFEejEtVRZmLN7gQcR6Hhmmlfpo2grX9OUiKAfG2h1+uXzFN
 kUIuOytAWQlsT04YXOtS4NGUhudOgY4iIkj6lYihA23yLGK7ZH1T8pjqO/XtCz58L1Z9
 sYQhEISRN4WyE1DhC8Js2fzVjkKeNiEJxuvfGK7aOkcg15Q5chHncm0tpqJl6U3ZYhhu
 np7mrsEo1iOiZSwl2U+ysFdM2YSm8u4h2/r733bgVBDMA9py6+ohPb4DOWaoUKsN0TGe
 n+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699869928; x=1700474728;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F0YvJCE9F0OYTvhxbgp0GCWLE4YxR69AD1kqgeQ2RUE=;
 b=WXB3u0N6uh+8EW/fHFbwfEPvNTdt/28k6U6xm4ik/1cZTlBrUVlxHwo+1NHNN1dRq0
 LPwF1qeLKDiGEtSFQ/2ibCcsR8Xz6K7Hdqk15X1GV8msShJ5dxS+z0ZOpO4LUYZgOybh
 Twj4Fl2fPHYmazXzIs2M+36hTFgJtwBGJsBqCppy07iYF/vV4/biAt8isGfrLZNss50c
 A5SWphkyh/WiJmrlWHaB+KfPgcEds+zR6b1Fdq+ZN2oYYNrBZNkR4O3SsIwuhbiao96S
 Gy7DhmsR/BF7qErlkmK7kzDd879qUdr5FRGnc+kgVyCQ/gHLast9jc10B90T2AjmRBbO
 JluQ==
X-Gm-Message-State: AOJu0Ywqf5fUfoLiTT8FLQ2lbzQj+uofBsCa1gDiuRdQUXvrLKuXpPJY
 W3ynzrvEZ7LNhWk5f9swaVB0Nw==
X-Google-Smtp-Source: AGHT+IGhfVpS6UgfAHC51x4FJ7DuY1j96OFdcAlxXMygePdnSTVeBrYSDTm+KIUtOPUwaxGSpoLdaQ==
X-Received: by 2002:a17:906:cd1f:b0:9e6:9abb:d3cc with SMTP id
 oz31-20020a170906cd1f00b009e69abbd3ccmr3936935ejb.1.1699869928465; 
 Mon, 13 Nov 2023 02:05:28 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 m22-20020a170906235600b009e6279fc1d6sm3734276eja.40.2023.11.13.02.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 02:05:27 -0800 (PST)
Message-ID: <53512cf6-b595-4cff-a1f2-6f1dd2c6621a@linaro.org>
Date: Mon, 13 Nov 2023 11:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] msix: unset PCIDevice::msix_vector_poll_notifier in
 rollback
Content-Language: en-US
To: Robert Hoo <robert.hoo.linux@gmail.com>, qemu-devel@nongnu.org,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20231113081349.1307-1-robert.hoo.linux@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231113081349.1307-1-robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Robert,

On 13/11/23 09:13, Robert Hoo wrote:
> In the rollback in msix_set_vector_notifiers(), original patch forgot to
> undo msix_vector_poll_notifier pointer.

Out of curiosity, nobody complained during 11 years, so in which
use case did you notice this?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Fixes: bbef882cc193 ("msi: add API to get notified about pending bit poll")
> Signed-off-by: Robert Hoo <robert.hoo.linux@gmail.com>
> ---
>   hw/pci/msix.c | 1 +
>   1 file changed, 1 insertion(+)


