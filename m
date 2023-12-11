Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA92C80D462
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:47:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkMa-00007l-98; Mon, 11 Dec 2023 12:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCkMQ-000077-LO
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:46:33 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCkMK-0007uM-I4
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:46:30 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d075392ff6so36750665ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702316782; x=1702921582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GAoNvWcQlylA41TXyo8EPpB1cjAbFX5C5u9juMLhZK4=;
 b=TFFFlic3/GqdyroKpRX8egSYaBT9LnGWKyv3MUexmgpRSq1m42y2c/Y0YDrF9o6OWK
 Qn0kRPqkH/loTFE6//3jyBB7odGywy5ZDXAS+GKR8Mq+3TvyyA9+QGyHZMNi3F7TfIqt
 Hc3hP0KKKDeAQZYsxejHDlmGFle9wTfFXaOw/g0U5pAy7rDQsxPsECQbypKzuyPNxoAQ
 +KhFBGK3vrQSaPS9snb5qSRrVIlIZYPjbXzKU/AWcaxWsycSBNeTS7A1cA52KmgxgGoU
 Gmf8F16ISvXkVSxVTTCeqfCr4LloKJy1QzfDBKkHsIWm9IrzXZpvQpXa7LYOlVtF/gcz
 mgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702316782; x=1702921582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GAoNvWcQlylA41TXyo8EPpB1cjAbFX5C5u9juMLhZK4=;
 b=oEseRRIbfqNoLmr7AJVbgUdEtVEhYN4BUq0S96W4M+e23j+uIqlH6t5YEnoSWz23Nx
 EZ+ePiq18Ue6sMgiWWWlzvR5+7jC/fbW13kFJYeRN3CExDnDcFpPRoJC/uHmmYi3lEzw
 qHdF2xtBTOrZlodO2XB0XEm03ppUFxwWCmubQyquto2g3f7UBa6l0OkF5Jx64cn4+TAy
 g2HwwgW+rkE5mlSkha/kXvpe8TsEB1RDhN1CXYkX6aGykmV/VD4l8lj37GWJ2x5GJcla
 VnuOZemqp7I4UbQUDeEx7SffIz6Ck0vDuaKIBWv6+F5eVgsvrUsis8suyMCYKddTeHIi
 PRIQ==
X-Gm-Message-State: AOJu0YxhCwQwIlB7sAP4C3eIUf/9GS12fDClVMELfuKI9VXSpi1yvHHe
 fD/l/AeIoqxVXEz5tER2CObXIA==
X-Google-Smtp-Source: AGHT+IFiL7wnjEa+adSBlhTKjdyb3vdH3qIF9H/3zvhhg6j2tiiPlIP9ZNcwhL1MTPFk1s52fwb75g==
X-Received: by 2002:a17:903:28c:b0:1d3:2a94:cb4f with SMTP id
 j12-20020a170903028c00b001d32a94cb4fmr1150610plr.56.1702316782532; 
 Mon, 11 Dec 2023 09:46:22 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902ce8800b001cfc46baa40sm6934437plg.158.2023.12.11.09.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 09:46:22 -0800 (PST)
Message-ID: <36dcb85b-91ed-4b5a-867e-91c979c60183@linaro.org>
Date: Mon, 11 Dec 2023 09:46:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] accel/tcg: define tlb_fill as a trace point
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
 <20231211091346.14616-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211091346.14616-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/11/23 01:13, Alex Bennée wrote:
> While we do have a bunch of debugging we can turn on in cputlb there
> is an argument for making tlb_fill a generally available trace point.
> Any fault (via probe or access) will have to be preceded by a tlb_fill
> for the address in question.
> 
> We don't bother logging the return address as that will be a host
> address associated with translation and therefor can move around with
> ASLR.
> 
> In my particular case I'm trying to track down a difference in memory
> fault exception patterns between record and replay phases.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   accel/tcg/cputlb.c     | 2 ++
>   accel/tcg/trace-events | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

