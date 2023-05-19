Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3BF709FC3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 21:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q05Vr-0008QZ-DL; Fri, 19 May 2023 15:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q05Vp-0008Q5-Hz
 for qemu-devel@nongnu.org; Fri, 19 May 2023 15:11:37 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q05Vn-0002hV-AD
 for qemu-devel@nongnu.org; Fri, 19 May 2023 15:11:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae79528d4dso15593895ad.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684523493; x=1687115493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C368+KVqW64XEaEEcXkEAmmver3bIYlCLNvmJM6rZD0=;
 b=hUXt4706EOemD8M+IMrIfh3zmMzxTAiYf+KphF+KEcbMQjXJ1nl/PU+L9I4ahUVeOv
 DVlR969nW8kSJkaJD8n1tDDLkwLXsyuWNqCDpSLuxtaIdNP3FBknvgBNl79k3LRewXCk
 WRvqBu/szo9RBJkP+xS0AhELT29UpjW7JMke5NuTjLbqjNzT2o72K5NFj3Pu/SUevpLH
 m6VfP7N2gA57p/5L4u0GEunU8sMU+Y57UNWj7u0+CIMhtJNfxE3q2dfFalZFI7q5Pma8
 WVha1kPZ3YMU8H60HHO/4BMTaHqzYeWKwDHyGNx5ek+MdyrCez4cYGATJ73aYxxJLupq
 tMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684523493; x=1687115493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C368+KVqW64XEaEEcXkEAmmver3bIYlCLNvmJM6rZD0=;
 b=YTCAp9Ew1kl74DAWG/712loBA0O5pXK5pAC1ypNJ9UOa1QVCFWseBbCSHy59sIKnOA
 zrfIXH0KAUpxIdMBu+v3ZLGdps95c2lJUDq2PsZ8/ZFCHXN5bX4XrLzq7YlBiKPPdW8M
 C4oDjEvVE/UzLa/1K3egWxIHfZxiUXr0xUzgdZHytMjPbFTbyrP13hxCQggMFRCxDRDL
 X+qusszFsGiUhzdq8roOHjPXsbCqbVHUVsWBf6TwT+WV6QvHIQXNXSefaTXbApUblXOm
 XBqhSvtm0WDQGIJ7ZpeOxNaL/Q/JAqewa8V1XFZsfoj/r5hpgW7rjVujOZ1O7Qu704IZ
 /WYw==
X-Gm-Message-State: AC+VfDyu7Hh//Ol8YPR0HpEr0ejxbI7IP1KHJXyY1rfm2bHKKVC2a2Wi
 DQVJbv0DVTvUbyJXD3vT5mfgug==
X-Google-Smtp-Source: ACHHUZ5beHZSLdbYJcgUxOwhN+6hebgnQP44cugGdcuF4AXTVIIUmuBFuStNcbeAkRUt7VDkk490Yw==
X-Received: by 2002:a17:902:ced0:b0:1ac:544c:12f4 with SMTP id
 d16-20020a170902ced000b001ac544c12f4mr4046294plg.2.1684523493595; 
 Fri, 19 May 2023 12:11:33 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:686f:d1bb:8fc4:dc38?
 ([2602:ae:1598:4c01:686f:d1bb:8fc4:dc38])
 by smtp.gmail.com with ESMTPSA id
 11-20020a170902e9cb00b001a060007fcbsm3772382plk.213.2023.05.19.12.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 12:11:33 -0700 (PDT)
Message-ID: <1513489b-2d86-3722-94fa-1a560ac31aa8@linaro.org>
Date: Fri, 19 May 2023 12:11:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v3 00/21] Block layer patches
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230519171806.435109-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230519171806.435109-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 5/19/23 10:18, Kevin Wolf wrote:
> The following changes since commit d009607d08d22f91ca399b72828c6693855e7325:
> 
>    Revert "arm/kvm: add support for MTE" (2023-05-19 08:01:15 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git  tags/for-upstream
> 
> for you to fetch changes up to 95fdd8db61848d31fde1d9b32da7f3f76babfa25:
> 
>    iotests: Test commit with iothreads and ongoing I/O (2023-05-19 19:16:53 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - qcow2 spec: Rename "zlib" compression to "deflate"
> - Honour graph read lock even in the main thread + prerequisite fixes
> - aio-posix: do not nest poll handlers (fixes infinite recursion)
> - Refactor QMP blockdev transactions
> - graph-lock: Disable locking for now
> - iotests/245: Check if 'compress' driver is available

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.

Though there seem to be existing io errors in several different environments, they don't 
seem to be caused by this patch set.


r~


