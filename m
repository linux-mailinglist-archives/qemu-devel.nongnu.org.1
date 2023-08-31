Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E7078F3BC
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:04:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbnsV-00055Y-GH; Thu, 31 Aug 2023 16:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbnsS-000553-VS
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:02:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbnsQ-0005DE-L2
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:02:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so155623766b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693512169; x=1694116969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bTkmz8ZWMppg/A1ma3vUO5mNuiOGJTEQfcDhNTaLZRg=;
 b=Y1VqehV9Np23moWeu1KzwzWblOshc4madUgiKAcDYuvGJBcjqhnkYhsy9vscf7+uT9
 Od+4lkpXVR0KELSs5Vp44SJGAqKTftcPhp39y9YCiKLJD0MD9jWWYskQgKTTtFyH63fP
 FwomQ/igBHQDltTUmy+NhUvCG3JvQ5ElYwSBUFsFftb4YqDXJzuV6iArGcyE13w7FoeL
 iMzyNEYgxyWaNBKRmH5g2bxUQNhqGK2ciIHduPA5lFDbe9f9pSuV6WhEI4f6Gdi3atgt
 YbUSuFI1ZhI6bDoNYEGWRPGBfb/2O7kzv/c3Iu6UIi/g807Rw848tok/WgDqJGTSQjvW
 XP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693512169; x=1694116969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bTkmz8ZWMppg/A1ma3vUO5mNuiOGJTEQfcDhNTaLZRg=;
 b=bAtBIcPM6tmoiWwBkosf/iG0D67KHuuwNZB2PZxKoPsQOGtwqfW1SnTr7yB3T+705d
 QpTaajSDgJtlyB6hLTIHCPPlvsoauAuaJXlJw1xGttvzTs0zed8xNNk5bILrfPlx150k
 joMtFC4HCAjkHHbnIExWpUF+9LGKSEmrka55TO9m/vutaSgrzK6SAa65pTUp3syEw14Y
 hFka68PSyxMAAtd9jZRvidwSeK+j/3RyDBPpZyaVWddFbPStdUsrWCls00bSBWfA/Qlo
 YcF0qqFoKfEvqU2JbIGHLTB1R7/1XeII3GfOWsx1qqfk+1IoZNrdZGUDaVVsyuQX0GPa
 Jl8w==
X-Gm-Message-State: AOJu0YxDOLEyalo1Kt2b1Awv+iI/N+Ad57OKSRIxUFiJiYhaO/JdFjq7
 rekJJX1mlXFgPLjtC86xZHgpwQ==
X-Google-Smtp-Source: AGHT+IHqIqrYM46ZWT3oh1uw1Oezx6kSMIDqk/wakWLTAnxocIJ3OmsB6icPCHso9sEsCyruK39fsQ==
X-Received: by 2002:a17:907:272a:b0:99b:e5c3:2e45 with SMTP id
 d10-20020a170907272a00b0099be5c32e45mr266189ejl.28.1693512168944; 
 Thu, 31 Aug 2023 13:02:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a170906229400b0099bd1a78ef5sm1095266eja.74.2023.08.31.13.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 13:02:48 -0700 (PDT)
Message-ID: <ea2a86f1-23c4-f4c7-04b9-49ff08545ae5@linaro.org>
Date: Thu, 31 Aug 2023 22:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] target/riscv: Use accelerated helper for AES64KS1I
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20230831154118.138727-1-ardb@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230831154118.138727-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 31/8/23 17:41, Ard Biesheuvel wrote:
> Use the accelerated SubBytes/ShiftRows/AddRoundKey AES helper to
> implement the first half of the key schedule derivation. This does not
> actually involve shifting rows, so clone the same value into all four
> columns of the AES vector to counter that operation.
> 
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: assign round constant to elements 0 and 1 only
> 
>   target/riscv/crypto_helper.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


