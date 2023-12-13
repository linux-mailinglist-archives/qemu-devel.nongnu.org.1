Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E253811A57
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:04:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSbj-0005an-HZ; Wed, 13 Dec 2023 12:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDSbb-0005VQ-1d
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:01:07 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDSbY-0006fZ-64
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:01:06 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a1ceae92ab6so956098366b.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 09:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702486859; x=1703091659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nPqK7GrcYmtiH3v3w3JzWW1DxNdjq8IQMp3DUklVk6o=;
 b=X2Q1bdzD1jw296CNXBgF4C3RbKokaN++sVVdh64q32FqjgFBCnoxc7xkVub+bZDeph
 Ycq/9aee+RBKRdeBH8ksK16lN+aWdzcL3PJlc1xgqc0RXBfOjBNqVnGrR+jNnGZd9aqr
 muWdmkgdquawVlfoYGpl33PERitFqHZixcP9EVMUd7Vs5AZdVu4tKfaxD1rVN9iMlKdM
 P9wyAp6g0QS6eGwrUVdlF8qj2Tb98coT+0VLM00FqAOE5pWjXY6aUdK0Xd/EbULX2Os1
 81VXPCPuYOwr6WJ4WtANY6m5YVFZ9neIsj3DyIhOmAl/51LneKsT07rXomg82Jd96UP3
 gk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702486859; x=1703091659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nPqK7GrcYmtiH3v3w3JzWW1DxNdjq8IQMp3DUklVk6o=;
 b=xP4hFkd2NO+Kn/IqiftlXRsba4cIlaENE16uHBD0bJ+DVuCzQnc1G6uTnB2Jzn94vY
 5AFeRJ/eGDUKonxGWPYn57nRJ9APtrn8Tj7eoIfCIUxF/fZR5Woig2v3QnokBHU7CayB
 VDLl17KjmwlZoSnfm1BdCVLxqiSiIjLbFkPRRM7SJhRuepSEeaOW4BLYOcQ+bz5N8jIS
 VvyFpTeBxlA5SnIW2y1x9+I0nq5h65c/MUKeJv55tYxJn7rNY164tTo05N2w3qmPp7z8
 zADB6ot9L4/Nhbau103A695XEU/gPyRCuaejc6yj7SVuMD8Ey5A+iEtEwtdRa7tNIcig
 u7CA==
X-Gm-Message-State: AOJu0YxYdESTc+//zGuXsChQ8bcbsqdQOf0u3mGNrN54CJ5yDRs+nsnH
 KGFXLvi/htoXg2lrDqiyY0aM3bQmFHt7OATo1x/5vg==
X-Google-Smtp-Source: AGHT+IGj0/KfsnmAFEqNG09uIgYWHMOTbaAWPiuoDfWlwAc+xnbcj8ZLgR9m5a7rGgg3UbFVjYS2Og==
X-Received: by 2002:a17:907:20b4:b0:a1d:f19c:ab1e with SMTP id
 pw20-20020a17090720b400b00a1df19cab1emr5069227ejb.100.1702486859552; 
 Wed, 13 Dec 2023 09:00:59 -0800 (PST)
Received: from [192.168.79.175] ([93.23.251.22])
 by smtp.gmail.com with ESMTPSA id
 ty6-20020a170907c70600b00a1d71c57cb1sm8132013ejc.68.2023.12.13.09.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 09:00:59 -0800 (PST)
Message-ID: <0064f684-793e-4954-90cf-d39c21385a43@linaro.org>
Date: Wed, 13 Dec 2023 18:00:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0 0/9] hw/xen: Have ARM targets use common
 xen_memory_listener
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231114163123.74888-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114163123.74888-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

ping?

On 14/11/23 17:31, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> While looking at Xen target-specific code, I noticed some
> generic code used by x86 which is not implemented for ARM.
> 
> Maybe ARM machines don't need it, I don't know. But I
> wanted to see if I can get this common code target agnostic
> and build it once, possibly bringing smth useful to ARM.
> 
> The changes don't break CI testing and Avocado local tests.
> If this xen_memory_listener feature isn't required for ARM,
> I'll send follow up patch that keep this series with common
> xen_memory_listener but with a runtime flag to disable.
> 
> Patches do the usual "change target-specific API to a
> target-agnostic one", in particular using "exec/target_page.h"
> at runtime. Then non-x86 code is extracted, then merged to
> the generic xen/xen-hvm-common.c.
> 
> Thoughts?
> 
> Regards,
> 
> Phil.
> 
> Based-on: <20231114143816.71079-1-philmd@linaro.org>


