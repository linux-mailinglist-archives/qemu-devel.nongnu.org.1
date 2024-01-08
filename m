Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1C826CEF
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:36:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnut-0002I0-UE; Mon, 08 Jan 2024 06:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMnuf-0002HO-Lv
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:35:27 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMnue-0007Lq-4d
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:35:25 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3374eb61cbcso1770362f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704713722; x=1705318522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=66vBGBKWOBJXGDVzbjYSUbASOb7UYiE26rO7O5tPKFE=;
 b=U7XNSk7ZpMskastyWecEJ4Ri4IQb1ResAFaaYbO/PChn3lKLVdhUEIMA+1EdlURcma
 +8YrerGzbM3z8XgWS3nUDG/W3fxZthX7e0XZFXiJ/ZJokfnO6/iMu/zRN5z+yKmJE3zn
 IhbTbLMDzQkVlQ2qoh8wpqdDFFmMFh2l190j31pW+NqTp8AYmk/XA/1d9Wbf2x/mlmpA
 TeOs6/CvE18lDMfRAfLq37iWVDrCMXCRoBLdiTGcw7/Lc2HTWbWTljimp3aSMG1w98xG
 FhLEviFQtrAKaD5RT5KBsXoi6CsdqIw38Bb3nXxRXr6wXCvWQarXqWF63sm0CT+dvg1s
 frmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704713722; x=1705318522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=66vBGBKWOBJXGDVzbjYSUbASOb7UYiE26rO7O5tPKFE=;
 b=fjl7zRXQDKHwihdZKzWeqAu0bh0N/Yj57k7fLEbKUbYIQ/aCLWFfnxN/bWFOAv2c2N
 syMMQ2e4wEFLVtThUU0LMKPLkshAHQpHYhWhTfFf6i+2PgtmyvUI+JkhoJjSebVqdV8n
 G24L/Lm3Jkiu1iw5iQMjgTm42Yr/P6NsijJUFSukaP3g+xgUIYgCSDSkiMoL+phL+Qp5
 +5MYZg0ikHr1BPH7uCZJCetUiW1dN/ohWo1NUVSWGdnyV2A1Rz4GfKccGm+LobBCxDJT
 tAXB+rVo05hdpGB1ibNrftLK9k99Tmr+PD3YG2P8RTmSeNOTPJNegaaTDjcclAcVoq6S
 ahjA==
X-Gm-Message-State: AOJu0YyaoWelSthkuFZ2aPh3Fs07bjPRTklSigLVepqs9vl5qqWkIrFA
 +rT4ILiX0egKrUlc6+DSHA2ee3CVfKBBpg==
X-Google-Smtp-Source: AGHT+IEl8pb0m1rKC+DHRUsHG3a/0TmV8bO34A3GpSZg8kn117DXX0UED/E0sft7CpcDpq53/i37Gw==
X-Received: by 2002:a5d:6786:0:b0:337:2aa3:ac87 with SMTP id
 v6-20020a5d6786000000b003372aa3ac87mr1644530wru.41.1704713722321; 
 Mon, 08 Jan 2024 03:35:22 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 a7-20020adfed07000000b003371e7113d4sm7585976wro.24.2024.01.08.03.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:35:21 -0800 (PST)
Message-ID: <bd890921-4503-4b9b-bf0c-7ba500b39c8d@linaro.org>
Date: Mon, 8 Jan 2024 12:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] gitlab: fix s390x tag for avocado-system-centos
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240107170119.82222-1-npiggin@gmail.com>
 <20240107170119.82222-2-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240107170119.82222-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 7/1/24 18:01, Nicholas Piggin wrote:
> The 390x tag should be s390x.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



