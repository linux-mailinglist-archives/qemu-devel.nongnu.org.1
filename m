Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E451D78D05C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nq-0001Z9-1K; Tue, 29 Aug 2023 19:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4t1-0002Ds-CJ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:00:33 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4sz-0007k8-3n
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:00:27 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-56963f2e48eso2521633a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693339224; x=1693944024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=23pGaOKFSIFd02Bx8maaFHUIhIg6AR5PXCaMeXj9FMY=;
 b=en70HLuJTzgjbwsw40j/zo9qdkLnqNmbaAl8WAS1Ld/BTSvx0fH5jtIISKTR7NILcA
 9qcIXWrMOa+wwfuWMTlF9dC8fEFtWFWpAd28uSxdw/KqmufVw9SZrM8eBM1VSATl0tPl
 lYw9IBvBhrVxjeb4WXbM9M5biSgUEGLidCCl+CTRfgqOghZcz9lI8cQw6kwTBTb3YHhk
 GoVXIHmTKiqYq0WItxaZK8A9D3mkbGx5RvJh+OeVav5Ag3RkDBOnnaWU2yaUYBL1QP/C
 U5IrUzxsJiT0Qj1csrFYRvhf5WCdJw4yUvrSnRaDRwzjIF8qidQkSYDu+zH41K5MkDfA
 GBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693339224; x=1693944024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23pGaOKFSIFd02Bx8maaFHUIhIg6AR5PXCaMeXj9FMY=;
 b=Z7inl9PaHkyWxy3qsfA4IjOTpEbbUTvjFtk2NN/St9vcacc+fjFpEbnDND60O2ZHyA
 sSUXMiR6bLf5MBMYKNfs84nAcQBo6ow2MVRnOA7XHFkgQt52dWNF5LEb8B0y5uYylfz+
 eU6xoU0YSFHlTR1IijZz8undZQ2hGmG6S4cobEGIpv5pUQKe+6ry1pBlrAiYKrEa5Obg
 ZKi3WbcoYQBKJDm98VEAHSBzGdVPrrjnaVK2K7qVPJvgd1iUqs7WtX5gmIhdy/NzntnN
 pom2OmVRc43QhyARJNKTYZWNToorQZ+MaFtqFEB1hBLBPJfQR3iDTtRpVRv0JI6zOiMJ
 vMxw==
X-Gm-Message-State: AOJu0YyqIIBBWMY3BZErj7JbsyLGlkL8fq9UxK2HYpbFkgGFKnGRBdIM
 Jl7OmhqHoG6tBydDkl3eHpnZBUB7397vfnmIjUI=
X-Google-Smtp-Source: AGHT+IGSBYpV9pJs2/WGlZ1NGuBlLSMV3hkMnnYikrvhVci1FRT02FEESIfIUKpXFtVuUhASH80NnQ==
X-Received: by 2002:a17:90a:be11:b0:26d:1986:f7ec with SMTP id
 a17-20020a17090abe1100b0026d1986f7ecmr268986pjs.1.1693339223814; 
 Tue, 29 Aug 2023 13:00:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a17090abb9600b0026d462d34ffsm11014834pjr.47.2023.08.29.13.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:00:22 -0700 (PDT)
Message-ID: <1cb1a725-56eb-76c4-6390-d8e502c63002@linaro.org>
Date: Tue, 29 Aug 2023 13:00:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 18/32] bsd-user: Add stubs for profil(2), ktrace(2),
 utrace(2) and ptrace(2).
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-19-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-19-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.h           | 28 ++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
>   2 files changed, 44 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

