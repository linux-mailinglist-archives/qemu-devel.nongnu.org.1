Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 398D3718605
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:21:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NdT-0006AJ-MQ; Wed, 31 May 2023 11:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4NdM-0006A3-DP
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:21:08 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4NdH-0006xC-Os
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:21:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b01d912924so48246445ad.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685546461; x=1688138461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TQZdbKQGqfsm8cKbHbYrCoCvbK7EOhjeQAgyrtYW1Qo=;
 b=OXauaZViWqMBhdGk5CjOCyEq7WLMF+Byyqs4UGXXYOq7A2+4rgCkeXt5oU1/V3gCEN
 OxRNhwxGeuSppbhkKc2t+O4AnVtB+gqL4ay36jjbCuW0DkGZ/aoJjBzRtgk0vr4Y6kOU
 OGJStFNv6VNRNX90s+q+gCI31jPGDYvdxATFfIWOIRE9ZJ46M/JarPFY7ZFmVEQiqtH1
 j76frWqN2KdMzHLGl+GTRYS+KLBDD+lS1Vqx7MGRe3UpgkMX2A8757wFlolFBHBjXv2c
 RhPlO/HBnTI2n7t0ZotWaYCjSmcXDtSvDEj+ZbNQmEdvf27TSYbWSlJQx/vOZUtEsdk+
 WEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685546461; x=1688138461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TQZdbKQGqfsm8cKbHbYrCoCvbK7EOhjeQAgyrtYW1Qo=;
 b=TQd9TBPivGfAav1Ip119fg6gfDyIWAktIJwx9oyNWYLM9YnSQ1PeSf6pr+52s29akv
 1lpJyxQ6YH4Y973A7pD+wb0lGxnZDJ9kGJBgulamXg4PUv+GI2CGP/5bbRdOxkLdg+Cs
 OpqSfCWwXyIYnKIf1ogXBlux8LYwL40FdlhsBEqIU4QngK1cBjSpB+Rst3d4BB66gIKG
 vBzZ3QjScUE4eoZKmAtKPUXpqKnyo6mpvrOA2GUllLQpck4f0ZYKb9KGuRXmUiGMcx7C
 uKNA4XLt35FVmjWt0fPrDoTYJjoLxTQi+O8WKSqkEHCP9EezP2Fu+fmtl9XGQ3xgjsPc
 CrSA==
X-Gm-Message-State: AC+VfDxfsjF0NEoCOJi9Ccyt4L6fl1j4ovRf4wcBxV1fKPkpM7iOB86A
 tl3xSPTsnpOneAZxox3t05Znew==
X-Google-Smtp-Source: ACHHUZ4FSJd8p8kurLwDSOULGjzRTU8F9BGNUhSfUvVKRE2DpoHGIGfclJOB9khHWRAyIzMb9kvOSw==
X-Received: by 2002:a17:902:d70c:b0:1ac:83d1:9269 with SMTP id
 w12-20020a170902d70c00b001ac83d19269mr4763341ply.16.1685546461282; 
 Wed, 31 May 2023 08:21:01 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a170902760600b001b1920cffdasm130806pll.204.2023.05.31.08.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 08:21:00 -0700 (PDT)
Message-ID: <898303d1-2278-beca-b5ce-6dff46e0faab@linaro.org>
Date: Wed, 31 May 2023 08:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tests/avocado/virtio-gpu: Cancel test if drm rendering is
 not available
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230530180330.48722-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530180330.48722-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/30/23 11:03, Thomas Huth wrote:
> The test_vhost_user_vga_virgl test currently fails on some CI
> machines with:
> 
>   qemu-system-x86_64: egl: no drm render node available
>   qemu-system-x86_64: egl: render node init failed
> 
> The other test in this file already checks whether there is
> an error while starting QEMU - we should do the same for the
> test_vhost_user_vga_virgl test, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/virtio-gpu.py | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Thanks.  I have applied this to master directly, trying to green the board.


r~

> 
> diff --git a/tests/avocado/virtio-gpu.py b/tests/avocado/virtio-gpu.py
> index e3b58fe799..89bfecc715 100644
> --- a/tests/avocado/virtio-gpu.py
> +++ b/tests/avocado/virtio-gpu.py
> @@ -143,7 +143,11 @@ def test_vhost_user_vga_virgl(self):
>               "-append",
>               self.KERNEL_COMMAND_LINE,
>           )
> -        self.vm.launch()
> +        try:
> +            self.vm.launch()
> +        except:
> +            # TODO: probably fails because we are missing the VirGL features
> +            self.cancel("VirGL not enabled?")
>           self.wait_for_console_pattern("as init process")
>           exec_command_and_wait_for_pattern(
>               self, "/usr/sbin/modprobe virtio_gpu", ""


