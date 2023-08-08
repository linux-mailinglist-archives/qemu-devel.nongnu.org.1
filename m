Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84724774CF5
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:22:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTU9a-0004Fc-RH; Tue, 08 Aug 2023 17:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTU9W-0004F6-71
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:22:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTU9T-0000NI-Gz
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:22:05 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc6535027aso26017405ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691529722; x=1692134522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=njn8meD4jX1VNWMzlOjih1Pz2xLPlzjEIUE/eGazEQE=;
 b=yDMThbfXaKq80wYPYNYVMVEd/ZiYi76tl5FJN13vjxouUqPevx3xK7bhdjpOF7sY7S
 fuHN0W49YvKXXQCMvZCtuzjx0MK7Z+fyYaGD0sDyjVTnzDIwZ571DuRDaqR7zJItRPnk
 VdfbXUWlYEGWWp21/bqoVQdh5o++8IvMSnXg+RxILQ27Ux5rfYrhVR37hyb5yz3T1fDO
 lsbccORlLg4BJYoXPOqMgERAYqGcpSMbsMRoVy2lcDUzJW5qLOWMX6CdgKJHwT2meyCL
 V0u5wGUxj732qrRroDs9Da6qXCWMLzD9vCHfJaWWIGvGntZ4WGECKbuuiLIsgT7upoee
 Nceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529722; x=1692134522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=njn8meD4jX1VNWMzlOjih1Pz2xLPlzjEIUE/eGazEQE=;
 b=LpmBcKdk7YvRQV0ttzq+H3fGAOdDB5B3lwH+M3bVGcyM8dJzlBEwrmSkH7nEK5HlVR
 6+tlxLb82vFJ1lQs+EeWmEc8QLjH8Z87+XMf4C7mNh3qqVhQecYozF0uLvzs84/Hz9IU
 /Fd9lhJ3O+ehZLE4nA80VeLcAbRvoRKlE/zU8XcjJbZluGnLap3CQeJexpAW9zgbs6Zn
 icy6OfFQPXxBuhn5Bi+YyyaqnsJVVyDSj140wxdbXWjMPVarWhB0MNkBsdae9pMW7Rk3
 99P4WRHguA3ZGiTURMgaTb5uqlDG4lUjaHregWm7Z/l1HdfcE+pwABkqtGevOG2Vd1lL
 a1oA==
X-Gm-Message-State: AOJu0YwWk6f/hInTjOwAdXKoKPEV08UB52pWLIruafH6KxU+BejGdgfP
 jY+q4qft/os1fCAhPBbVcG19Ng==
X-Google-Smtp-Source: AGHT+IEfo8ECQM3XM7vfIaaSsEer1sO1vqzj48nhAc/ytd9Tll3CFk3zV4t5jM/mvtZ5yVP91NXCNw==
X-Received: by 2002:a17:902:f686:b0:1bc:16cf:fc30 with SMTP id
 l6-20020a170902f68600b001bc16cffc30mr999161plg.63.1691529721928; 
 Tue, 08 Aug 2023 14:22:01 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 ix2-20020a170902f80200b001bc6536051bsm5917684plb.184.2023.08.08.14.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:22:01 -0700 (PDT)
Message-ID: <5e757317-35c3-634a-a6dd-1ac267a2bf67@linaro.org>
Date: Tue, 8 Aug 2023 14:21:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 07/33] Add struct target_stat to bsd-user/syscall_defs.h
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-8-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-8-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> +struct target_stat {
> +        uint64_t  st_dev;               /* inode's device */
> +        uint64_t  st_ino;               /* inode's number */
> +        uint64_t  st_nlink;             /* number of hard links */

Indentation of 8 instead of 4.

Otherwise,
Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

