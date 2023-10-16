Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE77CB052
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQoM-0000Mx-Iw; Mon, 16 Oct 2023 12:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsQoK-0000MW-K0
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:51:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsQoI-0006pZ-OD
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:51:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4066241289bso49019865e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697475076; x=1698079876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TbypOqUBR/68ZP0Xcvv2TK7E2f0AUOHCbTp3/+KXUvM=;
 b=VJ7zCmGE2TOWOtMQ91fcaBhpMyLN1uMaHnuOio47MTKF8BB8NrPWnCHcXytmE76F0S
 nlxpRBuy6q/329eRPBSfzg7MAq/1+o3yZ6mnxXe7Wa6y6hkXWpo++0mPnBeKHvgYl5yQ
 U3g0rVY90PR8MobqqXnVmyXDzmdiKiCREXdQ+9RogU6N9blwJuEHnv/IppVPtb8BF+sc
 1NLyI4d7fNnFZwE6eXDsWykCdVJZ17/EKZfwqsCm1v8wPuQ5XLkdY5/HFRWoS73wp5hF
 z1mmokYPvD7Q1s5CR4a+n5xWQ9ZzhV9zc4U3lLzIl3rbu7rcBSDunYb53eZWz6uvocmu
 1lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697475076; x=1698079876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TbypOqUBR/68ZP0Xcvv2TK7E2f0AUOHCbTp3/+KXUvM=;
 b=T7VQC5lmPnD4mTnqVsPdtYMa3k6uOpVrhfCr+e2A8wXh6y2kI0I7yfiir66L/hJKV+
 8qMHH+rI9HyfNY/Fi9O3hgoAm/t5Q9NsFt22H3+hOlaHJPAimZ8oXR+Mn50boVtRrf8Q
 dn1T1dhAfjrPyct4EZIFCMW4NWQh6vjamxotido70jd52s3NcAfn0NSb8v1wUY9eZ4qR
 J4Dy/W5qGsArYcHHjUp4o1P993pxYbtEmugoU75jU0EU1sVAgfAXMz9b+cyO62Go8CUa
 UrmgNcx4gePi7vqwf/s3MHGaL1YdrfrD/2EcUTHDIP9WgabQTn4xVgFVuNneTDEmcFuz
 mAZA==
X-Gm-Message-State: AOJu0YydAGgcZL9OreKEzhpKfELE8p4034s+zd8npQrKpcHyA0eQ8MXK
 JOosODGFOJnyTcp3I2o9o1Guzgqcu1U6qjTn1aA=
X-Google-Smtp-Source: AGHT+IGk11u33mwFN5MWaFMZwq5y+26rSdFcSBeg4aAB52PPhoTlPYjLBy1qSS0t4+JgDcDsm3jt2g==
X-Received: by 2002:a05:600c:b4b:b0:405:3b1f:968b with SMTP id
 k11-20020a05600c0b4b00b004053b1f968bmr30550945wmr.21.1697475076727; 
 Mon, 16 Oct 2023 09:51:16 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-186.dsl.sta.abo.bbox.fr. [176.171.211.186])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a05600c4f1500b003fbe4cecc3bsm7587314wmq.16.2023.10.16.09.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 09:51:16 -0700 (PDT)
Message-ID: <41e302a4-b26d-c308-00fb-347840b3d637@linaro.org>
Date: Mon, 16 Oct 2023 18:51:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 20/78] target/mips: add fallthrough pseudo-keyword
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <cd89d16dcaf6d8015ed3f317c30ff2fd6ae0bff1.1697186560.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cd89d16dcaf6d8015ed3f317c30ff2fd6ae0bff1.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 13/10/23 10:45, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   target/mips/sysemu/physaddr.c             |  2 +-
>   target/mips/tcg/micromips_translate.c.inc |  4 +-
>   target/mips/tcg/mips16e_translate.c.inc   | 30 ++++-----
>   target/mips/tcg/mxu_translate.c           |  8 +--
>   target/mips/tcg/nanomips_translate.c.inc  |  4 +-
>   target/mips/tcg/op_helper.c               |  2 +-
>   target/mips/tcg/translate.c               | 79 ++++++++++++-----------
>   7 files changed, 66 insertions(+), 63 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


