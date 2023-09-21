Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE97A94D4
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJmt-0000UM-L4; Thu, 21 Sep 2023 09:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjJmg-0000SQ-DL
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:32:02 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjJma-0007jT-A1
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:31:57 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9ada609bb62so111735166b.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695303110; x=1695907910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wzWDotbU0ZwuVuav5VK4bZxyKfn7MSCaxzI1K7F4hKQ=;
 b=mfwSoRrBDKmblC5NCY/OiT51E0GqeKtmQA1XQxO0PYB1Rf3ZtFb5Uw0Hpv5ImXVnaj
 0ern+C5hshGvhwjn7st080FOfl/xx86mlk742VP5JBFlT0Z09OwUhxU6zIuEsAKy3JEC
 wjzs9cm5hg7Tgat7Vbj7/Myr+UAHRlApO49rKgbgfNnTwCSlq16G+leHeck8HDXmtAMy
 0IhgyV9OTMqbYmPGQXc1946jZ7aSlpZO6KxBX/evdhmpxioA+yC44COKi0+tRpjPuQAV
 DtPNI5Y4kSEO+HSlx52yPeFe3XX1VIjeK/P7s3KLSHXYa2IkFj8T9K5RGn0n0cZKx+fd
 UFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695303110; x=1695907910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wzWDotbU0ZwuVuav5VK4bZxyKfn7MSCaxzI1K7F4hKQ=;
 b=U4ROB0Kqe/KxGq/rMyk/aiOpiO5IH5T4PYrxlPRmfCiqO+icYOuIhwidYBlMoYbrF5
 KLcKUcK0qCaTQaa3pwUqNZIqFA+pBBRf07rqwvrWjJ5spPed3aITyk9cvCyeRQAeLdWs
 0NCVRzB50nMp9gVbH3g1NnpQ0J+oUuYT5ZOYGFuQrztAsMPk4QTRX5qpYmoTpIxaSEdb
 y6pkKWA1SBwqWj5czCPU0TL2IjW+LktUGVw5a4BzPtG48RiUSVur2pxsRKro6ZusdmDc
 Njtolisl5qQiECctG7DymUg2prAyWD3SXx3IlKFzWjfv2hIvVzE2qucMU9Wcewe9SZnW
 fcVA==
X-Gm-Message-State: AOJu0Yzuw2NRIA28/v3ExaHYUYbd10vfkZnFOohCZJ3n2KfW9mClom51
 lWI7vOONohGE5hCmQGMQ/fDJBdE0iBJ8Nyxc6rI=
X-Google-Smtp-Source: AGHT+IE59XyzsroEFShjZk5XYol1xyI0nUbp+5H7euqu7a89yESgROwDSCF9jb2x4aAPMQgS9SlAVg==
X-Received: by 2002:a17:907:77d0:b0:9ae:690d:4284 with SMTP id
 kz16-20020a17090777d000b009ae690d4284mr719240ejc.75.1695291783607; 
 Thu, 21 Sep 2023 03:23:03 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 i18-20020a17090639d200b00982a352f078sm813480eje.124.2023.09.21.03.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 03:23:03 -0700 (PDT)
Message-ID: <8d1b94a6-9301-a317-6a13-2901310429fd@linaro.org>
Date: Thu, 21 Sep 2023 12:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: target/sparc: What is CPU_FEATURE_FLOAT128 for?
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
References: <59e5fc47-cd15-f7b5-a0f7-c0620de33576@linaro.org>
 <b400a0fc-cfef-66fb-824d-c245de82a33c@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <b400a0fc-cfef-66fb-824d-c245de82a33c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 19/9/23 11:32, Richard Henderson wrote:
> On 9/18/23 14:31, Philippe Mathieu-Daudé wrote:
>> Hi Mark, Artyom,
>>
>> I'm looking at the CPU_FEATURE_FLOAT128 definition introduced
>> in commit 64a88d5d3a ("CPU feature selection support"). Any
>> clue how it was supposed to be used?
> 
> This should have a comment like
> 
> /*
>   * Qemu is emulating the linux kernel, which will
>   * trap and emulate float128 instructions.
>   */

Thank you. I'll send a patch later to clarify.


