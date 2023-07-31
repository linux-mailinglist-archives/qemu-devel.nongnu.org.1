Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1EE7691AE
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPAz-0001Nm-KP; Mon, 31 Jul 2023 05:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQPAx-0001I9-No
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:26:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQPAw-00059V-4e
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:26:51 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so4469844f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 02:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690795607; x=1691400407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QcokSva5XBIUJvFuoYic//9RhXnd1IMXeZz0DskXf2o=;
 b=skr3xsPAtFgyp8EibE4fMORVzl932jJkxr3GKgquqBknh8VJFRhZYfltZGVkRuuAyk
 401Ei6YNbw1B2nqyNupAMw3zoQQZP4pHFD3e8CZmLdgtOqLumy00toeAZ4LwXA8ehAZi
 bbf7C0sbRGmtyvnn6C1uY2Gq9vxu8F9Pxu/xQU3aAKNOtqxFRZfhotKK2ykKUFf3QhGV
 rKqVl+lm1wXH/lI6AcgZORO8om08wKdnEz6P+yGcUnEJ2StCRpDAK+sCwi4LI7XjtWHK
 K6nLQd6jXVbdmpLM7SWDQz6jDutSEJHdMnycCCQ4LwE7PLANql8o+xPksuA6Fmt2Ke70
 X++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690795607; x=1691400407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QcokSva5XBIUJvFuoYic//9RhXnd1IMXeZz0DskXf2o=;
 b=Qo9caXM5OqMvN9q3xAhAgtDt/uvRmzFKyGZeKpjEQDrnZ3kk0vMydF8Sb9FPO3s4Mf
 sJSe2WUDMla0asNTcG4KYcUMrZheR2x48OkQLvHBuDUC4zlT0z/mV2NYSOw0uoquEcl7
 sX7lRP4Dlsk1raE/I02Dl8Hq1pi80tjU0ottxtu4oYWAv73mtWMnfTb3OcMpPumu/t9o
 pyrrBbcJRa9j1X1Pz/+vJ6RFrm/7udNLNYAI0LgQQ+0R03GoQ0RQB2pOihA9l6LGXv1+
 Q5NNJ7WweePCD1hoTKNQnZMnIQzGUFNYl+L6x+ylUxZarnJkjzqXbPJlFY5a9HbAo1Jl
 dJiA==
X-Gm-Message-State: ABy/qLZLw5nW/FgMK07b95OxF+S17l08X+SzN3T9KTVh6zamHKSAglms
 kHZaEhPH9GS5XrLyDbScw4yXeA==
X-Google-Smtp-Source: APBJJlFigW2YxmubZCdI8pdFbJcFUAr2MisrQEFA+8nLzFZvBYZS05GHy+ujghTzyWKLYJGAO+fSvA==
X-Received: by 2002:a5d:4c43:0:b0:314:3740:7f69 with SMTP id
 n3-20020a5d4c43000000b0031437407f69mr8829791wrt.37.1690795607620; 
 Mon, 31 Jul 2023 02:26:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.143.207])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a5d55d1000000b003143be36d99sm12474291wrw.58.2023.07.31.02.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 02:26:47 -0700 (PDT)
Message-ID: <acab2aed-93ca-7c57-5018-16118572018c@linaro.org>
Date: Mon, 31 Jul 2023 11:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Content-Language: en-US
To: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: John Reiser <jreiser@bitwagon.com>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
References: <ZMLfYE3fYCUhnaEE@p100>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZMLfYE3fYCUhnaEE@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 27/7/23 23:19, Helge Deller wrote:
> Words are stored in big endian in the guest memory for armeb.
> 
> Commit 7f4f0d9ea870 ("linux-user/arm: Implement __kernel_cmpxchg with
> host atomics") switched to use qatomic_cmpxchg() to swap a word with the
> memory content, but missed to endianess-swap the oldval and newval
> values when emulating an armeb CPU.
> 
> The bug can be verified with qemu >= v7.2 on any little-endian host,
> when starting the armeb binary of the upx program, which just hangs
> without this patch.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
> Reported-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
> Reported-by: John Reiser <jreiser@BitWagon.com>
> Closes: https://github.com/upx/upx/issues/687

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



