Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5883882336E
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:37:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL59I-0005JR-JG; Wed, 03 Jan 2024 12:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL58h-0004IX-3z
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:48 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL58G-0002gO-Fg
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d5d8a6730so61292125e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303259; x=1704908059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9gmrmUds30i8O+gezKj2VnPzgvbAe8y3qOObWtK4I5I=;
 b=zo0uYBPm7fLUVo4LbcwLcU05Vs/LggXk+9jB4SQMD/rhwIsMzq9IezCPQSqsbIx0uH
 jyXnHK645rfQu/RC/VO++e2YsHRSARzk90P0SNJSpIErXGv9yGZ8BL4AQZNJOGDlFXKz
 2Kjl3XFiWkNJ7mrkndfhxJ+kwzAxkOd4RISVotUtT6MbstCsKAagOzYuwFXMdKMj86uo
 ca9/QRNlpaYqGBJxZoWsOU64TVbb+SfR3/WkE9J33XCzd1hzrCLrNAdlnz6IjvlyXHTm
 /4/uOtv2W8eJZg1As+QxJa+v/f/dQO0yHVns9vTmiKesGIv4f98rPMWq+byu7ut+syMl
 X/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303259; x=1704908059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9gmrmUds30i8O+gezKj2VnPzgvbAe8y3qOObWtK4I5I=;
 b=mXrszJIDUt78jt7FGMkDhn9YltSoAg4P0TsHsGmSt/JIAIe5pTJw5sRAg36wGSIk1v
 dJSJdvidS+RqlMWs0hYJElXqWbZSVGiFHy4vJiMJb3W7IDs3b7e0gbNIVVGBJlAgaFFg
 qw8c6fdLxrXxTcdYXRFZnDVMuw8sYY+SDgWxKlGUtjFUZ5xVBNzSocpu+AOzHCFQy1J7
 ZED3rljaa2D2VI3F2SeVJ7iHmvwPZgA8BrRUOmU0Rxdp5+kvOynaZka0RFGuDtnxvuon
 OAUh45PgarbBncLGgaPf9SnkcRzI4vu2DuGMWUuOpSJdy+PtISa3eR2lEMC7AMWv+BtD
 SaXA==
X-Gm-Message-State: AOJu0YzPqFqMxuco3QOAbAeuxWZrWO/ege2y/X6T5cjxXO/v+lQa+7kW
 wd4oG5XkOi7tvcV16iotT2fhYkJnSgIvwA==
X-Google-Smtp-Source: AGHT+IHx7OF+Z3XuDEAEb6pnrI5vIIGJfQoUpRS99WF9MnJ0F0CR4oWEtWCVwLp5dCzRb8TJLSWlfg==
X-Received: by 2002:a05:600c:1ca9:b0:40d:5b0d:b0fe with SMTP id
 k41-20020a05600c1ca900b0040d5b0db0femr6946511wms.35.1704303259159; 
 Wed, 03 Jan 2024 09:34:19 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 e14-20020a5d6d0e000000b00336cbbf2e0fsm21642247wrq.27.2024.01.03.09.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 09:34:18 -0800 (PST)
Message-ID: <89ba5778-42c7-4228-8ec1-ff72f3e213ce@linaro.org>
Date: Wed, 3 Jan 2024 18:34:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/unit/test-qga: do not qualify executable paths
Content-Language: en-US
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
References: <20240103165131.2166988-1-sam@rfc1149.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240103165131.2166988-1-sam@rfc1149.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 3/1/24 17:51, Samuel Tardieu wrote:
> guest-exec invocation does not need the full path of the executable to
> execute. Using only the command names ensures correct execution of the
> test on systems not adhering to the FHS.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>   tests/unit/test-qga.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



