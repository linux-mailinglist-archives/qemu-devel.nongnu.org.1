Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F6F7DDB60
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 04:14:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy1fp-0001RK-6b; Tue, 31 Oct 2023 23:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy1fn-0001RA-6K
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:13:39 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy1fl-0006bn-Lv
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:13:38 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b5af4662b7so5689978b3a.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698808416; x=1699413216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+H5EH1gFE2uejGsnUkbS9tMoJG+SGCtOmHUWyaQrPbE=;
 b=MXoAQJTDAyDhYCV4NFPl0FBEvCuCyjrwl7oduY1YN9Htn8mSv+nvEaUXqhePyw4w09
 paHI5Clp2lK3CubduiKljGcSLGeDJ65erAJXLcHuDfepkjWBxiGp0RR1LTXOm/KFoD6L
 Wk4XrejLNmGTzDmnlJ8fnjfQOwbk8Fd2l8Sndhz5raa+ZrRbxr6XwOHk6ODOEB0SbrQK
 TbSSGpulhIhFISKYKiWKEscNrF1Z1OhPFivL7V0tCpEh6AL/uTZW4ro3pyvVatcvPMlf
 N2DJ+xilUY6Ec8miSNhCps5Iq9TEAe3uP+1uiQ4GbRPi+t4CMuphDyvW/3pvmv8vcYxr
 R/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698808416; x=1699413216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+H5EH1gFE2uejGsnUkbS9tMoJG+SGCtOmHUWyaQrPbE=;
 b=jQYCu6Nwxgw6hzskhMmO4pFudQls7ABldbCkksiaXNQRsgZLfLlbzHPjAIKaUEsAJX
 0zFKcfTX2D/0W7OgcSEwB2DV4wqDGKauvTGSz1SQOmM1AXclS33pCIeqopUhYmi5Ja0v
 fMIOXPFNxnYN/Gb2oWLCeNJTdpjCgUBjoWgVKZGqFFHXG8ekSXxcMcEMIYW8C4K+GgSx
 jwx26ta4CICunOnJLc4uYHJpHTvZvn9z8u2XmwstMrqowbAllu73FAdBCET6huP8tKgt
 SdO1jG6leV5+WKYrSD2L8FbeejImZTw9TV8tCDu/JxSogf9oDCYjRUlfixZJKq46KchX
 PMZw==
X-Gm-Message-State: AOJu0YyiNEveYoSU4p+Cz1bYePVV3QRgSRUD/NbuA2z9F2ofWEXOCvYZ
 E68YmfH9DpusNIur3db1JKuMuQ==
X-Google-Smtp-Source: AGHT+IHbQ93luoCOIltdWSf+V/n2UPmvo8n6P5uFG/gVXHC/KlPt/iWZGXtcmyoFhGsjaY22uz658A==
X-Received: by 2002:a05:6a00:1911:b0:6be:7ee:9900 with SMTP id
 y17-20020a056a00191100b006be07ee9900mr13651292pfi.8.1698808416130; 
 Tue, 31 Oct 2023 20:13:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 n25-20020aa79059000000b0069319bfed42sm299588pfo.79.2023.10.31.20.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 20:13:35 -0700 (PDT)
Message-ID: <ac6143a0-165a-44b1-99e4-2ba8b7882ffa@linaro.org>
Date: Tue, 31 Oct 2023 20:13:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] linux-user/loongarch64: Add LSX sigcontext
 save/restore
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, maobibo@loongson.cn
References: <20231101030816.2353416-1-gaosong@loongson.cn>
 <20231101030816.2353416-6-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231101030816.2353416-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 10/31/23 20:08, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   linux-user/loongarch64/signal.c | 107 ++++++++++++++++++++++++++------
>   1 file changed, 87 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

