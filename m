Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70571821958
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 11:02:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbaN-0003Tb-72; Tue, 02 Jan 2024 05:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKba5-0003SS-BI
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:01:15 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbZw-0005I9-Vn
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:01:04 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3373a30af67so1730886f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 02:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704189655; x=1704794455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s++RBQNZ14uMYixJRc1hsmTMclQuQpHvVPBssIi3yNc=;
 b=KHlNV0aCs8Z7aJvdYIMVBGWe+UemirCryE2TTOlIGo6oX5EghFaeJ1M0upP200BFZS
 Ko8v1BiPzMIhifJEp6iqjZHTq5kELXhBTsbzWtOJUmsdZ8ZLUnvxO2WbfB5yqJcT8EcX
 AajJFTDe2ErVpj0FFYJS+W9FZd38iffgm2YpeePKw6ha09tvfG+sVa7RUT5nAkK6LKX6
 uRHZ8JlApscHKXrksY0WLntBvSG0NsqMUBsKttETyxDBh7iZdZ5zaIKvQaLWFYPYQ6T0
 mwixtkuQ/KM6488jDVUckNrgcdYR7Y3Eae6yRB36aYee+yuV+MTzDu9LvxL/1y+SbmP8
 d/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704189655; x=1704794455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s++RBQNZ14uMYixJRc1hsmTMclQuQpHvVPBssIi3yNc=;
 b=ITWrhu+TlnIk142fdIpQy9IO6Z/o6LmhC1vYoouDlb1UtAawZrEu0H+dCTRjerX/gp
 kNrrYqIofdowNPoY7fgsSUR60jerPh/K8tMIHfvurW4O2gxYRqgesHM+4FD6cD5Cqamt
 CkJN84kPMESl6GLoiE7ffN3hNZhfhGO/0pDgjak3yj7Eu5g5zAUMiPHojdSmCMvQKbgo
 IDsBwCSK1YuKStXjmQtUXjVT0oFiE2qs/ooTMfzaE2Vniv/6sBh2VjCGB4fTQs3ng1eu
 cerBhkIZrGmGIl5Melkg49sYbeOgC1MFxUk8aOfbCdDUkn2X9JUOzQ+j0BkMh4rHytT3
 R8jA==
X-Gm-Message-State: AOJu0YyIFlUIKgCsTPxTrLWjLwFhpJpr7qwwEu4vEk44+c2WV+MMEtu8
 yipSkWmpnwzsA9RL/dJ2MB4ds4nj/ZU7mWzCjYv4+nQvklk=
X-Google-Smtp-Source: AGHT+IE2SKnciiCVGXbFrGp786lFth5FIt0p5rEscmRz21+qUUALEikOIIB5Q9YLTIw6IeqIg1uSKg==
X-Received: by 2002:a5d:5404:0:b0:336:7f6b:190c with SMTP id
 g4-20020a5d5404000000b003367f6b190cmr5708066wrv.205.1704189655092; 
 Tue, 02 Jan 2024 02:00:55 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 a4-20020adff7c4000000b003366da509ecsm28030822wrq.85.2024.01.02.02.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 02:00:54 -0800 (PST)
Message-ID: <8f99476e-ebff-4b33-a7f6-daea2b3b8eb8@linaro.org>
Date: Tue, 2 Jan 2024 11:00:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] vga: reindent memory access code
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com
References: <20231231093918.239549-1-pbonzini@redhat.com>
 <20231231093918.239549-7-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231231093918.239549-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 31/12/23 10:39, Paolo Bonzini wrote:
> The next patch will reuse latched memory access in text modes.  Start with
> a patch that moves the latched access code out of the "if".
> 
> Best reviewed with "git diff -b".
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/display/vga.c | 211 ++++++++++++++++++++++++-----------------------
>   1 file changed, 110 insertions(+), 101 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


