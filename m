Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 264EE719ADA
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:20:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gLC-0001VB-2Z; Thu, 01 Jun 2023 07:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4gLA-0001Um-1k
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:19:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4gL8-0000cD-Fa
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:19:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f606912ebaso7558335e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685618370; x=1688210370;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zSZtdwqA24kTLE42kQ0UHKLvbjrARjIaP2hmmoX4vWY=;
 b=q7ReiEKP4MzWGPD/SpRFk3H4nqrbTM8eDpAnuDN5eWhtzzHBRUqIDzrQi5fB5QFX+e
 JtIlEHY+G86k8qi4hbZ/q2br68T1o48KuL6xsXmjSEBAchlGbwbwh5RxMTyF3e0gxsUT
 c0Cez875MpR9mKve54wsGYD/8yrCktC/4tMn75R8+MrS91PD5FESuoD85qmWdBF7/Xns
 Sq2HIDyV4VI4QMB+RY+J3QtoL/dZ9PrbC0PCl/P+uN4rIOww+TUl/Tu9vFfJgxhO8wbR
 +sl/dF4cQ2A8cQ3TcdzFz0Ks9b7OEomGr6HDVpXi2Umxac7oLicB/JcTrUltj8zSlvQV
 NgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685618370; x=1688210370;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zSZtdwqA24kTLE42kQ0UHKLvbjrARjIaP2hmmoX4vWY=;
 b=mFLCykKoslNJ7fRtzbQvZ2Q0tG49g9p/7ngsHGyvQOtB9d9/+Moh4m+q3wDRQBsPm0
 E0H80AbnJXQ6f1ZXioN+p27SsynRr6QTKfXTQPnJW8pv6kvc/WoG/qWujI+YpBEJlwKN
 sk4sAo1t/+IDnkO5qTX3EpSIzSK8UKDulFGRTzc/ZWJn506H+FHEN+BM0gdq/a8kfkG4
 4E4HQTe4StqO0Y+7HiJekBv65PxRzP00TclP82FC5lumbyTbxXiB4b9SyMaSj0lleo0y
 IpSQi9/znbFTVr7tZBF/Eb2/h+f/nKpdFeeNIFRx9zkLfl0r0pNdKiyHWcVaJ6BRu30b
 nh6w==
X-Gm-Message-State: AC+VfDxqBXUGvxEDWyCK7WyYjoJktPmqGxFlXglX5uwCcexS51x2/dAK
 zSt52EJQvw7XLO0wWmGACEkVldRb46F4pxON1KY=
X-Google-Smtp-Source: ACHHUZ7E9B8kZdinuhfRsbluSgO2tnInO8wjQDaBAKs/OuPxxhIyOrUScfddfYuJP/azSG2Aab6lnA==
X-Received: by 2002:a05:600c:2041:b0:3f6:346b:9bf2 with SMTP id
 p1-20020a05600c204100b003f6346b9bf2mr1869358wmg.3.1685618370403; 
 Thu, 01 Jun 2023 04:19:30 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f080b2f9f4sm1989747wmi.27.2023.06.01.04.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 04:19:29 -0700 (PDT)
Message-ID: <bc43a6e1-3d97-7e38-5347-e44be65d85db@linaro.org>
Date: Thu, 1 Jun 2023 13:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 09/48] *: Add missing includes of tcg/debug-assert.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:02, Richard Henderson wrote:
> This had been pulled in from tcg/tcg.h, via exec/cpu_ldst.h,
> via exec/exec-all.h, but the include of tcg.h will be removed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.c      | 1 +
>   target/rx/cpu.c       | 1 +
>   target/rx/op_helper.c | 1 +
>   target/tricore/cpu.c  | 1 +
>   4 files changed, 4 insertions(+)

Preferably "target/*" in subject, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



