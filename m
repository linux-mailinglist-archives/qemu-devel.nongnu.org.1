Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C48F7E7220
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:20:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AYf-0006Nk-9o; Thu, 09 Nov 2023 14:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AYd-0006Na-Nr
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:19:15 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AYZ-0003Nj-Kk
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:19:15 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53dd3f169d8so1924614a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699557549; x=1700162349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pQ3ekx1cppHb11VHHplyYx0KbNrXZ7hZcYdW52/nwpY=;
 b=Q/JO2ZXjHa6C0ykyeIlYL4x6E3SiMqXd2tieUEsPOmLlFhpCX5ctX0FtZmiKuUVjif
 Nwlaawqx2FVcd6BitRWjbe7Sw9/+nLpuJvcYDddmK+p0pYowK5YvNw8DPTQxmPGXPDY7
 3w0qvRaIylMtERlykck8kY4gHhu/MM3xapn1Z0c8ns/I5TbqKxdEv1oOPKnd9mQfi4R4
 fElkcvrFHRK5psvVq3/Q/Ot6FU8ZlfByDDA2frCRJuXY5b8n4+ohCJIoeCE4cXdFvKP1
 tZBgG6NUoMLbaIXVCSpTFsUblsHZuqbKBuslIVF2L/ryXoqQ6FdNTDyYB4mDeU4hv+nv
 e3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699557549; x=1700162349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQ3ekx1cppHb11VHHplyYx0KbNrXZ7hZcYdW52/nwpY=;
 b=taS7ePSmA3wNP57uHyTiquni3qPiHdT0vYa8d0atDaExDKvnGCvQLTeC94/+Z8Mn9m
 Jh9vDwAE6TdFSVrWd/j5AceTfvrbqEYZ/tI/KFNSgNsSgEdci69NQHnJqqnizz5AIE+h
 N8oDKb6pV1uGp8CiiLLKF28vQIeR1HPWIANj+QoehP2dE8boksXzegU64CO40UpfQBtc
 12j6lYPTgEQja8S6gQkUcGlUEbvr6q3V1wh8KFgqUxGQAUFQecXolHm/ekdu2h7Ld6qg
 WRf7YQX5PBaNmIsI9D4Fi0KKnG1jbEkQzQliRPrTHDokpWRI5rnlxS1vgu0X9GKalAB9
 W9pA==
X-Gm-Message-State: AOJu0Ywds4jwvfDK/6elcSZ2pbYDQxXbqKfdmKNMv67pb1JM9X5xpnFT
 Ac9M0Iob7N/4racPqb0ff0SSSA==
X-Google-Smtp-Source: AGHT+IEUap+5n+pMvyXO/mYph5wl1JbMkz/mRxwP50WTx8G4/gRDxjhWbGpNhSixEuxUjeuA9+RxDg==
X-Received: by 2002:a17:907:25cb:b0:9d3:8d1e:cef with SMTP id
 ae11-20020a17090725cb00b009d38d1e0cefmr4882420ejc.59.1699557549639; 
 Thu, 09 Nov 2023 11:19:09 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 dt14-20020a170907728e00b009e5d30422ebsm178710ejc.101.2023.11.09.11.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 11:19:09 -0800 (PST)
Message-ID: <44242bf1-bbb7-4aed-8023-d9338154e24b@linaro.org>
Date: Thu, 9 Nov 2023 20:19:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc/pnv: Fix potential overflow in I2C model
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20231109171525.1129353-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109171525.1129353-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 9/11/23 18:15, Cédric Le Goater wrote:
> Coverity warns that "i2c_bus_busy(i2c->busses[i]) << i" might overflow
> because the expression is evaluated using 32-bit arithmetic and then
> used in a context expecting a uint64_t.
> 
> While we are at it, introduce a PNV_I2C_MAX_BUSSES constant and check
> the number of busses at realize time.
> 
> Fixes: Coverity CID 1523918
> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
> 
>   v2: - check PNV_I2C_MAX_BUSSES in realize
>       - removed extra space before cast.
> 
>   hw/ppc/pnv_i2c.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


