Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C670B82C309
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:48:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJlW-0007tc-OM; Fri, 12 Jan 2024 10:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rOJlJ-0007oo-TV
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:48:02 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rOJlD-00071Z-14
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:48:01 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a28b0207c1dso529445366b.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 07:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705074465; x=1705679265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FdgqvXX8UJ2qxsZ0TsBE2PbbJ01x0G5eEDgaM+18vfo=;
 b=hQfpJ0cvlT7c0L6VxRdMFtBFF/mZJ1enqARp/5Y640ssGeHYCQJno1ljcbuj4jsZKW
 Owt3GN++5Sv2imc+dfP7M047nbE4uZciRpZMdFWCGSdlCQzuTLaX19eiWFINbRE40JS4
 4Ew7beJkslMyv+rIc3KRbGIvlFN41hnidi/cqrxUbJpIo6xDyuYkiSA3RAT0+jdcLXP3
 KPAQYUgZ6+lzKALE8hlgjKsLqQk+vAQ9GXHdXXkoelEXCXzmmqtXKMAZxqw8gbqPxcDH
 Bh5x8aiN3f0Tu+o2LetMtO74miawZtg2wMz5/eHYc1uRkSgltKD7+/gqqQaZPqqbAjUE
 NI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705074465; x=1705679265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FdgqvXX8UJ2qxsZ0TsBE2PbbJ01x0G5eEDgaM+18vfo=;
 b=QY3TMnf6lbHpF9lP3F0otQQowvcK2PFVwoOndVv0/4hSeG9KrTJWz7ZxUKkHdCwgUe
 wk9DqT37ioVS8ioXfhdYiWf3E7Xp4lgjj3O1NOapmE/056P9/mQHt4joelEK2m0OeAIU
 LWBV/ZcqBBo/BhClPVTeYi0ssPQ0b9PNxhRZeZIu9swCRCs3vBlvSjFSSG6kcc0TLRB3
 74ssAiBYYc0RgGUzpBuGVq8XXd7QR1VhCvXYe7MgKIf6t7QmFYJ8Z1xrR0RpC2iSW2tQ
 JPsm5SG0UrBnfxIVLkiGPx8iXty8GgLPMaMpM/O/bcxWgaBWXTcLPLhsvZCwVSAV4cq+
 pcBQ==
X-Gm-Message-State: AOJu0YwAdj0yAChaix8NE8jx4iGjuTVStbD20M3pLF71mma8mM8jUQDv
 xq0G73gxi/sbGDKgi45rU4JqJWqDRN54gA==
X-Google-Smtp-Source: AGHT+IE4TfeIP/s8oXLntc7qq/ssuOTmrVIAX9ZJkyksz5U2xZ7RL5Kei1FT26mMtk+PV01S5P5Ksw==
X-Received: by 2002:a17:906:274a:b0:a2c:6bea:58a8 with SMTP id
 a10-20020a170906274a00b00a2c6bea58a8mr917134ejd.37.1705074464900; 
 Fri, 12 Jan 2024 07:47:44 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.145])
 by smtp.gmail.com with ESMTPSA id
 re20-20020a170906d8d400b00a2aed87bb44sm1898158ejb.110.2024.01.12.07.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 07:47:44 -0800 (PST)
Message-ID: <3ed35db5-0272-4ca2-b34b-461dcf817607@linaro.org>
Date: Fri, 12 Jan 2024 16:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/ppc/cpu-models: Rename power5+ and power7+ for
 new QOM naming rules
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20240111164652.908182-1-thuth@redhat.com>
 <20240111164652.908182-2-thuth@redhat.com>
 <70fae07d-f6c1-4143-b632-a988ae53ccb0@linux.ibm.com>
 <27a311a8-f6db-48ea-8bbd-a09eb3c2e07e@redhat.com>
 <54b6ba59-8edc-4b9c-bd3f-88399127f60e@linux.ibm.com>
 <12a5e758-f144-40c2-bcb3-14855b81b7a4@redhat.com>
 <45fb3790-df2a-49f5-860e-46d4f9b0150c@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <45fb3790-df2a-49f5-860e-46d4f9b0150c@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 12/1/24 12:33, Cédric Le Goater wrote:
> On 1/12/24 11:55, Thomas Huth wrote:
>> On 12/01/2024 06.21, Harsh Prateek Bora wrote:


>>> Hmm .. I would certainly vote for 'p' over 'plus'.
>>
>> Ok, I don't mind either way ... does anybody else have any preferences?
> 
> p is fine.

We also use 'p' for '+' / 'plus' on ARM Raspberry Pi:

$ qemu-system-aarch64 -M help | grep -F raspi
raspi0               Raspberry Pi Zero (revision 1.2)
raspi1ap             Raspberry Pi A+ (revision 1.1)
raspi2b              Raspberry Pi 2B (revision 1.1)
raspi3ap             Raspberry Pi 3A+ (revision 1.0)
raspi3b              Raspberry Pi 3B (revision 1.2)

