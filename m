Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B63D7BE3FC
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 17:10:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprtM-0007OS-OS; Mon, 09 Oct 2023 11:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qprtK-0007NE-PK
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:09:54 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qprtJ-0000Es-6R
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:09:54 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53808d5b774so8389660a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696864191; x=1697468991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NldQiTWA5sMVywFdcvGk4DI6HBcviGKaPNWPOAI7ABo=;
 b=wbKYxpdlD1O1EZ70ukkG6S+O+kz9V+aeuaxLMhXcM5UM5dsqDQrBid65JhvNxod1LU
 JCprzrrVTETJbMqP2C+7ryMcLh7YSry0Glk7s6vOCrEQQgOArREckbaifBGjt78yThOf
 h9037giOi1DbgxxWDf8r6HdELYTi2MgGiMQ0DEap8HtBSkKNIC+poNqwLiuvzrCrIiwg
 FRarhrVM7J5ps8yhYWx/FefgI4axHXx6p6RJB6w5QCEFKRAYk8iA6yPPq/GF9/bQbitb
 en5bowodv5VV3/Loudom5sj7kPR6XlT2D5IPgClZktBT0LmvgodMRoV1SQjpXv0RBKNq
 qxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696864191; x=1697468991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NldQiTWA5sMVywFdcvGk4DI6HBcviGKaPNWPOAI7ABo=;
 b=JCwoYbjFsADltnEZ3hsAljnRZtiH7Y8uYk8b71qokc5TjKJtWDruo2oUs3yBFdTuIs
 RstqBcjrrsEz5mgIaBylFopWV3e/u7ASmURy6ZMgYPd8YnkEhpZbvHRofy5kPLfTtsVV
 +4kgi7xxqniHieML7iJaWcA3QeNlNsOboBnVENKm2uqVY4am5E7VfASQuqy8qcz+DLwf
 tWhq4GSweQ14jGE6QnZ/MtOq3MebFBYqbZ269H0NDt2MyTpluRh+aNRgR7UTXaLJVp22
 LwvUrVUUDMI/OKZauOan1arxMUvPQx0jH1olF3TWj/5rF/OKZwi0iiLo/LRLc08t1aJF
 ekyg==
X-Gm-Message-State: AOJu0YyFMVauXx12J/6vud6mWRJrp2HJteSx3aAQR0oUGXlmrCaZ/Uo/
 rc+BhX2j9oL9nB6l0NGl5vCn8w==
X-Google-Smtp-Source: AGHT+IHQ27FjElR7d5mwjgma7Xr1e662z4pYTF7K7YI3KbhnnjFWGYlmg9ucmRkwxS0hlFOhZQGOWA==
X-Received: by 2002:aa7:c255:0:b0:536:e814:360c with SMTP id
 y21-20020aa7c255000000b00536e814360cmr14174772edo.4.1696864191113; 
 Mon, 09 Oct 2023 08:09:51 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a056402125000b00536159c6c45sm6114967edw.15.2023.10.09.08.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 08:09:50 -0700 (PDT)
Message-ID: <0052d92a-b712-63ff-5e3d-668787f0213c@linaro.org>
Date: Mon, 9 Oct 2023 17:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/1] tests/avocado: update firmware to enable OpenBSD
 test on sbsa-ref
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230927120050.210187-1-marcin.juszkiewicz@linaro.org>
 <20230927120050.210187-2-marcin.juszkiewicz@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230927120050.210187-2-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/9/23 14:00, Marcin Juszkiewicz wrote:
> Update prebuilt firmware images:
> - Neoverse V1/N2 cpu support
> - non-secure EL2 virtual timer
> - XHCI controller in DSDT
> 
> With those changes we can now run OpenBSD as part of sbsa-ref tests.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 68 ++++++++++++++++++++----
>   1 file changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
> index a794245e7e..2d683d4f6a 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -28,33 +28,33 @@ def fetch_firmware(self):


> +    def test_sbsaref_openbsd73_max(self):
> +        """
> +        :avocado: tags=cpu:max
> +        """
> +        self.boot_openbsd73("max")
> +

FWIW:

Applying: tests/avocado: update firmware to enable OpenBSD test on sbsa-ref
patch:113: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


