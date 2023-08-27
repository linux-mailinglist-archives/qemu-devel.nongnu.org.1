Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21F789B70
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 07:07:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa7z4-00013r-Dr; Sun, 27 Aug 2023 01:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7z2-00013j-9f
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 01:06:44 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7z0-0007ze-3P
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 01:06:43 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so17701645ad.3
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 22:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693112801; x=1693717601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bnMlfYVCjmVZsznukeDMmNxh/UR7hNIs4dXlqc9xRJ0=;
 b=gseHEeI9fUBMcCXnRx0kePt3N6fyygVDDRRbVbNWbHJoU7yz9x4nKZtkEjz6M8O5aA
 46ClSnGKEMWPaM4JME8h8fRqO89o2imQMd9+Wgest9iED8au+t00R/xZajNT9OWBiG1C
 yRIoXR8H2cZhXx5PJijzTQrGI24rUYAQVaY/CksUZlCi72DlHjTIqpFiC0pAOLwpzgsY
 Ssn5e7u9MOAN7G2gGvYsLnkp1M0wTXWvH88m5HgJqn7LkQWdmZEi/pAibfihgYatTom6
 0xzFP87OeKVaNirYXFYA/15Fm+j+Qz6RTMp971cQnCRRXdNxUn1lNoTaTV3Rps1bjs/L
 YNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693112801; x=1693717601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnMlfYVCjmVZsznukeDMmNxh/UR7hNIs4dXlqc9xRJ0=;
 b=aR61cj3es4rjOusgYC8XZMOBLbGVaYis9seTKJYn2ecXaNbmv3Tx5f+tSeUsyGiPj3
 Ko9Y33RX4bdm/10yrp13lgkKp1gjmjl53gGa5pbvLY7jSFz+PYJwqGAtIzyj9a9jSbFr
 /TxOFc/jn8dZbzoUn+2elP986wYhq5SFXi3CsmL+aWjxlG8BsgMP+Vrk2GpwiBPFBmzW
 mAJAm8NV8SzVpK79b1jDr7QAV/CsNfLl3/6OwbOcG38s6xsQUYDQc57URuYyGAhwHh9Y
 WdzPk1aIHviy2MfGzFi6y8nK4g4oQ1syy+dWKJ7OHU94HWeC615q6HZ4B3Fd4crPCi/W
 exTw==
X-Gm-Message-State: AOJu0YzaH+7KQCW3ttetzW5w/dtP+wn7/yEAiM0Lr1tHb1SgxAH9qaLx
 tperyVGcCDtJkgJcJfMjbcSK/g==
X-Google-Smtp-Source: AGHT+IGEQTK/EMQ5zewAG0OzilcciDqx8L4Upqi7/OkKmXiDUtAu5dTfASd852JQNP+eLoPudIGtAQ==
X-Received: by 2002:a17:902:b7cc:b0:1bf:8779:e03f with SMTP id
 v12-20020a170902b7cc00b001bf8779e03fmr19121339plz.68.1693112800690; 
 Sat, 26 Aug 2023 22:06:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a170903228600b001bbb22652a4sm4588815plh.226.2023.08.26.22.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 22:06:40 -0700 (PDT)
Message-ID: <44e2bbab-7024-a296-5740-375b9da9e060@linaro.org>
Date: Sat, 26 Aug 2023 22:06:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/10] target/tricore: Replace cpu_*_code with translator_*
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-10-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230826160242.312052-10-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 8/26/23 09:02, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

