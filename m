Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A783027E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 10:41:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ2Ox-0005wy-LW; Wed, 17 Jan 2024 04:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ2Ow-0005vE-4s
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:40:02 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ2Ou-0002MR-II
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:40:01 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so231725e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 01:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705484398; x=1706089198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xmYDWnl8dTqsrDQj2YhUBjlV25jNbeQ7ObR2DibyeoA=;
 b=jRBY7oL2TWLSuzIe1qLinuaYJ0omJkml3rKd1ORMNJ5/frS82U9H7fC5xLau4YZiy2
 lb3ranNPW/cV4/qySYITkvn+ON4WKzilcFycxREUvEI2Z98+MFiG6IO6IUr1CvnuZzU5
 R2hN8ys4GF+OtHs/haFxz+lB149N8rfCINrAXu6yui9IJYCBAJwGRBtqEGfPUzA6VyQX
 omKUHA+SiO9USUH3MmToQKqY+Xrw/3KGjHVBxmwXKv2BOxsgMsUzC2meUSCRgzJq3frf
 RmVZ210E8munCJRpQp78jkjV3tbmmcRMEYDLPLJom94gZA2ToFjDGwGQMYBLrIImmWGZ
 aZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705484398; x=1706089198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xmYDWnl8dTqsrDQj2YhUBjlV25jNbeQ7ObR2DibyeoA=;
 b=tbyEHYsVtMHYKG6nSUKVra79QP0099oo6fE2MLnDKxZXDGV5S8Ka28OdFVESH8uCQb
 Y6r4qhtuVcE5AJzzaKOuppiidevl3wSA6Ja03NAN4xyajW+Ldm51bGVzqSWCaNHuw2NV
 vQ4hich3EzHNhMbLEP3OwU6/x1BO2kqfXnMQpck3qcXLKgAIRO07d5d5Xj2aA4YPp9Xd
 uozmMNxXPkqt2cG6zHXwUWrA3UOxI0oXED3gaEntjN0ADsPT+7OU/8UARfZSyG7v2qeZ
 GXI8zRlEk4P+BKytSD6qQdNv0F2OnHHvffW16R7XuIWBulsHb5F9R2yBALOe0VI3kmLp
 v6pQ==
X-Gm-Message-State: AOJu0YykYb0sCe1NY0WoQxPd2bSFy71lUoqy9DBXRZCgYWlY7hIC2fmw
 oC/iD7MFl1wWvS0BpO2VFnjEu8hl0VAKVe2bWieeSkfmlS8=
X-Google-Smtp-Source: AGHT+IFBrcEeQrmmn7TjIuwnPOuNkld5cdjzyHfmIIbVrYYCuAqRVRKzyKECnEpnS/yA6LjWMHmnzQ==
X-Received: by 2002:a05:600c:3799:b0:40e:6812:2bd0 with SMTP id
 o25-20020a05600c379900b0040e68122bd0mr2619023wmr.267.1705484398269; 
 Wed, 17 Jan 2024 01:39:58 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 k20-20020a05600c1c9400b0040e54f15d3dsm25655095wms.31.2024.01.17.01.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 01:39:57 -0800 (PST)
Message-ID: <bd2e30cd-4723-4b7d-b12e-c4b329aed18b@linaro.org>
Date: Wed, 17 Jan 2024 10:39:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: Do not set CPUState::can_do_io in non-TCG accels
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, kvm@vger.kernel.org
References: <20231129205037.16849-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231129205037.16849-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 29/11/23 21:50, Philippe Mathieu-Daudé wrote:
> 'can_do_io' is specific to TCG. Having it set in non-TCG
> code is confusing, so remove it from QTest / HVF / KVM.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/dummy-cpus.c        | 1 -
>   accel/hvf/hvf-accel-ops.c | 1 -
>   accel/kvm/kvm-accel-ops.c | 1 -
>   3 files changed, 3 deletions(-)

Patch queued.

