Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E0830F78
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 23:46:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQEf4-0003JF-UH; Wed, 17 Jan 2024 17:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQEf1-0003G6-LA
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 17:45:27 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQEey-0000OZ-Gi
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 17:45:26 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d6efee006bso1219135ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 14:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705531523; x=1706136323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QRay5p2FeRwkFHqq7oMBYO5mXXsEae16w052z7kDyw8=;
 b=TLL37UJwEnph1+2X65w/q+kRhcYHSudp0CHojoMMDp6eC+BKsnsG3iRXfdN1RKhuEW
 EW6ZpCvxvD63Z+t/7BOsUyn49DYFxX7tQDzge14EuR8OMmbIOKEt8p+iQxz9X/KBC3GS
 x//MeW/kmPWAV4mXQdDQdP2bcj0Yo/MsKv/E0jZnIXlrMjGSRCPenT32jrWPmwIuI8RJ
 Yi6DeR3ZfzHiUydkou5gkWAkWjj6MUNQOWluexUzp4gRZzakkHAZAKbzs9mOteSg0gyF
 hV82aBC8zMpa7gfhz82F5ssSxSYbHj26aOlGEbIfFEB/xA9wLqdw1n4G+eKJvhqWHGkH
 XwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705531523; x=1706136323;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QRay5p2FeRwkFHqq7oMBYO5mXXsEae16w052z7kDyw8=;
 b=emglgS740Sv3QdnOlM13Yg3/TsMDrEEkTY6MdRocAYJGU3Tndlty37SUzgok6mRH0x
 paxgWg/Ex1V5/NVlBr+8wOWq/btD+nZ8BqbAeWWs4WMPzOZFN3tVQeYOV85ennu7abKT
 2W+hGelbuTlRi4i6wI/r/MTtVZIs6iNUFQi7aAUFPgqB3npQ6ody3+mkp9Y/qC2qp7z6
 /QKhyil7jG+9crRFqJJbRu/kfQE9p403nL5GiYrJPIl1y3T+jxaac+5yakU5ZvIeDGju
 2kvpuwO7djDNCEr1n+cHFH9R6ulJl5Tb2VR47Z0jmPpFjUq8cHJLPBdkLcspqtbe+LhL
 7zyA==
X-Gm-Message-State: AOJu0Yw+Cyq1rrek393QBs52/oCT6tjrHlROXtm+8VUXVRspfVl7amRg
 uX1IHdyQ7W2qIkSQMGAXoKKvBWGwhut6jnRckk5TsuFXHHbfc+0eK3KzHIJ3TTfm5YA5jl1c/Y8
 xpBc=
X-Google-Smtp-Source: AGHT+IG25NFg2jNfwGn/5dUyPpZHEkbSoD3gJphdNrzUr5YxH17ML16r9dE8kr/0kKlF9weliSemnw==
X-Received: by 2002:a17:90b:243:b0:28f:b0bc:9b7a with SMTP id
 fz3-20020a17090b024300b0028fb0bc9b7amr2009672pjb.49.1705531523040; 
 Wed, 17 Jan 2024 14:45:23 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:321b:5fc1:fe4b:9b89:f799?
 ([2001:8004:2728:321b:5fc1:fe4b:9b89:f799])
 by smtp.gmail.com with ESMTPSA id
 qc16-20020a17090b289000b00286da7407f2sm209422pjb.7.2024.01.17.14.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 14:45:22 -0800 (PST)
Message-ID: <2d33a850-32e0-4eb0-8638-52fa936fc004@linaro.org>
Date: Thu, 18 Jan 2024 09:45:15 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/s390x: Import linux
 tools/testing/crypto/chacha20-s390
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, thuth@redhat.com, david@redhat.com,
 philmd@linaro.org, mjt@tls.msk.ru
References: <20240117213646.159697-1-richard.henderson@linaro.org>
 <20240117213646.159697-3-richard.henderson@linaro.org>
In-Reply-To: <20240117213646.159697-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/18/24 08:36, Richard Henderson wrote:
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 30994dcf9c..28f19a3176 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -66,9 +66,13 @@ Z13_TESTS+=vcksm
>   Z13_TESTS+=vstl
>   Z13_TESTS+=vrep
>   Z13_TESTS+=precise-smc-user
> +Z13_TESTS+=chacha
>   $(Z13_TESTS): CFLAGS+=-march=z13 -O2
>   TESTS+=$(Z13_TESTS)
>   
> +chacha: chacha.c chacha-vx.S
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $^ -o $@

Once I started testing with cross-compilers I realize $(LDFLAGS) is needed here for e.g. 
-static.


r~


