Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B327776BB1
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 00:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTrI4-0007SC-G1; Wed, 09 Aug 2023 18:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTrHu-0007Rc-Bq
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 18:04:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTrHs-0008NQ-HB
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 18:04:18 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso2924175ad.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691618654; x=1692223454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JpSzuVjrJ9U8iOviJPkno+RABJdCzE0hv+vIKUsBA4k=;
 b=BBudCVgNRtKvjcT0FPB75/zsm4eGjQB1WM4vJrYrstePpWSPwamkgAveNAWkW7LcjX
 oA/96/Aiv+EGkzN2G8688U147DP8fXt89RIEU8yhun8sqrTpsMqiFW8bxveXzRGK3Lib
 4DP8NcWkAGNmMcXWmOA7kIE8cMl2yyVykIVlI6GWW1QsupWs9iwB5Or1mMrm/PLWVUgM
 5TEUBsQz3Wo0JDXEAQN04WW7Am3SfKp+Ut5s+tdk92FAjYf4QblLamoNQN/t+IxG1wzg
 LIbaWdxAM8/XaNQBkBVM07QCD/8SPbwuD38p0eafIQjZmMYksg/v2DmIyb14VJ/F5XSN
 NThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691618654; x=1692223454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JpSzuVjrJ9U8iOviJPkno+RABJdCzE0hv+vIKUsBA4k=;
 b=Or6TVl6MaeCzDnlkLC2DHrIujbflf6QCUCBHlLSdP8ucXRKIqJzqE9e4RQeRnufato
 REScasBVxTzoAdqv2ajwAUJedeotcCiPIxwigNIaOKNEM3ykcLQ9fAUOisRNsSNtxuoT
 CgoF1Dq3gNMesai99mP21B0f9rNe+3XBMUXxlifVcejl1fuJjXNmWw7hokAaQZ0HGnUC
 AJE8e8ZHVaO4MWlqPScItTsvZmOaAc78vtJmA64JMkDmc+s7ZgiWcc4K03q5D8Gj+WwF
 Io4w3vXdOdGW2S/7I4DQBqMfA1n+v7BIsqoXHoZgyIS59wuRC3w2CfsskaO4pkLqijed
 qQ3Q==
X-Gm-Message-State: AOJu0Ywe4B5PjNPIdts/gnuN96vhebRmcrXA01vHUt1fJtpaLxl21MDx
 H2/QXcEbc90jlhsr6FrNagR9pg==
X-Google-Smtp-Source: AGHT+IGBcOfmmB3h/eM3eZ2EnM/iutza4m++1rgXAb3yVCSS6oToPmwqh1YF0t4qIo6nN9URc/4FwQ==
X-Received: by 2002:a17:902:c40b:b0:1bc:921c:eb48 with SMTP id
 k11-20020a170902c40b00b001bc921ceb48mr477654plk.34.1691618653980; 
 Wed, 09 Aug 2023 15:04:13 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a170902daca00b001b03b7f8adfsm17239plx.246.2023.08.09.15.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 15:04:13 -0700 (PDT)
Message-ID: <095cf8cf-f0b4-02ad-b555-e52e67343b4e@linaro.org>
Date: Wed, 9 Aug 2023 15:04:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/2] hw/nvme: more fixes
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230809133909.45818-4-its@irrelevant.dk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230809133909.45818-4-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 8/9/23 06:39, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit a8fc5165aab02f328ccd148aafec1e59fd1426eb:
> 
>    Merge tag 'nvme-next-pull-request' ofhttps://gitlab.com/birkelund/qemu  into staging (2023-08-08 16:39:20 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git  tags/nvme-fixes-pull-request
> 
> for you to fetch changes up to 3439ba9c5da943d96f7a3c86e0a7eb2ff48de41c:
> 
>    hw/nvme: fix null pointer access in ruh update (2023-08-09 15:32:32 +0200)
> 
> ----------------------------------------------------------------
> hw/nvme: fixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


