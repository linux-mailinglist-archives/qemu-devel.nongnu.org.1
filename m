Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C180EC4C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:42:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD24r-0008Ab-CZ; Tue, 12 Dec 2023 07:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD24Y-00087u-58
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:41:16 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD24U-00031A-6n
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:41:13 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50be3611794so6617840e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384866; x=1702989666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wlgXh/5dlxWKpmOVvCZZMz1542zi7cOXE65xucIWQf0=;
 b=r9+W11g0DJ3MW9ARrtuJXSwhIRTB4OjRs5RTCbAtcwyRIMhYFFPhHRXpt/Ou0pU99l
 MF2Oy3PxgkAwNOP5E0XYLGjL9XPdHSmE7AP+bCdY0BU//+KB8GYvA6SdKb0WVpUJQbSV
 nOPTDABroLuey8fMivhTeDZv+fj/7Pg5MbEz4GKrnPg5uXsQkK+Qm4WAxFVsNmASr9kW
 P0z3iX+kWq+Pc067EqByWvN5fidaBy4c4kIpJ4XzWiWgmXGedLYtImDSSYVX360m6eYa
 myD4S2r7eJd8Ua6fplZFAeh9JMoQrng9miOMLB6QC26mGO01JdeYXdLgJ3cTA0d5AKyj
 oxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384866; x=1702989666;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wlgXh/5dlxWKpmOVvCZZMz1542zi7cOXE65xucIWQf0=;
 b=abn7tsUwFaDWCbZ76CsHigEpW7qDVsMFKEJdEm0rT9XEDhn3blpPzhRov4Sn9T6Vx1
 N/gJQesOCW/yAz5XCTByrUBtR1GKbWc4B+CnZSy1juljpf/Ex3MmucgGRq7ES0g1YFQS
 xCi/iyLx7vbXA/VgBqRYQ1MBK+p5bG4xb3srbZt/O/NZ/I0uYLVgS4sw59K27sV93z33
 3I4quevvt/Vbcdzlem+QMIXwgC1P/PV+Kq05vbGIEJVZVDQEZ4GmfVbnAD0tZjPXJS2m
 YHpPJoanpk38CWfttJoDOeI68hi6L942lXxpOS4o9pwvsfgusSkR/HEAj/af/T4mwXnX
 77CQ==
X-Gm-Message-State: AOJu0YzSxIRggttuGFlL4NNffT82eh05TbJCBoFUh2djRF26ug7uxs+h
 zrdP4+VaTPi9+4Cowc0u+N5j4GuZ5wSFGZ+QLbqp8Q==
X-Google-Smtp-Source: AGHT+IGVuKKXcOO5S+DYtylVPRV5Au95HHz+ZdrDNYIwMVahDpFTAQUfBoVTS6/f2pOnkEIlPeigJw==
X-Received: by 2002:a05:6512:1595:b0:50b:f78a:37c8 with SMTP id
 bp21-20020a056512159500b0050bf78a37c8mr3971601lfb.95.1702384866233; 
 Tue, 12 Dec 2023 04:41:06 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 ts7-20020a170907c5c700b00a1b65cd1957sm6228907ejc.107.2023.12.12.04.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 04:41:05 -0800 (PST)
Message-ID: <45ce89e2-6dc1-4064-adb0-5c88e5ac78b3@linaro.org>
Date: Tue, 12 Dec 2023 13:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] exec: Rework of various headers (user focused)
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>
References: <20231212123401.37493-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/12/23 13:33, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (23):

>    exec/cpu-all: Remove unused tswapls() definitions
>    exec: Move [b]tswapl() declarations to 'exec/user/tswap-target.h'
>    target/ppc/excp_helper: Avoid 'abi_ptr' in system emulation
>    accel/tcg: Un-inline retaddr helpers to 'user-retaddr.h'
>    exec/user: Do not include 'cpu.h' in 'abitypes.h'
>    exec: Declare abi_ptr type in its own 'abi_ptr.h' header
>    exec/cpu-all: Restrict inclusion of 'exec/user/guest-base.h'

>   include/exec/user/abitypes.h                  |  8 ++-
>   include/exec/user/guest-base.h                |  6 ++
>   include/exec/user/tswap-target.h              | 22 +++++++

Missing:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 695e0bd34f..1341862c2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3615,6 +3615,7 @@ Overall usermode emulation
  M: Riku Voipio <riku.voipio@iki.fi>
  S: Maintained
  F: accel/tcg/user-exec*.c
+F: include/exec/user/
  F: include/user/
  F: common-user/
---

(Although maybe the M: tag need some update)

