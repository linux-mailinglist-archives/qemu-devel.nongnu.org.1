Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE2282B704
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 23:14:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO3Ja-0008BM-1r; Thu, 11 Jan 2024 17:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3JY-0008BD-L4
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:14:16 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3JU-0000rG-PM
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:14:16 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d3ea5cc137so48923545ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 14:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705011250; x=1705616050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bZIKw/0pCZOdfea1VwTWbOnFsRUGEY3tdoqRAcBs29w=;
 b=gRQHpPXqCVNIr5dzlJwwU2rT3EghKTa3XmwbDtWnH+TSN674yK+SAaVPhMS3poA9Hi
 oYZD5DrCqkh9o/88o/RLZmOxD7XoFDiHNd2L1Y4k7hNwOE5wLpn69ep1Ua6UqojcWD9Q
 0cwBWjS+rGqa8kb24fRnVoqOzaxkM8BZBSzaaJ3RNu4hji7Q3HPaI/Pjka7mgCjTYlc7
 GcWxtyLLxgTpi/xplE577m6K3nBnWhK+y8ua5XUqn5t2bFHrNx5fiVv6E7FIk4jlB47R
 uzXmSPyQTOyvFiqx9EJ8Ue8bgiWPftgAnoRTwxINoI1gWxdR4frupK8E9rbAw49gb/VF
 RBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705011250; x=1705616050;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bZIKw/0pCZOdfea1VwTWbOnFsRUGEY3tdoqRAcBs29w=;
 b=czRR9itKR7NsXJyO5zRKaop7ifI4zk4x0ZNzsp7l+7gwA6lhzumKz6I62/1gSMbADM
 aXMEDhdTbR+BcDsp+WdqzZYzjkMw5VGv3p71i29C41UrJFTmTi+gssSwZLE1C7U7mZgV
 Aedsw0lkkBCUOmWlPROfYjDb9+ZtBart/zKZ/nXXycaC93Co3vputvj3GnBw25DQNu8T
 VPDx9xwerZ52ZPE1rmxS3cu4wPzax4c+wUzBkTSuQfbNp95VPKQjD7LL9Xv8c+moYWBO
 iyQqWYkF57Kd4V/KkTbVGLN2cpnWcVNZUShJNlA2O+JrOI1uYM+B1pPl9/qVAZfJ6xMt
 6D6g==
X-Gm-Message-State: AOJu0YyOHLC0IDlZDGcbbMJ3i9MoH0NJLcNnPa/EUfyzo4YYg5OF5ngi
 dqIuBflnxqrO+bny1dPsaCkZWpUuOCPyCw==
X-Google-Smtp-Source: AGHT+IF50nsIjxuho9hoSouNn6OJpLXo2/B0Etn2tGerSsNC1Xwv3Jz3EMkwrM4X6e2WZv32su7hFg==
X-Received: by 2002:a17:902:bd87:b0:1d4:921c:be35 with SMTP id
 q7-20020a170902bd8700b001d4921cbe35mr440182pls.70.1705011250639; 
 Thu, 11 Jan 2024 14:14:10 -0800 (PST)
Received: from [192.168.5.64] (ericne.lnk.telstra.net. [203.45.18.161])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a170902dac300b001d49a08495esm1632482plx.118.2024.01.11.14.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 14:14:10 -0800 (PST)
Message-ID: <cf1f7d94-7068-44f8-941b-7920a31d747e@linaro.org>
Date: Fri, 12 Jan 2024 09:14:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] tests/plugin/insn: migrate to new per_vcpu API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-8-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111142326.1743444-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/12/24 01:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/plugin/insn.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -195,6 +200,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                   fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>                   return -1;
>               }
> +            g_assert(info->system.smp_vcpus <= MAX_CPUS);

Alex, can we do better than aborting here?


r~


