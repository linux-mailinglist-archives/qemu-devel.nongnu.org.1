Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F47EB144
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 14:56:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ttd-0007os-PQ; Tue, 14 Nov 2023 08:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ttb-0007lG-PU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:56:03 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ttZ-0007Yv-Iw
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:56:02 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so80920141fa.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 05:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699970159; x=1700574959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lvQiIJnm8epdhnB5vkpeRbG5RDMsBlsUOmn/ErmAs3E=;
 b=AKIhvgTh7zf9lKJ3T4tNHpVLs76mnMNN+mmxKyI55onWiu8OJo7lulqByp6wG1nlFy
 d4/tBwsujyxgKt/6TJByPGLG/z4OU1BrSzFacwVUq/emqyJ25hSP7dj1ls+wqV1yNfVr
 gDtjqhoan7WCBPEs7eD/tJcku/qve9t31PIb7xVLWGrWERZdwPz/+gNdpLa0CqGu9aLS
 HO0CRczeYg5bmSl5sFWeWN/hx4voJiNHLtL36bABUu1KpoelRV8BrpkY8O4CRWj89ohs
 U1MrUqlmURA4t2j5Lp5463zT1lAeIkW0/8IXllM5TRHOSVX7Gua4qoW4sr5phHtmJXgE
 OTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699970159; x=1700574959;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lvQiIJnm8epdhnB5vkpeRbG5RDMsBlsUOmn/ErmAs3E=;
 b=IAGr9WmVhko2QenysVoBEcp3Zuq/VuEwarke25fBEiFw1hrnXyeH/unQ3SSz5oHl6H
 jy0uNo2eyNrHNcVD2pMjfXCksIJ9eSAPNhnmkLhc1gzOQXeRdPvE5jNcFvXE/hFdqFX3
 yeUrUoGs6YFtB1Nai0BU8j0ecP08HQh/22Je8I+JVjdScBjC0Z4rjutZEknq+Lae1dB7
 GrXKM+656Cn5yRhBQ0DNExipMG6X/onZZER/hKlK63I0iGTV4YRDQ3d/HCRBKJQYsNlV
 hUxKXRWDMi64+pdOUhPl0iXhqIcTTvrQxOj7Olr31Es7vfkob+LOcmkGvFZGkF0dpRiq
 uJXA==
X-Gm-Message-State: AOJu0Yz29FwpXBd99HcPSzrLVVWm6DKhZm8q999ohdqBSWB9m+svcVt+
 Or3pCWxSLoVkzhXDu3tGSH2bgA==
X-Google-Smtp-Source: AGHT+IHzswkfE7e3I7hDUvm2VdqNG2hFrVp8V7AJ7+73k/8D9WsRzXIdAy+MgUwZ78p+bsfL1MXbEw==
X-Received: by 2002:a2e:8842:0:b0:2c5:47f:8ff7 with SMTP id
 z2-20020a2e8842000000b002c5047f8ff7mr2475960ljj.18.1699970159645; 
 Tue, 14 Nov 2023 05:55:59 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 v14-20020a05600c470e00b0040a47091602sm13749947wmo.31.2023.11.14.05.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 05:55:57 -0800 (PST)
Message-ID: <3b7badd2-931f-47f4-a24e-3f5b9541c06d@linaro.org>
Date: Tue, 14 Nov 2023 14:55:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 07/10] sysemu/xen-mapcache: Check Xen availability
 with CONFIG_XEN_IS_POSSIBLE
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>
References: <20231113152114.47916-1-philmd@linaro.org>
 <20231113152114.47916-8-philmd@linaro.org>
 <9ba10b4a92ac6782d0c581b1e1ee5d5efee44c33.camel@infradead.org>
 <86153cf2-129d-4e1e-8949-786764bdf607@linaro.org>
In-Reply-To: <86153cf2-129d-4e1e-8949-786764bdf607@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Cc'ing Paolo

On 14/11/23 13:25, Philippe Mathieu-Daudé wrote:
> On 13/11/23 20:52, David Woodhouse wrote:
>> On Mon, 2023-11-13 at 16:21 +0100, Philippe Mathieu-Daudé wrote:
>>> "sysemu/xen.h" defines CONFIG_XEN_IS_POSSIBLE as a target-agnostic
>>> version of CONFIG_XEN. Use it in order to use "sysemu/xen-mapcache.h"
>>> in target-agnostic files.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Noting that CONFIG_XEN_IS_POSSIBLE is for Xen accelerator support, and
>> may not be set in all cases when we're hosting Xen-compatible guests,
> 
> As is CONFIG_XEN.

Actually we have:

- host Xen support
   . CONFIG_XEN_BACKEND

- QEMU Xen accelerator
   . CONFIG_XEN

- HW models
   . CONFIG_XEN (old / generic models)
   . CONFIG_XEN_BUS
   . XEN_IGD_PASSTHROUGH (PCI stuff)
   . CONFIG_XEN_EMU (Xen on KVM)

Paolo, David, is that correct?

When can we have CONFIG_XEN without CONFIG_XEN_BACKEND
(and vice-et-versa)?

So for clarity CONFIG_XEN could be split as:
  - CONFIG_ACCEL_XEN
  - CONFIG_XEN_MACHINE_FV (Fully-virtualized)
  - CONFIG_XEN_MACHINE_PV (Para-virtualized)

> Maybe be worth renaming CONFIG_ACCEL_XEN if you think we need
> guest hw specific CONFIG_foo_XEN variables.
> 
>> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> Thanks!


