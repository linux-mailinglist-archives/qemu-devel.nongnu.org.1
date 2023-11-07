Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BAF7E3B50
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:48:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0KYq-0004Wu-Qg; Tue, 07 Nov 2023 06:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KYm-0004WG-PI
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:47:56 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KYk-0004JI-IG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:47:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so41690265e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 03:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699357673; x=1699962473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kmwgRC4MPBd5LMG5ILw42WkUu1pXWJZ091MauX9PBX0=;
 b=UkWttzegeeOyU5FEaESqnWVUPsoq1Q6xGl2HAg2dmCKHQaVNLbNLNrd6rGe0uR0bMi
 11v7V8H7y5i8tBfkuL716LmfqRduJgM3JiY84DzpMmA3VVUFwk944cOAwZzIzbVxqOhG
 MH/iEOwOF+Dk42zOpjKZCWfE0JVZ7C7JsnZLHPfL7Y1PXz6DSw+k/s8PuGoUxn+avtht
 Dr8uhfbPlH9gSFn87G88tK7tDWmK4n9W/IQ2KO54Tr8t69TI4k4HJvahMla7GDyxJzTt
 HwkunWpPO7su0Rjj0vJ/IGW99P3JU6jpLfgSyJN0Osg+54kN9KmpsYbjR7Be64YcSUGa
 o+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699357673; x=1699962473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kmwgRC4MPBd5LMG5ILw42WkUu1pXWJZ091MauX9PBX0=;
 b=beaH7RdMFgj02g5EUkylkDn3C7+IKf/gt4zwJMOOX/Jv8H14af36rv95c0nuCIu8iR
 aWObshh/5pQnPAf2iWlvZPUTZ0yYpFyVJZCVC8GfTDixj/H9bCQqAFaEV2JvhtMinXh0
 dFyCYC2m17H9zglyIdiRs1CSxw9W6Xlqd51VfU4s01cxmgpehHcZjNJ/a7ByJDRQJ2q5
 staVYqn/PohOf73OpiQx6lAOVu9nEEPUKaVQSlXhbcG8e5zKRgHecko/oSyti5+tVr2y
 gcfr7iW9AqbYOPUVpoceAFdf+NUWWZ8OmnpWybQHMjIROykhl3lpK9gSrzMUwBHRkJlF
 aCxQ==
X-Gm-Message-State: AOJu0Yxc3TwjSjJtH+JBwdd3AVUZyhDBVlGkkJWY97jyao3gbuQEYwRf
 XOMVKRKKOBJtVkTvb02PxzHP1A==
X-Google-Smtp-Source: AGHT+IGah96JaFLiEJQn/DQTjaTTK0MuS7RAX/yns8tS7JCvabxFrxmxpaxhhXeLkWFYcNaLruxMiw==
X-Received: by 2002:a05:600c:3588:b0:405:3955:5881 with SMTP id
 p8-20020a05600c358800b0040539555881mr1991466wmq.36.1699357672866; 
 Tue, 07 Nov 2023 03:47:52 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 o29-20020a05600c511d00b004083996dad8sm15475932wms.18.2023.11.07.03.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 03:47:52 -0800 (PST)
Message-ID: <92fd4b7b-b1b7-4092-8ff1-8ca102abbd81@linaro.org>
Date: Tue, 7 Nov 2023 12:47:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add more guest-agent related files to the
 corresponding section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20231107101811.14189-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107101811.14189-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/11/23 11:18, Thomas Huth wrote:
> contrib/systemd/qemu-guest-agent.service , tests/data/test-qga-config
> and tests/data/test-qga-os-release belong to the guest agent, so make
> sure that these files are covered here, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7be61119f..48a6507759 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3144,10 +3144,11 @@ M: Michael Roth <michael.roth@amd.com>
>   M: Konstantin Kostiuk <kkostiuk@redhat.com>
>   S: Maintained
>   F: qga/
> +F: contrib/systemd/qemu-guest-agent.service
>   F: docs/interop/qemu-ga.rst
>   F: docs/interop/qemu-ga-ref.rst
>   F: scripts/qemu-guest-agent/
> -F: tests/unit/test-qga.c
> +F: tests/*/test-qga*
>   T: git https://github.com/mdroth/qemu.git qga
>   
>   QEMU Guest Agent Win32

Since I'm preparing a PR, I'm queuing this patch, thanks!


