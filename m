Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC30A720D6A
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H8g-0007W6-Di; Fri, 02 Jun 2023 22:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H8a-0007NM-63
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:37:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H8Y-0005bO-Hj
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:37:03 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b065154b79so31210275ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759821; x=1688351821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xDIp+e9O/kyTLyZgTzY/NOxlXD6X0QJpQtQoN9a//HM=;
 b=Ma/9sGso0B/N5jDsfmhOPw4xVLyA3fh8x6wsOVmqjPNnYubYlAQ4A1OZB6wGTYPT9r
 +G1VM+uIIaLMHOG67WhMLl2zs2Z9WphnFF9S7oXh18P1KYCypjQakQGPzDKLHCRpMDkf
 QjMIrmc+Pa9afgbzKJjxzM/lYvPoDodJZZfX7kXwvbJpglgFiC8CcyZnVv6ioP7YOZuP
 PjpmSjin8Juc6fSJoRcOXV73ZjLv/WlT0MDOPBHyDJFE6+OzQEfr5R9tICJwrjS2pX8D
 RdgkNF1uwu+xb3tRhVgkNaAxLKzQ3V/ABzRtiAEtAOwfgO8Lfpqz7Pe+2tgDpr933DsH
 OMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759821; x=1688351821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xDIp+e9O/kyTLyZgTzY/NOxlXD6X0QJpQtQoN9a//HM=;
 b=cEdC2yf+yIm55WyliH2w2R5M66VzUvH2yMEvSovVRnT1Ywjd8sXlCwwuQRF29qffPG
 3S1G2rbdhbILD3FHZeQdLcszmAgQKVj66sm7I6Re4On6WS9K5G5ELobSdh9tLtToueW/
 4mIEPVvJZi3EadIiJacIddysbaPtYbyM6G6meJbZsB1oWpQEX0g32Z1IlSbQbvco5VKD
 awHc8S2jkLNLOgQ4TzUl1NDRFvBSPmsQBXq6BinHI+gLR5aZyi0+lRwmzxNjYpn9zYk0
 pqwOBApQwTOP0Nt62VUbIIo8y3crRS/MtUvLy9j0f/pqgvfLdfpck79j66b5/CPzdQ5Q
 vIjA==
X-Gm-Message-State: AC+VfDzjQNdVemTceEgTWrX5as1s+FaqfEfyblfXq3cDtaX11KG5lY3x
 /EimLntV9BqQJ4890QAwgPopxg==
X-Google-Smtp-Source: ACHHUZ5P4HjjZmxvtSZtSAvZrmiNn8ZOGICobChvwXsy4PHihpTX+wEyh0VzuAdYi0k+zPrUzYaVAQ==
X-Received: by 2002:a17:903:1209:b0:1af:e302:123 with SMTP id
 l9-20020a170903120900b001afe3020123mr1606591plh.3.1685759821128; 
 Fri, 02 Jun 2023 19:37:01 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a6dc4f4a8csm2046592plh.73.2023.06.02.19.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 19:37:00 -0700 (PDT)
Message-ID: <ab9a3fac-298c-cf93-390e-7e448ed34a17@linaro.org>
Date: Fri, 2 Jun 2023 19:36:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/10] Migration 20230602 patches
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20230602104910.35157-1-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602104910.35157-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 03:49, Juan Quintela wrote:
> The following changes since commit a86d7b9ec0adb2f1efce8ab30d9ed2b72db0236e:
> 
>    Merge tag 'migration-20230601-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-06-01 20:59:28 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/juan.quintela/qemu.git tags/migration-20230602-pull-request
> 
> for you to fetch changes up to b861383c2690501ff2687f9ef9268b128b0fb3b3:
> 
>    qtest/migration: Document live=true cases (2023-06-02 11:46:20 +0200)
> 
> ----------------------------------------------------------------
> Migration Pull request (20230602 vintage)
> 
> This PULL request get:
> - All migration-test patches except last one (daniel)
> - Documentation about live test cases (peter)
> 
> Please apply.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



