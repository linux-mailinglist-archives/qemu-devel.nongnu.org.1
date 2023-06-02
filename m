Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFF1720AB7
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:01:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5BtM-0005FR-5a; Fri, 02 Jun 2023 17:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5BtH-0005CF-GI
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:00:55 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5BtE-0004e1-AW
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:00:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30af86a966eso2272362f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685739651; x=1688331651;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QQgiMqj1nrDoUhmtMqituV6lRR+7RjEBabHn2wUqlZk=;
 b=eLzwoUYaau215UbMRtOubc+C4pqn8Eal0M6NKdgesZZR/yvn0FKfVdYxxSTyZ9h2ed
 MG7GRHuEOv9YK5KViGspsTC7D32UTaRP6r0ushJndWpkMRF83i/EDVCHJl+GAgZ+IQUn
 6LlR/rcLqaIS5thyZwQ33q5VgGsXkStiwjc1bXVdwYFCUB1XjRuuv6LMWPvUi+9jfecX
 iZin+7Kms1TJz42W7lPGa/CW0za6fe1WT1DCoGO2mpfqQmvXWYkAMCQg2uA/pMsz68r5
 R8kIpOlgsfXxrJJHaxj7Y+3UdQO7HTJm1BK3HBtHg0uglHjId1IqbHzMaRwKK6BWOubK
 vrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685739651; x=1688331651;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QQgiMqj1nrDoUhmtMqituV6lRR+7RjEBabHn2wUqlZk=;
 b=aWYrKxvhkszsxqKOs7qafI/EwDwpKn+pFgmoW+vzTlgu24C0XvSOJFXHGRrCq5GzCq
 hM5GkGjGqDISwgPPkKvliHxHWVNz+PxSIu4+PGOyPLNHtYq3q2zyZSeLH3ZA8dk2ncaG
 qz5VwVDktxeA5dYheDqMUcuQHAZq+E7p3TqeBZh/pliDynMVQgfVjIek6vrL1wxEYlwy
 LtAnJ4n4QWrGsmr0Zi0ziiSZpM7lcWFbJQH/eW2Vw5bq/qqVNyudsZepLo575DQLN0Q+
 QK1x8qr1637dl6gTN0G5yXRM552PU8XQeWhRwaH96B/LVoCE7Gmor8RfO5HzdWIDolCQ
 J3OA==
X-Gm-Message-State: AC+VfDyNOBDfAL6/g/kzZCI/uxc2bgM5hFCijec9P+FfOmCG/V+CdQME
 ijZfUBCb3PuY0No4PH5pyOn+qIxIRlr4qIj13ds=
X-Google-Smtp-Source: ACHHUZ7ns9+sJi7asNUOrgqPfEps5alg3ncEyFUqFP7c13fh5SFRLVGc4z+7d3R3vmSvpdZKfTjIrw==
X-Received: by 2002:a5d:65ca:0:b0:307:a075:2709 with SMTP id
 e10-20020a5d65ca000000b00307a0752709mr651126wrw.68.1685739650845; 
 Fri, 02 Jun 2023 14:00:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 y4-20020adfe6c4000000b00307bc4e39e5sm2592647wrm.117.2023.06.02.14.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 14:00:50 -0700 (PDT)
Message-ID: <915444cb-5db3-fd94-bd80-3bd408e997e3@linaro.org>
Date: Fri, 2 Jun 2023 23:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 45/48] plugins: Move plugin_insn_append to translator.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-46-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/5/23 06:03, Richard Henderson wrote:
> This function is only used in translator.c, and uses a
> target-specific typedef, abi_ptr.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/plugin-gen.h | 22 ----------------------
>   accel/tcg/translator.c    | 21 +++++++++++++++++++++
>   2 files changed, 21 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


