Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9F782B6D6
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 22:50:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO2vl-0005Ne-Ky; Thu, 11 Jan 2024 16:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO2vj-0005NQ-Ag
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:49:39 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO2vh-0005lw-NH
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:49:39 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d9bee259c5so3711548b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 13:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705009776; x=1705614576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=idYtcl5uMru5KIsGjXAoVCTWEokucfM0G587d24SRnc=;
 b=FVf3dW7XpIRo+iLVgFZXZRJ1BK9+BoN6KTDNurg7hyyqUTFse1G4nGAn2un2B0yauK
 HD5AdpSwZ+DqEGpsK2id2yw7RRx8JnQDkG/HFO6CHtPt6iuiNVzj254unrNrgyPRQOBF
 54HO0eBphaZDHvCBhBGqa4JHcEWJLUDx9NA1l0GEySOf+QAj1B1UkuB2DSsryR9MwLRh
 gTT2Me7XCq5mrhBHVLce8eCt42afLYPoRdNHlg4G6kUjTH2vKSVV4fzD/dPT/a4KxggS
 dEs7WrzlBulTdP0B5h0nlnb+0r93Y48jp2oBsvgzq0jZRuXAkvE6HLJKELeEGYNkwEw+
 G35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705009776; x=1705614576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=idYtcl5uMru5KIsGjXAoVCTWEokucfM0G587d24SRnc=;
 b=YpdA7NpnSi0jKhUbEVbG8vMG2SDTQiO8AVbfts7NzZT4ucDpIYQ5WTqzAkDEkaDpHS
 0V3W6Bzzgb9wmjSr05NtVLbVhjJuPxLkLLbhkPAUiNTpN6Vz3cVtKTwjln2kZlW9R9mp
 z2w82Be1ONnnstB7qZcWDOmDwxD3f5BMtFUudE4B1iyz5TILDqGmiY2KiwY5ii9WSKlP
 KwEZ6Q8eMAG/p72jOg7vfh9H7VctoFoIemliBSi2NLi7jxFTt+9AGLQzlLFHBeDrwQXn
 CagfvaCobqsighC6kCzpr4Uvzu/4rfQRAxv7cM+79Jqs9ny2ZfPcykv2lqXse+C1dxWa
 XwKQ==
X-Gm-Message-State: AOJu0YxNbnvM/YD48rxVL1ltT2uERJtw8Ll9/fdJNd2FAlBETjhoa5Vw
 LNdXnx5fqgasn+SwK+uyKXjp9vxH6B0TVg==
X-Google-Smtp-Source: AGHT+IEPmdH1zHMBJoxS+yO/nUdKaOn4QGCmlqKVAStKOCBO78Hftogl+/3NpyB1zE0iPvHzptM2BQ==
X-Received: by 2002:a05:6a20:1994:b0:19a:2830:146d with SMTP id
 bz20-20020a056a20199400b0019a2830146dmr14287pzb.85.1705009776038; 
 Thu, 11 Jan 2024 13:49:36 -0800 (PST)
Received: from [192.168.5.64] (ericne.lnk.telstra.net. [203.45.18.161])
 by smtp.gmail.com with ESMTPSA id
 oh15-20020a17090b3a4f00b0028c1a5aafe5sm4336284pjb.14.2024.01.11.13.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 13:49:35 -0800 (PST)
Message-ID: <15efba7d-c308-43ac-a036-2dd00ba26422@linaro.org>
Date: Fri, 12 Jan 2024 08:49:32 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/watchpoint: Move TCG specific code to accel/tcg/
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240111162032.43378-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111162032.43378-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/12/24 03:20, Philippe Mathieu-Daudé wrote:
> Keep system/watchpoint.c accelerator-agnostic by moving
> TCG specific code to accel/tcg/watchpoint.c. Update meson.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/watchpoint.c | 143 +++++++++++++++++++++++++++++++++++++++++
>   system/watchpoint.c    | 124 -----------------------------------
>   accel/tcg/meson.build  |   1 +
>   3 files changed, 144 insertions(+), 124 deletions(-)
>   create mode 100644 accel/tcg/watchpoint.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

