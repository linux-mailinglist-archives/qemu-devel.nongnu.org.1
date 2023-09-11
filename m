Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B179AB8B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:28:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfoRF-00019M-6P; Mon, 11 Sep 2023 17:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfoRC-00018t-Sm
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:27:18 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfoRA-0008HB-Pa
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:27:18 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fac16ee5fso1693214b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694467635; x=1695072435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sed9o8QhyIg7mbkPUKSsul/eV6x1tE6ktPmyl83T2g0=;
 b=cEHkmvZ76sWvcdjnBtz7KUj0yZRZF/DRnZIQuhdxXU2dcZNktzpBOor4Fifz+owUhd
 HO8TeO2gwsI+OEkryHOiY2wL9Pwbc9qsPkJuujYQ2Aoyrnx25TDYFEjLWcD4DtSqjBqa
 8040PG8V9lJ8yEOGY65CNkBDIfM7hFhFwuAg72jLt0XIsrfaF38MLSzar1ZZJhAXloxW
 uvtVaNCYY93K8qHHEj+GUE3DIr6lOJM5an381K+SJadSU41fRT87qspdgW+0lmh7TzMR
 YavCPvVWtX0Z49vICamlpQKOfbydX9wUQvLfMLXFC0ZvxfYCZ5CRivPwO7oUYoXHf8xC
 mMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694467635; x=1695072435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sed9o8QhyIg7mbkPUKSsul/eV6x1tE6ktPmyl83T2g0=;
 b=aeauy6RHz42kbaN3aZhS6poPeZLsgWkxzIhjTFlPM3IeHg+S9tWFqsXV+57m4nCvP/
 AaEGvUhwmyfSML8/4F9Qns9O10/hzCiuBiBoRlZItTqFe3so1bXZ5a9toUZmzee3DaCK
 5gqJcosQWaRJxHVxAJvWnBoshgKnjRsiTqanZP1NJcNuzJa7bBrFA8yDgPmZaQFFV30O
 5kgJeAlPrF8Vg0UZcxZWXs4m0VZgLLprld1edHU15weO4gAdpaJSoYCV5RQhN6uehMrh
 fEx9rRlzY8c+GuJ//s1iXtr6og9B8IqHPP+tjG4L17+e3DTAhh3iYBBPnw4tg9a2ziVG
 kc4Q==
X-Gm-Message-State: AOJu0YzIJL3oQXzW9MY5nMcd+I5Icu0mT5u/krlmAXLYwLBQqh8bcsUY
 ofaj6x/AFQBI7V4cp9vKbVdKuw==
X-Google-Smtp-Source: AGHT+IENiYFgqjXwuSd1fGci5OdVUTxJL28ivZdPYm8ZO/YTrGO5UQ+G/q5GIitrGq36d2NReNEtqA==
X-Received: by 2002:a05:6a00:22d6:b0:68e:351b:15b5 with SMTP id
 f22-20020a056a0022d600b0068e351b15b5mr10935210pfj.33.1694467635387; 
 Mon, 11 Sep 2023 14:27:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a056a00084c00b0068fb8080939sm3140466pfk.65.2023.09.11.14.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 14:27:14 -0700 (PDT)
Message-ID: <04ef4d38-9a64-2a5b-9dbd-8f08d3c8aeff@linaro.org>
Date: Mon, 11 Sep 2023 14:27:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 21/57] target/loongarch: Implement xavg/xvagr
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-22-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-22-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 9/7/23 01:31, Song Gao wrote:
> This patch includes:
> - XVAVG.{B/H/W/D/}[U];
> - XVAVGR.{B/H/W/D}[U].
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode               | 17 ++++++++++++++++
>   target/loongarch/disas.c                    | 17 ++++++++++++++++
>   target/loongarch/vec_helper.c               | 22 +++++++++++----------
>   target/loongarch/insn_trans/trans_vec.c.inc | 16 +++++++++++++++
>   4 files changed, 62 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

