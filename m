Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC362829388
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 07:02:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNReh-0001V2-GM; Wed, 10 Jan 2024 01:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNRef-0001UJ-5T
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 01:01:33 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNRed-0006Rm-27
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 01:01:32 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-59879d7a655so777448eaf.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 22:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704866489; x=1705471289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bZLy7w4sWwr0LxjC+kOBmf3dPDrUlHrMBo1D7eYdnS0=;
 b=Up+j+ZBQ/PbEzTXvIwEDSAPe9VuMVt8/xvZjWr6+ryRtBfazEVcgCiNGa2ZwVLdemW
 nw0RtOtcr/yeGkPKQnapYBhvJMnBWXE3EaE9wcCzRra19xwAax0T+JDsl+1Gwa/+QtTt
 gDhgCl/FQZDPaCeJrPDOCTgP6ajp/3a2XwhVoWjqcz7eO290OLJW8t4PK1/xLgKhP9yD
 si6lKfIEhUaRXGec2C4KglltbbydWgKY42OPC6nwy0ga2V1Q1xddxgHB7vPsUqKPMwKf
 USlIC9RSw02sCgXaHtCckTXtxcgyAwMwbk2/0JFPzgIOcVA95Ko46PMK1VZUx3C0SXR8
 18Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704866489; x=1705471289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bZLy7w4sWwr0LxjC+kOBmf3dPDrUlHrMBo1D7eYdnS0=;
 b=pYMoJ5iCvvdnlfBX/BXfNfR1Jo7hEbiiG4Dv6Q6AXxvU0sqJaDnpuTXBEUJ8ybtQYy
 bFa2kbagjN1/KPayrErW4WFcbTf36edPSQVVSNXphWE06m+hLE1ODDAZKftyk07Tsyvj
 YMbP7HxxAgfkxKiGkYpDDL4Qip7Bhchgsb7yUDyib5JXHuamCjdLrsj6tnltQeF2SFQb
 SvNCvW8iZXXVKTXhoPYZWniG02x3IaRxciyJOZDUXAk+OY2pYgGAmQ3W6m0EaNmoB6Ba
 AOajUnWENqWl3Q/OOHKYjcMEoh/6DpCbL18VX+I6KSMgQ4bPdSCq8p/WnZbgcuMQZJ1b
 9cNQ==
X-Gm-Message-State: AOJu0Yy6RQ72FjV/nr7JZDVu20sZYNpFkpu0/sB54sBK8DWiJHl5U63l
 bqJtuj/v5i8a7tdywCudO45KvSY+9VAwhg==
X-Google-Smtp-Source: AGHT+IF/Ox5d1Zv5hnwlyiCKIflahIBNF663KuWxW22l+73YDArqiEI5TYp0+AOV5uSjzTqo+IOUMg==
X-Received: by 2002:a05:6358:338c:b0:170:c91a:b466 with SMTP id
 i12-20020a056358338c00b00170c91ab466mr541667rwd.23.1704866488934; 
 Tue, 09 Jan 2024 22:01:28 -0800 (PST)
Received: from [192.168.40.227] (ip-38-9-1-25.internet.url.net.au. [38.9.1.25])
 by smtp.gmail.com with ESMTPSA id
 s9-20020aa78d49000000b006d9b2d86bcasm2648982pfe.46.2024.01.09.22.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 22:01:28 -0800 (PST)
Message-ID: <50340773-f466-46a1-9c8a-93640cef7dd8@linaro.org>
Date: Wed, 10 Jan 2024 16:47:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] linux-user: Allow gdbstub to ignore page protection
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20240109230808.583012-1-iii@linux.ibm.com>
 <20240109230808.583012-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240109230808.583012-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 1/10/24 10:05, Ilya Leoshkevich wrote:
> gdbserver ignores page protection by virtue of using /proc/$pid/mem.
> Teach qemu gdbstub to do this too. This will not work if /proc is not
> mounted; accept this limitation.
> 
> One alternative is to temporarily grant the missing PROT_* bit, but
> this is inherently racy. Another alternative is self-debugging with
> ptrace(POKE), which will break if QEMU itself is being debugged - a
> much more severe limitation.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

