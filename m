Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E253C81FEB8
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:37:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9IN-0001h7-Gx; Fri, 29 Dec 2023 04:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9IK-0001gk-MN
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:36:44 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9II-0001el-UX
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:36:44 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3366e78d872so6275244f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703842601; x=1704447401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e9mPqUMGyTlvWggXKTRx24ao8HJd5rzd42DiZt9bZSY=;
 b=isGxaOobQLhiz3V/NxF6xYYYxZOi3quLE0h/xnY1B35bUs3R856cL2IF+s912SPiOj
 DuAWgsO+BlZVNPUjBVfaJnxIws9jHzGidrUgMC0t/Kink94ENYFJfXTA+Zi1PPoxcHNi
 WwxblmAOT8UMDLeFOh4FrPruBDAjinDN6TcwsTxqbRMYdJNvNU1VUYYwnNYSf90Dzd6l
 idB7bm/Ms4mPqQjhrrjJKB0cmHbPRZpsV8zZRdxPlBInsQF8H1yN0zMnE2ZiLjyvKSbr
 B6nZlIpvneC0GQB0PImNSsoalRnT40q6vvVIkgDhV3m3hhY8Zd8ZZyK2U1vzri955jEg
 MeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703842601; x=1704447401;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e9mPqUMGyTlvWggXKTRx24ao8HJd5rzd42DiZt9bZSY=;
 b=C6ci4zUvHpwHtbBw3NWRPFARt/Il2CQxRJH8mPl7SHtPcz8iN1dVMmlA741TIVpmiY
 S3ydefQX3y9/twNjKZwV8hEmyfpZpd2WtK+ca1FeH9cvT/DCfDd6lVnOZFRVmvLnfIjO
 t7f97/7uiIFu9P4x9CI1jkcwV3XCiD2dUTd90Wu6CefPK1Yl790zswbFDJz+JzDA5VjT
 /CkjTIwJf7KBVuhkV8QH++m58Nd77SFMkiBt7OWb8pnCHO31e24brR6QhJ1hNU73vF8j
 1+pSuK0DOzO0l0wQTTFC/U19dx6ZgYIEQ9Qy8lCt1xdTKnYGYGgvR6s9nLQSMmHUQ0pa
 AO4Q==
X-Gm-Message-State: AOJu0YxgOuDY2bX7YjZ9NPkJq6rHSOntz4Nu033gQEX6CLLqudpmBbCH
 w7BrtyJL4IfrEeXtOMm+Kmr+vEiUJRjNWw==
X-Google-Smtp-Source: AGHT+IFp0X+lRhilxkFRM2gV1lloV2UIVHXsCqytMvW294xT+4b8bnz+Nf9gmbKfdsO6G9QqKbG4Ow==
X-Received: by 2002:a5d:5692:0:b0:336:6a97:db2c with SMTP id
 f18-20020a5d5692000000b003366a97db2cmr2890850wrv.128.1703842600855; 
 Fri, 29 Dec 2023 01:36:40 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 e29-20020a5d595d000000b003372b8ab19asm27104wri.64.2023.12.29.01.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 01:36:40 -0800 (PST)
Message-ID: <1dd6a793-1f30-4882-b45c-5c7596f5f984@linaro.org>
Date: Fri, 29 Dec 2023 10:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] meson: remove unused variable
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221171958.59350-1-pbonzini@redhat.com>
 <20231221171958.59350-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221171958.59350-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/bench/meson.build | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


