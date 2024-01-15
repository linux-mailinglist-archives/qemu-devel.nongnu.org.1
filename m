Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B62982E26B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:04:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPV44-00026v-2i; Mon, 15 Jan 2024 17:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPV41-000262-3f
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:04:13 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPV3z-0001UY-Mn
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:04:12 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6dac225bf42so4726971b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705356250; x=1705961050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Te8RZ88rkhFOCOIfdHq0HpubOJdKUPJeN+D7j7kOq+g=;
 b=Julj/Fhsa8DBqiUSipDmEbaij+dw0sWu05QEFIQ6NoQje2Aa0AGg0DpqGkypuJCEv/
 79/5KR5NLc4yn5c9mNb/kiL+jwucIRBQU66SmYIoB+jkDpvyl9HePTOqjPsH80Vtb+To
 WZAPKry4PCq7XRbrlucy8Za36Jzzsolko2zwpvNEqefMOhj8UGM3YaDLoB6EPra7hvKw
 IPFK4h6tij+1nE2mt/SjabWq1weuToD6gAJgnzm0ulYxxnT6I1gouX4orM55Gh79oLx4
 tDydPmr3ikGFBlhK4oHZud2I/uw2TXDfc9elXmriLiq9UjFJYtsqvaD9HSq73opuC5Gr
 Qbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705356250; x=1705961050;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Te8RZ88rkhFOCOIfdHq0HpubOJdKUPJeN+D7j7kOq+g=;
 b=otoYcnxE/OqmP/BMxi9GfWXTVz3pckpFHaNxKECro6nln8ZNaIymCANEPkGB7Rk5oP
 rZOqsUOchveDNd4QtuT6DQHEQD3jTshg+Bt4kwNUt+vzeo7/FNfDHyRXNJFhQ/9DR2OZ
 jGySTVrUqEQy4T37fd+cNBLznpIOysZ5bVDWH/1KNGEAGUi0wNJl1ywdE5TftcvuiGAr
 jj+U9op1d2ogq/+8YXjqRZn5v+ZAH9cUnYUCQ5nqjepmCYkMpr2uVdx8a2bU1dRKbByq
 bs9/5qCSCVR8mRfcUOw06VY5tgdO9TXic90U9Od66EyJtBkYY2CPrMw4lPqn3Kr8ec7s
 QHsw==
X-Gm-Message-State: AOJu0YzK8kW88N8dboNBeeL1lmPp1Mmah5uP+TKB0QY97qZsbAZ3keO5
 WubtyKStwOTSEGGyEC3hrwlxfO80v1TdNw==
X-Google-Smtp-Source: AGHT+IFy5U08SD3ELkVmpW4WXn3YmmOdlNjxVT73iUqmcb1iVU6Bm9EqK1AMhCyknZPAxg5hcrcDcQ==
X-Received: by 2002:a05:6a20:dd85:b0:19a:75b5:5a1c with SMTP id
 kw5-20020a056a20dd8500b0019a75b55a1cmr2636572pzb.48.1705356250278; 
 Mon, 15 Jan 2024 14:04:10 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:85fe:4dd3:358e:ec4?
 ([2001:8004:2738:1dd9:85fe:4dd3:358e:ec4])
 by smtp.gmail.com with ESMTPSA id
 pm7-20020a17090b3c4700b0028e653bcd81sm1321344pjb.52.2024.01.15.14.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 14:04:09 -0800 (PST)
Message-ID: <c1323e2d-fa2d-4cb2-88f6-6cf80077ab70@linaro.org>
Date: Tue, 16 Jan 2024 09:04:02 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fixed cpu restore with pc 0 on SIGBUS
Content-Language: en-US
To: Robbin Ehn <rehn@rivosinc.com>, qemu-devel@nongnu.org
Cc: palmer@rivosinc.com
References: <33f27425878fb529b9e39ef22c303f6e0d90525f.camel@rivosinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <33f27425878fb529b9e39ef22c303f6e0d90525f.camel@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/13/24 07:57, Robbin Ehn wrote:
> Commit f4e1168198 (linux-user: Split out host_sig{segv,bus}_handler)
> introduced a bug, when returning from host_sigbus_handler the PC is
> never set. Thus cpu_loop_exit_restore is called with a zero PC and
> we immediate get a SIGSEGV.
> 
> Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
> ---
>   linux-user/signal.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Queued, thanks.


r~

