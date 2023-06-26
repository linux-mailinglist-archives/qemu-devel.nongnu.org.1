Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C5473D8DC
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDh0N-00043h-UA; Mon, 26 Jun 2023 03:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh0L-000422-K7
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:51:21 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh0I-0003Vl-Vk
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:51:21 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fa48b5dc2eso1875574e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 00:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687765877; x=1690357877;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w0iNVNoPAduUD7tR7YNhfeKiQEGbfskDYPEO5m0wW2g=;
 b=GAyj5W/6NUBvr6vzMesyWL86X8pgwY+Y0FowP6PC2QFV9IdFQrUdHi/MKIObw2fUJ4
 m9jvHcfcJmiisK3eD9N6GdpwNbU9gFEykI8QTTsVjgXv2q8aMWmegtEy7Ov36sMTHqI+
 IXYjdaqZQPGgBmBbo7uQI5UgR+eHh9+7RLgzH94BhELLuh7Ln03XNrbcc4J8tYcxqBnu
 gO3vsgAfAC2FBwLihrgMGP8CNGvGRzTcza0Dih7nNuwgl5NjDUsNRkwh8xkt5GCAc44b
 LccOiHAPFElQmXLewCZqk1T93dZrmw+3FQsZ/M68WaDmwBKg3nefX9jT5CnRTspzN2aD
 QChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687765877; x=1690357877;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w0iNVNoPAduUD7tR7YNhfeKiQEGbfskDYPEO5m0wW2g=;
 b=ejbgtdfKycbkcy3xFNtNtgnNktEkOyB1g92K3Z5BFAtKITTUIyr/6LFT7q2MHeNXN+
 OOcnm7nOlpfm5aBXFF8QYC4WT/4bCpA8Ex3+G36kO9xTUV7I3NR6w+geGwDOUBNh0Nzp
 NB4gWSpNHTiQJB6cTS/LFC90c/pC8V2n3dJE+6a2p6jUHeJKu9lyRQ3afjstfi4WZPfk
 JlsTMCeh1rlbilXoQiJcNqCBtFvvxou+bpcGaA45Xh9ItA7/IrRWD7+dkpj0U6ZjbvTZ
 6w05BmS/WiiSvaeX7uvE/+rLfbDLiLU19NAHd7ODK2V8PtRnCZQSl4nsXjK4AHbArm/A
 pbHw==
X-Gm-Message-State: AC+VfDx/ToTYs3Sr2MsoMTmSXOEftgY81Oqdzs4oTIGNx2UEjRnUA6ZK
 snyAqfk6SeKto8QMC+wIcPZF1A==
X-Google-Smtp-Source: ACHHUZ7VEEbJKX8q9qMUscrmtoUwB2LbKNK8CT4DF7LIFx5oWh+kDkB47lrMl0yQIW47xcZIhQvjtA==
X-Received: by 2002:a19:5e06:0:b0:4f8:70b8:12b1 with SMTP id
 s6-20020a195e06000000b004f870b812b1mr10803769lfb.4.1687765877108; 
 Mon, 26 Jun 2023 00:51:17 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a05600c00c300b003faa6ce54b2sm849114wmm.2.2023.06.26.00.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 00:51:16 -0700 (PDT)
Message-ID: <dece72b9-b1ab-5bea-02f0-621bea087876@linaro.org>
Date: Mon, 26 Jun 2023 09:51:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 04/11] target/i386: do not accept RDSEED if CPUID bit
 absent
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230623131711.96775-1-pbonzini@redhat.com>
 <20230623131711.96775-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623131711.96775-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x136.google.com
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

On 6/23/23 15:17, Paolo Bonzini wrote:
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

