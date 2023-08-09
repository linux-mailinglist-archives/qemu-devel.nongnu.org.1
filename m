Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F27751AA
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 05:52:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTaEU-0007Rr-5v; Tue, 08 Aug 2023 23:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTaEQ-0007RL-UK
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:51:34 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTaEP-0003G0-86
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:51:34 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-26929bf95b6so2554414a91.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 20:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691553090; x=1692157890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=89kkMfCvr8pBsVyCCbUQc21uEjCC4+QfjE4d4s2eZnk=;
 b=R058VyYuwdgADJDJQGQHZqRYjuCqYMMNEr9hH1V1hZGLOONTCgm3tIE56G8xQOCpT7
 FiN9TKRkvi07s6aCj6y/J2wMLLS2p2Br1Cr1sH39fwXmdjNQ0+ovsFLnbLnGKg8leRdP
 hsquBf1AEMdYzb24bMaogJVltyYRPHgrFfb5dPGILatQ7ZkNP/JDsAwAk+18yD0VMLbC
 Znt+9TR13JJmjEHC07DwkxJ9nzWlMOtJF6Pf0q6MYyzEhE2VhiFNaos6UMe/Cr0PdETK
 WXCTIl/w3uPxIuIv7vkaI2tdAHygTJ8AV7G7Pry5bPVLMuE/41JEddJlwPCinRz6OsH1
 J49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691553090; x=1692157890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=89kkMfCvr8pBsVyCCbUQc21uEjCC4+QfjE4d4s2eZnk=;
 b=jhfP1aoNRe+OLjH/5niTdssnM051smFexPXVslEGOmLkPpFKjyv7aeQQsnIU8SNolC
 WeXCQpRDFp0T2JpbVsgORreiKHSFm1ydq6z1+UPhZGHlG2/yvMGFzRIK9TEyMz2nVwUd
 vcuB6ngvW29awuBgJ4OK+pNBOPRfaC9gLPQ9dtRcDmaGraTiKgaeZ1T7QuhppcdpyP7u
 eELGzWuYSr/MYPp5xubuIODoGcIxIywoXO6shA04E016+uk3aw+la+8j40PLbZKt6peK
 HqCOe2WjKLIeJkiEOBRDycYba4JkulEUgPxHM2C9Jd2u1gAS9jr/3KETreYpY/JS1xIJ
 2mCA==
X-Gm-Message-State: AOJu0Ywws6BMeYY0X1C5uM6ak6mmYK9AT4AtncM7EVVRb8bNSKG/11fT
 zY/T4ZITRyig82BuXeadFX0pIFpURDy32/bXyKk=
X-Google-Smtp-Source: AGHT+IFyiRDzWMDBK5wSRAgt/YZUw7rTK3DmDIeY/mCq6TsxYHeB9pBkAD62FpC6TBVanZH4ipk/Yw==
X-Received: by 2002:a17:90b:1d8e:b0:269:5821:5808 with SMTP id
 pf14-20020a17090b1d8e00b0026958215808mr1151280pjb.32.1691553089985; 
 Tue, 08 Aug 2023 20:51:29 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:aef:cddd:11b6:aee3?
 ([2602:47:d483:7301:aef:cddd:11b6:aee3])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a17090a468800b00268b439a0cbsm326851pjf.23.2023.08.08.20.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 20:51:29 -0700 (PDT)
Message-ID: <7c3f2510-ea9a-927d-adb1-4f74d05f72b5@linaro.org>
Date: Tue, 8 Aug 2023 20:51:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] qemu/osdep: Remove fallback for MAP_FIXED_NOREPLACE
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230808164418.69989-1-richard.henderson@linaro.org>
 <be628c0f-19a9-6710-e132-f958f55cd0f3@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <be628c0f-19a9-6710-e132-f958f55cd0f3@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 8/8/23 20:50, Michael Tokarev wrote:
> 08.08.2023 19:44, Richard Henderson пишет:
>> In order for our emulation of MAP_FIXED_NOREPLACE to succeed within
>> linux-user target_mmap, we require a non-zero value.  This does not
>> require host kernel support, merely the bit being defined.
> 
> Hm. Should we add something like
> 
>   assert(MAP_FIXED_NOREPLACE != 0)
> 
> somewhere?

I wouldn't think so.  Where would a zero come from?


r~


