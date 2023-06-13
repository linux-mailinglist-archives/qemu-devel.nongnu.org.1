Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A32072DDC0
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 11:34:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90PG-0002Au-CW; Tue, 13 Jun 2023 05:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90PF-0002Ae-1t
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:33:41 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90PB-0004nW-Ny
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:33:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-977d4a1cf0eso756931066b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686648815; x=1689240815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vmk3t3RFy1iA0Rtwl25n+ogSSLcU5SknU7pe8RprfBw=;
 b=Kr+TDsyK6HWDWLPikzwYXvZ8dPJa6FqgxxZ5ccWLWZJFCRNkNBHQXVnx55FlTe61Of
 Lbn025z3AtdNh4yNz6OVQkZpgO0dmeseUabPyZHMTeXEbJvC00WVvi75bKFi6gmBSiUH
 5GlH85kJlIif4ngMxjYg1XP2pQphfm53bVaaxRgu1mhlu6AUikeAS7Ta/U+we4zdcP7r
 P2+JAmzXlMOhx2B71KKLovE169xl+qiTzuM6tLg+nwCZOxTkRJSsonLtvTSQ+e89GKx8
 Llu3tz6luQHJBEt9tg2XgSe9rb1vVXmVMpswwKW/U5k6fooAEwxfsPPeV+Z5ZBx8BrIG
 SVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686648815; x=1689240815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vmk3t3RFy1iA0Rtwl25n+ogSSLcU5SknU7pe8RprfBw=;
 b=cA8E9qV9IHQOHAi/KDacNYHponO5Jtcrq6tg+yfizPpKM2EOxZk2lHgHeUyhNgaiU8
 TXtWwj+1EKjT5V45QY93V/Rae8J4br6pkLIxRy1dH/asuvkKZ/9bt25sguUFfhf7EKmT
 yHz7IGDaf9/SDMyCQcm1FdputO5iQT66K275Jvr3SZpZXwHNNNyjNATTEIT97PaerBfa
 meWn1vlAKlWNsU/MJMTQNCbwNmy4aLrZdIbpiK6Y47lvMj2ZY7rNXvR9rQLc3GfKKa3D
 3qas0d94k2mdnxFzAiwSf66ff/LxhC6JoF+PBFmgV2o1DCrl/qa/TURwfPL1euc3OJ7l
 lzqQ==
X-Gm-Message-State: AC+VfDy+egGYrZH19l4Z/8kHXEP9dihXxqkjv/A1H8+/rmv9aDrslLig
 +1GftYSnlG86e6ajJYetpTNSrA==
X-Google-Smtp-Source: ACHHUZ6s9GELMtn9YySRsowoJxEp1USM55v32gvrqs8DRyZozL35I373PhcP6UHFXxnG7Yp9ZgkUJg==
X-Received: by 2002:a17:907:2d91:b0:97d:cc56:d9bc with SMTP id
 gt17-20020a1709072d9100b0097dcc56d9bcmr10044395ejc.51.1686648815169; 
 Tue, 13 Jun 2023 02:33:35 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a1709065fc300b00977d6723bd6sm6370547ejv.195.2023.06.13.02.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 02:33:34 -0700 (PDT)
Message-ID: <db75fc61-9686-5ae7-dff2-44e02a49ee66@linaro.org>
Date: Tue, 13 Jun 2023 11:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH V3] memory: RAM_NAMED_FILE flag
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Xu <peterx@redhat.com>
References: <1686151116-253260-1-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <1686151116-253260-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/6/23 17:18, Steve Sistare wrote:
> migrate_ignore_shared() is an optimization that avoids copying memory
> that is visible and can be mapped on the target.  However, a
> memory-backend-ram or a memory-backend-memfd block with the RAM_SHARED
> flag set is not migrated when migrate_ignore_shared() is true.  This is
> wrong, because the block has no named backing store, and its contents will
> be lost.  To fix, ignore shared memory iff it is a named file.  Define a
> new flag RAM_NAMED_FILE to distinguish this case.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>   backends/hostmem-file.c   | 1 +
>   include/exec/cpu-common.h | 1 +
>   include/exec/memory.h     | 3 +++
>   migration/ram.c           | 3 ++-
>   qapi/migration.json       | 4 ++--
>   softmmu/physmem.c         | 7 ++++++-
>   6 files changed, 15 insertions(+), 4 deletions(-)

I'm taking this in my next PR, thanks.

