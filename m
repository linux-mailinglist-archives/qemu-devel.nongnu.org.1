Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8DB9390B3
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jul 2024 16:32:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVu4v-0004D2-Ie; Mon, 22 Jul 2024 10:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVu4s-00049y-Hi
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:31:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVu4r-00063T-0h
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:31:50 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so37709075e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721658707; x=1722263507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y2kkm5GxDIm0v0vyBRbrS55jDFAHppYtNPVmtNL1YEc=;
 b=HrYMOD7gu+wJBjwZDTONN+sYhsOu1+NvN4DdwDy+O7DLJH71dPGY705vpwup7QCP9D
 IMQr2JENQyMsN7jVlf5qao2ujdhM/0NAY7L0unicaA+NIvGb/3p2IvndpJLx+o767p9l
 7bs/mQf1SoYoJ75o4KzCgI3gQxUQPAiJ1+eqoWyrEleF/KOTaIQM/vu00lA8YrzH8qbg
 oZpvk3hu3UkD5/K9A+BMmbTB35BPQf8yyiEStogj6ejhR6Qa2tnhm6W3KJLLWyU5QTj7
 G7MWBpwGMCb48ezM09YPC5Gxw1a8TrPDCD09AmTLV7XSSCKL3dmyhYnpYDQ3VQ1IHv8K
 P7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721658707; x=1722263507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y2kkm5GxDIm0v0vyBRbrS55jDFAHppYtNPVmtNL1YEc=;
 b=TzG+9rPUst6W9PY/4AhtJesehCkpz+MEU8kHyvbjZMwaUuMBs+1MpXdi/kFNPm0DWP
 hDCmyA5q3Gnkrs2BhJ0/Fc4qU7KLV3oMgcACGejQXWZzEEUy91VPW3Jg0aVTbXKkZXFe
 tISGTyZzaNgXqCB/RNqfvkRJolveMapD7mg5dAG/BLup4YsBmRiYMeaVlOUA/h/wU9c9
 GnW6cVAE6MSUQAYLNCaKGT6q3LxYHihswePKGq+mXWEgBH/r3QtjGYcz60+Ru7uDTEgL
 Iz55Zf6TO3+AiJprdl3DIQ1lqIK64M5ThwPOokEIeTJCH6VfDBGQPNdzut9PWE6IdGdo
 83NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFjyfhM8uKxozCbhTjEnCs5ZgWqVZRhJMlPVbt8t74D6wdPlfwLeM7Ua+dreJ8p6uMQ8QSBPb/h7vooE+zd0fT/mTgMgo=
X-Gm-Message-State: AOJu0Yy8H93NOOe0zPgyYjpKOvi4/7ECSMFtrx9fuo7uFW3GCgC9ijI7
 f8fVF1ISR8ik2HuqgU76oajKRGL7nE4F1SRipcMQRBRbUWlcbgm8r0OlgwAKLIg=
X-Google-Smtp-Source: AGHT+IHVR74e+Ksnt0el06BPIU89keloWQDT0+NrR90NRV09lmdoJOlq0H5+QqbiQ6dPkVLwFfcXRg==
X-Received: by 2002:a5d:4604:0:b0:368:7282:51d6 with SMTP id
 ffacd0b85a97d-369bae4d54dmr5889900f8f.21.1721658706981; 
 Mon, 22 Jul 2024 07:31:46 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68f789csm132043995e9.6.2024.07.22.07.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 07:31:46 -0700 (PDT)
Message-ID: <29d1c659-fd98-424e-a090-97ae941103c0@linaro.org>
Date: Mon, 22 Jul 2024 16:31:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] chardev: add tracing of socket error conditions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240722131611.2820041-1-berrange@redhat.com>
 <20240722131611.2820041-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722131611.2820041-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 22/7/24 15:16, Daniel P. Berrangé wrote:
> This adds trace points to every error scenario in the chardev socket
> backend that can lead to termination of the connection.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   chardev/char-socket.c | 34 +++++++++++++++++++++-------------
>   chardev/trace-events  | 10 ++++++++++
>   2 files changed, 31 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


