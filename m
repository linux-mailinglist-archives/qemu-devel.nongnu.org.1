Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA39763C89
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 18:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOhJl-0004I2-LY; Wed, 26 Jul 2023 12:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOhIV-0003o9-8i
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:23:35 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOhIS-0008OQ-Jp
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:23:35 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2680eee423aso12519a91.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690388611; x=1690993411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mfDyvJ7mqNKcI5sJeE35jf90D/jeLVIJrd6UlbZ9nbw=;
 b=RjBQCnKY4tkM0y9qgOxp1R7Rm4KlzdYPUEwNuXUUMyEupppS6mVei/UPFpDkxPwepu
 ZQJR/KEZhlWxPmqB6N8v8Gm3B8Dhx+7tI4SPYekUpnYim5PKjuai2T7h7JM8qBXJYbIC
 RQH/gzuYvHwLp5gB3MCB15+c4UB2WWQTbVN248weB8KJwuDKObHkYq9vkp5HlBkL2wB+
 BKcd5DWSOWm4pCi6L4iAzNvre46fa3R9CB4OGtHEELyvRGa+RRNqi5NYngp8PRPq70mT
 rkHQZV0Ro0h5i6SYsZNHBdwP+uqEvMQSKzrAps3c0wfluvZNLWW3sMHiYYGZx4xIZNE4
 4CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690388611; x=1690993411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mfDyvJ7mqNKcI5sJeE35jf90D/jeLVIJrd6UlbZ9nbw=;
 b=glCaX/D5Vk/gceOCr5adnwmCqHjQgQJYk+7QkzH9LxzalPiLozfgQDtpQ35H6xh5i8
 b7JAgowFdXZf+Zha+DNq0bZzbUelsxeTEjUTyfBvKuNQjJCyZLUYFlFm15FTkrY3+t/K
 Mq5P3sGtZYBZ7tNGyAwWxP/HVSIzayP+F29nmxgcvbmBetq1LLAQsTgH515xWtpOPQn9
 SLYA8z8/Kfn3QcgdMGZw+7vvIX9pV1QDuGa6DZwhtOqxCkf32cErzfrd+IeFkHE/sJU6
 xZvSObCPzW2k307/I2PSlpdy9EW8cDCR1afCTqrpKW+3PvcI1JA0qXwvE1hm/NvomFX1
 9otg==
X-Gm-Message-State: ABy/qLZ+8ku0GInpv8HM3/cJ9zCesOCx+481POqg5LUFI2hLQj4+fahF
 HtF0vMUVa57s3SA4GsI0tP+DHg==
X-Google-Smtp-Source: APBJJlEvvLddn8c4y4zTp8NSkgfV/9vIHrMgGsWCRoELr3RNKFwMASOOKkBx+F8xQXGPTRkmN3u7GA==
X-Received: by 2002:a17:90a:aa96:b0:262:ece1:5fd0 with SMTP id
 l22-20020a17090aaa9600b00262ece15fd0mr2090538pjq.12.1690388611208; 
 Wed, 26 Jul 2023 09:23:31 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9456:37ab:20dc:17e1?
 ([2602:ae:1598:4c01:9456:37ab:20dc:17e1])
 by smtp.gmail.com with ESMTPSA id
 bg11-20020a17090b0d8b00b0026833291740sm1442882pjb.46.2023.07.26.09.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 09:23:30 -0700 (PDT)
Message-ID: <80f31372-2199-f911-2912-e913bc138ec9@linaro.org>
Date: Wed, 26 Jul 2023 09:23:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/25] Migration 20230726 patches
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230726121459.1837-1-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230726121459.1837-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 7/26/23 05:14, Juan Quintela wrote:
> The following changes since commit 6cb2011fedf8c4e7b66b4a3abd6b42c1bae99ce6:
> 
>    Update version for v8.1.0-rc1 release (2023-07-25 20:09:05 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/juan.quintela/qemu.git  tags/migration-20230726-pull-request
> 
> for you to fetch changes up to 697c4c86ab515a728ffb2adc2c3c04b22fa9210f:
> 
>    migration/rdma: Split qemu_fopen_rdma() into input/output functions (2023-07-26 10:55:56 +0200)
> 
> ----------------------------------------------------------------
> Migration Pull request
> 
> Hi
> 
> This is the migration PULL request.  It is the same than yesterday with proper PULL headers.
> It pass CI. It contains:
> - Fabiano rosas trheadinfo cleanups
> - Hyman Huang dirtylimit changes
> - Part of my changes
> - Peter Xu documentation
> - Tejus updato to migration descriptions
> - Wei want improvements for postocpy and multifd setup
> 
> Please apply.
> 
> Thanks, Juan.
> 
> -------

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


