Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F42176BB99
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQtTs-0002RN-Dq; Tue, 01 Aug 2023 13:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQtTq-0002R4-DN
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:48:22 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQtTo-00088J-OT
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:48:22 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-55c993e26ffso3574989a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690912099; x=1691516899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hsgOkWCRTm5lQaWsfZXawKAwxbMKcBlF2bf9QWr0xPk=;
 b=TTNh1CKT7TZHEJkT32+1DG61dN4k4ohZA9DlOPzWfBxZMub9dVfK2EOexcyIkC2GHj
 ki4e7v/wl2o0hVz9aQUxj/lNmxXq39osMOBFIczMApL7yG2riou3Yu7Kr/uNOJsolFHi
 K44w3eD3tuaRdYmVlllOVL3UvKnSrF7m8jDlJnuRb7Kp730Y0wyyhX/l/gQbGFNwvloj
 iJ7VlWnmPRtDh4jVeo+CUmQBu+EpWhMarOzRBDQJ2rDOFj4j/9ym9KkOCXYZxfpQjz6k
 H6adbYGWuLjDC6D7TWxqRVkHZyqvTfG0j+n0Wy9h/lJvVHxbctziiZ5o6FGZlom0AWTs
 aK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690912099; x=1691516899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hsgOkWCRTm5lQaWsfZXawKAwxbMKcBlF2bf9QWr0xPk=;
 b=NFqfpRrCzqCeTMQANUdmbqZE9rUEBQXOsrL1WzyoKsRBUldcBHzLyTZIxy3JKvGosW
 aute/eHhUn8yrxVmLjxgadVmCee3AMRlFK9krRyvH/9bCKaimPeefzgIczLHetyNIfUg
 JLNq049iY64k2SRkPn/HSxbFDt58i6JTPCW7TUtOv5+ys+X+Fvvls1cygSfQuj7W9k/P
 ljRNPcQ0IcjM1J/b5I94f4iHB5mu6yYrOqYB09F15pX8WS/hbr/Az48CeaGeYoriXGGt
 YoCr+B5WlArE7CJvTCuzBCbSao3dba3c7CgWRLFTcgw+IDdJXmSS4N80lbvRPHW3z1y/
 ParA==
X-Gm-Message-State: ABy/qLbpz8uNLju0L2PCdIDWdVtuibzccO2zXzC4BQJ5KtgsFWcxPA75
 1D0WbVtnyowMXyZVM2/1w9lKOg==
X-Google-Smtp-Source: APBJJlEZOi+dol4q4aaZZNoLzGMyAnPjcqo4W7EgzhYZe2mpt6bqwjwOkeGV2GcVuk0uIVk54dcKLQ==
X-Received: by 2002:a17:90b:8d2:b0:267:75ce:f6d9 with SMTP id
 ds18-20020a17090b08d200b0026775cef6d9mr10837596pjb.3.1690912098689; 
 Tue, 01 Aug 2023 10:48:18 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:67b4:35b2:87e2:dccc?
 ([2602:47:d490:6901:67b4:35b2:87e2:dccc])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a17090a414600b0025dc5749b4csm3228141pjg.21.2023.08.01.10.48.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 10:48:18 -0700 (PDT)
Message-ID: <7b04e968-0c9f-a118-1ae8-c0cbba3ea562@linaro.org>
Date: Tue, 1 Aug 2023 10:48:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/5] Misc fixes, for thread-pool, xen, and xen-emulate
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
References: <20230801094038.11026-1-anthony.perard@citrix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230801094038.11026-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 8/1/23 02:40, Anthony PERARD via wrote:
> The following changes since commit 802341823f1720511dd5cf53ae40285f7978c61b:
> 
>    Merge tag 'pull-tcg-20230731' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-07-31 14:02:51 -0700)
> 
> are available in the Git repository at:
> 
>    https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git  tags/pull-xen-20230801
> 
> for you to fetch changes up to 856ca10f9ce1fcffeab18546b36a64f79017c905:
> 
>    xen-platform: do full PCI reset during unplug of IDE devices (2023-08-01 10:22:33 +0100)
> 
> ----------------------------------------------------------------
> Misc fixes, for thread-pool, xen, and xen-emulate
> 
> * fix an access to `request_cond` QemuCond in thread-pool
> * fix issue with PCI devices when unplugging IDE devices in Xen guest
> * several fixes for issues pointed out by Coverity

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


