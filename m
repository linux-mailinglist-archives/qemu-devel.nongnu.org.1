Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E464A78CFF1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n4-0000qr-LS; Tue, 29 Aug 2023 19:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3pE-0006vV-9e
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:52:28 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3pC-0003J9-0k
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:52:27 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68a520dba33so3787343b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693335144; x=1693939944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uZ38P2iKl1o0bH61cJRziRjoUNfJpr7f1NSjn3T0SPg=;
 b=Ql6173Gx7n/DCEpv6veuFiX8XYUeviymYNU14ruMzlvX6Xtn+iO3GGuTybtWV2mTPK
 IXtxR0cDtrdaNVWVtV9PAiQOzltq6qq7ueuWH1T9zFZaN8OnhaOBsQL4ZkLtGsy+g++C
 eTnfh9OaqhcobPEfyPgmzlw9/EnliMiHz6j69NOHoYZinjMsGdYxeJUJ4vR2nzuXRPC9
 jyW9z6WFbIFR6GYikJkX0P1XTOBHiS81rTltIfolDnEwy4aaW0gPL/c5bSbpdY9I+h3t
 Q6r2y1yyEzAfzpJ2/DmX6eEoi5krrL+FTExKuAVLQJRYTbZnJlcz6kVNpdX61FyYvaKk
 Uf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693335144; x=1693939944;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uZ38P2iKl1o0bH61cJRziRjoUNfJpr7f1NSjn3T0SPg=;
 b=bFMHMaFinIWp1O/eh69UuFZcJjJadWxYCRvthbJOjY9jbDQA0x9XMdq4fMY6E/IlE+
 4L+A1VS7GNsiDNi5GFacYu58mPphnf/9wj6dAEIQVTjxXZ1xwJJyvYgVBnieX54Er1dO
 3PH8J9pP6m0t5C860iddrGSZWYdEeIy40pKU1z+X1/zyG/jpTMWnmne+YO87FpHKjOh9
 6qn6LG47ZdLoT5qSW/S58k9rzitaucQnqQSsXX00uq/IBWHRBWmHFnpaMVnIc4Hflqqa
 Znpqd/c2TKy+sOJkGyhCtOpgeBg5I0I+cWgx9+F5piUAoynajxJUcRSPiQWHB3jg45wu
 IC7Q==
X-Gm-Message-State: AOJu0YxyZFovyhbrNVqFTDBEy/prn6RtLYFMasJJQ6XuO1kFbHf5pTQq
 LoIP7PpJn53WpoXjzD5ZbEvxQyXRsdUfwL6QC70=
X-Google-Smtp-Source: AGHT+IHwsfUFk9hVlYJwRpHVTKmj6E29jiwf/zlIxhsAQenyx6lIc3IuryshEPsTOkYmCQkHrIE0dw==
X-Received: by 2002:a05:6a20:9189:b0:137:74f8:62ee with SMTP id
 v9-20020a056a20918900b0013774f862eemr215940pzd.18.1693335144538; 
 Tue, 29 Aug 2023 11:52:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a170902c19400b001bd41b70b65sm9728910pld.49.2023.08.29.11.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 11:52:22 -0700 (PDT)
Message-ID: <57fd7e50-f75f-0b90-b6f1-c8b7aebf9b3a@linaro.org>
Date: Tue, 29 Aug 2023 11:52:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/10] configure: move --enable-debug-tcg to meson
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-11-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829082931.67601-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/29/23 01:29, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure                     | 11 +----------
>   meson.build                   |  3 ++-
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   4 files changed, 8 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

