Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3941806DD5
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 12:26:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAq1F-00046t-LX; Wed, 06 Dec 2023 06:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAq1D-000467-RM
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:24:43 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAq1C-00027Q-A4
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:24:43 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a06e59384b6so88232966b.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 03:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701861879; x=1702466679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nO/5hc8upuraU4L0aJsUiwj7hZf9XtPBADLAascHOzU=;
 b=GdfYrQEHZOhCJlynzUtrmXksFL3+UwP+7ZBjmZsh1wlVwKjngzZFn+EHpIs5DffgIz
 R7gPjaP9+QS9aswzkCIlJhyTA7zLihg/a45LHxX8H9IMSw7/BDQvY6zTKtZw3B7SCwpK
 JaymwxCcTHpo/0cntlD2uEaTLjv9goUPhZb7fLJxWhjRmVjRvW7avDsNqK4+PFKSE1Ag
 ENPkc6d7LmuxQJxUZCPGO72O8r+YheYm9mDH7WghQlZloyOTPuFwupUNoLWh6wxY0YuH
 jDwFwUkmpZMI9M9vR7ipNfe4MBUot4c4zQZ0pvHKqvQlTi3GrQ2gVN8huDjMILj3ObuM
 oxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701861879; x=1702466679;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nO/5hc8upuraU4L0aJsUiwj7hZf9XtPBADLAascHOzU=;
 b=HSMwN0n8l7N8FzUhpxMDcC2Jvsbz3jwOnZyc1g+aduGxT5MCdRneuiDJTRXpXO9ez8
 tj38jXhfHzzWWXvmbqrLS7Djs+hY+DTDID0IY3YoXucgETlb7bwFkY8uVq5lvZUUmb8T
 D94kP47mrkCd+WRyi6iK1ddAjW5KwJEr4u0hgvE37V1vM6T6MD1h+HmnaEE9LxDjYVFq
 WFeY0BsIvAladfoqzqOxirYAxsSI7GdPA1Fg1IoGsn0Lrey9aKz4s19tUeG4ny0Mci59
 EQqjTD1S0mxrzG5eOH5piu9coDmfHOs/l+Gj3N68qqcwuuVAnnFgiBxNxSAm/lpBfiMZ
 3d+Q==
X-Gm-Message-State: AOJu0YyH49woLAOEdg5e0v3G+pufcq1sU2pyqK7TFVFete6KMLpllutQ
 pkBg6ZOgO4ebOsUMK1bSNQ0i1A==
X-Google-Smtp-Source: AGHT+IFgb2UXUJhzl7skXprLdWRijl/3FkV0Q/H3G/m9G6EDRZp5ScojmwbUYINEbULLG4HjYPwoUQ==
X-Received: by 2002:a17:906:f34f:b0:a19:7781:3e2a with SMTP id
 hg15-20020a170906f34f00b00a1977813e2amr427643ejb.23.1701861879214; 
 Wed, 06 Dec 2023 03:24:39 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1709062a9100b00a1bec12448csm2792866eje.150.2023.12.06.03.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 03:24:38 -0800 (PST)
Message-ID: <8c0add09-101e-4848-915a-829ba0e819d7@linaro.org>
Date: Wed, 6 Dec 2023 12:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] tests/avocado: fix typo in replay_linux
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231205204106.95531-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 5/12/23 21:40, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/avocado/replay_linux.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



