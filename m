Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D980AB05
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 18:43:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBerm-00004s-EZ; Fri, 08 Dec 2023 12:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBerk-0008WL-0d
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:42:20 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBerh-0001aE-OL
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:42:19 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d1e1edb10bso21818095ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 09:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702057336; x=1702662136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hQm6GvRg7gjuMYZ65RdFwBqlSpxPlfEF2+WBwv7hVbI=;
 b=Wb92N+eCi2qvo91ZOoVYnY/8dG+Zk1+Wr9aLGn0gj7dIDPGuHIC4LP4JMr6j9Xe/nw
 vgSs3lQeRiRxr5OyoLotrm/A+HZ7+saAkC2vQfhYjT5m6Oi2/RkBdOnF+ld0CLTo/nb/
 BlCpV7R+QevZ6dK68t4/SIARGdpkDIbmyadtIU3bwVcoN6HnsMzsPbQI2giuknLE9C0e
 /kRpPN7N3Uj7XzmROKUsugxn+PdPXJWmfO9lxQ1AQYr2dWmfxT+C1/Yt9HnAHLVqTdFa
 y3q2ANA4kxk0Rgfh4SLj4oEG0TwJunCtU7UvzbFad08eQ2G7g1ZNTiAO30Pldd0XGKPp
 28Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702057336; x=1702662136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hQm6GvRg7gjuMYZ65RdFwBqlSpxPlfEF2+WBwv7hVbI=;
 b=iYNCeaeYjB2qA+CdrKC8JGctF29eHFZoSXet/T+KdZRVFbqYcU55q8ecbFpPEhYpsN
 A2SycJ1sFiQ3f0SjRkbf7LaZup+6N2kbiMEVM6pNW7JoyK9EjStXG3rSmFXpYy1PXXyu
 3opH4LA1gdziWKwsuJGZ+cmCuuafLL7hjOl9pX/UJhOKS/KkzMIhmK5yg51Qreq7dRLd
 pYdmJV4o3lKEDcFfXhbv6NimjLL+fTHfJCU7ELUoXPrWifXFdCSrlroGBvyPzIZs9zUc
 nf1BXXI6AdGuCcfzvhc0bk7NoFr/l1RATO1jCcBgWGpLZRivZs0U4v2gQMWqs3Dhkru/
 6Crg==
X-Gm-Message-State: AOJu0Yy1vjcSmpVp3T5PROpVjG+nhebX1fYadicj5dWZW8TsCBpcjUTM
 eOcpK1iXlsFaLpdF2cZeFWT4dxvJ3FONEoeE3pS11A==
X-Google-Smtp-Source: AGHT+IHby3+j58EU8/AtNonTEpyMqq3f2C3HoQTWveLXIWr5oaYdNJmiRkfmuUg7isJI/YcdSviMIA==
X-Received: by 2002:a17:90a:1f4b:b0:286:77c2:6027 with SMTP id
 y11-20020a17090a1f4b00b0028677c26027mr503768pjy.36.1702057335888; 
 Fri, 08 Dec 2023 09:42:15 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ih15-20020a17090b430f00b0028669c66e37sm3607678pjb.21.2023.12.08.09.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 09:42:15 -0800 (PST)
Message-ID: <8a876325-92bb-46e6-8ba5-47405dbb00c7@linaro.org>
Date: Fri, 8 Dec 2023 09:42:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 8.2] accel/tcg/cputlb: Fix iotlb page alignment check
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20231208020619.117-1-zhiwei_liu@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231208020619.117-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 12/7/23 18:06, LIU Zhiwei wrote:
> For ram memory region the iotlb(which will be filled into the xlat_section
> of CPUTLBEntryFull) is calculated as:
> 
> iotlb = memory_region_get_ram_addr(section->mr) + xlat;
> 
> 1) xlat here is the offset_within_region of a MemoryRegionSection, which maybe
> not TARGET_PAGE_BITS aligned.

The reason we require these bits to be zero is because
(A) The lowest bits must be zero so that we may test alignment,
(B) The "middle" bits, above alignment and below TARGET_PAGE_BITS,
     are used for TLB_FLAGS_MASK.

If iotlb has these bits non-zero, the softmmu comparison will not work correctly.

> 2) The ram_addr_t returned by memory_region_get_ram_addr is always
> HOST PAGE ALIGNED.

RAM blocks can have larger alignment than host page.  See QEMU_VMALLOC_ALIGN and 
qemu_ram_mmap.

But I can see a path by which it *is* only host page aligned, which could fail if the 
guest has larger alignment than the host.  Fortunately, this is rare -- only alpha, cris, 
openrisc and sparc64 have 8k pages, and tricore has 16k pages, while supporting system 
mode.  Hexagon has 64k pages but does not yet support system mode.

We should fix that, but I don't think it's urgent.


> So we cann't assert the sum of them is TARGET_PAGE_BITS aligend.
> A fail case has been give by the link:
> https://lore.kernel.org/all/b68ab7d3-d3d3-9f81-569d-454ae9c11b16@linaro.org/T/

I think the macfb device is at fault here, not your assert.


r~

