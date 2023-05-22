Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B494A70C0A9
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 16:03:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q167I-0006Ib-WC; Mon, 22 May 2023 10:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q167H-0006IT-AG
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:02:27 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q167E-000886-Vv
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:02:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ae87bdc452so20106765ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684764143; x=1687356143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G15aZEZjYPBd9Rlthi4KqUFx99nujyjNkZz3Gas5GTU=;
 b=wDAGQo1LSCJQ2OCTcvrRc0xmpDVSHiGAJY8209/Zz3zMeUUog6RYPEtiAzXI2+1Zo7
 Br44ogD+CbeIaDApWM3IQuirKkmqt8nW+AugEBMlPxxbDSkJtVs2kWXbNTrm6AJ5qBoE
 r5ZDDcgxYldH/cmtOxrXcPQx779FHt3ImNwKUhMzUhqmb8Pu8xPAH1S1UU8rSPubcCdT
 ayJ34NZTekHAEQGA3Ubj/ndHjZfXXdCQlYUJ8uEAbY0UvjNoWwSVzIYZR/SRBPSQrONp
 KnCEC8JZSSwKTswWU2aRYh+wbMAPsdOqNsaLoAlr7cukBk8/5KVWvUmoBL+wYa/DlvMl
 RUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684764143; x=1687356143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G15aZEZjYPBd9Rlthi4KqUFx99nujyjNkZz3Gas5GTU=;
 b=VHcf3CbVUiMMF8+ClY5M0L+R+qQDMle1RQOkej6zL7/aBDFIUNQw74jsjIRRZEPVth
 xmmDh+fGbxaQ/Mq1aTXsXoaWrjY5Qvg6bFHP4pGXdvNI/Xd9mq+HL8U6Vc1PoJ/myG4c
 n5+XB/efigQm2NYF7fNuIOL/Z3Sn8yQ+HTrDLGfHyoL5VvDZjygM1BxDB2YMRhX/V7Tf
 aRfDMFgG4+edUA+MwFuzCDFI7tYtfoHjNCjDeJ2YpGDZRY8lrJehu7wBVwbrKr0gredo
 IIpypoRZzgujXITrM6RFZyTmBlVv7sRmCfaRhVH9+lASVLn6TXP7AWllAYgj5STHV/7Y
 ZRYg==
X-Gm-Message-State: AC+VfDypl6b9cy4XPgFqOVaW3JfDRV/XSPYUGWTDDw30SdDVSQ6WykmJ
 tpW2zTgEPNvkKoyuXqj09CtpVg==
X-Google-Smtp-Source: ACHHUZ5VVLPuHiNYUz6sJdv7reou7F0XYK3Tnomr8TWlJHDQ+elv9Y7L6+WeZ+YHpcnJMD6DEVvmxg==
X-Received: by 2002:a17:903:234a:b0:1ac:85b0:1bdb with SMTP id
 c10-20020a170903234a00b001ac85b01bdbmr15699367plh.55.1684764143084; 
 Mon, 22 May 2023 07:02:23 -0700 (PDT)
Received: from [10.0.14.188] (static-66-243-253-154.ellensburg.fairpoint.net.
 [66.243.253.154]) by smtp.gmail.com with ESMTPSA id
 bj6-20020a170902850600b001a183ade911sm4917349plb.56.2023.05.22.07.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 07:02:22 -0700 (PDT)
Message-ID: <6be5313c-db9c-4fea-5b32-c0231977d2f8@linaro.org>
Date: Mon, 22 May 2023 07:02:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/7] Python fixes and related patches
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230520190632.7491-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230520190632.7491-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/20/23 12:06, Paolo Bonzini wrote:
> The following changes since commit f0b95ab6b8192d84338496a0b6fd8f2c08a4a3a8:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2023-05-18 07:52:12 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream-urgent
> 
> for you to fetch changes up to 4b424c757188f7a47630a4d8edcf4ad9f19255bc:
> 
>    scripts: make sure scripts are invoked via $(PYTHON) (2023-05-19 20:40:29 +0200)
> 
> ----------------------------------------------------------------
> Fixes for Python venv changes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



