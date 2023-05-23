Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA4F70E979
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:24:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bMR-0008F3-O8; Tue, 23 May 2023 19:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bMP-0008ES-8A
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:24:09 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bMN-00006W-QQ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:24:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ae4c5e12edso2024405ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684884246; x=1687476246;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vTx2fWnQAiVPBWNVa5T/zm0xxAjsnjioBC+mjmJtevQ=;
 b=ClKLRV6/l/vC0Q3jlXAyzrJQg3+f6GaYwesqtkNbtttC4+Vlnd3gcE27dvP2nK8QTa
 EIVydO0S7jaCUCUBPb8LQYkGLUDlDVvKb4MfCh+/lIqimrZiC+TxGhAfz3u9QbeWw1dT
 kw6imscPdDmF+pzyw9z1WdCJQTslnwY6lNA/WVZ1cZUQBXsQgRl4CiLc2xPodifY9Llk
 0mrntVFJzbbPizW6fDT/xIxyb5sfa4wpHFoUQGF0vTNiqdf8V2yzNP1WJvZhnz+I01jc
 W5gzxm1FLlXkOFCAzBu73ywmQgEVE5gwoTkJWmQW2lTJjsfQTLjpq2FZdY3Re7p3ffpr
 fK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684884246; x=1687476246;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vTx2fWnQAiVPBWNVa5T/zm0xxAjsnjioBC+mjmJtevQ=;
 b=VRzCB+oJZWVGPdgul4sb9yAr00QZIHPs0WQMqmi3yQnsVOT6Kdr+6wXo+S9vtXhCrr
 nZ05lnH0zSUfPTSluhIWrUt54xmbd5gxu4j04WeB+zV2CPl93LM++Dm/lq2ZFF+iBOlR
 LTQAFAirZVFSXtpDI0tsbbeZq9WAzFw8hjHc0V2tAPj1xhZ/MLajglH8GK80hJypl5Mw
 38a3Zd4sIBF1/UxbFwB4gqz2HLEhwWrXmjY91ozK2BhutHwe/eL+i0/mbMQtnbqzGVsY
 oK58T+rdIIrU9OOvxdh+86Y+QGyzbaKsRIV21db3ddEbFSBr03gB3cKUe2kf+GQN/6S4
 jc4w==
X-Gm-Message-State: AC+VfDyeE0fQoGx153Rr34ZigLxY6tJa8UaOWp9syelwgF+220hNRnZg
 f/77TC8A4ezjS3zRiDw8CDTSAA==
X-Google-Smtp-Source: ACHHUZ6ojW1n0/MFAMNIsO++tVz4XK/IYWPm2CDkCT4msEjoMi976cUUsmKhQXyFlQOcLyAFhloejg==
X-Received: by 2002:a17:903:124e:b0:1ab:afd:903a with SMTP id
 u14-20020a170903124e00b001ab0afd903amr18018793plh.24.1684884246221; 
 Tue, 23 May 2023 16:24:06 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a17090322c300b001ab2a0733aasm7286180plg.39.2023.05.23.16.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:24:05 -0700 (PDT)
Message-ID: <7b379719-3b87-b2da-af42-6f6aba368de0@linaro.org>
Date: Tue, 23 May 2023 16:24:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/11] hw/virtio/virtio-mem: Use qemu_ram_get_fd() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
> Avoid accessing RAMBlock internals, use the provided
> qemu_ram_get_fd() getter to get the file descriptor.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/virtio/virtio-mem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

