Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB3F803177
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 12:26:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA742-0001PQ-3p; Mon, 04 Dec 2023 06:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rA740-0001Oz-0r
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 06:24:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rA73y-0006aY-Gt
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 06:24:35 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40b4746ae3bso38623485e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 03:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701689073; x=1702293873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WycpjHYO6RfyHNSqm0uAFT2yuh0BDw+IodrN8qMQkCI=;
 b=SFh5QtPfsUy+JpzpbNHPacoH+yVeoDJQsC26IDs08XQ7BzHeip8K7kKiKwdUihL7Z2
 sd5wo7ozp5Pql6zpebqQDu1ojjgNCaMW09oRV2iL3IWYrpQf0x9wmNQ+vTgGC4mkX/Ij
 1H/SXTzPTpbwjDK7F+x72ZHagdz4fmva0n22R9RHIPpOpJSLAVkzfyZapWXBX6n+ixDR
 UYN2BrknNhtGS0pWvok8hHWAzyIDDvpROGdiJeikNgw9qZC53YXyZhUtr2p33ktfoC0g
 /z8crKUvPoQm69XfEZafQ4gxmxh/v9L7v1mdeeeH1MZxLc5q00GV1rjbPRArmY1peqp3
 Cj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701689073; x=1702293873;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WycpjHYO6RfyHNSqm0uAFT2yuh0BDw+IodrN8qMQkCI=;
 b=LdRoToPS5bT3iNRbxccci1mV1MubeZlER/+0ncjqwIozmXsAeU77op4RbMSPMQs5uS
 m16ZO9lV0+S2Qg9Idzx9Ce3XDQrkjDDLdxEOii3VLjRINmSJ8WioX3uSJ8WVW4cb7Oyr
 XuAkGHgxHoOzLq4S4gLPlFtuh2bIFbCaDSOGYcKqAnwnjMrsIuYD3dk2iHTFGwOVAYwy
 LCg6c2JhF338S+mNZUw63DXCVPvUqEfCmJDjVnMo9WgR54MnUj+ogAdvWNOEv7wdzmMZ
 9pvqye+ckeTTZsx/lkkwV2inXv6AbQfqGe8BWoUdeS3Ovj1tGcyduW/r/2B+tdorbVDr
 ugtw==
X-Gm-Message-State: AOJu0Yyj3UXa0L1ZHP3xD7MGKlLhjjKYPj1O3hV9WFhiuDUamTCI/Kxs
 dIvwu4wjx313kH5eJa3EbPhPXw==
X-Google-Smtp-Source: AGHT+IFJtf2kqS9sIjuhVkRWIyR1FX8N/6hFvFEUJGWWPcKeS1G1ysvhlTjqNN4q8DuLhM9gSSo56A==
X-Received: by 2002:a05:600c:1c95:b0:40b:3857:1301 with SMTP id
 k21-20020a05600c1c9500b0040b38571301mr2234064wms.32.1701689072812; 
 Mon, 04 Dec 2023 03:24:32 -0800 (PST)
Received: from [192.168.69.100] ([176.176.140.35])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a056000050400b003334675634bsm3500083wrf.29.2023.12.04.03.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 03:24:32 -0800 (PST)
Message-ID: <c7ff45ab-4eb4-460d-bc63-e1fafe6ea239@linaro.org>
Date: Mon, 4 Dec 2023 12:24:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] system/memory: use ldn_he_p/stn_he_p
Content-Language: en-US
To: Patrick Venture <venture@google.com>, David Hildenbrand <david@redhat.com>
Cc: pbonzini@redhat.com, peterx@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Chris Rauer <crauer@google.com>, Peter Foley <pefoley@google.com>
References: <20231116163633.276671-1-venture@google.com>
 <40d8f91c-e951-413f-8f15-446f0f1b4938@redhat.com>
 <CAO=notyr9V2Z3Ad=rm6qinVmfobB4ESn70Bn5rA-3gGm3Siv-w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAO=notyr9V2Z3Ad=rm6qinVmfobB4ESn70Bn5rA-3gGm3Siv-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Patrick,

On 3/12/23 16:42, Patrick Venture wrote:

> Friendly ping? Is this going to be applied or do I need to add another 
> CC or?  I do think it should go into stable.

I'll send a PR with this patch included.

Regards,

Phil.

