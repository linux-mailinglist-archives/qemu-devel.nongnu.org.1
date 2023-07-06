Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 707DF7497B3
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKhg-0002lo-Mr; Thu, 06 Jul 2023 04:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHKhW-0002dW-NQ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:50:58 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHKhV-0007yA-5e
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:50:58 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-986d8332f50so54943166b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688633455; x=1691225455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CniIOzDXhYMaXuEP6vqLCYXmvMQ3w0l601sik5s9zoY=;
 b=DaNPnyesgDdyZyrzsN4QjYYQhEH96S/npSUTu08J0QMNW9tc9qsvno8r4/NPaLR2AG
 LV4inDYQkk21XOzkIBmHj3RNRSuEeV7If4XRSjoI7sTJdZPJ4yrcSDL4qlE7nSQaTRPH
 3duEC0n33NE6sUeBc5xPeRfU/RJ0coLYdzwFla0SpyXyj6mY+rgrUQSS555q73r9onyS
 paM2zCLg/MAplHTQSG0wli7zl63vguDVuG6a4v/QZuZN2D1RF8bC3Q1BPfTku3/Gr6yR
 qrwa2fIjjMBR9WuG7Jh/FxOolnkktaa9ZRSfTlEgy5IS6PUSjBpPAkQWQ7t/ipdHmYFR
 KaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688633455; x=1691225455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CniIOzDXhYMaXuEP6vqLCYXmvMQ3w0l601sik5s9zoY=;
 b=e4hrePAiolUmV5zbGAg8wF9y5aewLMgWkn+tVqLhuf22FClnF1n0oRIgMAlwyuoORz
 R9K8Pkp78Vy5hspVFNjTjuWWqzBcsONM2Lk/NDEX7LrGwNzhJ7sX4i0QKs+4RMyTPEKe
 Yy7q643v1DH2QrDVTah4E2AJsMhUVRB56Y4IPJJtQu0P1enAnDhiWEDiDvNxwBV5d7qP
 VKF//5PuBAdeIk5ATAOCFnzlEDXajM7B326DBN0WXxVJEeWLiGo9JBsXM4iEUI31dI59
 rVa2zwDqNLnjz38nZ1wx7cb/E6pNaE/DW9NMjH2GFdnlqCcMqYRfTM+h6JuWpqeTaDjQ
 n+8Q==
X-Gm-Message-State: ABy/qLY1gGZcIXGKZUpdK16w1fsCWtQYw5iLbkK11R2/XbVHWbfnRjn5
 n8RWQe6lMEDN2VRa4efaFP8TOQbq32fUgMuE+Mw=
X-Google-Smtp-Source: APBJJlGeYQy6xolAfczdGZDZB7OwzbNu3K+Qj2no8P3v8sQaQS34x/sVvPaIuLSmFgriCMicuInBig==
X-Received: by 2002:a17:906:f2ca:b0:96f:d345:d0f7 with SMTP id
 gz10-20020a170906f2ca00b0096fd345d0f7mr685469ejb.62.1688633455534; 
 Thu, 06 Jul 2023 01:50:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 v26-20020a17090690da00b0098e4aef0791sm532682ejw.66.2023.07.06.01.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:50:55 -0700 (PDT)
Message-ID: <590f7428-4f46-0d6f-b616-f77e509013b6@linaro.org>
Date: Thu, 6 Jul 2023 10:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] meson.build: Remove the logic to link C code with the C++
 linker
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230706064736.178962-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230706064736.178962-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/7/23 08:47, Thomas Huth wrote:
> We are not mixing C++ with C code anymore, the only remaining
> C++ code in qga/vss-win32/ is used for a plain C++ executable.
> Thus we can remove the hacks for linking C code with the C++ linker
> now to simplify meson.build a little bit, and also to avoid that
> some C++ code sneaks in by accident again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build     | 24 ++++++------------------
>   scripts/main.c  |  1 -
>   qga/meson.build |  2 +-
>   3 files changed, 7 insertions(+), 20 deletions(-)
>   delete mode 100644 scripts/main.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


