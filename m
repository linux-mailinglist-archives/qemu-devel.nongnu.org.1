Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8B7B77E1
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:36:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvU8-0004wK-Re; Wed, 04 Oct 2023 02:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvU1-0004tz-Cq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:35:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvTz-0003Eh-Sz
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:35:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4053c6f0db8so16609115e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696401341; x=1697006141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8CjNCnxPhBG8t+PcRIaZiNPyCwtoEqsAzGE9d82aFhI=;
 b=gwrdaMZBgT4D9e4+kN2hq3Y9fHcnasUo1PlH2F/Ld6BgK4AqfrA9JvVoW/uoNb+DiO
 qYB2U2vxUhDVNnKtDov5kYU2LGc6KJ9McDAuOpKeFzs/clq7mJ9IDK+CdmS6v+z4wTaK
 QOcqX2yKJ4E7hU9N2j2r+QHtkVGyoApBcGHoJMOkwseFUi/o7W6b9eQcyUwCUNjloS1F
 9WTyQMBhPzJGWMrTSAZu9/8kVxEWs5QDB/h0sWP6sYQfgZqGd57fu5GjfQtKZvDYu1h4
 KRTpSX1PpYjuA5EFZ0V/nxpJ+8mi3Ja2MX8wBIvavAnmI3ATDXYBGCkPMj3KKn1Bm6sw
 uXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696401341; x=1697006141;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8CjNCnxPhBG8t+PcRIaZiNPyCwtoEqsAzGE9d82aFhI=;
 b=rABhAg5cpg4HQLjxfeQoQuViRnQkuyMwQt9nA1mxou+It5xicEgRbAuo/iDvwR1I9T
 YoPTiCaJ/J1R0QD8wV2ubZGmrZQQaQx4mR4PVyY7wSebR3CQ041+HTelntGCOpYJjJof
 BeCUtqcMyKq8uo24xP2bc7inJKhY7Aa9Rz7pKtwAdWEwtKNaZQM1OBfd0HQKp86NL7ld
 P6KGkTwefJzVBS5Xn6F1I763GatulaxvyWehqfY4CLK/TtxsVhhUSzmpJUIhRF2Fmtlx
 unh5WBSCtOkL1qYB13lNebhB/JRx4rPZUwViItVfWSineLrQejORcYhCuqXToDY8vKGC
 98pw==
X-Gm-Message-State: AOJu0YyytjNG6nCCJ96o3JioRZzf3ksmmfEUAESKi6X/Hn1wDhBB5dFR
 83926F8vc1gIKVaHtdUdHmy8DA==
X-Google-Smtp-Source: AGHT+IEcC36Hj73EyHL27OMG2m1Z0E8PAepu/EV0/0EPN3R8NLAlI8b/iLdior+Qf9lCnEGsVe3Lag==
X-Received: by 2002:a7b:ce19:0:b0:405:3e9a:f1e3 with SMTP id
 m25-20020a7bce19000000b004053e9af1e3mr1455232wmc.11.1696401341475; 
 Tue, 03 Oct 2023 23:35:41 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 f19-20020a1c6a13000000b00402d34ea099sm704709wmc.29.2023.10.03.23.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:35:41 -0700 (PDT)
Message-ID: <db51c0f2-ef57-7b17-ca39-63b97f103f0d@linaro.org>
Date: Wed, 4 Oct 2023 08:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 04/10] tcg/aarch64: Use tcg_use_softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003174356.1602279-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 19:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.c.inc | 177 +++++++++++++++++------------------
>   1 file changed, 88 insertions(+), 89 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


