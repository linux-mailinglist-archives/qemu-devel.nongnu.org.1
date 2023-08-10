Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F487771EC
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 09:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU0Ry-0008Cj-SQ; Thu, 10 Aug 2023 03:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qU0Rx-0008C7-EZ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 03:51:17 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qU0Rv-0005pv-LF
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 03:51:17 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b9d3dacb33so9222981fa.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 00:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691653874; x=1692258674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XCWcnDBsc5Z+cGxeUXWCutK8SeV6ORSiPUrWMxByRZc=;
 b=PCJSR3z7a9buwxU99wGy81fYPNKmcS7nSmxjzC1KOHk2UqYvB4L0lA12hGsdKruMku
 88z7IMMdPhIVsFd1j5a+rV7k6W5k2csl7Y9pGJx/gH/0+uat0gIgVK4LhkZ5MBGhTx9c
 ilR8pWYeyhAyOsMkXqk0/6hmhDHHMIpdwrFqrMnWxpaZQFu++UA8IhPQe6UrRmbJ47E3
 IK8bkVn5kO+NAbwagnumQEjrKGnqplDxv5PL1xl8tYj3JaCYH4hiZ7kDYk1cc1kTxgKW
 V0elDSrlxBFGJkKENFTE1/jeOXXkmMyD+PGItL3a0CNBFs1b+Gc71g92wAchdXppgYPf
 cUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691653874; x=1692258674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCWcnDBsc5Z+cGxeUXWCutK8SeV6ORSiPUrWMxByRZc=;
 b=S50ok0+6JMJjzDUci/JAdmcfxeTt/YBBh2M9u/qkteLZx63oXKCOZuU2AoJlMm2j7q
 zhc4GUIZU9XKnjC+dwQeNtyYhbhuxSgiw0BmVU4eBEevZb6S/faOlQH9RJbPKPu5vFWR
 WqjUFWx+k4UaHPWaT6Dip5P57ddraeSTaT/cF86FPTHhZMqKasLgQ8Qy6h4wRjwmt7K1
 DZUpyGf7paDxepNVYXNm3+eSRfgNqVIRtYlevlm6lhTnd3xOBczRdUqvjp42Vee/AjHR
 C73EESuR+KhlCx0TJqeRtfihRIRvut9pJo0VoAdIjugWt470ibYSRET12hGF26gvAMQp
 LuTQ==
X-Gm-Message-State: AOJu0YzEfqk3HysVUHXRxzc3gYv1SqH5Xu/el2igtP108yY/M9DQGqc1
 REBpILky0eTmfX1LlZtayg+AQw==
X-Google-Smtp-Source: AGHT+IEEyL/q5J94PiGHrQR7+ooknb5TYb2896Pghup5/9zhlraia+sKxV8ggPRATx5mOlif2Sy0yQ==
X-Received: by 2002:a2e:84d6:0:b0:2b9:a6a1:f20 with SMTP id
 q22-20020a2e84d6000000b002b9a6a10f20mr1257509ljh.42.1691653873752; 
 Thu, 10 Aug 2023 00:51:13 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a170906255300b0099b42c90830sm560239ejb.36.2023.08.10.00.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 00:51:13 -0700 (PDT)
Date: Thu, 10 Aug 2023 09:51:12 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH] target/riscv/kvm.c: fix mvendorid size in
 vcpu_set_machine_ids()
Message-ID: <20230810-d3fe7bd8e11c07aa7e890bec@orel>
References: <20230802180058.281385-1-dbarboza@ventanamicro.com>
 <20230803-3d2b378004c77196efc74f09@orel>
 <d9659727-2ba4-370c-32ac-9f5ade5bea60@ventanamicro.com>
 <20230803-70bedcfb60cb5b2efb87cedc@orel>
 <93cf5366-9723-3c08-6ce1-d0dbd1f4a76f@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93cf5366-9723-3c08-6ce1-d0dbd1f4a76f@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 09, 2023 at 07:16:00PM -0300, Daniel Henrique Barboza wrote:
> Drew,
> 
> On 8/3/23 09:05, Andrew Jones wrote:
> > On Thu, Aug 03, 2023 at 08:36:57AM -0300, Daniel Henrique Barboza wrote:
...
> > So, I think we need a helper that has a switch on the KVM register type
> > and provides the right sized buffer for each case.
> 
> Is this a suggestion to do this right now in this patch? I didn't understand
> whether you're ok with the fix as is for 8.1 or if you want more things done
> right away.
>

The fix looks good for 8.1. Using target_ulong looks right to me for all
KVM ULONG-sized registers. When we try to build an API which provides the
right sized buffers (which is future work), we'll want to use target_ulong
there too.

Thanks,
drew

