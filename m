Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C28457161A6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:24:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zKM-00030f-8V; Tue, 30 May 2023 09:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3zKB-0002Xd-Fn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:23:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3zK9-0000F4-Io
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:23:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b0218c979cso23938915ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453019; x=1688045019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QDniFCtCQLQYPB+SGNK0cHL1b7LpRhk4J2XXXt5kUWo=;
 b=QupazzSCROyrfLdfQob/aWW7ykoMAFjU0lgtol1WDH5rI8l+7hRx6lCaO6bLkPtP8e
 EdvAPgZrWII3YT7yuF9Z+9RRFWz1nAa1S+PcVS1+A+t83lVhnxkToPssJczLEvP9nYEH
 cBGPLzZDYan93Wjn3Z4vovjo6LEE3HRwu+onT8dy5z5OTpObcKw9cWkV/JDrfGSBEKaH
 TB3cHE1jIfEfpcjwHUh3RKpJIzSDgqR55q6g28Kq/Q7G42wizsiJqzTUXeoFY/fTUccF
 Ml5ZOtMQOJTOkcEDb1pnbxHxoqvl97cY4AhLectMI0CkSM/UjsBQyaKUy4Hvll/y/7/Z
 az1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453019; x=1688045019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QDniFCtCQLQYPB+SGNK0cHL1b7LpRhk4J2XXXt5kUWo=;
 b=iJYonjn64By6JGPVFNfIGj4vd/YOapn42oZkjVe4onqpvkyHSpsghJs4BZ4aqJ1Mjs
 MMgtWxbrYpfrNJmalb3dvy0wLNPWiLtrXt/OwXE+r53oXiAoQHju09SPvDlW2SRHUzj+
 Q8n4C8EJH015OrXbBQZcTTScnuJkjZ7uvWvXo6SiKWU/u5MiqZ8VdXArnAx3LeffzcNp
 +Okhwo/H3bVFt78ZeNpfH/A6TY/OmAX0D4wrrF5hsqMNMre2IP2Ra9WayVCKteZQU+tB
 zhyVBAPjsR7dQ3Bo/BiSQnMB3drWIfmr13M+8YbgoLI1k9YtUHTB5b6iR5IggK5yaxk2
 zreQ==
X-Gm-Message-State: AC+VfDz1WqIlFc0P7tU/AUsTg8kFUopeyPfspRFYZYy6p8rEf7Z/LW7F
 kuAafv8xPg3KO37lNQ+2RjAhDQ==
X-Google-Smtp-Source: ACHHUZ64hvutss+xEWXHV/m26jTzx/pm8CSYsEbT3pxSwx4gO7aAIj/9uwRzuKgwh2prCZCgxBg49Q==
X-Received: by 2002:a17:902:f391:b0:1ae:8bd9:e015 with SMTP id
 f17-20020a170902f39100b001ae8bd9e015mr1573922ple.5.1685453019599; 
 Tue, 30 May 2023 06:23:39 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 p23-20020a170902a41700b001afd6647a77sm10228666plq.155.2023.05.30.06.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:23:39 -0700 (PDT)
Message-ID: <a0fa954e-9903-841d-9c00-c035a6ddc8db@linaro.org>
Date: Tue, 30 May 2023 06:23:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/21] Migration 20230530 patches
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20230530115429.1998-1-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530115429.1998-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 5/30/23 04:54, Juan Quintela wrote:
> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:
> 
>    Merge tag 'pull-ppc-20230528' ofhttps://gitlab.com/danielhb/qemu  into staging (2023-05-29 14:31:52 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/juan.quintela/qemu.git  tags/migration-20230530-pull-request
> 
> for you to fetch changes up to d83da4626ebc1462e8f0065d446f97aece681d90:
> 
>    migration/rdma: Check sooner if we are in postcopy for save_page() (2023-05-30 13:27:54 +0200)
> 
> ----------------------------------------------------------------
> Migration 20230530 Pull request
> 
> Hi
> 
> On this PULL request:
> 
> - Set vmstate migration failure right (vladimir)
> - Migration QEMUFileHook removal (juan)
> - Migration Atomic counters (juan)
> 
> Please apply.

Fails immediately:

In file included from ../src/migration/ram.c:61:
../src/migration/rdma.h:52:5: error: no previous prototype for ‘rdma_registration_handle’ 
[-Werror=missing-prototypes]
    52 | int rdma_registration_handle(QEMUFile *f) { return 0; }
       |     ^~~~~~~~~~~~~~~~~~~~~~~~
../src/migration/rdma.h:53:5: error: no previous prototype for ‘rdma_registration_start’ 
[-Werror=missing-prototypes]
    53 | int rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
       |     ^~~~~~~~~~~~~~~~~~~~~~~
../src/migration/rdma.h:54:5: error: no previous prototype for ‘rdma_registration_stop’ 
[-Werror=missing-prototypes]
    54 | int rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
       |     ^~~~~~~~~~~~~~~~~~~~~~
../src/migration/rdma.h:55:5: error: no previous prototype for 
‘rdma_block_notification_handle’ [-Werror=missing-prototypes]
    55 | int rdma_block_notification_handle(QEMUFile *f, const char *name) { return 0; }
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/migration/rdma.h:56:5: error: no previous prototype for ‘rdma_control_save_page’ 
[-Werror=missing-prototypes]
    56 | int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
       |     ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


r~

