Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D36D67213C0
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:07:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5aJa-0007RG-V8; Sat, 03 Jun 2023 19:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5aJZ-0007QX-6E
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:05:41 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5aJW-0005Vx-Od
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:05:40 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d24136685so2533834b3a.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 16:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685833537; x=1688425537;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xpQwXi2Qlb2MDi8WtoNb9saG0RJz2uUyMXLjvIiNrSQ=;
 b=rRGOniqXpH1dzhIj/PwMXuwXQAP/kBh0C02o/KGDEEy7vVafKsBY5MXUOiCydim58G
 c8WtQbYkXAeXWwv1opKkXQdLqB2Tv189PofZV/lzQFpfCmzHzQHifjjBKwaMJi/NOdc5
 YC4apg0AvfP2efZpuTd6z3lBRjLKSCEx0o4BdIO50aBswhFXFz7Z7mpWKTxUHqnjRW45
 67CVDH+56c5fWHStDhqbjs5DNc5fQ7qW0hu4dxLGtphRBe7H8gS0ELzhrgOs+K4Uwarg
 tjZi9GMCt3LZRJxluUH9eSpeEif2rihzoWd8+i/YbKw+5Vxr2CkjQQ6fzZ6nZFCq1d8H
 PvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685833537; x=1688425537;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xpQwXi2Qlb2MDi8WtoNb9saG0RJz2uUyMXLjvIiNrSQ=;
 b=BNbDFSIJ+FeqGSwiwhRxURnCbmfgBk/oHnoPoqOcJb2HkM/SKk0JhOlCVb+PbYFP4g
 /3P5x8bw8IDFgS8qTXX7dmKo5Fj2X+FMD1Tn6dlez9YsOcBuQreynT8EOllWPe+S4sb4
 4N3MuJq/4+eWFgp9jBHYY2R2RsQR5xLipZiqpQ6ZP6SToYeaP6WIZepbNDRom0Oq2W0j
 IUK+GfRWJatc9e/kkyphnWqRHCS1BDZjXoUQGR+qCY0exJp2eRKk/x/s50yPu1oe1pdc
 k12wGtb4ndANXIyu0mmvivy1uxMgrBa+Ry8pxC1nYMY//T6QV6Xi5MB6KyWSEcOofB4O
 DL0Q==
X-Gm-Message-State: AC+VfDyo2xHh4E072lgOOgh3xmzjyWrUC7jy6Kgll8yM4QvtXT0Slc3S
 uwUlxBQBZ7aojks3/7z8C2J5bw==
X-Google-Smtp-Source: ACHHUZ7JBZzRQ6aKwpvEKvuEDZmqXJorgfSLe6uGAA/ufMQUUBxdCyXpCv8V2ULy+y9Ah7TdpIzySw==
X-Received: by 2002:a05:6a00:369b:b0:64d:42b9:6895 with SMTP id
 dw27-20020a056a00369b00b0064d42b96895mr9602418pfb.5.1685833537142; 
 Sat, 03 Jun 2023 16:05:37 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 z6-20020aa785c6000000b0064d2ad04cccsm2924006pfn.175.2023.06.03.16.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 16:05:36 -0700 (PDT)
Message-ID: <daa2b742-7a4c-0bea-c483-1da660ed0dcd@linaro.org>
Date: Sat, 3 Jun 2023 16:05:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 11/20] target/arm: Convert load/store-pair to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> +%imms7          15:s7
> +&ldstpair       rt2 rt rn imm sz sign w p
> +@ldstpair       .. ... . ... . ....... rt2:5 rn:5 rt:5 &ldstpair imm=%imms7

FYI, you don't need to extract imms7 -- imm:s7 inline will do.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

