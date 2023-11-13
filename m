Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F77EA2A3
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:14:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bRi-000357-Hz; Mon, 13 Nov 2023 13:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bRE-0002qd-RC
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:13:34 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bRA-000823-SF
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:13:30 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6d2de704f53so2955215a34.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899205; x=1700504005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=47qdXCf7H17vKwnfJuoR9ApbQrhsQSNwWFz2iDtLcKY=;
 b=AQmV+1NPzORGmMhNV/8GcEpJFtOutjF2648ZJJv1EXAlbsY2LSFx2AWF/QNKxLDhiY
 xJjviGlngiw7p7Dgyg+iGgFPck26P8ildIx/+g6a9edfKZDsPvOtckg6DMwHN+wzNzKm
 CDREp0YwtJeydySpQhkVUOgem4DrZpmxmWWDfv0eGwhMOd8wuymTyjSg/mvYGZbUjbG0
 trRF6dRehgKprhR+o/GzRtMXCT8iFTcrnVrs8OEO6Y03fHip9PUsmjBnJZMDiLqiwrPP
 EaLQL8TKxCynsBoLSQ3V76e+ZbzjQkZjYJ1Qz7XiGhim2+KzXURnyN+u6Duj/6QbaE77
 xz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899205; x=1700504005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=47qdXCf7H17vKwnfJuoR9ApbQrhsQSNwWFz2iDtLcKY=;
 b=w9YEi3GVkPfoxixZqxHwsk+0F9ujum5Q5fvDpwxuT2wsugjMARY/P4Kjud2w8tC07i
 oLv4jIK8VnWBE/J5MEsRNTny80zMN6d4/wzGGtwLPDbDLhYTnEGzKZHWQCKfwumUdFZg
 yRS+inENcR37FNOiBHdQIz2aNk5uTsshP9kubAdq5pQ5Dleri5/kW2PlkytCzsitDgcC
 Q0N/e+s/Y+UHZZLz5LBkcBFDn8hV2v4Lh4SmjcPxxuxCK+SlLstULNg9xS4WPO5N9PwX
 aTLTCMWV8wCZU8TcmDq8mbUSyQchIZuVLoXnVgX/w2LKt9g/XdcfPdHi1dvsgw9dZJmc
 EKgA==
X-Gm-Message-State: AOJu0Yxs2FJZqbze/1ZMu+yJjYGFzLRN2Pi2fQfECJXQ1Dyact1DH9Rk
 yLDZ0XXQkNxQNOLsI018TwAzwcdxGc7APSG9wKY=
X-Google-Smtp-Source: AGHT+IEMW24hoP1qxVuHtBZTWwzdY1wJIRvBdCxR4pcag8Dcp4IYaLDv8RiEja604eSuwTfs9vPIQA==
X-Received: by 2002:a05:6870:e40b:b0:1ef:f127:34fa with SMTP id
 n11-20020a056870e40b00b001eff12734famr8873450oag.57.1699899205660; 
 Mon, 13 Nov 2023 10:13:25 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 it13-20020a056a00458d00b006b58af8aae3sm4092255pfb.77.2023.11.13.10.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 10:13:25 -0800 (PST)
Message-ID: <b7d29ae2-2064-4e4d-8fd7-1a75af4cb4ad@linaro.org>
Date: Mon, 13 Nov 2023 10:13:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 03/10] hw/xen: Merge 'hw/xen/arch_hvm.h' in
 'hw/xen/xen-hvm-common.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231113152114.47916-1-philmd@linaro.org>
 <20231113152114.47916-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231113152114.47916-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/13/23 07:21, Philippe Mathieu-Daudé wrote:
> We don't need a target-specific header for common target-specific
> prototypes. Declare xen_arch_handle_ioreq() and xen_arch_set_memory()
> in "hw/xen/xen-hvm-common.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/xen_arch_hvm.h   |  9 ---------
>   include/hw/i386/xen_arch_hvm.h  | 11 -----------
>   include/hw/xen/arch_hvm.h       |  5 -----
>   include/hw/xen/xen-hvm-common.h |  6 ++++++
>   hw/arm/xen_arm.c                |  1 -
>   hw/i386/xen/xen-hvm.c           |  1 -
>   hw/xen/xen-hvm-common.c         |  1 -
>   7 files changed, 6 insertions(+), 28 deletions(-)
>   delete mode 100644 include/hw/arm/xen_arch_hvm.h
>   delete mode 100644 include/hw/i386/xen_arch_hvm.h
>   delete mode 100644 include/hw/xen/arch_hvm.h
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

