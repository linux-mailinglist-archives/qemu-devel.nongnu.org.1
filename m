Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAAC827A16
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 22:14:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMwwg-0005KG-6z; Mon, 08 Jan 2024 16:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rMwwe-0005HO-AX
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 16:14:04 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rMwwb-0007Qx-Lg
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 16:14:04 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d40eec5e12so18322765ad.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 13:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704748439; x=1705353239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q5rJw54yP4v7QbgPp1BiRs6Jtx3owK3bClJNsIzaE3I=;
 b=KZbe96kXblIQ6j56lUNvnsASEVJOJslRnvS7TR7KIeAhGe+Yn/5BOlKqBCUzP3m+02
 GNw1KPIY63rOw+4u+0iACp4/QV9xkDiJIWbsP3PJFcMDIo/P/S90IpYYoTN1x0Kil1Q0
 UFROXxP2rihZt+KQ/eKpKEOkJgFUJ7AuB+GAtDQCRTC+AXun3+gO3HdjIRsnYzNaMNEu
 Iq16Zhjxn1Mc2+7kJJ/XaOGCkjDZDJl6/4PgiR+4Sj0CEwUDvrqnM5N2nhB+VvnbcO6q
 1w+aQPQtvPEITtexlBzE29sHvR/X2xO/kFA5L+6oPwMmigZRjrhneMLPXa10fhf4+TdP
 3nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704748439; x=1705353239;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5rJw54yP4v7QbgPp1BiRs6Jtx3owK3bClJNsIzaE3I=;
 b=Ska7QIh8YZan4AB8CkVq+J6+dFgtbMf966pRyl3XrCj/Jvi7qy6kaZ/xNRHUMKOO7+
 hM5wOa3J7ZoCOto106raLCmBKtmrh7djS+fNlt1as8gYmj88QdCI1g7Vxzl/b05gqLt8
 mpocWZmTfdznvvXBq6gs02pHa35fq09gdfy4L06bskKcKY2Po8vic/FLLmIit/wIyuxw
 qVyQD959wPS4S62Pf/fclh3JCYSzzLs93N/RH6Bc/0HLsCcKJ3mCh1zUUyNxM9yRFr70
 ogK90uvHY9Ox+IWWVrCJDr4aKV+UA4ANzHPUev/KUNeKWIIVrtQHRZPQJ7HdUp/j6ZVS
 t7Aw==
X-Gm-Message-State: AOJu0YxSt7aAo87Vy3GjfeOB6YL46i73BFiI4BzxYoJ3IbGK6Hlshghd
 S+ozVi9pYOiWmp/Sjqfp9G61T9D/Xo1Txg==
X-Google-Smtp-Source: AGHT+IGrU+wWGGlNHzV57euIH5goJVtvcAgYBnapGXAG/8s2ZK7UDZsgZH2uGQE5yRRAbSuGKrW7xQ==
X-Received: by 2002:a17:902:6f08:b0:1d4:868b:7ccc with SMTP id
 w8-20020a1709026f0800b001d4868b7cccmr4104960plk.111.1704748439578; 
 Mon, 08 Jan 2024 13:13:59 -0800 (PST)
Received: from [192.168.1.66] ([103.194.3.133])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a1709026a8a00b001d1cd7e4ad2sm332117plk.125.2024.01.08.13.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 13:13:59 -0800 (PST)
Message-ID: <cd2f9cb8-9f79-438e-8ca8-a3bf1675b232@linaro.org>
Date: Tue, 9 Jan 2024 08:13:55 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: fix build with musl libc on ppc64le
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Natanael Copa <ncopa@alpinelinux.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231219105236.7059-1-ncopa@alpinelinux.org>
 <5f7b5921-b6e3-48f1-8bec-b4fdbfdac2f1@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5f7b5921-b6e3-48f1-8bec-b4fdbfdac2f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/5/24 03:26, Philippe Mathieu-Daudé wrote:
> Hi Natanael,
> 
> On 19/12/23 11:51, Natanael Copa wrote:
>> Use PPC_FEATURE2_ISEL and PPC_FEATURE2_VEC_CRYPTO from linux headers
>> instead of the GNU specific PPC_FEATURE2_HAS_ISEL and
>> PPC_FEATURE2_HAS_VEC_CRYPTO. This fixes build with musl libc.
>>
>> Fixes: 623d7e3551a6 (util: Add cpuinfo-ppc.c)
> 
> Hmm this commit barely moved the code. Maybe it revealed the
> issue from the following commits?
> 
> Fixes: 63922f467a ("tcg/ppc: Replace HAVE_ISEL macro with a variable")
> Fixes: 68f340d4cd ("tcg/ppc: Enable Altivec detection")
> 
> Anyhow, changes LGTM.


Queued, thanks.


r~

