Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB0B771CA0
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 10:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSw0J-0000lK-3T; Mon, 07 Aug 2023 04:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSw0H-0000lA-82
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSw0D-00005Z-Q1
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691398452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPUKL33T+2B4449feKHALm68bsJprYNPmme0sUTkOJY=;
 b=Ft1j+HFpU+UTYygSKeoktIMing1wDUNAM8LyUcmnUEbWPOlGX6Oo80dEKKNgYHVI6iEWeJ
 uWHE6dmiOgjvDvewLSJDJTVauCVEgx5QqqhJZy3rBLKqJXKp7xkjaiXtHRyI2jidT+uz36
 8qbn3eHNwuh+IQ2Ferv3bQs/ZlDkkQs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-mRaLOW9CPUmuVwXB-gOkBQ-1; Mon, 07 Aug 2023 04:54:10 -0400
X-MC-Unique: mRaLOW9CPUmuVwXB-gOkBQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe25f8c4bfso26600995e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 01:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691398449; x=1692003249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SPUKL33T+2B4449feKHALm68bsJprYNPmme0sUTkOJY=;
 b=lULNEMtoYpqz5lqMfxA8WCYU/SVeETI4BQRjT6jZH5+FScIaU9Epmj/0A6yUU7oEjS
 8S2J+yCrJ2cCk/ynlCxHBdrheeosbDOCWcOhWvoXngqSmz+YyhAhL3EppEbxY0IUNFvK
 GUloOaV3DAPVYn1b1tYexOx6lbcoe+h4vOM4ylQzAeL+Ft+oD7FPEejkMjGTw0CkUqaU
 f7Atb94nC0USalQ8cB9KvdBukqF16vGUwFQV2XdGR+PGxBw1uEK4HzpEmTotz2s52nol
 Ll6Uf7YrCct4bAtdgvY525jiKJKc3DlM9ATk3PJjKVg7xKyj7UEPpqXEkmoqGUySkhC5
 JkJQ==
X-Gm-Message-State: AOJu0YwaOJuQsFLqsnRpuKlKxpGrPzizy79pSz6muQcFILCZl3QDqE36
 sWDJzEy5fl0B7EeCEDgNR8uL7IekQBOOqkM+6Snx6yC1wyA/FkMJWAEKTZpVLtnZLeEz/+JJFwi
 XXs2OlbmkeRjZEEI=
X-Received: by 2002:a05:600c:291:b0:3fe:22fd:1b23 with SMTP id
 17-20020a05600c029100b003fe22fd1b23mr6841760wmk.34.1691398449288; 
 Mon, 07 Aug 2023 01:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXTX44EI41QKhQfvX0soVEMWP+SX06qK2QRC51vJMss6NmHO/F1OXMnW5EHSjBGGwZWJtTrw==
X-Received: by 2002:a05:600c:291:b0:3fe:22fd:1b23 with SMTP id
 17-20020a05600c029100b003fe22fd1b23mr6841749wmk.34.1691398448919; 
 Mon, 07 Aug 2023 01:54:08 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 a25-20020a05600c225900b003fc00892c13sm10092216wmm.35.2023.08.07.01.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 01:54:08 -0700 (PDT)
Message-ID: <4cbf15ac-763c-106f-b98f-6dac1d15542b@redhat.com>
Date: Mon, 7 Aug 2023 10:54:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] configure: Fix linux-user host detection for ppc64le
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230807083950.29521-1-joel@jms.id.au>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230807083950.29521-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.139, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 8/7/23 10:39, Joel Stanley wrote:
>   
> -case "$cpu" in
> -  riscv*)
> -    host_arch=riscv ;;
> -  *)
> -    host_arch="$cpu" ;;
> -esac
> -
>   # Normalise host CPU name and set multilib cflags.  The canonicalization
>   # isn't really necessary, because the architectures that we check for
>   # should not hit the 'uname -m' case, but better safe than sorry.
> @@ -508,6 +501,9 @@ case "$cpu" in
>       cpu="ppc64"
>       CPU_CFLAGS="-m64 -mlittle-endian" ;;
>   
> +  riscv*)
> +    cpu="riscv" ;;
> +

This is also wrong because it confuses riscv32 and riscv64, which 
matters both for tests/tcg, and when creating the Meson cross file[1]

Instead, the "case $cpu" that sets $host_arch must be placed after $cpu 
is canonicalized (and possibly just before $host_arch is used to find 
linux-user).

Even better, there is already a variable $linux_arch that has the same 
meaning.  I'll send a patch to unify the two.

Paolo

[1] https://mesonbuild.com/Reference-tables.html#cpu-families
>     s390)
>       CPU_CFLAGS="-m31" ;;
>     s390x)
> @@ -810,7 +806,7 @@ default_target_list=""
>   mak_wilds=""
>   
>   if [ "$linux_user" != no ]; then
> -    if [ "$targetos" = linux ] && [ -d "$source_path/linux-user/include/host/$host_arch" ]; then
> +    if [ "$targetos" = linux ] && [ -d "$source_path/linux-user/include/host/$cpu" ]; then
>           linux_user=yes
>       elif [ "$linux_user" = yes ]; then


