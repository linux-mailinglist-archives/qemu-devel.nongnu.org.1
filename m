Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2877A0B16
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 18:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgped-0000fi-TD; Thu, 14 Sep 2023 12:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgpec-0000fK-2D
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:57:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgpea-0005hG-Dw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:57:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40434d284f7so10265185e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694710632; x=1695315432; darn=nongnu.org;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PFDrZg1H7FdsNSeJzSEmgLOu0CvwUXAeF443lrdS7FU=;
 b=dpCgBlr4jI70vMTVPsmChIR9l1lSh69Mq+MA+goZ/C4hLrgapdQy88KyNSEF9V37Hg
 lVnSy1+hpguFYAyd5xs8mKpd/fCzLy7iSqzZCdaTY/Uj0Y6xFwDPZqVz46d96+LDrHn0
 wjwVnpGS97sxJolsObffxPrqTWeM/69p8c8vYE2dcHPkKNULgbQZ0Cp2d6HVnA6nFIyO
 OXsGvXNw5gfDmP4FVNuNQ06GMJfYa+R/J9GE4MkkadtUShflj5HKFd5OLbIbHHwK1ijt
 wCkHeRAZzw/wsDjfoSmw4xdqKeqmjwVWGpprRgqX1rwWNA8bv9oMyc4PLG/nZkDutxO0
 NN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710632; x=1695315432;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PFDrZg1H7FdsNSeJzSEmgLOu0CvwUXAeF443lrdS7FU=;
 b=bQzpBMd4f2uP2bKR/Hjs1/A9Ikgy7TJTts+BQoqlbdaCXdZ3YLnoE2eICimvNV0Eqt
 kO1Gs9aMqbSShDvqPgup3kzgJrwfX2iyMpFGpboiMxiSOpTSGbYUE+H48Bnwgy5m0uwO
 1KL/QD5Rl4CsQ/5BX82FGNLh40T4SWPbyUJx3w+LbRZOY/Z+hsh9bhUre+bp4UHbyjn8
 LhlsPK063FmOu+0BOrOC3Yd4q9wFQ/vuqKmXkQJ8tsKDiVhZxOCeNfq25fRwSe2qhpBb
 7ct31M8/SlhpuxEjgFRb2EnotkWiWCUZgXH/os7cHlrzchKUDJA/sThB1EJOTen/kuNk
 JvqQ==
X-Gm-Message-State: AOJu0YxomxnfjmZIXsf4KOcyMp04fXTTKvl0FEwurkB0KppCEvHuX+I3
 U50HPIHyz8xftTwpW3BlmLn+XZSAk1w=
X-Google-Smtp-Source: AGHT+IHcgTAUpLDIpk6xes8cb0Lh/vjJMt8y5ALxtexCsQOKSOve+PfADFBaxlPn1IG/Q/1qE8x9cQ==
X-Received: by 2002:a1c:4b0a:0:b0:3ff:28b8:c53d with SMTP id
 y10-20020a1c4b0a000000b003ff28b8c53dmr5036856wma.33.1694710631778; 
 Thu, 14 Sep 2023 09:57:11 -0700 (PDT)
Received: from karim ([197.39.44.105]) by smtp.gmail.com with ESMTPSA id
 k23-20020a05600c0b5700b00402fa98abe3sm5310533wmr.46.2023.09.14.09.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:57:11 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 
Subject: Re: [PATCH v3 22/23] bsd-user: Implement shmat(2) and shmdt(2)
In-Reply-To: <0bdcfe70-58ac-4ed0-4f75-33d30653a9c2@linaro.org>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-23-kariem.taha2.7@gmail.com>
 <0bdcfe70-58ac-4ed0-4f75-33d30653a9c2@linaro.org>
Date: Thu, 14 Sep 2023 19:55:49 +0300
Message-ID: <87jzss4ru2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Richard Henderson <richard.henderson@linaro.org> writes:

Do I need to enclose `shmdt implmenetation` in a WITH_MMAP_LOCK_GUARD() block?

Mr.Warner forwared me a patch series ,that you sent on Sun 20 Aug,
for the linux-user, which encloses the implementation in such a block.

--
Karim Taha
> On 9/9/23 12:37, Karim Taha wrote:
>> +static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < N_BSD_SHM_REGIONS; ++i) {
>> +        if (bsd_shm_regions[i].start == shmaddr) {
>> +            bsd_shm_regions[i].start = 0;
>> +            page_set_flags(shmaddr,
>> +                shmaddr + bsd_shm_regions[i].size, 0);
>> +            break;
>> +        }
>> +    }
>> +
>> +    return get_errno(shmdt(g2h_untagged(shmaddr)));
>> +}
>
> On success, this needs to mmap_reserve the region for reserved_va.
>
>
> r~

