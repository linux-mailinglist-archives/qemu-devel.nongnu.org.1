Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E5872A1C2
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7gPl-000483-39; Fri, 09 Jun 2023 14:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7gPX-00045o-3w
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:00:33 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7gPV-0006RM-5K
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:00:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b0218c979cso8010675ad.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686333627; x=1688925627;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pGfITknA4PI5GU0o/TSgUux8JlN66WcsspgE4IcSdEg=;
 b=Esh7LFcqozH1wYcvAFm+bulZft8/JZFmln5gIFoGQxS1kRU+E1MO2j3ndqT2ut84/s
 C/qKCdo61e+oQAnZJEEyceaJFkQ01wty/8JPDXuk5KGPulazaCt526kc6MDNH4730yDU
 2rnseiSW3ayw4CWYNGjmdhIMRx9fpE0R0mPltwMbNRiQ0yHPCHQ7OtK9VjQrkmFgnH1B
 53bwdZSGnzJs7DKGsKUae9LYL2O6IrxfDaGqyItxvkGAHXOp5/kuibXJXxCQIhHj4tGH
 2uHtaMdAQf696fQr4GghfI3AHqyqdxCtyKb41RozePg5C7OGNMItHFYI71zF+saVFwLi
 OfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686333627; x=1688925627;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pGfITknA4PI5GU0o/TSgUux8JlN66WcsspgE4IcSdEg=;
 b=LKscQ0wgggzz2hEU9Hga+XAHyDZf+lrtkcVbiD1u7CttlgICiMXJW9+sqFadSvZ6IM
 AAWvIcLnv3LJrAuttRZDGJW9DjwWeWBl22grdSHV566VwVL0dvBlxQgAEDUOTK4IL0bB
 HlDKCsw4/1OEKKJxctpXqqAMR752EPkw57fglsQcQUPSBNes1hOfnaHaQyxzEM84dQzs
 5saVw5CrMcH0rGBgTK8LC7ruHCy0AyQibRjJ69JdJB6BU+ON5az0DFoBABO5xoWhpuV6
 kaLQ0vto4XF8Wb3StCTwgUv72agliEXA52PVaRq+y5TSGU8jQCBQgPzWuIJtDBbyWm24
 yrLQ==
X-Gm-Message-State: AC+VfDx+nfqwh2URc2dJ/apVtcBzIUsHpIwbjNh9QWyEL7Nr+85B3Z4S
 sGFd3TcaHYB071SINCQbES4NOXU91+og5Np1XK4=
X-Google-Smtp-Source: ACHHUZ72Pkttfds/Xz1/Y8wG441G/BjniYxtWf1mOrz7biYFLPsNUT084yAIfiSwHEBI/KdGhtkI6A==
X-Received: by 2002:a17:902:7d98:b0:1b2:1825:813e with SMTP id
 a24-20020a1709027d9800b001b21825813emr1516004plm.5.1686333627513; 
 Fri, 09 Jun 2023 11:00:27 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 19-20020a170902c11300b001aaf536b1e3sm3557877pli.123.2023.06.09.11.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 11:00:27 -0700 (PDT)
Message-ID: <6d9aa9c7-38f5-7f07-aa38-25e08e08bd98@linaro.org>
Date: Fri, 9 Jun 2023 11:00:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/1] maintainers queue
Content-Language: en-US
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org
References: <20230608182122.1794691-1-jag.raman@oracle.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230608182122.1794691-1-jag.raman@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/8/23 11:21, Jagannathan Raman wrote:
> The following changes since commit 45ae97993a75f975f1a01d25564724c7e10a543f:
> 
>    Merge tag 'pull-tricore-20230607' of https://github.com/bkoppelmann/qemu into staging (2023-06-07 11:45:22 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jraman/qemu.git tags/pull-maintainers-20230608
> 
> for you to fetch changes up to c45309f7a40083e5034fcb19e27e3c0b1b5ec6cd:
> 
>    maintainers: update maintainers list for vfio-user & multi-process QEMU (2023-06-08 14:16:08 -0400)
> 
> ----------------------------------------------------------------
> maintainers: update maintainers list for vfio-user & multi-process QEMU
> 
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> 
> ----------------------------------------------------------------
> Jagannathan Raman (1):
>        maintainers: update maintainers list for vfio-user & multi-process QEMU
> 
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


