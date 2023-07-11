Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2044474E291
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 02:33:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ1IR-0002q3-Lo; Mon, 10 Jul 2023 20:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJ1IP-0002pg-Aw
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 20:32:01 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJ1IM-0003fG-8z
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 20:32:00 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b852785a65so33030695ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 17:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1689035512; x=1691627512;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jA/5TBIWumv1LUCuBL6i2fDNoWAiKZFWdmY8JXenSNg=;
 b=GGFhH1/l0aZrx/3p3WnLYh7zfEX1Fg9TBbW6C0qJlObZrs0DrjjfHTRNMonS92Hyqv
 s+x72dzPNXDn2aX3P74wXdnBtbS+PE80103c6TTVfH12JZE9xQeclB0FaBEt/86Om/aU
 ARUusfj22mZp2lWP+60l9uV/sNx1YdKixt21jA5np2A7HzxHCLSMkJu0GeHZGQckVMlQ
 e7zlrNxgQkKnyzrLYEa17fHKaBG3mG7+ExwP7ukBNrdoOGsphxFpm/YlLQMIcRS+BQqV
 6haFP+bvg5FhiVN8TWYjkTMsYKrP4qUMBPfIOgTR2Z+jiRz/q4ltVzHJkcElHoy3D3ks
 Fb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689035512; x=1691627512;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jA/5TBIWumv1LUCuBL6i2fDNoWAiKZFWdmY8JXenSNg=;
 b=lJOX+/tD6TBimlxzgZcZqMQsz0IdA/dmzMpg8soauYgRbzam4xg5NsN9cZpozsPrDB
 ZIzrDfPeQUm5krpRg1TyT7VNAJv2t0at5wqpdm9HU0y5Ss+Ddd2yFge8KMB/iGhf6v0g
 lg44OzLRwV+SMjtca4wKxopbfAnOyaqkpfa9hptSqBN/uG4O/F+jIBErj7wnaB7H02qi
 JQc08YJYVm9g9WTIlz+N4ii7er50PdiOEXDcza4K7+iM74enjQo0T3k7eCUd2+xXBzem
 GBN7Elh545TZGmSZBjWQQY8qxXEiZbyCeYNfE8/LJP3WzKREH5X5A1nqb5pMTrU9s8aZ
 MVxw==
X-Gm-Message-State: ABy/qLaWpXBNhN7CW3swjlOvv0PwtNytmnlHQRlJ3nsUPdyRuhP2HGK+
 vQRDxRZ9YkqjVfWQJF5BNZHniw==
X-Google-Smtp-Source: APBJJlEhh+N3M7UeMoMTMEAYv3O0taIs0qW8Aic1SgECTsIpexI/van40b/4W54KGfx+EfJgIK6pIg==
X-Received: by 2002:a17:903:22cf:b0:1b8:870c:4ce8 with SMTP id
 y15-20020a17090322cf00b001b8870c4ce8mr22808403plg.18.1689035512097; 
 Mon, 10 Jul 2023 17:31:52 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.5]) by smtp.gmail.com with ESMTPSA id
 w19-20020a1709027b9300b001ae3f73b9c1sm477017pll.101.2023.07.10.17.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 17:31:51 -0700 (PDT)
Message-ID: <b98e864d-5371-800c-1271-75e5607c5eb2@bytedance.com>
Date: Tue, 11 Jul 2023 08:29:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: PING: [PATCH v2 0/5] Misc fixes for throttle
Content-Language: en-US
To: berto@igalia.com, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, qemu-block@nongnu.org, berrange@redhat.com
References: <20230627072431.449171-1-pizhenwei@bytedance.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230627072431.449171-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

This series has been reviewed by Alberto, can someone review / merge this?

On 6/27/23 15:24, zhenwei pi wrote:
> v1 -> v2:
> - rename 'ThrottleTimerType' to 'ThrottleType'
> - add assertion to throttle_schedule_timer
> 
> Something remained:
> - 'bool is_write' is no longer appropriate, the related functions
>    need to use 'ThrottleType throttle' instead. To avoid changes from
>    other subsystems in this series, do this work in a followup series
>    after there patches apply.
> 
> 
> v1:
> - introduce enum ThrottleTimerType instead of timers[0], timer[1]...
> - support read-only and write-only for throttle
> - adapt related test codes
> - cryptodev uses a write-only throttle timer
> 
> Zhenwei Pi (5):
>    throttle: introduce enum ThrottleType
>    test-throttle: use enum ThrottleType
>    throttle: support read-only and write-only
>    test-throttle: test read only and write only
>    cryptodev: use NULL throttle timer cb for read direction
> 
>   backends/cryptodev.c       |  3 +-
>   include/qemu/throttle.h    | 11 ++++--
>   tests/unit/test-throttle.c | 72 ++++++++++++++++++++++++++++++++++++--
>   util/throttle.c            | 36 +++++++++++++------
>   4 files changed, 103 insertions(+), 19 deletions(-)
> 

-- 
zhenwei pi

