Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 749FD81FECB
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:55:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9Zr-0007S5-LG; Fri, 29 Dec 2023 04:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9Zp-0007RV-60
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:54:49 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9Zm-0003Gu-VK
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:54:48 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cce6bb9b99so13432021fa.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703843685; x=1704448485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ya/boOc3Q+0MJ5Qw3GiPGlhWhN4tYF8EO9nKbRzFz24=;
 b=E8SjbGnIF6OrWvVd0tp92aEVq6bSCrCjeThjzZgpFZN+oA9RSXrNEKiiJ+lpNv0RB3
 qLbeqnPypSQq4q40ykMazRHv9sY1eqoWQkCTiDLYzyUvo7K2KxHqlv4eH2iMIRIrdzqd
 XqnRQMRahDAoGPbqgVBnhjHViONSHbQ9UoA+pmWGlI5bOGpr5Cpx/5UCPEeAF5Tj28Fo
 n8gHyuMarojkoenEMlaYGf8VASC2UFuZDs6268UpqyCsBbNk2CF/drfJaJC1jl3PhMjZ
 YsIiF5LtDinpbd34rQss4kUSArnJEqOwU0U3AQzSvVD1HgEMA007wCYDH/7pZp4Nbn6O
 3a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703843685; x=1704448485;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ya/boOc3Q+0MJ5Qw3GiPGlhWhN4tYF8EO9nKbRzFz24=;
 b=ERfttt1kM41ArCLIVFP7nYOjDIctOGriNPAWF3VY+12p0MOSUHd9oS+FQeYYmK3Zcv
 zkO2dvd2+KBFe9T6oPLcuIdJ/6o3c1Scp0+BQJnvi93brfOqTfvotS15fxkiZkFawagX
 6Y4b2FgdWFpURO0RVbhqS3GjxMQ8iGYV+uAq7gtJZZA392evytVt92I8yDx6gIqxAcvM
 cBhBQcbABMiscnaLjkSgLAQZXi06c8ynvLzbWrM3avGt5joSuVZdBrK47jonz5skdEJZ
 V0vyVbZbDclSObsIZXIyDxc/lavLVyLe/SHzTnBPg8gcHruxzKQm8wWujpeFArCE2QFw
 YMig==
X-Gm-Message-State: AOJu0YwIgFnxYcdwnJd4AFU7xq5m5WbpCLTnAyyJ1KJYmFPICoTsEnbA
 Fj1IHGYhAoBcSWs6Brn/bFJVJN6/tfzUKGVeeCUZQLdCmqM=
X-Google-Smtp-Source: AGHT+IGbx8NSpstzjvrp07/xQYo9wMu6UiDNeovgcizJp2Wy2FIY3x/gggoYhCiSftNIXiFCeqgStA==
X-Received: by 2002:a2e:3a03:0:b0:2cc:75c0:47bb with SMTP id
 h3-20020a2e3a03000000b002cc75c047bbmr5170807lja.4.1703843685215; 
 Fri, 29 Dec 2023 01:54:45 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 fi11-20020a056402550b00b005550192159bsm4908811edb.62.2023.12.29.01.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 01:54:44 -0800 (PST)
Message-ID: <ed9fec22-f132-4d78-aad5-16c23b8e0a31@linaro.org>
Date: Fri, 29 Dec 2023 10:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] meson: move CFI detection code earlier
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221171958.59350-1-pbonzini@redhat.com>
 <20231221171958.59350-19-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221171958.59350-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 21/12/23 18:19, Paolo Bonzini wrote:
> Keep it together with the other compiler modes, and before dependencies.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 80 ++++++++++++++++++++++++++---------------------------
>   1 file changed, 40 insertions(+), 40 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


