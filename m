Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD5970E969
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bDx-0006ow-AE; Tue, 23 May 2023 19:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bDt-0006nh-Rg
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:15:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bDs-00064M-8C
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:15:21 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64f47448aeaso92446b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684883718; x=1687475718;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VJ8vvIz03QK/Am/P5PPi6e+Ex+weJOXye4jWDybuDfM=;
 b=WfEsLCh9UIN2oLFjE9xQYmD9+gHDrXdYuuclY+sOR4Njdl1It05Z/QwDSeZfWnwyPK
 DG3ZfRSu33KXwFTQ5yeRFlEVwYABI4pmDrpzMxvmpjcz02umnrLHBd+SltESI9yGmjiz
 fFvYK9jKmBx1YDR4ofKzB8g3PtfXWaZLyrudPiQwej1KFRmUqmSzbHR1qzEf0XqTyNuY
 0SH/3P8lF3u03fQgFwHNgxZ4DuqkG/ZX0NGd3LT2HBBmni6LMix53eC4QXdznJda4avL
 sOiS+64mheane+X2F48XmnMU0lHb/akDErYe9ODvglwWNfaHBGcW69yNQMlWmuds3JMT
 rTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684883718; x=1687475718;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VJ8vvIz03QK/Am/P5PPi6e+Ex+weJOXye4jWDybuDfM=;
 b=JXa4enaMUCbqxWjdh4D52689bBxGKWJrqqfmRo7/ANpL1N3/owWspZVr3NiTxz35q7
 UoLGYnWQEUMcCzUFAa445eFhuSqkN1Mc2TbVa2wenKPeCg/3QOrrqJ35eqDsVXysBYAd
 ucxKC9eVNh3hEueFnwXyFuRuVARETRIaNT9MI29SdXSIwQKhoE2zlo5nTIAOoLVSDiLi
 FoxApwRCwCOX0dOC4c+eH7xqsfAVd66h03uIqjIQDrJLnG6WVNdbC8smtY99Obvawb44
 4YZ8+iOfOQS/bb6dx4lhLF5ZVY+UArX+fzqYntsSCLBx/11YB0x5aCfwFnneQHDgzibG
 4uBQ==
X-Gm-Message-State: AC+VfDzUZf7ENdc6FaHoCGpAJuTQcJz/uWUdDkUDpe6FE55X4U0dKDzo
 pLsckXqQIXHn+uJhvC+4JNNTR2fAQn6PgN4aDPY=
X-Google-Smtp-Source: ACHHUZ7hTb7FV6E5zQ+B/bJpPTJF2DLtFkhCWr6phfpjympD10GO5DB7cXGkP40vaPpl2T7vcWwfKA==
X-Received: by 2002:a17:903:2287:b0:1a9:bdf8:f551 with SMTP id
 b7-20020a170903228700b001a9bdf8f551mr18243015plh.69.1684883718658; 
 Tue, 23 May 2023 16:15:18 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a17090ab38f00b0024752ff8061sm94060pjr.12.2023.05.23.16.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:15:18 -0700 (PDT)
Message-ID: <0f9ff5f9-fa26-1ece-97e9-1181d87a2f2c@linaro.org>
Date: Tue, 23 May 2023 16:15:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 04/11] hw/scsi: Rename target-specific source set as
 'specific_virtio_scsi_ss'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
> Following the SCSI variable named '[specific_]scsi_ss', rename the
> target-specific VirtIO/SCSI set prefixed with 'specific_'. This will
> help when adding target-agnostic VirtIO/SCSI set in few commits.
> 
> No logical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/scsi/meson.build | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

