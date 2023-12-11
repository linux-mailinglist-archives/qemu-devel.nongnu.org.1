Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B302380D48F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:51:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkQV-00026d-0j; Mon, 11 Dec 2023 12:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCkQQ-00024f-Vk
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:50:39 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCkQO-0000Kv-Je
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:50:38 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d0a5422c80so41618495ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702317034; x=1702921834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T/w/gYfM24jsW7uyl/C9y7UNIg63MGgUtupns0AzkfA=;
 b=ZJDRlWse/cRBeNlVLZ0TnecojQwqnepsfKnZ/M92PRyNm4fUcglRbqwnOEAf+71ekD
 boVmb3zPP1j8RqB+BqVp/ZF9v97Kj8fCTbvbbAmkQW08kDScduxr1IGsUc8MuE4XJOMC
 ojv/lOMQvZuStWFZ11uA//fJaQPVdNewCXO9XKl9qu82Df6rWSLutI8IkjUJJlVrjB4h
 D70hYUsqPm7LN0F4gcUaIwPJIY5zoI6lZKqlGH58nMJOi1Hhy95mTkI6HpsDbqkXRMC3
 mLwfJ5wYJv1zXF1vZJVaGHggUOjKF/QolB6V7F/4b9knPmnaMKH8LZ6D7Pd6Wqjs8HiZ
 SjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317034; x=1702921834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T/w/gYfM24jsW7uyl/C9y7UNIg63MGgUtupns0AzkfA=;
 b=ZnAPTftBgCi8V78+pUypgViCCLeNgUNtgryfGwfcVwwa1xdR2npoXpqxsST+nfG/CR
 hBgNNk5r5NA2QQGbpGnp6+82xfpu0XDWcINieU+hh50/hvHlHvKJISGTtYwwOckJAQ+w
 XkLVvoiQtPCGCE42mS58PQ5tRZDbFMDL3i+qiws9skpehO2kzvit3kmV00d5On8sQPGt
 kUVo1X2oFF8jtalDdxU32nzPSGrxKTgLhDKxryvowyGktIrDLi5SvW86VI9tNCch//p9
 UsVhaPypsf6ybWds3de2bdLrA7rdR/xzhFtM0H0u1aj8juj1qY/Rx13LumRG0nSMB5VE
 +gPw==
X-Gm-Message-State: AOJu0YwwT7dCNBWmqcH8P8vXrlCLmkfL6ixvLkum5Nb4ctMW9+rN6Frg
 oRye8foIKDijnE28Ja3pahzTvg==
X-Google-Smtp-Source: AGHT+IH0yP4f0t4AIB069eTw/fbMsYk7kqc3pdpfg04iJozwcaD1qUBkXtrcVg/TRop1nLBcxq5G/w==
X-Received: by 2002:a17:902:eccf:b0:1cf:a70f:3a2d with SMTP id
 a15-20020a170902eccf00b001cfa70f3a2dmr5578288plh.63.1702317034101; 
 Mon, 11 Dec 2023 09:50:34 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 bi1-20020a170902bf0100b001cf594f71f3sm6903692plb.157.2023.12.11.09.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 09:50:33 -0800 (PST)
Message-ID: <fe5de826-85e3-4d24-8ee5-40d0e992c1ef@linaro.org>
Date: Mon, 11 Dec 2023 09:50:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] accel/tcg: add trace_tlb_resize trace point
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
 <20231211091346.14616-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211091346.14616-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/11/23 01:13, Alex Bennée wrote:
> I wondered if the discrepancy I was seeing in fill patterns was due to
> some sort of non-deterministic resize being triggered. In theory we
> could resize away at any point which might account for the difference.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   accel/tcg/cputlb.c     | 2 ++
>   accel/tcg/trace-events | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

