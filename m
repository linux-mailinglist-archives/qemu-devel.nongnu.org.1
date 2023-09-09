Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD54C799B48
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 23:04:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf56O-0007RU-T0; Sat, 09 Sep 2023 17:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf56N-0007RE-8b
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:02:47 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf56K-0000kg-Us
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:02:46 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-27178b6417fso2498258a91.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694293363; x=1694898163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5R5pWrFT1wxzaD5JeLQKHChR5m08xtEB1LYQGuFgpQQ=;
 b=chIeadMOoskk6YtVRjVMhK26CfaSC+HORkpfEgWa2H+XNbAd1SZGR/KMVHjxK24hPO
 zMBahCvitYEhcYg/4frXJK5lQFsz2/2M7CXHrGC6nhANVYVlq3z4II+8aoJz3Bytf6mC
 skFK/mC519zaj6q0uDqJC/cpgOQjgBSMsdCZskTUgEZgAR2gcN+BOVNRnpMKYqhh1esP
 YenOT1SO7qknMbvUPhpYohRsJyaaMxuVHUPVOYuwb6k/UmWxj6/KjZVn6qyj6Tn7u4td
 +cFP9ucgJI0MWJMTbS4FX1+Jm+CLdBSssrf4ehAnfObigT6LuIDYetK0ZUpkBHmHLoj4
 VDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694293363; x=1694898163;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5R5pWrFT1wxzaD5JeLQKHChR5m08xtEB1LYQGuFgpQQ=;
 b=b0PUWM2OL1O1zU8HKD1XBVC9H+SNqKZHx7DRQJWqb0ObWymNioBlexQKU3vqSY8ehH
 LfgWUrMhOt4OV/PMJwHIe64DWz9rEQCppqB6eRV5abx23HHBIld/e9KQKa1WT38naTsK
 6ukx06oSXO7d4jlJU1bvu5P5D+s8N8sZSgU+DOUwtHhbM2g0ybiHkyLa/ELc0kuAU5mb
 i9nufbRP0ziBYG/4oQ+B6UD1qgl4n+aqhwvwd/PYOEGajCPw7R3HkjErNkJ9v4ERtJ3p
 kobDBArZ/RGXbmbK18sEFbFIp8AP5KghKExCYDbvM3bhEuD18f+ema3uDDS2WKi8jpCE
 kHgA==
X-Gm-Message-State: AOJu0YwN7Sb6q5mnHqgy/eB8HJyJ8Iz49oWGcwJnSU8QGezWxB5VmnCw
 yg018lwL3yiZy6ewaGIbP5im0UfODPxD2ZnLksA=
X-Google-Smtp-Source: AGHT+IFvP/f1jgHFOk9g3XWrvFqHATn1O4TqtPTysA96+LT+CTqdnNP72z6eGd4K9j3slS0sq5npmw==
X-Received: by 2002:a17:90a:49c4:b0:262:f99b:a530 with SMTP id
 l4-20020a17090a49c400b00262f99ba530mr5770270pjm.34.1694293363263; 
 Sat, 09 Sep 2023 14:02:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a17090ad70f00b00268dac826d4sm3166927pju.0.2023.09.09.14.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 14:02:42 -0700 (PDT)
Message-ID: <6f63bbd7-da85-fc4f-75f3-018826d28460@linaro.org>
Date: Sat, 9 Sep 2023 14:02:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 00/10] plugin and tcg cleanups to cputlb.c.
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230828185550.573653-1-richard.henderson@linaro.org>
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Ping.  Patches 1, 6-10 still need review.

r~

On 8/28/23 11:55, Richard Henderson wrote:
> Based-on: 20230826232415.80233-1-richard.henderson@linaro.org
> ("[PATCH 0/3] softmmu: Use async_run_on_cpu in tcg_commit")
> 
> Remove the SaveIOTLB hackery, now that the flush won't happen
> until the TB.  Clean up the locking, so that we don't try to
> take the lock twice.  Clean up the iotlb lookup so that we only
> perform it once per page, rather than for each aligned piece.
> 
> 
> r~
> 
> 
> Richard Henderson (10):
>    accel/tcg: Simplify tlb_plugin_lookup
>    accel/tcg: Split out io_prepare and io_failed
>    accel/tcg: Use CPUTLBEntryFull.phys_addr in io_failed
>    plugin: Simplify struct qemu_plugin_hwaddr
>    accel/tcg: Merge cpu_transaction_failed into io_failed
>    accel/tcg: Replace direct use of io_readx/io_writex in do_{ld,st}_1
>    accel/tcg: Merge io_readx into do_ld_mmio_beN
>    accel/tcg: Merge io_writex into do_st_mmio_leN
>    accel/tcg: Introduce do_ld16_mmio_beN
>    accel/tcg: Introduce do_st16_mmio_leN
> 
>   include/hw/core/cpu.h        |  13 --
>   include/qemu/plugin-memory.h |  11 +-
>   include/qemu/typedefs.h      |   1 -
>   accel/tcg/cputlb.c           | 426 +++++++++++++++++------------------
>   plugins/api.c                |  27 +--
>   5 files changed, 212 insertions(+), 266 deletions(-)
> 


