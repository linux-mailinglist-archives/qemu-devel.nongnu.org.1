Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0023479B05A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 01:49:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqeF-0001x9-Bp; Mon, 11 Sep 2023 19:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqeC-0001wm-N4
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:48:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqe9-0007ex-QV
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:48:52 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c3887039d4so23663925ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694476127; x=1695080927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m9AQFIKv6A3s/Vraj75WnJu2YNNyzZo35QS2Yq0QFCo=;
 b=aT+ExPncwVkcaBna0t1hF/B+KVTAjwgzFFrUOa+LRIdzWExryj01c3rR0rzsuIN1Et
 qm3GF2m+pqMepGJO8/1UH62lCJUPIDN0avXUXHJh6JLpiUjeEB6kqkWWK8Y5GJk4WVyQ
 E2Kv6OvhHdbToPjXxOvOdag5G88dRwHWPZQRHARIjwWqw6mAqunm7FCYJgY38Z52UFvX
 6I+eKf6dWUJDTj5lryoL4tMqxTrqKSvyl92gJ+CNWYSEiNr0X7mHhA2bwnSPMbwzzbJN
 AWt/G+DELa7mVqp/IFMP3qXZ1bY7vD1fs8hc9n2v6GhP7N77YMtIozV3OQlVkhlpUyK6
 wOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694476127; x=1695080927;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m9AQFIKv6A3s/Vraj75WnJu2YNNyzZo35QS2Yq0QFCo=;
 b=YpuB9p3FxmveuO0pxwNU+R06iwyjmg/nJL13fti8jsGzYSvCSKvWuVvlksAHWS1rsa
 CWnXLgtZC1pLbE7+zrC5YmSAwdQb86LEGrHvDlPG1mLit6Z41fLzrqtZaEoEUNNY1+1Y
 nyq3rcDRYmXT9M5/aBRjI9ROGeM3GCfaIr85LVTUBGSgxozjE/Ew4jyqitYQeQowUjoK
 1h+FP6gky7YMAX2hms+/eUqVK4H2U0pn7iLRrDegB1hycJ0ZyTWn+PeewPjyfbkZDw7+
 3iL3XYpo5OXjzD5P+rVRBi7Tc+ia4LaPdC4h9G17RI9v3CoH6iwq1N17aLiAkdLls2wK
 ofdA==
X-Gm-Message-State: AOJu0YzuCX0kF3mYOTvJu5r+DZIzReulR0SRqxMxW6Y7AYIbOvlsbrHw
 wKZVsn3zp58Kqz85tkOE4Tkj/HxQEMpHALPcS3Y=
X-Google-Smtp-Source: AGHT+IFOguFrAveajighZTVuhYk3bDFeu7SLMeQWSZBMd6csyBbPQmeaL2ChvVPqXZ+0br4bJPWQcA==
X-Received: by 2002:a17:903:110f:b0:1bb:25bd:d091 with SMTP id
 n15-20020a170903110f00b001bb25bdd091mr10775738plh.30.1694476127177; 
 Mon, 11 Sep 2023 16:48:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a170902ee0400b001bf5e24b2a8sm7056768plb.174.2023.09.11.16.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 16:48:46 -0700 (PDT)
Message-ID: <cff6d835-39cf-f7b5-089a-5a64722a07f5@linaro.org>
Date: Mon, 11 Sep 2023 16:48:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 56/57] target/loongarch: Move simply DO_XX
 marcos togther
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-57-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-57-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/vec.h        | 42 ++++++++++++++++++++++++++++++
>   target/loongarch/vec_helper.c | 48 -----------------------------------
>   2 files changed, 42 insertions(+), 48 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

