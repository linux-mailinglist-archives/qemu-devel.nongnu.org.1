Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FBE9B422B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Oct 2024 07:12:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRa-0001g5-Fb; Tue, 29 Oct 2024 02:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRY-0001dx-8m
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRV-0007GN-C1
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so50387425e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182260; x=1730787060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LahcWkmLa46gQ/BZWeklcOH8biCwkYCWvJuufWQf5gE=;
 b=qGxxcXR3WjRAtXxNEEpfHmjg3GwpuE4vZRwd/VithXlzDoVy2SwnPJSYKIfTGkS1u2
 tst8oheP0FHMkVSQvR0fQKyf4L1EIa6RosCFMxj3mDWlBprRP2SKBIdLvKMyYIylq9TQ
 qafC8S+oEANv9tsi4rW6E5RsWOmx6HLVvsAs3o8uWp7qj+KfSVJ0GXvYWWIuxac8vhek
 oHVZBpT0jvi/FgvW94K/1s0Qs2GW9FtNpBCFIlY1qx7P238MMxCEZIfB75+/8P07s6SF
 0EJN0lnr3eHOD9+v/TmTg3BPnovVebcyaaLnVqJa8VzaAzRYDV9h18Tyww+Xroxcfk4N
 i22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182260; x=1730787060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LahcWkmLa46gQ/BZWeklcOH8biCwkYCWvJuufWQf5gE=;
 b=XRdQS/JV/tfO1W/lZY8Yh0YWQUHTBVEErcYIiNsvYk01DImxgz1j+IbGKgm0hZsnpK
 +mBUo5i0zwvqYMkqBc5Hj8H/AA495JIWFf4Z86xkPswp7NgzQCWykSb7OQ1VCLh1QPDk
 XP41GuSnFdjOHbjDrHzU/58kTBxPkFuQGIN+kAnFBBltJ8iXjhsW0sJvsoEnfybzaFxb
 BbV2WS0kK1axw3nquhQNz/wX8bIsTkNZp1jOUPnKdf8MTaeAjsPtfTuWvFEPodAETv3R
 pkgU6H9vahckcRFOTmdIpOAnWkTI1Iz+cmchZvMELZmh32AI9qi5HXPVTsB/rfzGRwBL
 X82A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkNs4U5qoBTAD9JOhKHGXweyL+gKrXW/Bk+2nxg8wClMTAIN2Dnu3+LTuSg52zoptVx01oCtJ1kuE4@nongnu.org
X-Gm-Message-State: AOJu0YyhGUCHak5AIMLr6wxdG3+rTt8D/OvqsQSMraLBEf5eh+km4N5H
 grCDvIz2jLWEwcEmDPCVNMXnCyUfEiJPaLuP9MP5x4Lm+ESj9B3S1RMWox7vlew=
X-Google-Smtp-Source: AGHT+IHExKUK3UshOUzVx5r5Be89FzG9/0HsbhesmFubuIqpfzCLyoE34FsfTaBE395kmjfd8mxDug==
X-Received: by 2002:a05:600c:3b87:b0:42c:b187:bde9 with SMTP id
 5b1f17b1804b1-4319ad2f06fmr81341425e9.30.1730182259795; 
 Mon, 28 Oct 2024 23:10:59 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431b45aa058sm12150405e9.1.2024.10.28.23.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:59 -0700 (PDT)
Message-ID: <3939d294-2a0a-4f39-aed4-86adf8de48de@linaro.org>
Date: Mon, 28 Oct 2024 12:22:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/21] target/xtensa: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-15-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/24 15:12, Peter Maydell wrote:
> Set the NaN propagation rule explicitly in xtensa_use_first_nan().
> 
> (When we convert the softfloat pickNaNMulAdd routine to also
> select a NaN propagation rule at runtime, we will be able to
> remove the use_first_nan flag because the propagation rules
> will handle everything.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/xtensa/fpu_helper.c     |  2 ++
>   fpu/softfloat-specialize.c.inc | 12 +-----------
>   2 files changed, 3 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

