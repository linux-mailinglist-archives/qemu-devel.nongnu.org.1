Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 198CE80E0D6
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 02:26:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCrWz-0007dT-HF; Mon, 11 Dec 2023 20:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCrWv-0007b2-7S
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 20:25:49 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCrWt-00045i-Kn
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 20:25:48 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35d64ad4188so23379435ab.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 17:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702344345; x=1702949145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dMolOtqCAF6KaRbRCKYG7OXXs4brMS7TLx7Ry/3CdY8=;
 b=tnwJrF71Pgy91B3u7wHnedxAp3DqMd8w1FPqOURGaBZtlnMrkrHFKILNB/GrMTN1jE
 tqnZbd4gEkgRXB1Vy7RCBDF3f1nVk7uTxZ1v3hwPJ8Tgb2DFLR1Kr1usE9rrrWcfiV3v
 xSSeOl07AEtciBNfWubulCyN4hBhe3Qud8eZdtxI8HGk/PqS9jXgtgCejtaSQ3XlevP2
 DBldrTVCB12eqj2FIeVQHj3oce8Pt01lmlkTtVpD0gcPLfBKAURdEfiaZlNNQOEdFoEU
 vF8qOwbAyLeLOtOoQsXd4T2PIXR3hMo+4nIercH60r+X+oM9SbqLPUtVsMTA8kl5/SNw
 nxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702344345; x=1702949145;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dMolOtqCAF6KaRbRCKYG7OXXs4brMS7TLx7Ry/3CdY8=;
 b=OSFw/mbqbf7XvZZfOA4WLA+KVhYD5lHnAKfChxZFfjGQalAGrxRgCLIJg2DjBNeb1D
 n/fxF/xpxtLNUuic+BBMr/7lE+HrdPr0m1bHcuTOwWYyw94WmxE3eHUiL59fgbRWpMcT
 eYnV9cs1WcaJDpN1rXyQdP9/gKBL4jZDzm/6HvvW2MpCDUyAohscBG8BUETXSCfrxIi4
 zzmYoOeMn/okp+zyLWj4tolhdGrPLqWXsQzlhN/GzI4VQCvYLW5A3o17ttir8KRFblB8
 BH1fuH3UNabScAJNmgdJDrJrQ/tGLQLluMfIDQPMFjRv3uzolmJuk+pWYU+sfV9mnsNP
 7vNw==
X-Gm-Message-State: AOJu0YxLkkWvk16baDx00K/rs63bRFq/wgYNxZc8n5VICV+SFHfaGZqe
 3Se/ZFlqjKsklMLgcgrlnReL5A==
X-Google-Smtp-Source: AGHT+IGPnoJuSOyxW7PVmWb48KNWHyk/+zNYo8RbXBPtLiJ+muSoQb9T3WRt15HpRbtwfV2dvS3uow==
X-Received: by 2002:a05:6e02:1649:b0:35d:59a2:1282 with SMTP id
 v9-20020a056e02164900b0035d59a21282mr8264982ilu.46.1702344345021; 
 Mon, 11 Dec 2023 17:25:45 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a17090322c800b001d1ccb0ac98sm7282973plg.272.2023.12.11.17.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 17:25:44 -0800 (PST)
Message-ID: <af89498e-3ce4-4866-8047-00f4866e9ca7@linaro.org>
Date: Mon, 11 Dec 2023 17:25:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] exec/cpu-all: Restrict inclusion of
 'exec/user/guest-base.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-23-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> Declare 'have_guest_base' in "exec/user/guest-base.h".
> Very few files require this header, so explicitly include
> it there instead of "exec/cpu-all.h" which is used in many
> source files.
> Assert this user-specific header is only included from user
> emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu-all.h         | 3 ---
>   include/exec/user/guest-base.h | 6 ++++++
>   bsd-user/main.c                | 1 +
>   linux-user/elfload.c           | 1 +
>   linux-user/main.c              | 1 +
>   5 files changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

