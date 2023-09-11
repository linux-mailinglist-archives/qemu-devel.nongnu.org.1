Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 548E979AB86
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:20:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfoKX-0007Ly-VH; Mon, 11 Sep 2023 17:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfoKV-0007Li-JC
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:20:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfoKR-0006wr-Nr
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:20:23 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c336f5b1ffso41200635ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694467217; x=1695072017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wLVkGFfXRnmpRMHBuuWFzKLyv3L6ojp0o4alfSSOugQ=;
 b=KEzgtpW+XGzvMMQIuWeJemt1fEJXlWulJ78FbZrcadPj42TimKaz5HjEQ/ot5HtyZU
 8rAkj7IBeCCeB1uWgVylDu2Rg+fblB3RX+rxmI92E/qMZiwNmIEYVHak//FvucgWoW8q
 LeK1+1kMIzTlENKcS/+dw+ZS/02meU+o0Zq9Fe7X1Of81MQyzb7s324Tk5HLJ4FwNJLi
 BOdyoQ83DHaUwi8ViRwzKWd+L8FJL4lekFobp1s8N1o5QJMLTCuG5kEEtfaKNdcHkaAO
 BvWTxgqlGBIRFhRpr+X5Zkq9fYxnqgYXekXd5Cs+awwrqp64rB9tDiDQe8OV87Wl2Lwz
 K8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694467217; x=1695072017;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wLVkGFfXRnmpRMHBuuWFzKLyv3L6ojp0o4alfSSOugQ=;
 b=tnIj8Z7zHyki6l7N18T193eZHAN52i0jfu2hZPtOrvyRw+DOz++pbHtOC6pk5wPWUa
 +x9V3QwNM34seERfjCYapvefIx1SGh2bsg1ANnP6SNSvf3xmHc3rAbC33s9Ads2X6zst
 F73LlDsptH+bPI5PSXyHWauaSqnDQcIfGSIaJR1hUgaJNSCq9DUuIpUcIQbMaPEUhDPm
 cZAhcYHD7Lk1xJdu7OFC5FO1tp2UQUvjnw/9tf4rZTdV6RjK3X6y/7wo11HSLVaXXnOZ
 l9Zv8ZUwvVVqbrrliGvzC3yzV3kQ/yg2amvgb8pdtNBl1Af7G3+9E6q44cllduSc/qeT
 3YWw==
X-Gm-Message-State: AOJu0Yz+L/GKG1Zwg+AaTXvc9mPZL4uVdigQlCEMPPMAxsLIP3ZGtqjH
 mKGp+3RyqCMTlarBJ4ESnFL9zhhBBWhapNHAwkU=
X-Google-Smtp-Source: AGHT+IHBCU4ZDhPPg6dNUnbSQz+KnkLT+t2xWgbBEoieqIGJaxxpfr9C54iZKKTNXkTYNyQxlKo2vQ==
X-Received: by 2002:a17:903:190:b0:1be:f45c:bc38 with SMTP id
 z16-20020a170903019000b001bef45cbc38mr13534028plg.2.1694467217176; 
 Mon, 11 Sep 2023 14:20:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a170902fe0100b001b9df8f14d7sm6881490plj.267.2023.09.11.14.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 14:20:16 -0700 (PDT)
Message-ID: <d1ae13fb-bf5f-4e90-2655-abb92cf41143@linaro.org>
Date: Mon, 11 Sep 2023 14:20:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 19/57] target/loongarch: Implement
 xvhaddw/xvhsubw
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-20-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-20-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
> - XVHADDW.{H.B/W.H/D.W/Q.D/HU.BU/WU.HU/DU.WU/QU.DU};
> - XVHSUBW.{H.B/W.H/D.W/Q.D/HU.BU/WU.HU/DU.WU/QU.DU}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode               | 18 +++++++++++
>   target/loongarch/disas.c                    | 17 +++++++++++
>   target/loongarch/vec_helper.c               | 34 ++++++++++++++++-----
>   target/loongarch/insn_trans/trans_vec.c.inc | 26 ++++++++++++++++
>   4 files changed, 88 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

