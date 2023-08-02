Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2908D76D6EA
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 20:37:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRGi0-0001AY-0L; Wed, 02 Aug 2023 14:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRGhx-0001A8-Uv
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 14:36:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRGhw-00068D-Cu
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 14:36:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bc1c1c68e2so1278865ad.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691001387; x=1691606187;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=suHTtANtdNZ60LtqRiqaCJt0FRomDSx/Tb20soN1Ldk=;
 b=zneSIdYthpzfVYsHnWoLy3G6KJ9bo9ED/Ld1pZn+MeVeK0jKcWTrWc0A6A/CQfVrfX
 o4m4sHWtE+ZTJBYdSCXYYdlboTS6T92WXk/La2L6sb8nAOJ5elltgPXf7MTFY8z8qKbx
 wlDjTGrAPQANpIRf/qfhJLePn8eMLYwb71yBt47avATb7nZyjyukJXBNGwwpHde9il8d
 9VHDUHSbJ74IzaZJy6wEF7seNYojIfpV7ehWvU2+VRykTTrdgzsK9XUn3Qdsz0VPcE79
 DxQrlQFkvunREEmHpBKDqm5tZPROF6u4kNGydj/9VHGq35dRtyKZN40vjGQWLPUWTECr
 Brpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691001387; x=1691606187;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=suHTtANtdNZ60LtqRiqaCJt0FRomDSx/Tb20soN1Ldk=;
 b=Cj2frRfakkjtvWgkMZZggCn88Fya73m1OMKFQCVGrcSGssmMVd3cuNB5qk26Q8WTFb
 MZXjNC4BmbpgSa9kf29Z6qjclqV0jH3WIjYf4BRG2fnZwLx/nlHnbRy6h0i3Y95DOKu/
 JPX8gyE45oisZHenhP5nfh8tuYjlw7x2Y9ttXE5TYlI9eAlNc1uO+PbmD+xFOqihUJF4
 l9Zmf4msVy7VIAcpQTnlD4yYK0KG9SfULqTkZc+gUpurdYc8OVHqBnMf2LUktcORf4eM
 AQuJ35RxR4W/8R/ew1YyPzWYQd/ShthkdrFHttp54NCjA1bHt7TJcMpJMqOQxBxgahtT
 uFmw==
X-Gm-Message-State: ABy/qLayhhvjIx30qlBmj/JAoImygvINQBJX7iOBEEhv/ITuUTe6cCdG
 TjAtU1RR+RSnqx/Sx51aQga+eg==
X-Google-Smtp-Source: APBJJlGIfOiVyFd/TefuC1EsKn2WaRyrodQOvsyQ+EN/952vRValbRSTMEyB8l92d3rPoBS5pbIM1g==
X-Received: by 2002:a17:902:d2c9:b0:1bb:3406:a612 with SMTP id
 n9-20020a170902d2c900b001bb3406a612mr16053935plc.57.1691001386777; 
 Wed, 02 Aug 2023 11:36:26 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 jk17-20020a170903331100b001b9e59d6ddesm12764197plb.124.2023.08.02.11.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 11:36:26 -0700 (PDT)
Message-ID: <5b57cd92-149e-5f72-d946-082ebf0bfc9c@linaro.org>
Date: Wed, 2 Aug 2023 11:36:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 8/8] linux-user: Load pie executables at upper memory
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-9-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230801232745.4125-9-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 8/1/23 16:27, Helge Deller wrote:
> +/* where to map binaries? */
> +#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
> +# define TASK_UNMAPPED_BASE_PIE 0x5500000000
> +# define TASK_UNMAPPED_BASE	0x7000000000
> +#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
> +# define TASK_UNMAPPED_BASE_PIE	0x00300000
> +# define TASK_UNMAPPED_BASE	(GUEST_ADDR_MAX - 0x20000000 + 1)
> +#else /* HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32 */
> +# define TASK_UNMAPPED_BASE_PIE	0x00000000
> +# define TASK_UNMAPPED_BASE	0x40000000
> +#endif

It would probably be easier to follow if you use the kernel's name: ELF_ET_DYN_BASE. 
Should be in linux-user/$GUEST/target_mmap.h with TASK_UNMAPPED_BASE, per my comment vs 
patch 7.


> +        /* do sanity checks on guest memory layout */
> +        if (mmap_next_start >= GUEST_ADDR_MAX) {
> +            mmap_next_start = GUEST_ADDR_MAX - 0x1000000000 + 1;
> +        }

What in the world is that random number?  It certainly won't compile on 32-bit host, and 
certainly isn't relevant to a 32-bit guest.

> +        if (TASK_UNMAPPED_BASE_PIE >= mmap_next_start) {
> +            fprintf(stderr, "Memory too small for PIE executables.\n");
> +            exit(EXIT_FAILURE);
> +        }

Really bad timing for this diagnostic.  What if a PIE executable isn't even being used?

Both TASK_UNMAPPED_BASE and ELF_ET_DYN_BASE could be computed in main (or a subroutine), 
when reserved_va is assigned.


r~

