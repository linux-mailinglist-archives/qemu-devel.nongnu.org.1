Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3EA7EED74
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 09:20:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3u44-0007gH-Si; Fri, 17 Nov 2023 03:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3u40-0007ZG-TM
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 03:18:58 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3u3w-0006rC-4k
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 03:18:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso16978095e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 00:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700209129; x=1700813929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RlTvPcgFK4oRDrU5WnnMAz29f5x4fwJ5JgGgaQozQbE=;
 b=hrUFBIOuLKtaj8vMIID3w/ustl3ep+g0D2xi7fdLqGLDrrI/8VONsSVJJUqkEGmtIm
 ngR5bZ/qxg23ofIogfaRQB/bbuxRx6veFMxkn8ekVUNAB9uNOyVFXJCewiNf23exjNPf
 H1MC46lXMzFFGXvfs/9D0r9i4714X5mWvVwlxEOj2kOtbJRTsH9AULWcHrc9tPdCRKqS
 IXbHuDgcv1xBy9ccYEACoC24U6qsIWfTomuXBcFyZVAEN5OGUvRosAcp/EvxsF95g1S3
 rzD01amvP81Bi6bRepAUmkUrBKUSVpq0bmWLLGtNAMzLTFo9XcRSin/TGRnet0KsawxO
 6ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700209129; x=1700813929;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RlTvPcgFK4oRDrU5WnnMAz29f5x4fwJ5JgGgaQozQbE=;
 b=GFMRoBPHDZ7WYiIsFE2ScpstnicvlAVI1Ntyue3OWIvfSJT/1nq4AFGLxJ2D4yCfkJ
 v5IHWPalqZfcdao90rMAS/A/xaHQldwY+cndjD7Ye/u1qW6eAlIbZyg7hKbKDiHah/1t
 96E6/a6gPkSSxiqw+yua1gb2TAiFpCzdxGwS8VI8lz1cnV1t6MYniOjajLDo/CKpaiQx
 m9AxpCivjVuP+sOH2yLJiIKDTZYrRqlqwOXPKsJUOuhC4qNs6ejEIiW8+P5/5UcsdZPk
 F2Q42D2uasPlSDSyFBN4pIVHkkWl3rB1J8qMa2v1cP0ejteqwEGoakN8WkQL0AW3/QIi
 g6AQ==
X-Gm-Message-State: AOJu0Yzp1GCmTDgGWdzNUIqD/o7WapaBuGG3KxGtohP9VSdx/qYFxptq
 YW67J7dIaIqRDvVWywhw2MpVXA==
X-Google-Smtp-Source: AGHT+IENiXztF3lnYAIMKq/zMUBwHs6/QoSKYiuEAvrMfrUiC2jK6aAnnP5VGUbYaPZ2DHw+NRYVrA==
X-Received: by 2002:a5d:59a4:0:b0:32d:c792:fcaf with SMTP id
 p4-20020a5d59a4000000b0032dc792fcafmr3198714wrr.26.1700209129076; 
 Fri, 17 Nov 2023 00:18:49 -0800 (PST)
Received: from [192.168.69.100] (bd137-h02-176-184-46-187.dsl.sta.abo.bbox.fr.
 [176.184.46.187]) by smtp.gmail.com with ESMTPSA id
 x5-20020a5d6b45000000b0032f7fab0712sm1578975wrw.52.2023.11.17.00.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 00:18:48 -0800 (PST)
Message-ID: <7abb3a05-0779-4bb1-926c-403b50664135@linaro.org>
Date: Fri, 17 Nov 2023 09:18:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] system/memory: use ldn_he_p/stn_he_p
Content-Language: en-US
To: Patrick Venture <venture@google.com>, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Chris Rauer <crauer@google.com>, Peter Foley <pefoley@google.com>
References: <20231116163633.276671-1-venture@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116163633.276671-1-venture@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 16/11/23 17:36, Patrick Venture wrote:
> Using direct pointer dereferencing can allow for unaligned accesses,
> which was seen during execution with sanitizers enabled.
> 
> Reviewed-by: Chris Rauer <crauer@google.com>
> Reviewed-by: Peter Foley <pefoley@google.com>
> Signed-off-by: Patrick Venture <venture@google.com>
> Cc: qemu-stable@nongnu.org
> ---
> v2: changed commit mesage to be more accurate and switched from using
> memcpy to using the endian appropriate assignment load and store.
> ---
>   system/memory.c | 32 ++------------------------------
>   1 file changed, 2 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


