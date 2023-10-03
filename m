Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0997B7336
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 23:19:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmnX-0000UA-NT; Tue, 03 Oct 2023 17:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnmnV-0000TD-AN
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:19:17 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnmnT-0002zq-S9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:19:17 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-278f0f565e2so1027283a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696367954; x=1696972754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uqxCT41hNwR5lc5LjBcEjFOED6bjk1Q4MnnczZx6+dM=;
 b=dTIED00QrrnaLjpTJkpVRiD+B1IIqpnR5u7xB6v32XDAVriinC2zkU/wDFAd3TcInu
 aqMudLNX2G+UCIV6ABMhCPio+/Sf+SZy02NVfbN1X4piBYgZY9iVZeXNLA9umJOMy0lg
 Yon9sYcyj7lJatWufL1aikxPZexbReUSov1jHvTREeLK9ws1clmrdOWzGp7O/jsGQKxc
 2VsfNpXaFrYuzGCQfUI0nY8ikCwnp//X8vEeXfsLu2NVWwTGu2oA0oFwT8yip46nlK6O
 j6Mq7TQcNOyFCVyVc5qjsPuGZ2XCZoF8eNeLfqnzvXKo2JyXg6SYhDRD9ecO4wW9misT
 +Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696367954; x=1696972754;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uqxCT41hNwR5lc5LjBcEjFOED6bjk1Q4MnnczZx6+dM=;
 b=gHyQXTE4tcyOYjAzIzG81su8FD4GPBGTcIzO971ynpqlNBs1OqLVb0hx/t3e22moGi
 /PLP/rNhsfqdpzm+Mzg0+CWW9vy/aauWFcYSUzUPNsCHGB9vc6BNLm8vS8Xste7MTVCP
 ZdbuTt40YUwCOtEADoTTQZAKU+jGRIhdnty1avT25D6jyKEyaN0t0miT7hLMAGjyfCbF
 xh1Zm2Ek95QnQFtWDv80XZ67W5UxWLAnLQaks29V+V+hKpvC3eM2Au8P/RFpsezM/Jp4
 zDLZ9nnAia3LCg7ibmI3hr4LJGR6trc42GT0/RbVimWAOiG66kroixa6+EDHN4y+E/OI
 k2Hg==
X-Gm-Message-State: AOJu0Yz8g/sP7PJz/U6EXuOpg/UlhXjv+b3OZ7oOj6Jc7nanWzexpEUc
 lsn8ICHNuvhlGI6e8N1zxhS6KylQXmefoOvaHPo=
X-Google-Smtp-Source: AGHT+IEIOJM6xfeTJITX1doU/fa/prR9jOJy0iqpR2URXdo7LUahKT/1PsNp1i9UQDZ7F2w5uRo2fg==
X-Received: by 2002:a17:90b:1b50:b0:274:8041:94c with SMTP id
 nv16-20020a17090b1b5000b002748041094cmr533084pjb.13.1696367954381; 
 Tue, 03 Oct 2023 14:19:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a17090a6ac700b0027768125e24sm28301pjm.39.2023.10.03.14.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 14:19:13 -0700 (PDT)
Message-ID: <1e60c1c2-6b35-27ed-31c0-afbcbc9c7ade@linaro.org>
Date: Tue, 3 Oct 2023 14:19:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/m68k: Map FPU exceptions to FPSR register
Content-Language: en-US
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230803035231.429697-1-keithp@keithp.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803035231.429697-1-keithp@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 8/2/23 20:52, Keith Packard via wrote:
> Add helpers for reading/writing the 68881 FPSR register so that
> changes in floating point exception state can be seen by the
> application.
> 
> Call these helpers in pre_load/post_load hooks to synchronize
> exception state.
> 
> Signed-off-by: Keith Packard<keithp@keithp.com>
> ---
>   target/m68k/cpu.c        | 12 +++++++
>   target/m68k/cpu.h        |  2 ++
>   target/m68k/fpu_helper.c | 72 ++++++++++++++++++++++++++++++++++++++++
>   target/m68k/helper.c     |  4 +--
>   target/m68k/helper.h     |  2 ++
>   target/m68k/translate.c  |  4 +--
>   6 files changed, 92 insertions(+), 4 deletions(-)

Queued to m68k-next.

r~

