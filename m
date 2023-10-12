Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014C7C67EB
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 10:53:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqrRO-0004T1-C3; Thu, 12 Oct 2023 04:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqrRL-0004Qq-IC
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 04:53:07 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqrRI-00065b-Ho
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 04:53:07 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50437c618b4so930836e87.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697100782; x=1697705582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PmCWNR9xqOyV3ZttPj9i9DCezrvDZ9UsSuxJSQeh4D8=;
 b=KaeISB/UCzOZOSs/jImzoKKeTMyPIoExLbjeE0aLUWMJ7MtUVUlcfHKRiEZTQMrsVT
 UotfZjqW75YieRmQFfyCC5u0QVLH1fVaNw3MvsScGRkWAnOl/jXeugX/MjK5XfgRRlx1
 PR3FhTUkEaWpHAg71YfH2LhdUHSJUHlDmmf2xqY3xgdHr3PCyrr2q7nRloVy9B91+Kdk
 9iW9C37UZB39iBVkV+FJQqjeAAEE94L48ZIljOwenHqju7RW1PTFhtCd0QMXRGPlYWkd
 60x+IbdMv/eDmFta07BR7MsEdsr7Q+o+IztqTxcuSL2H7ZfCQDJpp0bsi3NkTF0EJU3Z
 5bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697100782; x=1697705582;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PmCWNR9xqOyV3ZttPj9i9DCezrvDZ9UsSuxJSQeh4D8=;
 b=SdYskF3QMjWmRrCFcmvgX76TXiHninb8+301Z/r3B8zxwWINj430mVrSnq2e3aQmU+
 pLdlCDGTtD7D9LbSbGFYT1rCevgT5pBFcXqGBSfK5slNMWhwxxO1YKqRlINH7c2dsXYI
 Sr4tyAeydVp49xYuUCn1Fk115PljMzIvhHamQOMgJ63BAvqhch4xHWkxNJRcdDUZ4S/k
 WbA2QBC4h6YcbINxiW9fzA2kH1llQuD9lYgHqwmQMq16agYG4F3ih5/W931Y32xSro8p
 U88kyp9naMoV3QZAmqJXhBWKBBAVLG8jkicRJj/bcyRxuBd3KHPPQj/egrsCpFQwWOc/
 JilA==
X-Gm-Message-State: AOJu0YxBeVNQUQYbqhCdM45LTnqAIUxdn6IaqtF0IAKN5Psw1y9O0NA4
 B3AUEnGxhx+nZIP7X+K8P3DJUQ==
X-Google-Smtp-Source: AGHT+IHx7rrv54TWzQs9uXDoc3W4DV1uecrFrB7T0/sbltjk/C7hEJTkYecBfuoC8ZdQSIwDVAK7MQ==
X-Received: by 2002:a05:6512:4026:b0:500:94c5:6e06 with SMTP id
 br38-20020a056512402600b0050094c56e06mr26193362lfb.56.1697100782117; 
 Thu, 12 Oct 2023 01:53:02 -0700 (PDT)
Received: from [192.168.26.175] (192.red-88-28-24.dynamicip.rima-tde.net.
 [88.28.24.192]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b00407460234f9sm13711483wmo.21.2023.10.12.01.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 01:53:01 -0700 (PDT)
Message-ID: <41fd8262-54e5-11d1-85fe-e5e53bb802c5@linaro.org>
Date: Thu, 12 Oct 2023 10:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 100742/100742] target/arm: Adding a check for the result
 of calling the CPU information check function
Content-Language: en-US
To: Sergey Mironov <mironov@fintech.ru>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20231012085005.848149-1-mironov@fintech.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231012085005.848149-1-mironov@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Sergey,

On 12/10/23 10:50, Sergey Mironov wrote:
> 6 out of 7 calls to get_arm_cp_reginfo() are checked
> 
> Signed-off-by: Sergey Mironov <mironov@fintech.ru>
> ---
>   target/arm/helper.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 74fbb6e1d7..cffbbaf571 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -198,6 +198,7 @@ static void add_cpreg_to_list(gpointer key, gpointer opaque)
>       uint32_t regidx = (uintptr_t)key;
>       const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
>   
> +    assert(ri != NULL);
>       if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
>           cpu->cpreg_indexes[cpu->cpreg_array_len] = cpreg_to_kvm_id(regidx);
>           /* The value array need not be initialized at this point */

100742 patches would be the biggest series I ever saw on this list =)

