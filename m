Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D93716044
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:45:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yiK-0003Iz-75; Tue, 30 May 2023 08:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yi4-0003Ew-PW
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:44:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yi2-0004j7-5I
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:44:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f60e536250so36609085e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685450656; x=1688042656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cENy9Vm0QBAxLo0+GQbFR/tBWvWKDMvvrJwArNE6Lsk=;
 b=bN4FwvJeHSscoHPPhkTQ4isUBEfzNBy/JSWF59+Gh8G7qCI6NC936yW/S6C27/5D8B
 bW6kXdx6/1RoHISGBcJKEPe1j4h9cEDi2OJZMCz7w6J82jpfhUv9ORLCdGWmuPtunMhz
 QKSgKOW/Yj9Pyu1H6IhLUmL97/ysYiFzvBHnmQl682Y35Ex47GElswlr7hNHFdWJtUjw
 835rw4Lo1mhC3bEhhSLjiMUe6vfeO4gjWzBhV2NPDA0tjXl3X5yz2oRXFEj8d+95Hyer
 JfeDBiyM+Fkpkk+8ocWJZ7uF0YBtCONYCeZwFbrHbRZTh0qS6s++w1S1IauTcqA/FMr/
 nSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450656; x=1688042656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cENy9Vm0QBAxLo0+GQbFR/tBWvWKDMvvrJwArNE6Lsk=;
 b=HHr0vaNRhosotUa6R/ovbk58gvENKjhs8etwX8w87kEKvgqHf/bLDZd9OvZSLFNrsy
 DJ1MVP0cohVo61oULatewRZHWuTAtFb19WezQHSg5+4MNTEWcwzVDvI1ghnqoZrb9EH0
 OktZbRFIFao33vQGcxJ/KWqjNOANq2p+6DFJS39+w+dapYBoLVaii3SJe2lF3M/Zyfy+
 GSCF3NVYEOAAEf34uwDjX2tThY/g1OU3K/RP9t3DHIWSXzZ1mPggmBxrUz+c7GEl1Q2l
 YXWs1N0/1wuXdEwPQWSqm/bX7RJ9b7Wx9rZ6hhQlxH2P+6TbNMpDi1LCSryZmkJpcp/o
 EVOA==
X-Gm-Message-State: AC+VfDwLvPaVx0B0ieGusNXRqzhHmubfrVTjxKuabspkpFXido2i3eWC
 lLeEEVcQQmLV8CRyS1/mmHBbdA==
X-Google-Smtp-Source: ACHHUZ68aGD9UNbgz8EIaPlJNbQ4wWXMCzNY5pRuRPvZO/o5qswu0R6qZtxGOdVOB7dn9Buuc4Iv1Q==
X-Received: by 2002:a05:600c:5403:b0:3f6:e67f:a79e with SMTP id
 he3-20020a05600c540300b003f6e67fa79emr8820869wmb.13.1685450656614; 
 Tue, 30 May 2023 05:44:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a1c7505000000b003f6f6a6e769sm10925975wmc.17.2023.05.30.05.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:44:16 -0700 (PDT)
Message-ID: <6fedc43c-ae24-7afb-92d1-f46fc15d2ce6@linaro.org>
Date: Tue, 30 May 2023 14:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] exec/ram_addr: return nr of dirty pages in
 cpu_physical_memory_set_dirty_lebitmap()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20230529121114.5038-1-joao.m.martins@oracle.com>
 <20230529121114.5038-2-joao.m.martins@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230529121114.5038-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 29/5/23 14:11, Joao Martins wrote:
> In preparation for including the number of dirty pages in the
> vfio_get_dirty_bitmap() tracepoint, return the number of dirty pages in
> cpu_physical_memory_set_dirty_lebitmap() similar to
> cpu_physical_memory_sync_dirty_bitmap().
> 
> To avoid counting twice when GLOBAL_DIRTY_RATE is enabled, stash the
> number of bits set per bitmap quad in a variable (@nbits) and reuse it
> there.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>   include/exec/ram_addr.h | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


