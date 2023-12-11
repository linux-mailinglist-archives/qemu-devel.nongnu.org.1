Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A6F80CA78
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:05:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCfxa-0005nS-SG; Mon, 11 Dec 2023 08:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCfxZ-0005mx-6q
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:04:33 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCfxX-00054S-9M
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:04:32 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3333074512bso2861205f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702299869; x=1702904669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kuWaf12YblzXYC4gd29Ng61Snnnq4mLQpk9zoPJBqbU=;
 b=pDqEbHclWBvQ1AOKpRYELrr/ul0dTVHf6GiZyPodWQmedLJ36RtHOV4AreLbadPfe2
 45Fq2B35seAJjLRqG7CpiNBN7B/idTG8/6Lf6NsDcwCVM4EwdNda3bzLurdg2p85Frnn
 SqWdRv+V6ThkUqNGvwQLQSm4yrIoV6eM1XvDwqcpKJ0S/XdDIhx1yqcg5p/iOxCNXCru
 4oHtdIacDVmZIwFb2kQRIMMEQgYD7WIVDdez6M1U0oGzQcqNK5xbR3I81QalB8jHwqD+
 SL4F5MaNXqO4/S/2yS3Z+RIjzdsqZz1cnW5DwJduJoNjFCwyoSE+Vye5Lx6TpYQ2jkbG
 rnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702299869; x=1702904669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kuWaf12YblzXYC4gd29Ng61Snnnq4mLQpk9zoPJBqbU=;
 b=OuFTSkl1Mppzy7/VjTNQ1LcWu5H/N/D1e0mohtujwS2CpylcCpTCf4ZTsbY5QSnbOj
 MA/+bMrdDe8Q0kq61fgp7V7utFH1PYQrkbIPgcXXnKBee6QmTeCi/BsyNsUg0HTmiO3p
 S4Cm0RV5/NrWGOZ9dMF2+wTx69XSwocxilBl60foC79Nq56O/EcKY+3ouW9P5UTQX/cM
 fQXjN/nd69QtIKiON1FK1K94ST556QHw8yvCnN6puzi/gZHJgDzDBqELq44sKpSTrwDS
 Bnp8DOZielDL9mEuNGcfxxAPZdgtJk8qRhPUGbL7gtNjuB21EwLs8grFIP1OLxfAlAEI
 XLSQ==
X-Gm-Message-State: AOJu0Yx7HbF35e6Rm5jjLRQdfQuxn4yg8ASS3n5SzrKKEuBFwrG4mjZU
 VfjdQMoIZmexxdgFJoweEmTg9Q==
X-Google-Smtp-Source: AGHT+IFwfnauUt34yGk+J1lPbf4oD8yNDE49fmZ1R2mLCfsXwsnNnw1XMhaQ0kfolHm/fMZD+EFjtw==
X-Received: by 2002:a05:600c:c0c:b0:40b:5e26:2372 with SMTP id
 fm12-20020a05600c0c0c00b0040b5e262372mr2260526wmb.35.1702299869175; 
 Mon, 11 Dec 2023 05:04:29 -0800 (PST)
Received: from [192.168.12.175] (61.red-88-29-188.dynamicip.rima-tde.net.
 [88.29.188.61]) by smtp.gmail.com with ESMTPSA id
 b5-20020a5d4d85000000b003333521a1cesm8536424wru.57.2023.12.11.05.04.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 05:04:28 -0800 (PST)
Message-ID: <a36980fe-c6dc-42cb-8e96-df00438af229@linaro.org>
Date: Mon, 11 Dec 2023 14:04:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] accel/tcg: add trace_tlb_resize trace point
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
 <20231211091346.14616-16-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231211091346.14616-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 11/12/23 10:13, Alex Bennée wrote:
> I wondered if the discrepancy I was seeing in fill patterns was due to
> some sort of non-deterministic resize being triggered. In theory we
> could resize away at any point which might account for the difference.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   accel/tcg/cputlb.c     | 2 ++
>   accel/tcg/trace-events | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


