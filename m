Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B57A2DDE
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 06:09:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhMb4-0001Td-Oh; Sat, 16 Sep 2023 00:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhMav-0001No-8r
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 00:07:46 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhMaq-0000Ju-2P
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 00:07:45 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2749b3e682aso1027137a91.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 21:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694837257; x=1695442057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWUb1i0njYqAZ3C9wGle79TpkM6ksIC2UsLiIm0hXpI=;
 b=d+JEBBNCl2X482/8vBDlwCzU9yELwMz9PeGz6imiouw8SyTSXQwB/k5Cu6tHX+xPQ+
 /aRRpnXDsVLs4zd2NIn0yjAadDU9aGzgH2aA93I3kFlH9juKHWisze7ivpUoU65qisUX
 4KU9SiWsRyj5/FYWFkry+UCIryuDH2SEzaaEiOTvki46APXcdgGNmhZpioBK47uq2OhL
 2v8SUQ8cQ1vJ38HEeH0+Ux/I0P/w4KUu2FyBYmb6M0v/1NGL3beJ5vJ34N1EWsqJLPTa
 rZe1g1Zsmp7Ij61Xsa8XAV0jzK+iGVj1Mj/GUrnWfl9mFaKhAeT6dSiQ6Ixsdc5/6Pd1
 mgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694837257; x=1695442057;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BWUb1i0njYqAZ3C9wGle79TpkM6ksIC2UsLiIm0hXpI=;
 b=nSBPLZD1dUvBtapnm3+C026dYxKbaDfnSyL6ktVC+tbtnYg5R6K9e5F0Ri9aeGJq6o
 1JW+Afw4SXL126nRlzisqzwwfN7HNcHIukVqWgfMNzXO4sz6V+I7M22tFwi9YiKzDOtX
 lGM9E+f3tkVjbVE0l17w5ph9oo0ydhGrD3k+Mg48S0F0ICU2C1GgcTmfuuVJEpRJoDCE
 3K1jjz3RX+AobPfT3ZYGypIBREmRYBQw+LHMGoL+IUfNRA2/N1bmQtLvxNPJssK4yCid
 E6XU8v+tauV7opXk2xh3K6hybiTwtXlEp+l0Z2lWeZMz+vqnGdrrwlBsuy9cuosyAI7i
 TNIQ==
X-Gm-Message-State: AOJu0Yw4etxdlrbfvWxMg6dDOBKkFSJ3j+HXP9r4TL30BUtVGEArkSv3
 jorpG+158W9CAUme4oRGqLuLgSf929xOTe+BI50=
X-Google-Smtp-Source: AGHT+IHgnPFQrMapp/PVkWJw4MRKsBgKHBfLOBcQ3A5kF4/MC5sPUGK07eqqQ2mECyvyAI2MN3u31A==
X-Received: by 2002:a17:90b:4b46:b0:267:ffcf:e9e3 with SMTP id
 mi6-20020a17090b4b4600b00267ffcfe9e3mr3172286pjb.46.1694837257276; 
 Fri, 15 Sep 2023 21:07:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 fw11-20020a17090b128b00b0025bd4db25f0sm3683034pjb.53.2023.09.15.21.07.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 21:07:36 -0700 (PDT)
Message-ID: <baa351b1-ac5f-6c14-3ada-e98f559b8fd3@linaro.org>
Date: Fri, 15 Sep 2023 21:07:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 00/39] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230916033011.479144-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/15/23 20:29, Richard Henderson wrote:
> The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:
> 
>    Merge tag 'pull-tpm-2023-09-12-3' ofhttps://github.com/stefanberger/qemu-tpm  into staging (2023-09-13 13:41:57 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230915
> 
> for you to fetch changes up to e0d9f49c143359b4a34cb80737af57228c62a008:
> 
>    accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG (2023-09-15 19:06:29 -0700)
> 
> ----------------------------------------------------------------
> *: Delete checks for old host definitions
> tcg/loongarch64: Generate LSX instructions
> fpu: Add conversions between bfloat16 and [u]int8
> fpu: Handle m68k extended precision denormals properly
> accel/tcg: Improve cputlb i/o organization
> accel/tcg: Simplify tlb_plugin_lookup
> accel/tcg: Remove false-negative halted assertion
> tcg: Add gvec compare with immediate and scalar operand
> tcg/aarch64: Emit BTI insns at jump landing pads

Ho hum.  Disregard this PR please.  I introduced an error applying tcg/loongarch patches.


r~

