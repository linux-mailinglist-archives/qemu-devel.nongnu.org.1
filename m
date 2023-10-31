Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7717DD89D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:51:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxxYe-0006wW-ID; Tue, 31 Oct 2023 18:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxxYc-0006vw-Pd
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:49:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxxYb-00048e-5x
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:49:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6c115026985so2804697b3a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698792595; x=1699397395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RepqbKWsDH+T450XPffS8q3hlthm1a6ko4kD+sFK/4I=;
 b=xWFWavIXoZAJTFdXObaHH6QoQm4xFMiR/r+NVNGxiwcjEccBOOieNBn+vRO1jH9GiF
 +bywTVEycpDwVUQxjLYOqdTJGLRhORB54hTkyCnfB7s03M71VacXu+Z1URpuS74QTzQ7
 j9NpQKrAjMwah/t2U7Apzl8P76Sc4VcgNEqNrN2SSPFrq9KhmURP56y0aDU5qedRFLvs
 Ayt5wnf2S7TYOSPs4g2/8dx6yNU9okvggCIzAE11WjgV/DoNReelBZfWGURICX/qZ+Qq
 AQ/PM//m13VZWetwhSUn6bKykXipAg9LSzUDz1uzCpFooTny9gLJrqA9m4A8VRtK6rpd
 o9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698792595; x=1699397395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RepqbKWsDH+T450XPffS8q3hlthm1a6ko4kD+sFK/4I=;
 b=fOTV64cVXR+jsc9gDy2iUbX75MfYSeEsqmeI2U8MI78Th0agc6LDdo2eCWddl5pXnI
 zv197cufju3AoRLMzfTlTpot3guo15hb+9v/EgWP702QT6wq36CITV6hHDAVZqHovKEc
 jTPmeABhZVKbDt+rs2GQTACYaWXt3Nt6xgqCOK7aD33Blsocp4n5y91FCw4LGXF2Vqdl
 Ou0wOyJfo0+HdbxWWmFWdz0reLRUwa/0kz7MEKAYeLzquD1+mlwIP3qDsUxgfD2xRQFq
 +4ldFOuI0v5pdNnBTtvqrUodUJ5o0lF2F9ZoQQKy8wmz66mdLJhmXAjDp7w9K1TsvZu4
 Tqzg==
X-Gm-Message-State: AOJu0YzgAqMdnxmIhh/jk4ZX90HSqJcUR1VozG5D+w23BZM+s7aHcPup
 hlXOLsRtx9H7lbOjM/sBfLchqQ==
X-Google-Smtp-Source: AGHT+IEhTJR/EeLqs8X8miCrmH7HlkxyEwgwZV0L99QiJclMR39P8wDrxj8FHUZBpmLeYN9n2uJ32A==
X-Received: by 2002:a05:6a20:8428:b0:181:16dc:d1ae with SMTP id
 c40-20020a056a20842800b0018116dcd1aemr2887501pzd.48.1698792595681; 
 Tue, 31 Oct 2023 15:49:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1709028f8700b001b9f032bb3dsm79086plo.3.2023.10.31.15.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 15:49:55 -0700 (PDT)
Message-ID: <e04bef2d-3ec5-4c98-a4d9-e6692b91f053@linaro.org>
Date: Tue, 31 Oct 2023 15:49:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/s390x: Fix CLC corrupting cc_src
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-stable@nongnu.org
References: <20231031053718.347100-1-iii@linux.ibm.com>
 <20231031053718.347100-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231031053718.347100-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/30/23 22:32, Ilya Leoshkevich wrote:
> CLC updates cc_src before accessing the second operand; if the latter
> is inaccessible, the former ends up containing a bogus value.
> 
> Fix by reading cc_src into a temporary first.
> 
> Fixes: 4f7403d52b1c ("target-s390: Convert CLC")
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/1865
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


