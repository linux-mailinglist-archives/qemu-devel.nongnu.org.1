Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E581AAA8969
	for <lists+qemu-devel@lfdr.de>; Sun,  4 May 2025 23:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgi4-0002K2-UI; Sun, 04 May 2025 17:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBgi3-0002Jt-7k
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:17:15 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBgi1-0000Xc-P0
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:17:14 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30a5094df42so3067621a91.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746393432; x=1746998232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9jthxIalgRV36qcaJ6A9+ytAz1hzHc7Ds4fwsmy4S64=;
 b=ZGSN/sZtdH9WswwuCa16mjNjmXNrj4nsnbtrqmSNEweIRnknM7hN6/40rNx/L2SL7S
 lQXzo7hPYFcbqS7U2ecsGmZXfTn36xElY/jFs0pDLYxamYMVYKL8+g2CFWE6uB2ddR11
 gmfBlTUfbXEqqbusZgK7rrJRGGV4Zo/wPAjQ6qOt/WWrY9gqPa5ZLgP1URY5YEGmiY8o
 RdprVPYK3rKpnj4PSEjPhGM/HvEaU5ZwdeP/qDS6j+HrV687IYX9h0oYZ29lQS/xbp1Q
 d/QdwU+V5VJKfkI56qzk9CKs5OwiiZjFtrn9I1V9SzEm9P3haZAHA5K0He/k8ph+kCJz
 A0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746393432; x=1746998232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9jthxIalgRV36qcaJ6A9+ytAz1hzHc7Ds4fwsmy4S64=;
 b=Q3tstlo5ABF/GUZUscR+mADZZRqPv+fBNSLlD9QOnCU/+eCyZir9fhkO8LGUY5czI2
 EHVAXNz/N7ekhdU5Cso8Pk4ezvsNHyZkANIjtpUY89WhwLi8L6xMmwO2d+jM2TdVlerq
 tKpHTX9wlteMtm5I1pwL2s5tbeurlxFxZyiJZiaUzWJZPegAgPSR1rur5Dtpdh24qhnj
 vzLQdSTkDqY2yyw2TARWGrN/BlUXcb75aP9JQzlHUlSu5iIdxEaV5puRhldH5FJMdJzi
 qzPj44c47nieNMb1FgAcAjM2R0DK0/Xp57o004wzvGN259LdoI58NtvCQOlsjcp1kDhn
 kCnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVexc1PmIzzcW0JT6jvL46y81Iha/nzUEjRtlXpsb0YXZCe29Y91Z2AdCbUi58C+Bin1bQPKG0teVOE@nongnu.org
X-Gm-Message-State: AOJu0YzKudw6BzulEDqkNVfUhtAowGJdJfAXgbY8/fE8Qx5nrUz+mI7q
 OGGXwTcubYNnS8j3AFGmXwTVkUlhKlmBWuTS33A4nKXqrMk7HtRHuWW/Ym5598Vb7VfS+hYBVL3
 5Hg8=
X-Gm-Gg: ASbGncvGwhyUp4rOxoN6NMycFpxcJ5LsbKEb0AQ3RK7Ucf2sMOXT8Q45r/jYDMH/2KB
 cTJwBwZtp3Hw9y1Okl8YITH80Em4HPmbWrYeS7BoKYN1Df14ncf3rBu/Csx36kndnoM3DX5HMky
 b7WSZJVu9ffhX/VV35P8gCcbIcVvTn6+Mai1zCBIpPHULzvaWgjrHt9mu51WRlDFjBYwGVsHspV
 MB2DMlyuinlqWrIlsVSke0r72cz1JH8q7C1iF3AcT0nSsQwLbHcenuDMuheH2AQIbLDMKM9UMy6
 pqPNOvLUZpuHOxyzje2/V7PuH+manDiH/5YdpwpW5PRfLtf05fqS5w==
X-Google-Smtp-Source: AGHT+IEQ40VJFWxh7hMv8k86s4XzR66YyQhT2LPDQifLm3NJP+IBMDfdGfnGsPMm23oxY2KX1o46Mg==
X-Received: by 2002:a17:90b:51c7:b0:2ee:db1a:2e3c with SMTP id
 98e67ed59e1d1-30a61954a41mr7144332a91.1.1746393431762; 
 Sun, 04 May 2025 14:17:11 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a267e27b5sm6612762a91.1.2025.05.04.14.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 14:17:11 -0700 (PDT)
Message-ID: <c582288d-c990-4078-9c15-5ed5d5a1f426@linaro.org>
Date: Sun, 4 May 2025 14:17:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_USABLE_EXTENT to runtime
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250502214551.80401-1-philmd@linaro.org>
 <20250502214551.80401-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250502214551.80401-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 5/2/25 2:45 PM, Philippe Mathieu-Daudé wrote:
> Use target_system_arch() to check at runtime which target
> architecture is being run.
> Note, since TARGET_ARM is defined for TARGET_AARCH64, we
> check for both ARM & AARCH64 enum values.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/virtio-mem.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


