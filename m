Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D281E820
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 16:41:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI9Xo-0002ly-D8; Tue, 26 Dec 2023 10:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI9Xi-0002kE-Sl
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 10:40:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI9Xd-0001XP-PG
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 10:40:30 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5b159350so3847945e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 07:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605223; x=1704210023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RHdp0uqmUB8TDEzjrSBm802IY0oobcqjgwZ8C0h+IY4=;
 b=hcpvKtKmPZnZ1Y1xTVjhPegVCL43zVUh7RUBKSYj2dBnqVsXK36FENlWn9lPtiPEqc
 8+earixNGhm+WIgCtkCwMNo8zqIub4lq6u+lVqMojhfH9ycvxfVaKKtH50oMkIjcoPk1
 KifzsEFERf276dR2YNudEg0KuDzP4p8aRC+FEOUbPIMbd4JUJNps7gcJE0takg80cRvv
 C4GcRVd4A3+2qI6QSWvdeqTXSewpGUIf+Ubez8sosghjIHnCYfZZDsPiM0Sqqsl/wIq0
 iqQV2mYIBTSnw3L57RPKTPeeLWAnK/KIAZVpVfxVznkgFj0TQ1zXAzi/DYixxJ90km3x
 lW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605223; x=1704210023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHdp0uqmUB8TDEzjrSBm802IY0oobcqjgwZ8C0h+IY4=;
 b=b8/R5Aq1C2PPyMP+95I1+JMrJHzYBPLYvcc1SNL4uDnmKfAvL66r6ZA/7XZmfLkSOI
 R7jo71VzL3LVG/ss7F+isNJcZpv1KJIK3E2LAQok6Ahy5Dvfyrk6TUvDTYO3R105D05v
 tXLOKOJT+qfujeV1hB2raRocibgXeYOgrWSRyNJIw5yyIzE29ga1qPxv63fRc0gzOTqg
 8zkEnaS+GYNXOkg7BIum0uTZwcDuQjSmDZMaR76YqQWqTKeDYERbINw5bdZpFAul3sc2
 ZHF7e9J89qvUbbmW3sBDawha6lLTRuDUNwkj8glrez/T1e/73UVOm8FIXLH7gOfTXg0q
 BJTg==
X-Gm-Message-State: AOJu0YymlZzPdHDkSBmpHVaq1pqDs/9Pl4Hk5AMqwGW2eUprAjoiuVic
 Tw8BoFpJIZsh7An+DG8cpWiGHLbBrj5o4/v+qz86l3hkIt0=
X-Google-Smtp-Source: AGHT+IGMO5NutPLgJjYdgBPeBsSGGvdf0xmb9gXNBal98pf5ddKkuETGcIw4IaKfoEWFMMNj6aRwDw==
X-Received: by 2002:a05:600c:4e87:b0:40d:47a7:78da with SMTP id
 f7-20020a05600c4e8700b0040d47a778damr4295578wmq.66.1703605223775; 
 Tue, 26 Dec 2023 07:40:23 -0800 (PST)
Received: from [192.168.111.175] (97.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.97]) by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm21164634wmq.27.2023.12.26.07.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 07:40:23 -0800 (PST)
Message-ID: <f1911426-2037-478e-b801-e22b933f71b0@linaro.org>
Date: Tue, 26 Dec 2023 16:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] system/qtest: Minor include cleanups
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231212113016.29808-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231212113016.29808-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 12/12/23 12:30, Philippe Mathieu-Daudé wrote:
> Add missing header and restrict to sysemu.
> 
> Philippe Mathieu-Daudé (2):
>    system/qtest: Include missing 'hw/core/cpu.h' header
>    system/qtest: Restrict QTest API to system emulation

Thanks Thomas for merging these!


