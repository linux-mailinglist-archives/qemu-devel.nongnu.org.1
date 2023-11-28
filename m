Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324C7FBC24
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:05:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yhd-0006FQ-Us; Tue, 28 Nov 2023 09:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7yhC-000609-1g
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:04:16 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7yh7-0004ps-Kp
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:04:13 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6d7e56f6845so3326812a34.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 06:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701180237; x=1701785037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VszYBxoqXTIGGEIvHjDkqIOwAC2hoq8cI38JTHQJpkM=;
 b=CEKh6bjQnkedNbSCfYIetxK85QUjimnt9tnW7NKsl2VVbpLC5pahRB8W2PMnke0L1V
 Gw+s4yqQ2TGDKgVHf8/wJiRz7McqO5NQgbGU5uHnj45tGAvPQ+DBqUp83ssdb07DxyvN
 Ne5vJjVHNn+mH6MeD3Xs14oNJDqKhd9urNXU9v+EJreOXY02NO4grY69WzsOPruW9I+h
 YpExnwR8ia33Nfer5NocJqETEbM+7EQ7dkgbjnEx1juTOSKpPU7/vAG9B44kECYE5JsE
 Yx3uOEjo6YSe9I2/p3HFlpG/jA+xiy93tER+L4g01NaHeYjRx4q+vpQxCUVKJ9FC2PN2
 QMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701180237; x=1701785037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VszYBxoqXTIGGEIvHjDkqIOwAC2hoq8cI38JTHQJpkM=;
 b=GVEzWE/gC3/a4IkWkaKNBR5grlq2vj9EvOTs+5ytdfik0+CyZDIHVv3jaJyza8aWxF
 FrAhJOZWlhE38La2gWf8wuT7GA05D3KFpKZEfB0GpYjAd2ZMPq6hWd5CoWSqv3x7OY1a
 VCGmNFPRydiSV52Y3YHPhvrA63inw4TxaaWFBHInQBmoFYsd7weBnkKuHiqz9A6LOD2z
 S98sZQ81FgaY14YsQ6ai/cumR5Fkkbt7kmwkg1xepl8Cn77tUOmkj3+86mNRWT3Uhofg
 boBoO/CZcx/QauiTszU8hw9b5RwCYIUG4gPm+3dy+PSbeQEwhjI/Wj7dmzEllV3sMiRC
 4K2w==
X-Gm-Message-State: AOJu0YxM5PpuyOppqvseffMmD/05VkJLD/URQCresue7rS37oBz0tipS
 GaIRkn9ZsJA4HeSSGCYZ+0byMg==
X-Google-Smtp-Source: AGHT+IF7aUWlaUUDP3lwCOSjx2MW11BgZyMoTF+VnG6tOT83Nc2MqepU5kbtYtuRHV4oFmlWsJGaag==
X-Received: by 2002:a05:6871:29c:b0:1fa:136f:5758 with SMTP id
 i28-20020a056871029c00b001fa136f5758mr16754943oae.44.1701180237509; 
 Tue, 28 Nov 2023 06:03:57 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 ny13-20020a056871750d00b001fa1350df8esm2068309oac.2.2023.11.28.06.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 06:03:57 -0800 (PST)
Message-ID: <6de3ee23-cd69-49cd-a31a-fe00a4249e31@linaro.org>
Date: Tue, 28 Nov 2023 08:03:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 07/11] hw/arm/bcm2836: Simplify access to
 'start-powered-off' property
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
 <20231122183048.17150-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231122183048.17150-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/22/23 12:30, Philippe Mathieu-Daudé wrote:
> All ARM CPUs have the 'start-powered-off' property since commit
> 5de164304a ("arm: Allow secondary KVM CPUs to be booted via PSCI").
> 
> Note: since commit c1b701587e ("target/arm: Move start-powered-off
> property to generic CPUState"), all CPUs for all targets have it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

