Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 147F8725627
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:44:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6nq4-0005H1-GS; Wed, 07 Jun 2023 03:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6nq1-0005Gp-4P
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:44:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6npz-00031w-Jl
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:44:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6042d605dso57097815e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686123849; x=1688715849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a7kFLTwd9oAcXvuZ2kL8/nrAB/z2NmDspgmdb6ajfa4=;
 b=mlRXlRW00vzb6rxZWr7X+XjEfx6MmCnVcCuxj7tOjv7pxFjIObNhzTnvnkkaAyvMD9
 yhM2r3PlI4CMTNouRT0Maza1YzS4ei3lE4g6gCAQD+biohr1E2/OzVCUS7Cwio/sJ4gs
 IkZ2WwaoAXRveN72DFTLzqtamHi9LRSbVnoVVAC2nioiiej6MIDqdWF1H5C/0TuQC+HQ
 tqRPEwnyZFMQA6nwbfUgiAog29BNZDERyG/pDcI2D34akN/ZeoH6dvnKb+hjjV1vaZ6v
 1QExnKqK0XbcANMIm7wi0NxX6KRwtwGOSAu7rKihWZqpxhal/nFxVDyRsVNvlVqegh9R
 3mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686123849; x=1688715849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a7kFLTwd9oAcXvuZ2kL8/nrAB/z2NmDspgmdb6ajfa4=;
 b=dmX7Y/fWAQTikaLLKAooNfKR/aeNLUCINZ8VEzoa4sLgk4NvjQWbZXjbNNghqO9Q0e
 VFVb9GGKoPmA0SJiC3ft06UatWy9mjwjUj7bZ3p7Rz8d6oZlrsHZq8NeSWH/h8dCC/+x
 3NbfzPN72NZyOErzL1liaY6bpAkhLCSFzpvMrSqgE8St3R+VY1oCVS0761v91JRXvkV3
 yk1YbZdjPAnfA9bJm6vHGMh8uOl/QVXkTb5oGYdlOt8pHIXThLsJXgXQrpMQiNoBWILu
 g1PdTMGUguDwq9Yu/WtT8hfOoBCKpIzTk6xZldtJKLbh9OLiebDcGNxvRDrp8D898F7S
 Lgew==
X-Gm-Message-State: AC+VfDxbQXrPCENpQT7BD3rj7T+4iEcRKc+xMSoCU4tVV0qE7Ueb4UlR
 kafpdWUAC8nSaSuu1TH/BXMjXPybhC6nQECMMjY=
X-Google-Smtp-Source: ACHHUZ4zPQcmHSuDUd8/P1PjJ4AKa0BpTZSCu6fzgPFzZqRz7Ftyy6CrxhIrF3LAIC3qxp9ozKkg/Q==
X-Received: by 2002:a1c:7215:0:b0:3f4:ed25:8aa9 with SMTP id
 n21-20020a1c7215000000b003f4ed258aa9mr3885130wmc.36.1686123849200; 
 Wed, 07 Jun 2023 00:44:09 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 s20-20020a1cf214000000b003f42328b5d9sm1162766wmc.39.2023.06.07.00.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 00:44:08 -0700 (PDT)
Message-ID: <cd95d2c3-6f67-cf10-8cfe-6b344e7eebde@linaro.org>
Date: Wed, 7 Jun 2023 09:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] tcg/tci: Adjust call-clobbered regs for int128_t
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: sw@weilnetz.de
References: <20230607054654.622010-1-richard.henderson@linaro.org>
 <20230607054654.622010-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230607054654.622010-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/6/23 07:46, Richard Henderson wrote:
> We require either 2 or 4 registers to hold int128_t.
> Failure to do so results in a register allocation assert.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci/tcg-target.c.inc | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


