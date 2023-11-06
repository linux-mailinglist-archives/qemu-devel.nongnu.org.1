Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB637E2EAA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 22:08:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r06oN-0005B7-9d; Mon, 06 Nov 2023 16:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r06oL-0005Aq-Ut
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:07:05 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r06oK-0004qE-Fi
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:07:05 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53dd3f169d8so8248805a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 13:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304822; x=1699909622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wu2vspcA+XycWJuL7j1AuiRXWi8+EU83MGQfKFvmtAg=;
 b=yQmDpSBsy6IkjLfbBo2mHXbS63WJVMcNya9m5lMckFa3PIV0ETxbbngl8ojfD6jQD5
 k9xN1LtKtSKKpefeVPi6olcvnGADjKQmNleffs3QdUZPiD6M+PAT4srJfvEDNEhMEj/i
 Go5Pp1R1w7v/w5aDjnGCM+H1PgrVTohmKSjZBWN+18+S2ZECpqXT+6BM5zV7YRWyuue9
 5ofdI+H5pDjWnnq5FIf5v5czedkLJ9JR/icofg1Tr8xWAFIKPYG5lmG3Os5QVZPxg6/d
 AoMeKPhFzHYv2lJ8Nf7zWRdTsoi/ED+fh46vEvYrtiLAPZcq3AAJ4QniOYcMQa72nJKL
 6JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304822; x=1699909622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wu2vspcA+XycWJuL7j1AuiRXWi8+EU83MGQfKFvmtAg=;
 b=wXvcNq/Ap5XGla02pvkRyLeZByxeHYyR786cDjsdGRxBHmklNgY1KNTiddBiF1xy6F
 q1o0WxyCiVovmOInxHahsiQ4BqgylYauvswhb3HB5Yf/fMG3UVRr5lPVOFIcjT7JsPZl
 87QFFc72+zPFzW6QYiY3GAGBOHRnU2hZSkuUE5RWVm7TBc7g7rwZi/VAavl6M4O609nG
 1IKZHbBEOSdetJjDa7zG52DlZFK5ZugMkgzZky7+vEGxyOcTUsYAZUDeNZoRBpOx2iMW
 vb0aAQskRmXY5usg9r8lOlxSqdDfjkPrULe87UDXfsyzQNEz3pN63UNb7tpoA7OrbOJ3
 rv9w==
X-Gm-Message-State: AOJu0Yw3gXa2kk8tRd/TFIMk6/uRGJfW40M8oIAaJOEASJpyT16pV5GT
 zZ1aA6xEAlN2iIe+8rf7dDOZsEH6qZmWUogfmiI=
X-Google-Smtp-Source: AGHT+IGg4+KIHvfBKPPJNLMj/MgVnsh9nyD4TGKHVGW11KBZw9oCP9f5tdbD8tAcNW5/48KLSlihAQ==
X-Received: by 2002:a50:9356:0:b0:543:55f4:58ce with SMTP id
 n22-20020a509356000000b0054355f458cemr16434125eda.13.1699304822702; 
 Mon, 06 Nov 2023 13:07:02 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 m30-20020a50d7de000000b00542d3e470f9sm4837923edj.10.2023.11.06.13.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 13:07:02 -0800 (PST)
Message-ID: <ebefdb55-f83d-4884-91d6-d19ff7ba2836@linaro.org>
Date: Mon, 6 Nov 2023 22:07:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/35] tcg/sparc64: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


