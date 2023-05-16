Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C337D7054B6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 19:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyyAM-0007JT-VT; Tue, 16 May 2023 13:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyyAH-0007J5-OB
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:08:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyyAF-00039X-U4
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:08:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6438d95f447so10011148b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684256920; x=1686848920;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fCEmR0N87NDQm7ekh6bMAQBrJNmgX8Adn0cOQE2lWzw=;
 b=r9/EWFJKrSFF52o8ar7r+xB/0eiPgaeuLAG/fWs2vHVgiKaF1OAh/T9105yvvca+qA
 gsjdKtOzXgmcHNG+aYNpOk2sa3bCdyX/1dqOMqY5Dyoz70yVwnDZub2DD2fYdXr/Mhw/
 SHoy4IZy4U9GmNUI+AbXuYqWC44mXeNJmb+BXWQaMYukgEhr2WC40KX8/eZ9xOjEmVAP
 aIY7hkkWAT5kXFE5n9W2ag8y6Walh6pkIUzn9+Jg4WGybakKN0q/q9YA+ohy/RKyPc4J
 y8miEOkfSMeANqoZajbi/hq6vpgodtG/MNW+xsWZLjWi1PK9cac3ipbB/Jjx54260rxT
 cQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684256920; x=1686848920;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fCEmR0N87NDQm7ekh6bMAQBrJNmgX8Adn0cOQE2lWzw=;
 b=BKQuDVQRCzki5s39Du9NJMFojMN0xTeI0u8c6f8Dk3qY4JjlRTyebHnzVuCR7QWIf8
 9pPTbimqqlCC/MPnT9Wfk+MqcwVjiH3+8o/LmrUd/kmoAr5vz/WAITqoHv4GG/xQZXuF
 ebYu90RJ/v23vwBMRbBGuvdzPRfwd0InUwizBZ1sBsytY19+B/5gPX+pYgswPJU2BLaP
 0apA3d955Q+azqFFlfWw3bhSnB0lhSIqc37o+/+QM4PlRhjXKZ/oDNu98oNm8wHO0W5Y
 cxNOQ4Ynb0lbkcJNuNiLccUX4PO+kdpkIPY8FYNjUenEEEnYF3p1EEEGwqMqH85kn55o
 ldWg==
X-Gm-Message-State: AC+VfDx2CHUG8fe0ARG7pnrbNJFYPTxPlH3Zzdb6pThs3cbS1xCezSWk
 OWJOlSV0Ngjt6ZwU9J/GBKq4VA==
X-Google-Smtp-Source: ACHHUZ6h9m4UcurWpHplDnzgdr3z3xm2NUPEK1uSVcDZKgFSuAOr1QUPzsa8mhBiv8hvEib/hfaTpQ==
X-Received: by 2002:a05:6a00:2d0e:b0:63d:2680:94dd with SMTP id
 fa14-20020a056a002d0e00b0063d268094ddmr53186420pfb.6.1684256920468; 
 Tue, 16 May 2023 10:08:40 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 c12-20020aa781cc000000b00640e14330d8sm13764822pfn.28.2023.05.16.10.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 10:08:39 -0700 (PDT)
Message-ID: <2377b180-797c-9057-114a-d9d3b61f5caf@linaro.org>
Date: Tue, 16 May 2023 10:08:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/9] Linux user for 8.1 patches
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230516124810.90494-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230516124810.90494-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/16/23 05:48, Laurent Vivier wrote:
> The following changes since commit 7c18f2d663521f1b31b821a13358ce38075eaf7d:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-04-29 23:07:17 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/vivier/qemu.git tags/linux-user-for-8.1-pull-request
> 
> for you to fetch changes up to c490496e85047d516b31f93ea0e14819e0ab5cf5:
> 
>    linux-user: fix getgroups/setgroups allocations (2023-05-16 12:48:09 +0200)
> 
> ----------------------------------------------------------------
> linux-user pull request 20230512-v3
> 
> add open_tree(), move_mount()
> add /proc/cpuinfo for riscv
> fixes and cleanup

The new test still fails.

https://gitlab.com/qemu-project/qemu/-/jobs/4295127220#L4423

cpuinfo: /builds/qemu-project/qemu/tests/tcg/riscv64/cpuinfo.c:20: main: Assertion 
`strcmp(buffer, "isa\t\t: rv64imafdc_zicsr_zifencei\n") == 0' failed.


r~

