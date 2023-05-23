Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3409670D7E9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:53:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Nky-0003E7-KY; Tue, 23 May 2023 04:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Nkw-0003DP-Pb
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:52:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Nkv-0005G6-3l
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:52:34 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3093a7b71fbso6809988f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684831951; x=1687423951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rYJafVqFSXzIBZK3HQUrG2l2qkIP+m/o36QVuS12J2M=;
 b=Af6cEFUS5Tg9hpUKM/MV416B4LyCWaK2rBhQuJYTLP0FdCGMzlaco70J7sul72MNT+
 KePB+6pf4tRG/HVDN4Rrj8MVjoZDFM+wVfx8J+6KqKLQ5yktEroHXrSEnScUvX9onRyx
 ncR6l98M/F0rIDcd2j4zq4i4ZNgJIgszXFiT6x/HDdGGx5fFitNr/CTVV9ec+pbHKP5m
 ekNuvPgKH2ytQMLVML6metr3lgqeG2Q8nR5VcgSohqCnl9KS/007AW+mkbCCl7TIqzb6
 bWeLpoQiJCQ62y0gE06yk1mdSPRQyNUnUht0yUNKYxbX5Dk5ZBUANnZuDzDDyaWMCd1P
 X8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684831951; x=1687423951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rYJafVqFSXzIBZK3HQUrG2l2qkIP+m/o36QVuS12J2M=;
 b=OiVFNVgPPEcmF6ebvR5yqt9Rt/AMCkNBtvkQEKIRqRg+0/hEKfKnI70urw1iu27s3g
 py+8kn+/REEsQfeg4yDT4Jqko5WCeeJ+Tx5dNH1ZRDiaFkjHJXIJJYLlA51iR2mo6Qqd
 CAdiP/9bLk7ScMRHSH6LBMw+EP86bDv8YDiC355DfJCOhCWc0Ba69DJ3KU2yiurKb7MC
 uUygSeX2aT/5GWJZ9ZxnSIkNKijRTvmlwvokP9Mcs2jGjNVDLs6cu6JbbnmxS/N7UmDQ
 rl/JozT7v2VicK3JPkrMTVXGgw5GURyfwqNpZUMng9OAjABnVYnyTMe1vulBJOxaB8cJ
 B/cQ==
X-Gm-Message-State: AC+VfDw+K6vlp/tpBVo18F0deRFGegB6TvzxQD0l7sHKNwOBysNhlpJo
 5T/bRrQ9GSqIATV8DU4A9SjOkw==
X-Google-Smtp-Source: ACHHUZ7IwXrnNiu7ZrLresMsWjnXCXoyxM5OnzSq5U8By7PpwukbRA1GISPoI99NW9sDHDR9cfWKyw==
X-Received: by 2002:adf:ff90:0:b0:309:ccad:b2fb with SMTP id
 j16-20020adfff90000000b00309ccadb2fbmr7575566wrr.5.1684831951373; 
 Tue, 23 May 2023 01:52:31 -0700 (PDT)
Received: from [192.168.69.115] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 m22-20020a05600c4f5600b003f07ef4e3e0sm2803110wmq.0.2023.05.23.01.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 01:52:31 -0700 (PDT)
Message-ID: <df00a5c0-7b59-e21c-c758-b1085d0c50b7@linaro.org>
Date: Tue, 23 May 2023 10:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/1] Add vpd data for Rainier machine
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, andrew@aj.id.au, joe@jms.id.au
Cc: qemu-arm@nongnu.org
References: <20230522153659.3379729-1-ninad@linux.ibm.com>
 <20230522153659.3379729-2-ninad@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230522153659.3379729-2-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Hi Ninad,

On 22/5/23 17:36, Ninad Palsule wrote:
> The VPD data is added for system and BMC FRU. This data is fabricated.

Per 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-meaningful-commit-message:

   QEMU follows the usual standard for git commit messages: the first
   line (which becomes the email subject line) is “subsystem: single
   line summary of change”.

In this patch the subsystem is "hw/arm", but you can also use
"hw/arm/aspeed" or even "hw/arm/aspeed_eeprom" for subject prefix.

> Tested:
>     - The system-vpd.service is active.
>     - VPD service related to bmc is active.

   ... more detailed description of the patch, another blank and your
   Signed-off-by: line.

Missing a blank line :)

> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   hw/arm/aspeed.c        |  6 ++++--
>   hw/arm/aspeed_eeprom.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>   hw/arm/aspeed_eeprom.h |  5 +++++
>   3 files changed, 53 insertions(+), 3 deletions(-)

