Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92C707D05
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pza34-0001Bp-5i; Thu, 18 May 2023 05:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pza30-00016d-Jb
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pza2y-0005pI-ES
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684402542;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=M+GeQzFfC4odhNteiRcE+9zowp87k4ybGO3jVEBDBSw=;
 b=YpSmdDJdili5Hq2agvhJBaqVpL+7HhekPUTqqWVvFupqm/oTTAjJjSE8uUheCXt+whSc8z
 p+7DE6kYhPIkWTguq6xboyOrGd92oW+14i/NShrejrez01NKI/TP8ctcgqWyInr6dU6Q7S
 8NpWDLz+jzurv+vUCiiYAaKBdv0cUOI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-RG-vCwJEOYmkiAuE0ljNgQ-1; Thu, 18 May 2023 05:35:41 -0400
X-MC-Unique: RG-vCwJEOYmkiAuE0ljNgQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f421cfb4beso7276965e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 02:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684402540; x=1686994540;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+GeQzFfC4odhNteiRcE+9zowp87k4ybGO3jVEBDBSw=;
 b=NceBuYVJlXljcNtHwhuvj5sGqiO8wGIU38SN5Hpc0hZAsEHYMXL0IRf2k/t4gxtK3a
 tZRCxOfHIxGciMq+xdwgfpWyyzwarbdzpCZBRU8+HV+LX+/LuE78RI5eny2oWVg491ET
 ZCGJXwbowkcHuOadDvWkXHPwz4R8nmoP6x14+L0zNtkRhApT9jV1NvstVzfmy1SK0a1I
 qQxSz0kc1VeeUERg3XQS9W7WvPjAS8U+bgyepfVNCHULa19B6VYvxy+yHw3ghR3LD8xX
 zrFSfi70B+MnYLrzYMBfL7SacZwWFI08e0RVrkBxew/0Kef5O7qqIfOXP9HjZK44pF2G
 3nNg==
X-Gm-Message-State: AC+VfDytbkXbmAxO10F03J6wIRgWfMncPs7+ZbcgBTp8w/fCVhV/8omb
 4uPm9S6M45Ya5UTsJOx2L3WQkprdbTzCZUdTrSQ1sDQujzU7kGLVmsJgJLE3kg6tJwQWUjT6T2c
 6g7F6iO2zz/WiScQ=
X-Received: by 2002:adf:ea84:0:b0:309:4cd5:76f8 with SMTP id
 s4-20020adfea84000000b003094cd576f8mr759865wrm.2.1684402540243; 
 Thu, 18 May 2023 02:35:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5oL+errXNl7OANJeG6melB2CNOKqP6GMHd+O/UaeVOa5JdkQECJTlnFszaXGylbUr836W7rw==
X-Received: by 2002:adf:ea84:0:b0:309:4cd5:76f8 with SMTP id
 s4-20020adfea84000000b003094cd576f8mr759856wrm.2.1684402539938; 
 Thu, 18 May 2023 02:35:39 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 s5-20020a5d6a85000000b0030633152664sm1544182wru.87.2023.05.18.02.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 02:35:39 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PATCH 2/9] util: Add cpuinfo-i386.c
In-Reply-To: <20230518044058.2777467-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 17 May 2023 21:40:51 -0700")
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-3-richard.henderson@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 11:35:38 +0200
Message-ID: <87wn16dlsl.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> Add cpuinfo.h for i386 and x86_64, and the initialization
> for that in util/.  Populate that with a slightly altered
> copy of the tcg host probing code.  Other uses of cpuid.h
> will be adjusted one patch at a time.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>

For what is worth my vote O:-)

> +#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
> +#define CPUINFO_CMOV            (1u << 1)
> +#define CPUINFO_MOVBE           (1u << 2)
> +#define CPUINFO_LZCNT           (1u << 3)
> +#define CPUINFO_POPCNT          (1u << 4)
> +#define CPUINFO_BMI1            (1u << 5)
> +#define CPUINFO_BMI2            (1u << 6)
> +#define CPUINFO_SSE2            (1u << 7)
> +#define CPUINFO_SSE4            (1u << 8)
> +#define CPUINFO_AVX1            (1u << 9)
> +#define CPUINFO_AVX2            (1u << 10)
> +#define CPUINFO_AVX512F         (1u << 11)
> +#define CPUINFO_AVX512VL        (1u << 12)
> +#define CPUINFO_AVX512BW        (1u << 13)
> +#define CPUINFO_AVX512DQ        (1u << 14)
> +#define CPUINFO_AVX512VBMI2     (1u << 15)
> +#define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
> +
> +/* Initialized with a constructor. */
> +extern unsigned cpuinfo;

On one hand, it is weird having a flags variable that is only 32bit.  I
am so user to put 64 bit flags. Future proof, blah, blah, ...

On the other hand, if tcg has survived for so long with only 16 bits, it
is inside posibility that 32bits are more than enough.

> +unsigned cpuinfo;
> +
> +/* Called both as constructor and (possibly) via other constructors. */
> +unsigned __attribute__((constructor)) cpuinfo_init(void)
> +{
> +    unsigned info = cpuinfo;
> +
> +    if (info) {
> +        return info;
> +    }

Have to look several times to this, because info "needed to be"" a
static variable, right? O:-)


