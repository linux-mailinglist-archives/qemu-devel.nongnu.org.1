Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E5C7D435C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:40:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4WP-00071F-Gf; Mon, 23 Oct 2023 19:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4WN-00070m-Io
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:39:43 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4WL-0001St-PN
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:39:43 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso2811695b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698104380; x=1698709180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mMpbBWEX62vCyk7L63TLZNNr0gAj0FuvKX/cwItcFiU=;
 b=qsnn2Y7p7Ynqp+Z5sa1l+8nCjHACIRwJX/tzXEsAPHVNs7dJA9NJkKZRZRGWyHkEfO
 l0GyZ9Kv2PGciRgakpnTjztJcKrHUazaSa5dee2MS0tVw4sSPP12JgJDkagJQ6Oa5zyK
 FeCCU/UCgsLd7utg1s/K6fyDV2NJewsjwAtxubvyaDWTN6qDv9LG2H3SCluvyYtwKBDN
 4IdZIN3uK1UmUTplgXJHzQ9Gg+ImvA86ld025+4sDIOB2bUqD57ZOsBObK3V+rBXnE5F
 K1J/Nh9mxUkS+iyMHxz8CqyLnCimh/G2AuIfRLkKU9kN83WleNdD11bezhoyQ+49qfi+
 7mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698104380; x=1698709180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mMpbBWEX62vCyk7L63TLZNNr0gAj0FuvKX/cwItcFiU=;
 b=qRM8dOh6WTsQ8DyTBbg1Usbr6B/dsEousLs7c+PUE74QDfr1LfXxHRYimkftfjmlt2
 6DCRc8xHHrhsq3ONXrogGAcvpfKIP1G9iTDOBuG1RAv4VwETDxBDX5GTx2W97HxF+w9A
 T0QtzkltOQf5Ov+BUBlNimyThZvtCURDlVyGNnH3//p48vfxCFHi6AlNJFmZlLUbuai9
 RRlvEyhBRuMy/wQDp62dMXQNvOlXT8WZhQ0IVa2x6SXELwSxvAB4gl9o+kjYmNGjZCd+
 O/KiOkWVJU/87+kRMZfmhZpBbNoIScDvAv5SBmrBSXBzSGhJMvBPrxQrCET8UcCCWQ9X
 TbHw==
X-Gm-Message-State: AOJu0Yy1j/EPO6qJotJtyPmbP9Adg4d/Sw6ie9YLXkNsYWHOqvO9vWtY
 /4xpb68V8htzxxd1sQ9DqSn7Y+5IYFM/V7miPd0=
X-Google-Smtp-Source: AGHT+IFmCg7zXeltceQ5P1hwBJM/eusx5ZMdwBD44MsIsyned9OJ8EWrnFoWx/ZnQdVsyICZjn6goA==
X-Received: by 2002:aa7:8c56:0:b0:6bf:239b:e841 with SMTP id
 e22-20020aa78c56000000b006bf239be841mr14239256pfd.0.1698104380529; 
 Mon, 23 Oct 2023 16:39:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 p26-20020aa79e9a000000b006bfb8a34c64sm1711555pfq.88.2023.10.23.16.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 16:39:40 -0700 (PDT)
Message-ID: <f905c215-2c93-4a44-8aed-2688bf8a2f26@linaro.org>
Date: Mon, 23 Oct 2023 16:39:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/mips: Use tcg_gen_extract_i32
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023160944.10692-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/translate.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

