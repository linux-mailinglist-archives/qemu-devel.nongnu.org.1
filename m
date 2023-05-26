Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F3B713043
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 01:15:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2gdo-0003lI-LR; Fri, 26 May 2023 19:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2gdk-0003kb-SN
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:14:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2gdh-0007UQ-2L
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:14:31 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d4e45971bso1073163b3a.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685142866; x=1687734866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7xoOv+SHCoiOts+9rLYs2Aw7cpxdQzmpokynS7XEz68=;
 b=E8hoPIPU4nyv9SNtcjEuaTpcFAOTp9fiJ9nQMhbmX/bYS/BbOPJfFa/NWQ3/1MG69G
 ujGWCx0GYOU7cpCtTyt0UGu1w1A78s8pW+I1AjPqKGUcA1eOuXRCDW3/nx88ynckICI+
 GD4JYEtjzauIkOmz8yaXA+0XXVPulAL7NvkRGyCK47Z3RWhNFsbKWpAKkS7VbAtkvKLv
 CL8jblhgU5CLnHuzZChEFXSzaKSRZC8MTqrFxbQeClfkbbXokOdc5R2gQ+EmQUz85lCc
 ZPvfpAs6gNIXU66I+rnh3ZALFwphAWJ/O9HqJX3XNyUCn9R61HubfSvWWRqH+ARb7HC/
 bU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685142866; x=1687734866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7xoOv+SHCoiOts+9rLYs2Aw7cpxdQzmpokynS7XEz68=;
 b=fZ9TutGVXeFYGOkU/8sWukmsTV6dRpR0ygnwpyVOTfpCN7Ry4lrt7J/WNtjrTn7j8n
 jcPIpuVRXQzN2xiVb7kLHS7tzPHAK2jHzacSEJOlW6VhwzbEK8WfUG0OKVzmEqwCp9YB
 lXr8HvWuCH6IiQQ/+dY+gs0QhgDcKOYkGnQJKQCS5upfijviK9juudj4V/W9N4ovTnVa
 DGn6ZTZgAj9gArOeyB4GgT0Uu0g9Y6OobNGiLMYc4h9IOZnlu71WFjK6pbBbBVKanW+G
 x9fz5650qW31v3P2x2SZSf+trWxbMDc9IAT715orUsocKY+OapfFKeVRi1TxHtNu2xfQ
 sBfQ==
X-Gm-Message-State: AC+VfDyBi1yHGef0tohGFQMhenWJGudnu5oLCF8bMHrS35bzNRyAM4RS
 8lFHzL4DFZYFoUOU6GAZx4OdeubuWhp3KJit/us=
X-Google-Smtp-Source: ACHHUZ6sVVnqMeMmJkA1XE7xHWT/5SVqez/nnIte0w7YMylf3j6sDUuZ7IoWyN1KK1yEXtNVle3Tsw==
X-Received: by 2002:a05:6a00:15c9:b0:64b:20cd:6d52 with SMTP id
 o9-20020a056a0015c900b0064b20cd6d52mr6058076pfu.14.1685142866362; 
 Fri, 26 May 2023 16:14:26 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a63f711000000b0050f93a3586fsm3217234pgh.37.2023.05.26.16.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 16:14:25 -0700 (PDT)
Message-ID: <f5843de0-a5bb-5836-ccc9-9b6f2eef746e@linaro.org>
Date: Fri, 26 May 2023 16:14:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] tests/tcg/s390x: Test LOCFHR
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230526181240.1425579-1-iii@linux.ibm.com>
 <20230526181240.1425579-5-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526181240.1425579-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/26/23 11:12, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/locfhr.c        | 29 +++++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
>   create mode 100644 tests/tcg/s390x/locfhr.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

