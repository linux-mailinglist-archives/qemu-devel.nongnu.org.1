Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277978002E
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 23:53:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWkuP-000236-VU; Thu, 17 Aug 2023 17:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWkuN-00021s-Qf
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 17:51:59 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWkuL-0001sC-Hi
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 17:51:59 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so2167625ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692309115; x=1692913915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2CvuslKNtbQWOEfJpMKLCzRXir2U4V07WE3I0ij56Ro=;
 b=S3v53bZb6B6YXEh3hDRCEMio+DdbRUhbZAQAMjfZNTnVCeZgsYcLmyW3W6TvVW82Zu
 ZM8vN5aJCAnfc/A7keURwp71wcEvR/s2Hoat+xNodOW5TjIz0tUNp8/XOmjeVJQ378Gk
 5U+tDoJfaNkcKxD43GU0fFFcPjAZ6tkDBJXxZqyAB2cNykq9VgRGTpLA1o09lwpCnpxq
 793cU26a0EAvcdXBoeTq4yb/a07t7icLogYWTwZy1LVwH18lufX+6CzBpaxpQSWxj9Nu
 1ubaeYkqLdx+U3bbvgbtdhahycnaXivpTw7oFQyWpuPCY6jL0XV3U/vccsYAfWUlZdOi
 E4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692309115; x=1692913915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2CvuslKNtbQWOEfJpMKLCzRXir2U4V07WE3I0ij56Ro=;
 b=i2kWEzPIqrTaMo0FfRa5BlMDt/rlQXtDu0p0VYbli79XyuNoS7Wfbwhbe2//bCjL0d
 EPfC6WtF6E3pna84Te2p9u69a6Qn+lJiR5O4WsDhlZeQjdr42S9sC4I47hhTTAsz1CPT
 NPeXJdzA2mNe7AD+4MlyKLjzO399SuWWwWkbj6pgAFoqqpJWQiQnhTAomISjtetRsZlQ
 XMn+eO37pBfXLPelxRFk7Yjj8+TxaqJ8aGH+d1vJ2EDn3UQKeTaJ/ksc7tZyBkaxBeun
 QhEq30vFrGfE9IUwLZrBHFdBIsQ9ABc8A5zcO3lOPgPadfFHDUlOPyfZR1aO1vW0wedj
 fQig==
X-Gm-Message-State: AOJu0YyYdHTUUvqYig3TfoDzRP2Xbib0WHa/NDokD7TOunIsyzyb/JYb
 B/GWiNpBUDVPFjadPnuh+7Rphg==
X-Google-Smtp-Source: AGHT+IFLigYt2nKy2jaT90AClmYvznb/ZghEpde+xYxUzic2YG/0Hu/lxov6JpAeHbLOmQ18Fy4nbQ==
X-Received: by 2002:a17:903:244d:b0:1bc:10cf:50d8 with SMTP id
 l13-20020a170903244d00b001bc10cf50d8mr1087466pls.23.1692309114642; 
 Thu, 17 Aug 2023 14:51:54 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:12cd:355a:c01e:3596?
 ([2602:47:d483:7301:12cd:355a:c01e:3596])
 by smtp.gmail.com with ESMTPSA id
 jf20-20020a170903269400b001b7cbc5871csm252257plb.53.2023.08.17.14.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 14:51:54 -0700 (PDT)
Message-ID: <008a0001-15f5-55c1-45d6-eb47ad9a2bad@linaro.org>
Date: Thu, 17 Aug 2023 14:51:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: How to synchronize CPUs on MMIO read?
To: Igor Lesik <lesikigor@meta.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <SN7PR15MB6086D1B0ECEE5ADBD07F8847C315A@SN7PR15MB6086.namprd15.prod.outlook.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <SN7PR15MB6086D1B0ECEE5ADBD07F8847C315A@SN7PR15MB6086.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 8/16/23 09:31, Igor Lesik wrote:
> Hi.
> 
> I need to model some custom HW that synchronizes CPUs when they read MMIO register N: MMIO 
> read does not return until another CPU writes to MMIO register M. I modeled this behavior 
> with a) on MMIO read of N, save CPU into a list of waiting CPUs and put it asleep with 
> cpu_interrupt(current_cpu, CPU_INTERRUPT_HALT) and b) on MMIO write to M, wake all waiting 
> CPUs with cpu->halted = 0; qemu_cpu_kick(cpu). It seems to work fine. However, this HW has 
> a twist: MMIO read of N returns a value that was written by MMIO write to M. Can anyone 
> please advise how this could be done?

You'll want to add something to allow each cpu to latch the value written.

Something like

     CPU_FOREACH(cpu) {
         if (cpu != write_cpu) {
             *cpu->mmio_latch = value;
             qemu_cpu_kick(cpu);
         }
     }

where cpu->sync_latch = &cpu->env.reg[N] for the register destination of the MMIO read.

This is easy if you can identify the hw sync mmio during translation.  If this sync is 
mapped somewhere arbitrary within the address space, you may have to work harder.



r~

