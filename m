Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D22D74AF7E
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:08:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjJm-0003YQ-0K; Fri, 07 Jul 2023 07:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHjJj-0003Xp-LL
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:08:03 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHjJh-0000k2-QT
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:08:03 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fb863edcb6so2785785e87.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688728080; x=1691320080;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E7TSDnS9KISk8ThF5duU9a8+YIAqEBL+jmkDSISruzA=;
 b=Yo0N48yoNe1XxtYklcW33OtkHgsc0dlp7vR4XR77XEnydw599djcU2xBiWGWQ++DYd
 bAbMFYS0YAF5mjDV0vRC1R5v+Jt5JLTTiiFXPaH3IYCwzR1+NX8AIjpZPHkGaeGmRkUJ
 RfhO874Ra1E0eIv1he8LorP6xKCQMLkFBmbV9e/fbrFehgzQEMOKdzpxtVtQsnB4S908
 u9+ap2IT5agIjla8GhMjhhnVCsX/DB7d3GKp8qKI5oGCFqwDwP6TIjzByCUDWPubqfJo
 Zl8Ycrs3M+j2NIdyF559lPjZzNb97EcfUBaXBz1HxmAlQgprcfRfzzN3jp2BX2MFTIn0
 L8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688728080; x=1691320080;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E7TSDnS9KISk8ThF5duU9a8+YIAqEBL+jmkDSISruzA=;
 b=AiiVJ+9BFBOwo9cHEXtSCHKFlnduXKhxZd2PSwGJ2pFt/2DiiXaNCISp/TYMpKkT8e
 YCY2qDW0X4vps9zUDoeUvpOW1/WJExv+4AYkD+369ag+VAbaYFfC3VE+qkh1shM8VrRd
 HN+4vbiKf+/Olcsi12kj7bGPHMmh7slgtgya5eblD6OpI/UdYVlM3Ww/vXB5YNHNvNnP
 hpk97xtVTrxnq7at+Se6HEgCopJcD5ACAIFQrrf6l5+vcx1InWdwGuAf9BcFX3bKzSOg
 lyTHfEdV+6J41N65pmrlnfVZIlUw0uq2loYkdQOJSvFl+If72gOPGS958uTz/Bue5zO1
 ALZQ==
X-Gm-Message-State: ABy/qLZza/LHrlD+3vkugJTUJyQ5YsjHwRgzVnILVjrIoxYswNrwBKwq
 L06/hfEm5zB8Z54nf9ihgfMUivN0rXhs1gYI4KI=
X-Google-Smtp-Source: APBJJlEr8WJDn22aVdyrISg3bESvtiFgfO5h+aXC1tuTAVWkUeuIssNbwUM8rWI6lkyzTtCnWAlAbA==
X-Received: by 2002:a05:6512:1289:b0:4fb:745e:dd01 with SMTP id
 u9-20020a056512128900b004fb745edd01mr4111238lfs.45.1688728080075; 
 Fri, 07 Jul 2023 04:08:00 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.9])
 by smtp.gmail.com with ESMTPSA id
 u29-20020a056512041d00b004f85628ec34sm638985lfk.33.2023.07.07.04.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 04:07:59 -0700 (PDT)
Message-ID: <d07defb6-b3db-c7ae-eebb-3d7f467a9b13@linaro.org>
Date: Fri, 7 Jul 2023 12:07:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 17/46] target/loongarch; Implement xvdiv/xvmod
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-18-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-18-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 6/30/23 08:58, Song Gao wrote:
> +    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;               \
> +    for (i = 0; i < len / BIT; i++) {                       \

Similarly.

r~

