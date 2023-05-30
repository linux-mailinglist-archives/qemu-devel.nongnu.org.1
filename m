Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79907715FFD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ybJ-0004T8-66; Tue, 30 May 2023 08:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yar-0004OK-53
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:36:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yap-0002im-Kh
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:36:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso31839265e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685450210; x=1688042210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BK2+whkDDCQj0Q4LI2OU1olhI+hCRTkZ4s+pWhfZ4LU=;
 b=zTkgBzNfibr8C6R6VZd0qXFGtHaqJt3vSCPELl2maPrZPJCxOyurqZUz2kNZv4V0Fk
 8gEAW4NwNT0889GzG8UmLPFZRPRPYZKOGZFYe8gwFkvuIrnh5lu0/bCrOaH69neCPEbU
 Icf1SZTv5ZJqd6l4sSYDCTPV93a4LRi5XW4spXEed5ZHtGUcJmR8heE4ea2fQKYNBa/g
 esz5K//RO1f/tOvURO+dArq5RyqdV4XUQvIgBDZWW0mJln7CCRDB36zlK1gRJsLusDW9
 UMW7OSHk9ggda6BMc+vQKi6pimlmPXRtKm3RIZ5vOXIfRKvkijF/N90dq4DSOhwx3SFs
 4Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450210; x=1688042210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BK2+whkDDCQj0Q4LI2OU1olhI+hCRTkZ4s+pWhfZ4LU=;
 b=katfOKb2PBBU7H3i7bFPUi7uyLF/I+bgh6Qa/KcbxXIiJuVgHhhvnX28PJ7GURI6I3
 blqMPa+wurOq6aI+cuh+3EFft8mxo3cZYNsZ5gtOiTdMHo7NsRIccGHy1SwDMFELJVl6
 8jxzB24CY9B6Y0dXCo1OLTgLJsEm5Ofdl8JXJ7UCWsQtioW04Avynv3QsiM76ChS5AqM
 kCGTbMdTrnqOyV60bbQFgVTtKv24IrGHcruFCqWlhFqoJsaB6oYT/3nAuElUoju8KyqB
 xn0hqYIZQ2BzQanK+GKFH5X9hrR/ydSVqqBbsCFSV6b6l5KM5bCf4fwHJyxPOrMqALXm
 VGQQ==
X-Gm-Message-State: AC+VfDwfCOb9lCFyhpw9x9Hja92aazSy+5Ghom/S99Dr1YSTfD3ieEUu
 FqDGgv4BVmlBBLtrNEf4DTt/EQ==
X-Google-Smtp-Source: ACHHUZ4+W8arsOgMo/5IOIVFUmxPKD9/u6XDoi3X9CP1Wczq5xw0H48AZDxEfSIjFdY7x6MM/Mrilw==
X-Received: by 2002:a05:600c:3c94:b0:3f6:d41:76ed with SMTP id
 bg20-20020a05600c3c9400b003f60d4176edmr8877684wmb.5.1685450210135; 
 Tue, 30 May 2023 05:36:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a05600c378b00b003f195d540d9sm20978358wmr.14.2023.05.30.05.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:36:49 -0700 (PDT)
Message-ID: <f71adc26-975d-2a2a-77dd-642bbc7db553@linaro.org>
Date: Tue, 30 May 2023 14:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 01/16] qemu-file: Rename qemu_file_transferred_ fast ->
 noflush
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-2-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530122813.2674-2-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 30/5/23 14:27, Juan Quintela wrote:
> Fast don't say much.  Noflush indicates more clearly that it is like
> qemu_file_transferred but without the flush.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   migration/qemu-file.h | 11 +++++------
>   migration/qemu-file.c |  2 +-
>   migration/savevm.c    |  4 ++--
>   migration/vmstate.c   |  4 ++--
>   4 files changed, 10 insertions(+), 11 deletions(-)

To clarify further, qemu_file_transferred() could be
renamed as qemu_file_transferred_flush[ed]().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


