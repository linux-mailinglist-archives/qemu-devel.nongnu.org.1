Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5853D81E84A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 17:10:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI9zL-0007aC-Th; Tue, 26 Dec 2023 11:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI9zJ-0007Ze-G8
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:09:01 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI9zH-0006o4-5t
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:09:00 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d560818b8so18212965e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 08:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703606937; x=1704211737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xhRN9bpVtU/5B4fWl6gEalG20DxJGE9CeZ+n3D5gy5w=;
 b=TZFWn5kLVsqWXr7yuppf+x2U3VSM9i/sxD8s/j4guiJ8Qb+hzRgKbVoeEKAuSPgI6f
 tW21uOhui5/g6jRg0adCzCBlUClm8alj9ATrtQ+smmzmTlg8i5DOHf79orMAnXMg5Qve
 oyk2Qp2bWlFGUMcPyVfS1YQofV1Gwi9i+hCebwWTg09ceXRTClwQHRtKMRtFxHfn5kEb
 qtN8tcGSgzJuL9tpDUGYg41BkH7tq598SrzCZcYIRAMlWWTd9Jyx3orRaXR6Km71gE5A
 /lsdjEjkS6SJnHOSJTQhzOrWsBLKrcB5sk7GO/IIf4oEMmp9FVmUuX4VExAxmEzrmcIt
 sXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703606937; x=1704211737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xhRN9bpVtU/5B4fWl6gEalG20DxJGE9CeZ+n3D5gy5w=;
 b=f28sngXMhHuDYKQGFGABvNeMbIqi9Trv6Pjyd0yLTRa0xIi09PTp4Lip9v+gDmwEaE
 Uu74HkBoYhBqi6iLmMcuk2qNcHimvZOHxpLnSqN0x04UJ2Md8yPRAy7wR606qrFFsx++
 dZsXkY2Z+xvLbtI3yQgae4mod/jXXH5CitKVbXvvzUmJx9x/jf+5SuZl6eYMwyYmT0tD
 Y4a1+Ab+S+nSGtgMTFaR3Iv9gllV+oqReA0Bt6kEtxLrXyaFWOMd3ZF7GBwaGlPi9lcn
 FXbSQpNB5bc8v7k+YuwaCIHvpSlVAydRUdxbIUPEuNbAkpgaXsjj+M7XiJJF/HV9wzZ1
 QkXw==
X-Gm-Message-State: AOJu0YwkaiQfWtBGrrRUjEf1galgnJ2jv81djvvC2s7iQaJNkV0NELKc
 XRtUTVB6MlgL4o6pNW2qCjfrUgFysqksSTCT+ZpuKUfpxt4=
X-Google-Smtp-Source: AGHT+IHeeG6F0DnjO2FSKvrXSb4JedbB2rWkVuY60rGDuNotQ7CpBfDKp5GOtntsXu4Dehmg1a7uqg==
X-Received: by 2002:a05:600c:5247:b0:40b:383a:ebc7 with SMTP id
 fc7-20020a05600c524700b0040b383aebc7mr3827876wmb.34.1703606937524; 
 Tue, 26 Dec 2023 08:08:57 -0800 (PST)
Received: from [192.168.88.175] (97.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.97]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm13252712wmq.16.2023.12.26.08.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 08:08:57 -0800 (PST)
Message-ID: <c2c7fcde-6753-48b3-b377-250bac49da08@linaro.org>
Date: Tue, 26 Dec 2023 17:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw: Remove 'exec/exec-all.h' header when unused
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20231212113640.30287-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231212113640.30287-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 12/12/23 12:36, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (4):
>    hw/ppc/spapr_hcall: Remove unused 'exec/exec-all.h' included header
>    hw/misc/mips_itu: Remove unnecessary 'exec/exec-all.h' header
>    hw/s390x/ipl: Remove unused 'exec/exec-all.h' included header
>    target: Restrict 'sysemu/reset.h' to system emulation

Thanks Thomas for also merging these :)

