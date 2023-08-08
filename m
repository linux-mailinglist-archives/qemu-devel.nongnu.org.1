Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9177744E2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:31:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRSa-0003q8-FM; Tue, 08 Aug 2023 14:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRSX-0003oZ-OS
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:29:33 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRSW-0000An-6e
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:29:33 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-268bc714ce0so108248a91.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691519371; x=1692124171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4kHWk1Q/PwN6qB7mVj6UYl8MgVcJoJIge7LSkKO3CLA=;
 b=l5tDsM4OtOYBiLPKptKxx/NdwtkTcC7xszTzEVjKs69G3R5PptbK/2oHsmyVpNe+2e
 1vleMkxIRCpOxVeycMQNBdA3PqQdIuYGx5YHYu/+SODH9ybKWUxBcKFzo3hUFhYMM/0z
 1oPUY5PnhBKynlB9mCMu1jt/2Si1ldEKYu9Ps2U/SeJU2yLFTBULRudDhzaqjzsqK2CL
 d60m4DiQTdWkU70MG1b9aXLasi4c9ETS3+6yslk0SRJ0A1gcyt7qFWkt3vB9qIRRsDrX
 YkLohBvLVhhW+0Ia4aTdAFNpwcCF+citvyed+hbGNQYcUdCK0yfWpJsgVwsgVq1mwYK1
 UOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691519371; x=1692124171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4kHWk1Q/PwN6qB7mVj6UYl8MgVcJoJIge7LSkKO3CLA=;
 b=fk8be3RAdirQ/eTnw6TDd3Dgv93OfIUlAC0UBvGrqpWx8f6qPU7KZoBjK9+6Eq543/
 8eiAnYk2cvF6JnSskommQjPCw15xPnOfy2SDXHdANc+pOmlaOUApKibR/vxsv5rmbOsG
 SIQj5DDiEJuLMQb2e1f5B4PakS3C20oWaheXKvKqiDLnLvf4S2CCDIpTvNfRcbfZoUgP
 MwH629IX9E73CpyPIYiFMxnedeH41dMUp8FEqsbj+MKIt9GmlAFYduHVpajERqhdXAgt
 uskAV9mBCyXCVymnWzNERGFNvrcE6BXZB2uxZXFcD8qOnFoZ131DoYShun/8vqD9cfVp
 DjKg==
X-Gm-Message-State: AOJu0YxZIQyJNgR0qzrdzGDcvWl9eXOyjk5Hqk4ME/Yi9FMMEX0QKr4t
 O+vKG+PhN8SPlQOOfl2CIYnqqg==
X-Google-Smtp-Source: AGHT+IEsJgrw/6BA6rQZa9O1U4/sRhMZalF/HQMd48zsbQ+SQIL91virR7oX8XIFzvQtfQMuX+wabw==
X-Received: by 2002:a17:90a:480a:b0:268:5b19:c35e with SMTP id
 a10-20020a17090a480a00b002685b19c35emr12847168pjh.6.1691519370676; 
 Tue, 08 Aug 2023 11:29:30 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a63714b000000b005633778becasm7086446pgn.41.2023.08.08.11.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 11:29:30 -0700 (PDT)
Message-ID: <0938f9c9-98a4-7238-c644-3eebd8964f87@linaro.org>
Date: Tue, 8 Aug 2023 11:29:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] riscv: zicond: make non-experimental
Content-Language: en-US
To: Vineet Gupta <vineetg@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: kito.cheng@gmail.com, Jeff Law <jeffreyalaw@gmail.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
References: <20230808181715.436395-1-vineetg@rivosinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808181715.436395-1-vineetg@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 11:17, Vineet Gupta wrote:
> zicond is now codegen supported in both llvm and gcc.

It is still not in

https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions


r~

