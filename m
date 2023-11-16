Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A57EDBBB
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:03:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WPX-0006W3-FW; Thu, 16 Nov 2023 02:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WPV-0006Tz-3R
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:03:33 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WPT-0007Cy-HA
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:03:32 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9d242846194so64369366b.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700118210; x=1700723010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9l8dyFHkqHOfrMGf/NMVU/X5w8bskbaRUPA8RkUrhxo=;
 b=UDWwGV7YTLOpiD1qysKlr0Qwwa+xPh8qMY+GD+Xz+FNILAf9xEpGsPWgoQKK3gmUy2
 uy0wqam1DJ1Ol92yUJ5FU54rMg2HYrcUpDk0k1NHwAA5KBhkvlWvcr3XMRWjiAHuWvAU
 LqKDp1K2d5Pe8MTFwr9zVqn/R6JmjqKrdB5NiHQnJZUuY2xD7/oeqZcS/EVT7AS0MGfM
 okOwFZOta7liGneMcZ5r7Ht3WXx3vBVCMq3FioVFKIE1FvNaPQzJR94EghrHeOYIVs0D
 kxIWopoPGc6s3Xoq15r13YPz9ZKa6qGuuTvMUAeur2qNirK8+L00CHfgwFsOXB0DffYW
 uZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700118210; x=1700723010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9l8dyFHkqHOfrMGf/NMVU/X5w8bskbaRUPA8RkUrhxo=;
 b=U0q4mAHHpebV0ZP5/MFV7cD2vVYa8NH/3pq3czUrdMy3CVr+JzV8yNuCAK0ZBsUo2F
 l0IggC7EQ9n6eWpH/SOT9+dmYIDNV3EHqj6dlscEcuOeAitLUWPJUazETIHK9EPNSVmm
 wmu2CBjWLpnwnvI2k10aEN5WNI6kCWrpLuWg0kMZA0/IxvUrVGFqnJfQ3OhoedkCFW+K
 Bj+puaUfRbLjJQbxozeN23JFjhFuGnPaJf16r5Opf9R372uGOBX2TkL3UuL80nhsKM8u
 Ne+y7Og0pL5wFvp+xGNgNB6rKcYYI3zzYRX57Jww1VkRxUgQ1Sx8TC+Nv9WMqrYGwPsZ
 hsuQ==
X-Gm-Message-State: AOJu0YxfMZm9DP6gOz7esI91a899JVFU56y8x+ExE4LiZBvfjov1uY4p
 XhXG6iOone6864zygzW/cVDq6gVJHH/VET+WrRI=
X-Google-Smtp-Source: AGHT+IG34LqatdkZQHMrGGLThOEVDDOy5S/4eWfqjwHzT43OTFj+mOalcBHa5tKv0SADiQlBJHuvkQ==
X-Received: by 2002:a17:906:1341:b0:9dd:8aa0:f7b8 with SMTP id
 x1-20020a170906134100b009dd8aa0f7b8mr11656636ejb.9.1700118209941; 
 Wed, 15 Nov 2023 23:03:29 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 ga23-20020a170906b85700b009ae587ce128sm7925364ejb.216.2023.11.15.23.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:03:29 -0800 (PST)
Message-ID: <7fa76aba-d74b-4465-a574-bbdad7e833ec@linaro.org>
Date: Thu, 16 Nov 2023 08:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/19] qapi/schema: make c_type() and json_type() abstract
 methods
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-6-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116014350.653792-6-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 16/11/23 02:43, John Snow wrote:
> These methods should always return a str, it's only the default abstract
> implementation that doesn't. They can be marked "abstract" by raising
> NotImplementedError(), which requires subclasses to override the method
> with the proper return type.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qapi/schema.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


