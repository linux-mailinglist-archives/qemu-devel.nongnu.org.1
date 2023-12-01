Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E7800D4D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:36:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r94d0-00068Z-5j; Fri, 01 Dec 2023 09:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r94cx-000689-VH
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:36:23 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r94cw-0004lb-ES
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:36:23 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50bc743c7f7so3005784e87.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 06:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701441380; x=1702046180; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXajICOthQ95e/+C/IgN3VDMYOEP80+U2tso7/fomSQ=;
 b=WDOcJntKz1chhZPF5JY0JgZObAvbLxUkQmxdVCW/Qc07eg7i5usyMUq7jtKl01LlkZ
 iJ8hz2V0JWnMtheYymg74QY7u99rNONEgOUyc8JfARiG0o0GrmdnSg0EbKHJNq47Z7AH
 8NBX9DIqH0yMeyJQePmlfu9BuipV90Ipi6jyDDBlMfkKwvzUf0UGQR0pf8I60253P1DO
 yj50Wjk50pt+b/4QhylzOdxcDhjKFS+NMLcKTQuvMjG8dW4ALQof71qZyu5c7l8JFVGL
 MVjCu646xxgEr4Mtu4PLaTOdyIsBO0aYDCKA1jbFuWX2m/nDESPwrnXiY4p5vyQaS3+c
 kWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701441380; x=1702046180;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HXajICOthQ95e/+C/IgN3VDMYOEP80+U2tso7/fomSQ=;
 b=O1ElGMnglsVEzuBpyddosJNa46wzjjsEkm6y6Nm0SV9Evck08o2H75G9uspC6XfJdf
 T7FtjNhA12afqQa7IueuWCSBprycDj+HrTsZJfyV/hJ/zU9+XypcExvi/aeuJu2amlbi
 Eauzw+yO4lFeqYT7usUpbCPsHq9Dc31ZgKCFAj4nrAtU5Y1NaBBe8IfjQKc99I/q0Nzf
 mEUKxvCqbPjKJNX9CFUPUFcH03UGoPpEjMJ+QrgYPV1yYOPE7PASEXclikJnTXeY3KVo
 oLFww8RePKEh1hIBbgI8shTlUzB0nnEs9RufWxhrkrbZ+6afRWfuh8ol3w73nsguisj0
 J9MA==
X-Gm-Message-State: AOJu0YxFnVxbhdAyjVrf9LkhTVqWrZYIop1tRvrPe0fcasXtvdi2eR3e
 QwWf+ZoHntswBVFEgQBG9JQ30A==
X-Google-Smtp-Source: AGHT+IH0iRS9kDB2jKbm7NtHDnULQ3NSMwtCm1BTyFFbEu7vd6la4FT+955/VPnk503ufY6kMOKvKw==
X-Received: by 2002:a05:6512:696:b0:50b:d764:64cf with SMTP id
 t22-20020a056512069600b0050bd76464cfmr1083640lfe.132.1701441380637; 
 Fri, 01 Dec 2023 06:36:20 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a5d5101000000b003333521a1cesm341747wrt.57.2023.12.01.06.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 06:36:20 -0800 (PST)
Message-ID: <2ee26bcc-6f0c-4a83-a25b-4a1609466a04@linaro.org>
Date: Fri, 1 Dec 2023 15:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: accel/tcg: Define TCG_GUEST_DEFAULT_MO in cpu-param.h?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

Hi,

Trying to restrict "cpu.h" to target-specific code,
any objection to define TCG_GUEST_DEFAULT_MO (used in
accel/tcg/) in cpu-param.h?

Thanks,

Phil.

