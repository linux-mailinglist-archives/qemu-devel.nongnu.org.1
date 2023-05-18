Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19183707D28
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:46:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaBT-0003Qv-QZ; Thu, 18 May 2023 05:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzaBQ-0003Qg-S7
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzaBO-00079p-Pn
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684403065;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OUG108Q9Iv3dBxzKAT0UghUTe5mqn2jfKfRRK9V5G1E=;
 b=VaqZhKC6NpnXKOTBgpFTupOisO5oCia1LF19XGg+Kzsa57ydxZq3r2Wa/wq3cDBUwc/i/7
 oFuSLXYZc3UwK1VInZcTvLPIldHA1PUWVqhQQJnFW5YnRRVwFeR4r0yOoDfRX/yXFyT0C5
 k29JnFOq7L8VNR5unYwWmjDLfllYUyg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-2mqkIdBoM0eZjryLPeom5g-1; Thu, 18 May 2023 05:44:23 -0400
X-MC-Unique: 2mqkIdBoM0eZjryLPeom5g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f422150893so11377845e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 02:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684403062; x=1686995062;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUG108Q9Iv3dBxzKAT0UghUTe5mqn2jfKfRRK9V5G1E=;
 b=kibHVXyI12wGMI9zChZmZl5C6JCbsyILzcQ+y6kG8q7hDH8YqV0QxyhDBKh47SgSCh
 oGSCg65c08yThrC+GNf0DFSGanimxqW5+s5L5LZUGU7KbhBMRPtQM/ivmqLumGM5wHb5
 WZjBUz29QUm3Hcm4mxvmTrGt0Yr3PMCS6olURL5YpXx8rriUNURPKWxYZ/OZwPXDyv+f
 8opTkTrz24X9aB3paujbbY/rp5qgeHth2sDBleePBJnBBcBDOgTsWQ6N6HmplAbDXrij
 QWKtF3Np1iIYnSl8pyjLNVZiCEsd9HU2J97dIBK/iC3X4sv1wNZwv3OlpMD/j6P1l5Pz
 UNdg==
X-Gm-Message-State: AC+VfDw3J7Z5FwooCKWOYaE2cwpBZWHVXb8THfQXQhcwig7eCA+hiyBU
 i7/0ibWcDSIgAEkLxYU0oje16odVft2BTxTSbk428D78SoomhWNj6SvdSgWs0q2HElK+10C9fzi
 Ga7tAjLA/oW1Iw/g=
X-Received: by 2002:a1c:7c0a:0:b0:3f4:2815:3afc with SMTP id
 x10-20020a1c7c0a000000b003f428153afcmr1112788wmc.13.1684403061805; 
 Thu, 18 May 2023 02:44:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51SxUFM9yumgOlfY468UpLvPYB6ti0wSlXOgqTwEvWPltsf478M++4Gcd39YMOJiJOw0V1Yg==
X-Received: by 2002:a1c:7c0a:0:b0:3f4:2815:3afc with SMTP id
 x10-20020a1c7c0a000000b003f428153afcmr1112776wmc.13.1684403061489; 
 Thu, 18 May 2023 02:44:21 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 y20-20020a05600c365400b003f42bb3a5adsm4881169wmq.4.2023.05.18.02.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 02:44:20 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 7/9] migration/xbzrle: Use i386 cacheinfo.h
In-Reply-To: <20230518044058.2777467-8-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 17 May 2023 21:40:56 -0700")
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-8-richard.henderson@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 11:44:20 +0200
Message-ID: <87v8gqdle3.fsf@secure.mitica>
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
> Perform the function selection once, and only if CONFIG_AVX512_OPT
> is enabled.  Centralize the selection to xbzrle.c, instead of
> spreading the init across 3 files.
>
> Remove xbzrle-bench.c.  The benefit of being able to benchmark
> the different implementations is less important than peeking into
> the internals of the implementation.

Agreed.  If AVX512 is not better than a plain C implementation, better
to not have it O:-)

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Not queued.  It needs your other patches, I think it is better that all
teh series go through your tree.


> +static void __attribute__((constructor)) init_accel(void)
> +{
> +    unsigned info = cpuinfo_init();
> +    if (info & CPUINFO_AVX512BW) {
> +        accel_func = xbzrle_encode_buffer_avx512;
> +    } else {
> +        accel_func = xbzrle_encode_buffer_int;
> +    }
> +}

Wow.
Comparing it with previous implementation that did it by hand with asm.


