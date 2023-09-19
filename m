Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C07947A5E00
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:33:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiX69-00024k-9P; Tue, 19 Sep 2023 05:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qiX5w-00022q-RA
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:32:37 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qiX5v-0003e5-Ae
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:32:36 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so741557766b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695115953; x=1695720753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R4sNG1NHIKjSfKysubHkR5QNe2PHYsgczQsxCB5WQGc=;
 b=wOXa2l7ImeaRon3WSKkNoz2xECmhhEucoBMZgIHaZv068mwDmmHqU31nTrBjYJTDOD
 WyTyDSQ43WlNGYxp5a/rYSGTPMQba8HjF2fxrQM3N9DGAP7f02qiNMbRrBNmgvjZRYnC
 3LJIBn5PLgaqWguc2kviBThDXyAnMTFiabe0LMrsoMNjoFih+WBAoYD4iZH2y2pvrfF5
 xi2U0vNBZE/hDi2/yciD5eA+pIpizDCP4y5KlV7V1N4g4IiasLvIA9e1OV0y0Zc09buU
 /UJZMduiq3/VF5O07zZohkxt84a2Y6KYqXyxinC7pugP9QJjbQmMCd6S9sL9kxIiItn/
 NSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695115953; x=1695720753;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R4sNG1NHIKjSfKysubHkR5QNe2PHYsgczQsxCB5WQGc=;
 b=Sf4pg+/iIyVFdOC/0HEy6SMu6ptpvBKO/G0qAfYyAm6L4N5VoVI4ZYUgOEJpYq58zc
 dVHNDIUExCuw36a+WeStHO34j1U/eQYBkyMsPppFqyL9l4tkLx18Qu702rwh0xnWguPS
 4PNd5EGmQLGUZCsHvNeDPUB4gKyOFDdf70+t3al3oF+gxUDQqSmpcT91xAmkeQOHcRhm
 B59rjbZNEb8wHEtFxQy2mcKW3aRvcE1sS9fTbVbMCxsBd+biYK59Gtlj5tWfDbEDkHm2
 hJOHk7EmJxS0bI0Isher+EqvSMV2hlSeMdJ+9eN8pxjUst+isY6DAB6UgLXg4MChp0PD
 cI5g==
X-Gm-Message-State: AOJu0Yz5G341SmjU+yyYm9XPqbOkdnDIDAzBsOcHKHZiEbHbSwuOkoYm
 3oQDBYMsqvtsk/PXeQzI2PKWNSv5KZJBh1a1lbFRUY7E
X-Google-Smtp-Source: AGHT+IEaeac144n73wk75ZxHBxKiFR6LuMYhWbIHB6aLxvzqmImgYbSiqWOFZoKtNAjFNJ74fI9p/A==
X-Received: by 2002:a17:906:7385:b0:9a6:6011:2c09 with SMTP id
 f5-20020a170906738500b009a660112c09mr9227216ejl.68.1695115953243; 
 Tue, 19 Sep 2023 02:32:33 -0700 (PDT)
Received: from [172.20.66.192] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 u22-20020a170906409600b0099d9dee8108sm7679695ejj.149.2023.09.19.02.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 02:32:32 -0700 (PDT)
Message-ID: <b400a0fc-cfef-66fb-824d-c245de82a33c@linaro.org>
Date: Tue, 19 Sep 2023 11:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: target/sparc: What is CPU_FEATURE_FLOAT128 for?
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
References: <59e5fc47-cd15-f7b5-a0f7-c0620de33576@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <59e5fc47-cd15-f7b5-a0f7-c0620de33576@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

On 9/18/23 14:31, Philippe Mathieu-Daudé wrote:
> Hi Mark, Artyom,
> 
> I'm looking at the CPU_FEATURE_FLOAT128 definition introduced
> in commit 64a88d5d3a ("CPU feature selection support"). Any
> clue how it was supposed to be used?

This should have a comment like

/*
  * Qemu is emulating the linux kernel, which will
  * trap and emulate float128 instructions.
  */


r~


