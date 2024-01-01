Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A138212CE
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jan 2024 03:02:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rK7bZ-0006Iq-Nw; Sun, 31 Dec 2023 21:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rK7bV-0006IV-8L
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 21:00:34 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rK7bR-0006vP-EP
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 21:00:32 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5955cb20569so710029eaf.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 18:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704074427; x=1704679227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F/v83Qjz23rIce4bNK64OnSL49aBBzew02D+Hquopsc=;
 b=F8QXtmNAvSMeWJZJCCErc1zYDECk6AdZdG6gX/AM1+BgI2NUub9ErXQdZJKfB6NXjK
 QW2nmQsMGqkZM6SRNW0XyHEIxgsD+5AApTcb1ZfkxIxInZl0zRKck13JkyBTkglMzaul
 4961717XYL979XDm+v1/BABIMbWtnCMmasarXENW8/yFt+6KKI/9LtASku7/oCJMAwVa
 7C4YJ6mVJuIkv1xws06d0sxvceNMIucjCSQevrWwgyltHJnBOLjTVPA6rRAdDP3KjKlR
 wF+ZCIACkHY42tUwtJMdsIIC4yGdaXJB2aj9M40/9ReFaCLZtjPCZURicMhaf6Ff0lba
 CNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704074427; x=1704679227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/v83Qjz23rIce4bNK64OnSL49aBBzew02D+Hquopsc=;
 b=ddKsdob6sUZC+pDf6MPgjCftzSVIt/3aAg6p9aX2ZHHJ40UN5WmNYzzm7Bhu/uPD8D
 /lks58KYAxrgcoef2PIkvqEQLKG6NC8bTyN3JW4qrQ2AIIXS2pJff8ZJfAnTw3nGhPaV
 fyCMkqr+Shk/5ooIE8mbEeDIxZVUfRdz0csFjJaKizCiWyt+GnUSreO99gME+vFd+ige
 5y21vALTNP4NiOZO1k+u5Lt4jK0XbNhdHBrV5QhT7AAMw92jh1eQkZYt/11Ylwhq40+0
 iTToQ6uoZS1i94V/Z/OWgh9bFDkQ90kV0nLnvh/ZHW7/zp+rmPtEm5sUTdrHaNsjqltO
 fXGQ==
X-Gm-Message-State: AOJu0YxuM3xRIid3pAlaHOqE7ynyioSq1CKXYanrSa01qummQeQLsB7e
 4DSgcdAE4imwvDP+rn8O0ol9zzgAaec2QA==
X-Google-Smtp-Source: AGHT+IEf5sj1OHHfcs8KaFNdJaOPWZfPd7P3DInrUj4bKei3lcp6JQAWTQhQ9rJgRCbgM5vY+h1KvA==
X-Received: by 2002:a05:6870:b24f:b0:203:7bef:1691 with SMTP id
 b15-20020a056870b24f00b002037bef1691mr20387240oam.109.1704074427595; 
 Sun, 31 Dec 2023 18:00:27 -0800 (PST)
Received: from [192.168.50.95] (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a17090ad98e00b0028ac1112124sm19708802pjv.30.2023.12.31.18.00.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Dec 2023 18:00:27 -0800 (PST)
Message-ID: <643f1d00-c917-4bb0-a499-ab7edacac3e9@linaro.org>
Date: Mon, 1 Jan 2024 13:00:22 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2?] target/i386: Fix 32-bit wrapping of pc/eip
 computation
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231212172510.103305-1-richard.henderson@linaro.org>
 <f07b02b9-6c6c-40c1-9f21-2a9bd033a5a5@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f07b02b9-6c6c-40c1-9f21-2a9bd033a5a5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 12/25/23 07:49, Michael Tokarev wrote:
> 12.12.2023 20:25, Richard Henderson:
>> In 32-bit mode, pc = eip + cs_base is also 32-bit, and must wrap.
>> Failure to do so results in incorrect memory exceptions to the guest.
>> Before 732d548732ed, this was implicitly done via truncation to
>> target_ulong but only in qemu-system-i386, not qemu-system-x86_64.
>>
>> To fix this, we must add conditional zero-extensions.
>> Since we have to test for 32 vs 64-bit anyway, note that cs_base
>> is always zero in 64-bit mode.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2022
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> This may be too late for 8.2; if not, then 8.2.1 and 8.1.next.
>> I think I have found all forms of pc <-> eip, but another set
>> of eyes would be appreciated.
> 
> This change breaks trivial 4M edk2 boot - both in 8.2.0 and in
> 8.1.4 (which also has this commit now).
> 
>   qemu-system-x86_64 -machine q35 -no-user-config -nodefaults -display none \
>    -serial stdio \
>    -drive file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd,if=pflash,format=raw,readonly=on \
>    -drive file=/usr/share/OVMF/OVMF_VARS_4M.ms.fd,if=pflash,format=raw,snapshot=on
> 
> After this change, nothing is printed on the serial console anymore
> (or in vga, whatever). Before that commit, usual edk2 boot sequence
> is seen.
> 
> Nothing has changed with the 2M variant though.

Ack.  Looking at it....


r~


