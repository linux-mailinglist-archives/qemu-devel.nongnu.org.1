Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4CF7A0186
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:21:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjSO-00064p-KV; Thu, 14 Sep 2023 06:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjSE-00064W-KW
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:20:11 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjSC-0001Wi-GW
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RoesKE792rRSgzSgJ/RQiUkZwLW8VSkr4NDS5VmZRqI=; b=i4xchKo5cws+GRYmx5LO2kkJbx
 2c6UHLBQGn5SaZgPhJK1k1WEjN4lStSlkKZASfHrmyF6P13F5iEOajq6ICDEBKNFVV9qBt77NWShL
 7GcdWB4IpD+QCC6cEWBAebry7JZIgHMg7d1U32XHyWn6L7i3WxX1FuoEVRrDkuaQ5sik=;
Message-ID: <d6eda354-468c-4209-9d1e-bca73733962b@rev.ng>
Date: Thu, 14 Sep 2023 12:19:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/24] accel/tcg: Validate placement of
 CPUNegativeOffsetState
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-8-richard.henderson@linaro.org>
Content-Language: en-US
Organization: rev.ng
In-Reply-To: <20230914024435.1381329-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 9/14/23 04:44, Richard Henderson wrote:
> Verify that the distance between CPUNegativeOffsetState and
> CPUArchState is no greater than any alignment requirements.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index c2c62160c6..86a7452b0d 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -459,6 +459,12 @@ static inline CPUState *env_cpu(CPUArchState *env)
>       return &env_archcpu(env)->parent_obj;
>   }
>   
> +/*
> + * Validate placement of CPUNegativeOffsetState.
> + */
> +QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) - offsetof(ArchCPU, neg) >=
> +                  sizeof(CPUNegativeOffsetState) + __alignof(CPUArchState));
> +
>   /**
>    * env_neg(env)
>    * @env: The architecture environment
Reviewed-by: Anton Johansson <anjo@rev.ng>

