Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6899D81FEBD
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:43:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9Oi-0004p6-2U; Fri, 29 Dec 2023 04:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9Of-0004og-Q4
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:43:17 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9Oe-0005rz-7c
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:43:17 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so363351866b.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703842994; x=1704447794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zkfhuLtARPUPsicZAgau0jf0Zc/v4OODq5RudOXK6ro=;
 b=caySYBxHp0svJhHaVwxJ1vCF4rMGLwYy++kjUTY5ENrFPA8ABK/XbVOynPre+jbswP
 fa8FbYpcsL2VoLbVQOvKlA5cDftKhWCTr3eMbAjuNkuGRvfVxe8fO/1XArhBLkpWMICN
 RMwV+M9MxbRC86xCE9IKkz0mLvT0CYIyPF96mERu+m6A4JQgCyXK60hOaVq0rYOEIlIc
 M1RSDloVmFQV69SQ7pPaOWYXVMtZuoUpzOVQANyALPoovdZbNdz1RJLft3AL9GiTNnav
 trPd+tvwiNKy7kOJTipmQ3yWdxy0z5jWYI2wMbtataaHtIfJVVqte9aSvxMKKw5a4Lg2
 I3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703842994; x=1704447794;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zkfhuLtARPUPsicZAgau0jf0Zc/v4OODq5RudOXK6ro=;
 b=natnZrLuqmJuPK/6KuhXG6hJLEbAp2q9+pMkNBAx8sH0zq7Njy6PS9Xh6YHJqN+7tN
 Yhb0Q2KHYYGm8myupexbahZwdoU5ffwFBOlk5sos5Rn2fdhLVR9PRlZxkIaXfltnP8j8
 CxY+n/8FgPdb6V9o5XfgV+R9lnmOBBsZiqkfHJR9cAGfUOJZsSfZK2QpQyvFUymQw9HF
 sUlIn1nAHWo0jrOwHUZdcNXR6CDGwmIksgeiqrN5ps6UCM2MH5Ye1ia1T3TD2yHRmVsk
 UoNuXcBgx1ZJHYZh5wD25Bdrl9wtOY2ZdiayDu+UHk+C/TU7f/VgCAOZvLAtE+OHOS9d
 4TuQ==
X-Gm-Message-State: AOJu0Yy4Arml9qQu62trhz5ifw7yFTqZ5G6i2vxEWvJjiHbH/NEhctEw
 B7QIN4n1Eyqb4oVcThd89kymQ5pPK6QlBA==
X-Google-Smtp-Source: AGHT+IGv0aC8lIF0AlwrpkVfYIPtPIIx63zYMpT4hBPN1gbbNVuENs3OhyvXa47oRyldJi038qwYjQ==
X-Received: by 2002:a17:906:7c46:b0:a27:991a:e0aa with SMTP id
 g6-20020a1709067c4600b00a27991ae0aamr271988ejp.101.1703842994554; 
 Fri, 29 Dec 2023 01:43:14 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a170906078a00b00a26adbd4f15sm7488110ejc.102.2023.12.29.01.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 01:43:14 -0800 (PST)
Message-ID: <ed27bb8a-a04d-436a-9028-643895b08dc7@linaro.org>
Date: Fri, 29 Dec 2023 10:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/21] meson: rename config_all
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221171958.59350-1-pbonzini@redhat.com>
 <20231221171958.59350-13-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221171958.59350-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 21/12/23 18:19, Paolo Bonzini wrote:
> config_all now lists only accelerators, rename it to indicate its actual
> content.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/mips/meson.build     |  2 +-
>   meson.build             | 16 ++++++++--------
>   target/arm/meson.build  |  2 +-
>   target/mips/meson.build |  2 +-
>   tests/fp/meson.build    |  2 +-
>   tests/meson.build       |  2 +-
>   tests/qtest/meson.build |  8 ++++----
>   7 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


