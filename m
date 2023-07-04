Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA33747077
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGeoa-0003iP-Fi; Tue, 04 Jul 2023 08:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGeoT-0003hm-2y
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:07:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGeoP-0003gu-Oj
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:07:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3094910b150so6293933f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688472436; x=1691064436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rm60kBnD7wIuQ7tvcpbnnY+ulDObnPjS7VC+ZfHDx/s=;
 b=aNDaZQIeiGzj5SjLwVgE4yS8D11HOQJJAq7wwo9MnwsqVCJuYhXlGmxi5FveAtuWSw
 m3BJkNfyhu8OtXGT97ukeMCaF2OnEC+s/Art9FMrPXqVR3pCv+u2tJTpECvGQC4ykAzW
 ppLYyEOOPTD2orTMoweH9XQQ9rYyM/fUco23Dc0S8vOITa+SRLobP8sVWhi4PZrf95Od
 fxjjoZZQ1JQTsa/hMWH4rsqIt33eDwVCFi4BJkMO5QB12pKHCbaEh1H3lkxD7w5wuruD
 9cqoZzDi434FFo2DKqeBHXdlkqvjEbMjqCikX3ZcbeqoqnAbY6mjOScqDQEOl88GM3o6
 s+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688472436; x=1691064436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rm60kBnD7wIuQ7tvcpbnnY+ulDObnPjS7VC+ZfHDx/s=;
 b=V45qGSY2RfkB7rS9Gb3qUF6FzJHLsKPZhOBoYb5+02gV90MGJH8IL7dogVB24frAA6
 9m39omot4jkzcInpld1/PatVrQlzA8NaebSeJIUScUbYpLRPvAHMmZ/YMKGvZ3wrCVke
 mIyiP7UB6FqIVpy6+IJkw5GjA3Be56mfD4r8j04tFHlUvqmNUOt+TWT+AgyAb6kaAX8S
 CB2nwGoWOS5MSuaqVnhpug10r1lDmL88T6isFhbRSBOuWg+oLopnhBimP13t7yzTWJmv
 LCrZ2XgAJcIxRTSFeuymRbOeX1I/njtA7IGlrSaLhGWjIZtieSi4EcsD5NsSHRLBrne1
 PiRg==
X-Gm-Message-State: ABy/qLYgPqG8qS1X6sVAcvcBcnIkGdTFNOZ+eZmACuyiWXrWoYiny1t8
 4AAGV1LXQYutcWGeZmVAG1c5hA==
X-Google-Smtp-Source: APBJJlGjsHGZurAKXgzzCX7tgo7wgnf52DGlc9VXeuKyGezoj/ajE2V8IjQQQqFmlz036xPj7p8KiQ==
X-Received: by 2002:a5d:4445:0:b0:314:3a3d:5d1f with SMTP id
 x5-20020a5d4445000000b003143a3d5d1fmr4221306wrr.19.1688472435726; 
 Tue, 04 Jul 2023 05:07:15 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 m6-20020adffa06000000b00314417f5272sm1226836wrr.64.2023.07.04.05.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 05:07:15 -0700 (PDT)
Message-ID: <8f7f8a7e-6316-74ca-e2cb-d13f86150585@linaro.org>
Date: Tue, 4 Jul 2023 14:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] kconfig: Add PCIe devices to s390xx machines
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20230704093204.2579133-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230704093204.2579133-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 4/7/23 11:32, Cédric Le Goater wrote:
> It is useful to extend the number of available PCI devices to KVM guests
> for passthrough scenarios and also to expose these models to a different
> (big endian) architecture.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/s390x/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
> index 5e7d8a2bae8b..373f38adcd6b 100644
> --- a/hw/s390x/Kconfig
> +++ b/hw/s390x/Kconfig
> @@ -10,3 +10,7 @@ config S390_CCW_VIRTIO
>       select SCLPCONSOLE
>       select VIRTIO_CCW
>       select MSI_NONBROKEN
> +    select PCI_EXPRESS

Can zPCI plug legacy PCI devices? I'd expect not, only PCIe
devices. Then this patch would become:

-- >8 --
@@ -5,7 +5,7 @@ config S390_CCW_VIRTIO
      imply VFIO_AP
      imply VFIO_CCW
      imply WDT_DIAG288
-    select PCI
+    select PCI_EXPRESS
      select S390_FLIC
      select SCLPCONSOLE
      select VIRTIO_CCW
---


