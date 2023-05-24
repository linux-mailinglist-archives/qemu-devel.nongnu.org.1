Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE170EDA1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 08:09:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1hfj-0004Fd-0F; Wed, 24 May 2023 02:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1hfe-0004FL-Jn
 for qemu-devel@nongnu.org; Wed, 24 May 2023 02:08:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1hfd-0002Sg-13
 for qemu-devel@nongnu.org; Wed, 24 May 2023 02:08:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so4525035e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 23:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684908503; x=1687500503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=35AY4tx81FhSXoYoKAjX852c7S4uDv5ze7K8QSMPXqo=;
 b=Y0frHNvcbd3BdKJ3K8ZJbF/2J6zEYeeSScPhkX6HBE7/nxtTX1lCLk19FaYhQOfxoY
 ZEKn+Qr6xSbHi70fTUDD4uKS8VLlp6f+gSSN5aFXr72/AecRwgudgZyNwZ33mQDOwE4S
 FO9zk84RVsuw4LIQhqUtenc5ieYDnMCYYmHnadp3VvRGRYuQH5eu6d/OploeSS0xGwXT
 KTsJ76ZAEe6x8v0m2K9wmbEzKM+vbT2+clofazs64q4dZwT2ED9sVjSGuEVloE9Xr2Gi
 6bmOkwAC1VIASmzDMp0hrYJFNYF5Tk3jIOVwDt2HPqBBngnyWNDS46ewRpejnXR9GDRK
 mWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684908503; x=1687500503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=35AY4tx81FhSXoYoKAjX852c7S4uDv5ze7K8QSMPXqo=;
 b=YPujg62b5kc4s9VBEmNTyAfs+JfXxYcmWCDsl5gDJrTxCqbK/FKPK9SjmzKuU+kQR6
 m+YvOx8Z++hsvE8VRYobP1vCdtoXfZtNakLiNHaKBurr2orspLhn6UdnJv6OQTMiN0+G
 ZJ0PH7POCo+IrfRCH1lhpAlremOqUfxm8nJreIQ1RMEj+uRfu0TCD6X8G2aR4Ld7eJfk
 rIP17weKSSLGZ68kRMr2VC4UkJAn+y9AEJ4VLjxIPiBvuzyZGIov9goRq0v5HaxDQEPd
 O6/PbNZpVtvNjeryy98lBLB0RyDfjXjClPfkDnKXaV6dC7BfcXatslBfkuVeM/9lZJdB
 eWLQ==
X-Gm-Message-State: AC+VfDzysucuTPwCvvPPLHvfGBLKnqNmZr0Gl8WvCOOBf2iMF8io5fVd
 zwk7Zo8aB56mkyUjkR/5GoSUUA==
X-Google-Smtp-Source: ACHHUZ5jLrV5XQp+9MNJ1Eu96hD16TVKDtZdi39aTSgBQ8xpf+MY+kOCrcJglgucGKB6Q0juJ1/T6Q==
X-Received: by 2002:a05:600c:294c:b0:3f5:fa8e:aaa3 with SMTP id
 n12-20020a05600c294c00b003f5fa8eaaa3mr9584473wmd.28.1684908503400; 
 Tue, 23 May 2023 23:08:23 -0700 (PDT)
Received: from [192.168.215.175] (35.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.35]) by smtp.gmail.com with ESMTPSA id
 i1-20020a05600c354100b003f61177faffsm2477326wmq.0.2023.05.23.23.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 23:08:23 -0700 (PDT)
Message-ID: <ea8591a0-dd70-8c9a-9c49-f23ef270546f@linaro.org>
Date: Wed, 24 May 2023 08:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2] vfio/pci: Fix a use-after-free issue
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: minwoo.im@samsung.com, alex.williamson@redhat.com, clg@redhat.com,
 chao.p.peng@intel.com
References: <20230517024651.82248-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230517024651.82248-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 17/5/23 04:46, Zhenzhong Duan wrote:
> vbasedev->name is freed wrongly which leads to garbage VFIO trace log.
> Fix it by allocating a dup of vbasedev->name and then free the dup.
> 
> Fixes: 2dca1b37a7 ("vfio/pci: add support for VF token")
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v2: "toke" -> "token", Cedric
>      Update with Alex suggested change
> 
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


