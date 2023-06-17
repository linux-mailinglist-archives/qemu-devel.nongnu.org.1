Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4E733F5E
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Jun 2023 10:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAQt1-0005jE-Ue; Sat, 17 Jun 2023 04:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAQsy-0005hI-T0
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 04:02:17 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAQsw-00044o-N6
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 04:02:16 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f865f0e16cso140654e87.3
 for <qemu-devel@nongnu.org>; Sat, 17 Jun 2023 01:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686988931; x=1689580931;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X2cFLerjFBcAd4PCLzlkvaFncTNg1RbDoze7XAyeZ54=;
 b=zl2/BjX1g/qrd5sQ4lTs/RtwgYYy2kQmtbSB6STyEk6WF6H4Lo7EA+3BKrYglCDFQk
 Ov/4q/8EvUdg6dDtXidWyae37mtsp15MPkAUrq2EV4MmtUEssh1hw3JMHJUUTiyRq1rz
 /zgLk2ZvMIVvciE+xoZlY2VcaR/I+YJFSEdR8DKiSZg65MljF4R5AQ21D+qJ8mpkaI6l
 iZjxlvllENYJNUKrwuWlyYXGTRzgFVammME5GeW8hOtLMIohxolXk4TEw0MaYK5xop/j
 xIRW7SjGFtk2B5jediTSjksB1+s/eYGCnQTLg2A0NS7GrWHPTzP8qRgxAyEruXLhQpcK
 3nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686988931; x=1689580931;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X2cFLerjFBcAd4PCLzlkvaFncTNg1RbDoze7XAyeZ54=;
 b=afsE3Kt/RUg4WKeijRAGlhijkTaDpogIJ/s0m2Er4rhX+RWwSisUw7eMWNH/rLXfo9
 3bTNarNh89VkvBP1nMrbZ56Et6TY5MD0/3hEKynFLdG7OOz/qase9fSb8jn7/ocrtCoh
 nCJlv6ppBKK7Ah4PD9UbINkOZYmlSx7eJF1g6AMkQdPKUFTcgd6RL6Wzb1tX1MADA5Mi
 KHcPesy+HU/P9/yYq3lXR86hQCUA2gVeo+GLErycsQpZGcttZbWFOZjgG3l+gkQZX5Ue
 l+xsbY6vbXb9SuADqCrLcFgnwCqkTPylOC/0VN3yy9v5DNMg4NMMElqbZ1Ab9bIrrEuy
 kl+g==
X-Gm-Message-State: AC+VfDwuHHagIZTXMjWgtd3wv95dpR14FnMGiAxIFo9osWPO6O8bLSUC
 MeeWD7pRzCCfuSnWMxddpWCEgA==
X-Google-Smtp-Source: ACHHUZ45vwC80XhM/gfpKIeZ0H9pItpKTy23nTmG/KAG9M0JQD95Up6mwtrdBErMsm8Q2Hxajh+XkA==
X-Received: by 2002:a19:790a:0:b0:4f8:417b:c752 with SMTP id
 u10-20020a19790a000000b004f8417bc752mr2748068lfc.44.1686988930675; 
 Sat, 17 Jun 2023 01:02:10 -0700 (PDT)
Received: from [192.168.157.227] ([176.176.141.220])
 by smtp.gmail.com with ESMTPSA id
 q7-20020adff947000000b0030af72bca98sm25517908wrr.103.2023.06.17.01.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Jun 2023 01:02:10 -0700 (PDT)
Message-ID: <94568e05-3e5b-9e7d-06e9-1175d30104bc@linaro.org>
Date: Sat, 17 Jun 2023 10:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/5] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230616100158.1845239-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616100158.1845239-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/16/23 12:01, Song Gao wrote:
> The following changes since commit 7efd65423ab22e6f5890ca08ae40c84d6660242f:
> 
>    Merge tag 'pull-riscv-to-apply-20230614' ofhttps://github.com/alistair23/qemu  into staging (2023-06-14 05:28:51 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git  tags/pull-loongarch-20230616
> 
> for you to fetch changes up to 505aa8d8f29b79fcef77563bb4124208badbd8d4:
> 
>    target/loongarch: Fix CSR.DMW0-3.VSEG check (2023-06-16 17:58:46 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20230616
> 
> * Fix CSR.DMW0-3.VSEG check
> * Add cpu arch_id support
> * Set physical cpuid route for LoongArch ipi device
> * Add numa support
> * Supplement cpu topology arguments

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


