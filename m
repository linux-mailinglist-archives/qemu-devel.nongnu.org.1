Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193E756CE6
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 21:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLTey-0007G2-Rn; Mon, 17 Jul 2023 15:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLTes-00078m-N0
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:13:23 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLTer-0005td-9r
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:13:22 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-768197bad1cso218974985a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689621200; x=1692213200;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CIq0yyaQNKhdyDzmqiwUukNVbgxGJgiY5lXBnt+WyOo=;
 b=rQRYEUUEDSqTJX6JqP7GiIZ+okEp85QZsUXhKCLq31XTeYdmkwVCPnJ7fER9XKx2tg
 95C4n+yDA47dBh+03B8X8prF/fzOSYxCquPMlUaWPuR5OLjV7NpyGF1MEz6+JomiJnl7
 2EkEtkdzWD3XccvNPJpuFZEnXUxZMZBN4axsbpyjAwvUTKh7BmFBCu2pAOJzpXta0qTL
 ijlC8lhJ1cG3lSvu1Z2w7CrUVq9gi4XC5/Z0DCRmQ/f2y/DmoXC0azBmh3eyHSq+R0YV
 d3EbcDwasND178kJ9NN5hKvimHfzaHjFy4hLQDf0bVlcI9UtRTNzr370iEjpoMq2Vm2T
 zsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689621200; x=1692213200;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CIq0yyaQNKhdyDzmqiwUukNVbgxGJgiY5lXBnt+WyOo=;
 b=QhGyoLrnzgnTcfyZ8u/FhWwnlO9SxPv5ZfbkqyFI9am2wOZ/pSv+SOuvXWlRh0CDvm
 BO/Uu3R/CE8lbIJ6w9Uj2b/yAw74gbduS0k4ub6MxcxtHhF99RzhyR2jC7/yq2QQdwaJ
 EuJdagNScu90tceNCYfJi7WQ8dM1DjGuU9gkLcWv/q1zJtkGBqsxcCTzS+uSpDZWsEpF
 UapV7QL8sLTDHjB/sUVSAxGdTsNZ4Bvnl+o8VrtioSe0mARx2e0SanLzpfvpBKMPzOWO
 xFrsEvWjPc40GvlBGwoiQqnLGO6sWto9BHIe2a9/9pmRhUs5FAVborhXtFUaFpnzoD2I
 vbUA==
X-Gm-Message-State: ABy/qLbS97oSAiIWtffB1L8l1rHMBTkS2o8mK7w+LynMmrB4i+F19jqV
 GRV936DXw0DGDWWPcPL1yQAUzw==
X-Google-Smtp-Source: APBJJlFwzbzCEx94saEd/dLIpqEp2Inc5WQgjbT3BHLH9FNXlWJDUy46QsH7fzdP6izsC9mwf0fhGg==
X-Received: by 2002:a05:620a:4151:b0:766:fc47:fa00 with SMTP id
 k17-20020a05620a415100b00766fc47fa00mr21967144qko.29.1689621200392; 
 Mon, 17 Jul 2023 12:13:20 -0700 (PDT)
Received: from [192.168.224.227] ([172.58.27.30])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a05620a10a700b007677f66b160sm6316578qkk.124.2023.07.17.12.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 12:13:19 -0700 (PDT)
Message-ID: <974b78d4-905f-70d9-6c25-7ee409c42437@linaro.org>
Date: Mon, 17 Jul 2023 20:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL for-8.1 0/1] Block patches
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20230717143733.448253-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230717143733.448253-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x733.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/17/23 15:37, Stefan Hajnoczi wrote:
> The following changes since commit ed8ad9728a9c0eec34db9dff61dfa2f1dd625637:
> 
>    Merge tag 'pull-tpm-2023-07-14-1' ofhttps://github.com/stefanberger/qemu-tpm  into staging (2023-07-15 14:54:04 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git  tags/block-pull-request
> 
> for you to fetch changes up to 66547f416a61e0cb711dc76821890242432ba193:
> 
>    block/nvme: invoke blk_io_plug_call() outside q->lock (2023-07-17 09:17:41 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Fix the hang in the nvme:// block driver during startup.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


