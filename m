Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7342E8FEBFC
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jun 2024 16:28:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFE5f-0007rq-M7; Thu, 06 Jun 2024 10:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFE5d-0007rF-Mj
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:27:41 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFE5c-0000B2-1H
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:27:41 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70244776719so810305b3a.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717684058; x=1718288858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8iyO4hVGzXQ1gRLfepERlkHU/kNDWRHjPFXCFSwdizA=;
 b=uBqLLg+NRbRNdvKsTyCREkt/2283eRWuJcwFsN6AYHTPIuL+9vDLgNml5NsbyF4Ay/
 5JuWQ7K66XxyTY+2pIv1g3vHhanRByyAbe6tjZHuiKpNBfjmp1h/Tu8pgOYequvc79Tr
 3pDvM+rAlMkaomaox+wryQAV+E4bePxyd8OAJCprLLYQvufKNNutw1cek83iEWRkxCeg
 Z3UGBoxQ2eji2L46Fur12NkHc1RBY7vXIOp0/JUzArHs4P9QjFEmdLW10IFjFvwWehqO
 3IbrqUsw5w3xleM0yRCLXkGdaevNfxkVP1tanWFQvv2zscFR5gTFp/i+PY4f2Y5+zW/u
 cYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717684058; x=1718288858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8iyO4hVGzXQ1gRLfepERlkHU/kNDWRHjPFXCFSwdizA=;
 b=TZp1ib0/rOJybQn2K8aWEdckME8DW9ckmYkanMfIashZTLszzlkZrxbWJ0Xz3+RUyJ
 zdqd/4ak9eEaoLvTDJMJvD/c9pVFx8NzX9A1SJJgw+i0PPO+oOFDai7JUGILfCUn0XCw
 igQ8828zh1imUmO280hncLUmL8lK0JcsFGrbWSnkWMOIAFO85oVoGYdUaeYfphrddwKt
 lpCxRV8jflI2gRoEHC0UraRjfTnyFI9IXkx/FsE5q32fTnZ0Uf9McIPfS/x/nBYROGkM
 BjHVzM8BAYBWSIeM2N2iis9Wc28gYESMP7CLOAxlOsHb+3HsVICjZnX79s9RBR1Jvt7/
 EipQ==
X-Gm-Message-State: AOJu0YwZhn3u/BTaC2x+sGTiMQpO1j4eN06Xncfu7cimrsRJoJypxDSA
 ZOmTBPaZu/zsVCv7Vx/nwcSqGoBN3UeXD4S9h6T8uBOKb0gOd4v4smxxlwAHyHFGEMhOrEepGEq
 K
X-Google-Smtp-Source: AGHT+IF42v/vzcKJQ3qQLOveLxEDUiaQbijs325IGU7gOB5LTFKNugHbCprM8b0NMGzpsdOTV2zBug==
X-Received: by 2002:a05:6a00:4509:b0:6e6:970f:a809 with SMTP id
 d2e1a72fcca58-703e599ad13mr6237966b3a.20.1717684057999; 
 Thu, 06 Jun 2024 07:27:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd3b0bbesm1157686b3a.87.2024.06.06.07.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 07:27:37 -0700 (PDT)
Message-ID: <06806a86-5568-47ec-b5ac-25414387c59f@linaro.org>
Date: Thu, 6 Jun 2024 07:27:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user emulation hangs during fork
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel@nongnu.org
References: <mvm5xunu4ye.fsf@suse.de>
 <a0e9ee6b-fbe6-48af-a122-fbf5d31aa476@linaro.org> <mvmv82mscfx.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvmv82mscfx.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 6/6/24 01:27, Andreas Schwab wrote:
> Which ruby?
> 
> $ ruby --version
> ruby 3.3.1 (2024-04-23 revision c56cd86388) [x86_64-linux-gnu]
> 

ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux-gnu]

That might have been handy to have with your original report.


r~

