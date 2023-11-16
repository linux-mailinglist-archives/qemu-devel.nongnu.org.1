Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 119797EE582
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 17:49:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3fYA-0003Yq-7R; Thu, 16 Nov 2023 11:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3fY8-0003Tk-HF
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:49:04 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3fY6-0002R7-Nq
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:49:04 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6c39ad730aaso929870b3a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 08:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700153341; x=1700758141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RgIzknu8j6iF6pgMo6QsBcrNXUp94acom+rpcppzQEo=;
 b=ihgOucLqZAOn+5rAy+JYaPkDiYW8yZ80H8OfRmdoL46U4Pi/ApihMiQiuH5nmIQQla
 WQ2mgCZvM05aRzbtk/AJdW8kakac2g7GCUY1rCctbgTY3Ow80p2Vz0vFCdKO9wV9tAnK
 wqnRSpw9xFfvb6zkZs2EejBERyOQjJuk3gZjBK2XA8tE6J8fwG/CZgZe0RIdWUVO1Qn5
 XSrbO0vk6tKHQHNiFbVKuGA5lgsddamZKj9w0oq6qshaWAhEp0pCD7s5cCnq+sKE+4/r
 G2QFuhEkD+4Ts8PZ3A1QOniGB8zYesh7wVKYAk9yqpnOon8EwaK/3Pj7n+ghcib/+kJ+
 EVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153341; x=1700758141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RgIzknu8j6iF6pgMo6QsBcrNXUp94acom+rpcppzQEo=;
 b=iI0tKgaQjhZTb/P6sKD8CZdC1Agjeumn/e8hXU900wWRuiJSmtNYbd5d5IghnqWhX2
 wcrw7GkH4b105wfSTA/BgDC5T/LUs/JtsBul5xdaOmcEP7LTow+0IqyLJ6OPjx8Nd2rR
 EuTjhwYnq2pAz7p8Eqy/VQMPJdargG6ss7XUiiIV5uiCGN5V50ooTO4MxyWLWrD2DfmJ
 DMsPiH4NrWA9b/e6q7A1xaLUa4TS3PzE09N/7G6a7L8ZEi5zuwZQ4fxwBcy3qFfYCf/N
 dPsx060+Wr4Xt+C2NA3QG0QlPl2617xng5dT9raiUo+/Tpd1802AO194mOk5nrY0sXWe
 IMnQ==
X-Gm-Message-State: AOJu0YzbzbgZmiSJ0ZJjJvYzVH5ayiu7lVIlX8qbjmui8x1DH27JDLtC
 kZEH2YB6396GWjWyjdyaqFoYQw==
X-Google-Smtp-Source: AGHT+IG2zYpPOUFqNOE5vi9RmQ+fB6+vsn8wBGPsqu7EByLNtXi2gPzv+VziBcmZBOs9Rm4qAfArDw==
X-Received: by 2002:a05:6a00:3687:b0:6b1:bf32:4fb5 with SMTP id
 dw7-20020a056a00368700b006b1bf324fb5mr16689290pfb.28.1700153340808; 
 Thu, 16 Nov 2023 08:49:00 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fi42-20020a056a0039aa00b006bb5ff51177sm4740337pfb.194.2023.11.16.08.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 08:49:00 -0800 (PST)
Message-ID: <c85b7110-ec9d-459b-9877-7fc62f390845@linaro.org>
Date: Thu, 16 Nov 2023 08:48:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0] hw/core: Add machine_class_default_cpu_type()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20231116163726.28952-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231116163726.28952-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 11/16/23 08:37, Philippe Mathieu-Daudé wrote:
> Add a helper to return a machine default CPU type.
> 
> If this machine is restricted to a single CPU type,
> use it as default, obviously.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/boards.h | 6 ++++++
>   hw/core/machine.c   | 8 ++++++++
>   system/vl.c         | 2 +-
>   3 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

