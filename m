Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEA570D1C4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I6k-0007EY-96; Mon, 22 May 2023 22:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I6i-0007Ds-Au
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:50:40 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I6g-0005io-RE
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:50:40 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53482b44007so3473632a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684810237; x=1687402237;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CmON1RQTBqk9irFHaSowtyGJidedCMYMcXFHXYxVm7U=;
 b=WH/p/Lc/L+EcDY2kP405WmYGGJxycrMOncOhflssfnI86a7iI/+Bu84VwsK5bb1Mpz
 Z9mWDjGSCDd0i8E75q4yEwx5NhMfRPehsN9TCKhEoP8cA6zTZvaRwc8X/3sx9EHBizRC
 SJvFm0h3snBc0y4To5szBMiiQLiVq5+Zk/bEqbNbHM41DfOWKhfV3mWJKhpOP1U+rLer
 gvLR7YXxS9Pbx5Dd2kE/R1INpXkA9rVl1t6h9TAGqe7ekeLmBYwlXnsU1JvoRF0+PEI1
 Nmzd0pwduD714q3pyXGkN1qlFv+V62tuqXcVHTJZ87ugDtLP1U7b74AnhGuKcDzqzK4l
 tRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684810237; x=1687402237;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CmON1RQTBqk9irFHaSowtyGJidedCMYMcXFHXYxVm7U=;
 b=dd+PqnuHyfIsYXQQ/IcKP1U7sbj2lkJAQ1eupIkLXi5Mmwa5Y0hbJRY8GxCoaKHiDV
 r6G2bJaEWBQLjOOhaiP8rbEsfmII+HxL0nXKzM+sS3oJMfHI+w6xRXiuSoUDEvWITUib
 n/JDf40vaXqm6kuzUBo0PbA8agOCV+VRFbjzZRbmESW7NTlPvf3Bn6G998Ug5qqztioD
 4Jz8KkoeYnNFGBqjPzPz6RHtUxJViSoiaVHE9GTD1boOHaNA5ZVAMazcvz0dPD22MPQ+
 HjhddKkx0l3IvEwfIK9Ro27HvKgsAF0OtHpcGf3xZ3wRBegQjrSJiH+lI548AosmTvN8
 DCgA==
X-Gm-Message-State: AC+VfDw0sWhFAfgCrIy64yg2OVV3tciUcAClew+6aRZ/azVBHoqRePjr
 iTPXQPvISLk7PSTqgLsucmlxbQ==
X-Google-Smtp-Source: ACHHUZ65GbhEy1WdCCJHmUHe74eiu0/ZRXDlMP4NTMjeJlVGgrbpMRZ3u6KYxMdTQr2h5W/PSHAvgw==
X-Received: by 2002:a17:903:25c4:b0:1ad:f68b:f99e with SMTP id
 jc4-20020a17090325c400b001adf68bf99emr10915677plb.16.1684810237526; 
 Mon, 22 May 2023 19:50:37 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a170902ee1400b001ac7f583f72sm5452507plb.209.2023.05.22.19.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 19:50:37 -0700 (PDT)
Message-ID: <ec4fa2b0-deb2-4e94-86eb-f1668cbef934@daynix.com>
Date: Tue, 23 May 2023 11:50:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 0/7] igb: packet-split descriptors support
Content-Language: en-US
To: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>, qemu-devel@nongnu.org
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
References: <CGME20230518140457eucas1p17f5acf26efb84441f8da0510ffd38bab@eucas1p1.samsung.com>
 <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/05/18 23:04, Tomasz Dzieciol wrote:
> Based-on: <20230423041833.5302-1-akihiko.odaki@daynix.com>
> ("[PATCH v3 00/47] igb: Fix for DPDK")
> 
> Purposes of this series of patches:
> * introduce packet-split RX descriptors support. This feature is used by Linux
>    VF driver for MTU values from 2048.
> * refactor RX descriptor handling for introduction of packet-split RX
>    descriptors support
> * fix descriptors flags handling
> 
> Tomasz Dzieciol (7):
>    igb: remove TCP ACK detection
>    igb: rename E1000E_RingInfo_st
>    igb: RX descriptors guest writting refactoring
>    igb: RX payload guest writting refactoring
>    igb: add IPv6 extended headers traffic detection
>    igb: packet-split descriptors support
>    e1000e: rename e1000e_ba_state and e1000e_write_hdr_to_rx_buffers
> 
>   hw/net/e1000e_core.c     |  78 ++--
>   hw/net/igb_core.c        | 746 ++++++++++++++++++++++++++++-----------
>   hw/net/igb_regs.h        |  20 +-
>   hw/net/trace-events      |   6 +-
>   tests/qtest/libqos/igb.c |   5 +
>   5 files changed, 604 insertions(+), 251 deletions(-)
> 

Hi,

Finally I decided to test your patches, and found some problems in them 
*and* my series this is based on. Please rebase your series to
"[PATCH v5 00/48] igb: Fix for DPDK" which I have just sent, and review 
comments I'll give for patches.

Regards,
Akihiko Odaki

