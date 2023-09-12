Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 519BA79B704
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 02:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfquH-0004yV-67; Mon, 11 Sep 2023 20:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfquC-0004xp-64
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:05:25 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqu9-0003CN-JC
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:05:23 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso41160795ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 17:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694477119; x=1695081919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7aeJFmCe57+HT2J8eu9cLgWjXAANkhSzpe+NWY1piwQ=;
 b=i5iAFCJjZ62ucVsQyl6ZoYNKVf/IZr7pUWgxW+d47KxoZNESP+SNyzoAyL3/3mPpkY
 /CBkf9O8w/tAvW9B0UWpd/ZS733eR8WfjEbrGotfPv+SxsAwiJXhp017ed9PeNIvK1QL
 Qb3pGYA1nl6pPXqzZx9qanzomuLsVE6OZGuuDc+vIXLy7Ae4YyeouSV1AOPKmMp2LsTj
 YzxXj0+V5UwZioPXRNfhAof4TwHPNNhbtom1tuL7dFDeuymho7kqdi2YtDazAkkUY/FX
 ygUDqlVZpHypxmHh2+HoZ3JV7K/M+o/4bQUm8XkVL3nx+SXy3ANSX0vNCqM+Hf/WfV9k
 j5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694477119; x=1695081919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7aeJFmCe57+HT2J8eu9cLgWjXAANkhSzpe+NWY1piwQ=;
 b=j+zgvYGG0Jx78k9yVfPmvfwK57D10opQ969wJ4C+TUXHU+EKqwMbDbC/nnW1Nf497F
 LfScz11TJnZN3pLIV+vdQ8ERbOor32G2YbUEm2Ep3MAEWjGIpGe0B3Fdlz1NZ0WSV/Rw
 x4ueTrJkRE17vLYCnJ6zIDlaK8dXOgkUmfMuL/r2RxiL0jP2fa2ldfIKhV1of9OBtwiu
 he7pJuNWY270o75xYgBwb/DVbtW6X7c+M9A+0kgyGIX9HQS2nIzzrfJhipxnJmxjn8Ck
 vfGFRKOMJdT2G77vgy/di7D3TM7Z0whRZCzEkBnp8HjKCguydDwDDj3mSva2G1s5VyKT
 avAg==
X-Gm-Message-State: AOJu0Yz+dzUQ/EJfTdFHKklkzqExkTPi0p4CDwTkWBGSn221DgrWaf1a
 ZtiHwvCTUgXuSrvxbuZ/ZICpgA==
X-Google-Smtp-Source: AGHT+IHSJZyv524OzxN3d0TAX9tKz42rsoBY+lGc8ZHdOHBBWB6cgfyhABo68lBUgDqczWPjHbidDw==
X-Received: by 2002:a17:902:db10:b0:1c3:6163:210a with SMTP id
 m16-20020a170902db1000b001c36163210amr11514712plx.60.1694477119668; 
 Mon, 11 Sep 2023 17:05:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902c18400b001bba3a4888bsm7008135pld.102.2023.09.11.17.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 17:05:19 -0700 (PDT)
Message-ID: <1d9c39c9-b5d3-cab7-1ab2-f4ee9f4cac78@linaro.org>
Date: Mon, 11 Sep 2023 17:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 18/23] bsd-user: Implement do_obreak function
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-19-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230909193704.1827-19-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/9/23 12:36, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Match linux-user, by manually applying the following commits, in order:
> 
> d28b3c90cfad1a7e211ae2bce36ecb9071086129   linux-user: Make sure initial brk(0) is page-aligned
> 15ad98536ad9410fb32ddf1ff09389b677643faa   linux-user: Fix qemu brk() to not zero bytes on current page
> dfe49864afb06e7e452a4366051697bc4fcfc1a5   linux-user: Prohibit brk() to to shrink below initial heap address
> eac78a4b0b7da4de2c0a297f4d528ca9cc6256a3   linux-user: Fix signed math overflow in brk() syscall
> c6cc059eca18d9f6e4e26bb8b6d1135ddb35d81a   linux-user: Do not call get_errno() in do_brk()
> e69e032d1a8ee8d754ca119009a3c2c997f8bb30   linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
> cb9d5d1fda0bc2312fc0c779b4ea1d7bf826f31f   linux-user: Do nothing if too small brk is specified
> 2aea137a425a87b930a33590177b04368fd7cc12   linux-user: Do not align brk with host page size
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 45 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  7 ++++++
>   2 files changed, 52 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

