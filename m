Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B527BEE25
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 00:13:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpyTg-0003rk-VY; Mon, 09 Oct 2023 18:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qpyTf-0003r2-32
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 18:11:51 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qpyTa-0001mh-Ip
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 18:11:50 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50308217223so6239825e87.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1696889503; x=1697494303; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nJy0hce/YrY23lL4GVCRdbFPgnpYuOHyHRvZoD67NIs=;
 b=Qp+JFLxd31Zbcwwv0scwQzvZVl6DRYKk0rFcRmpYhOEphGCbpWGm/2V6jRnkaPelLd
 YM5xDAgmSsevpuK1CZVDdI1DOLuBxTL4Fp/kDYVbtm3u1vVRTvfKwR9Tx9uKRVRJmQtE
 Ge35mMpUC9MKTil1N85QR8XNOgyBkIi3e4suoOzU8+05ZYnRw5Dnx15nCWi6WGO2EFTq
 WcAuLFELR5o642HIIXOU1Hch+1pf/RrspXotELwu6K3rlGOHY4P2gzjScDFDcJfTWdGo
 an6agRozInWRA8ocI/DnLsS2I3hDk0CAZZTeOzg9LMuTa9+LbZskFxwlhvJ0gBduFYxn
 rotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696889503; x=1697494303;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJy0hce/YrY23lL4GVCRdbFPgnpYuOHyHRvZoD67NIs=;
 b=vMsnlBAMjFiwagOgzG3CfEKxXiirB51juRdem1VDZeJLkc6vXNhfD1pWH5ACJ9kUxg
 4ZFt+Opa3zoTtvdvqbiLvqEWvWxXs9hom4626VlCLokuRd2+KVWjPjig8OVBQ+wjCBcX
 aybbbNBfLq9OzcbPAU9yYgqOkron6umKGOq2qg2z69raCIS5cjcQaD6MaebwWlOwqtso
 Z/rgORUIxqz8Ow02A85XFFum7rFZ63uDHlgAZ6KbGe66yodVJ1TnBHb5YMxHLBukxODM
 R6sIV4M9t5LPP/Nx4ywMWQGjip2dv+CTPLROPQF6YohanTE3MbTjkUhG38vuKTYXmd5/
 RCow==
X-Gm-Message-State: AOJu0Yy/s0ImeVRTik5X+CqoGatZSVnsCYfQOAPhuupJThBOHcOcz42T
 e24MZDP8sT//XNADI+c71BwNTA==
X-Google-Smtp-Source: AGHT+IEQZJ6+hZs6o+jHiOoe2HZ60A/G1wZUI4gX36JdY+mej1GgSheBuqpnr1bggyP0p8HRwIvWqQ==
X-Received: by 2002:a05:6512:250c:b0:503:1b83:e352 with SMTP id
 be12-20020a056512250c00b005031b83e352mr17216392lfb.52.1696889503024; 
 Mon, 09 Oct 2023 15:11:43 -0700 (PDT)
Received: from localhost (95-25-87-177.broadband.corbina.ru. [95.25.87.177])
 by smtp.gmail.com with ESMTPSA id
 m23-20020ac24257000000b0050420eff124sm1553302lfl.152.2023.10.09.15.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 15:11:42 -0700 (PDT)
Date: Tue, 10 Oct 2023 01:11:41 +0300
From: Roman Bolshakov <roman@roolebo.dev>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Cameron Esfahani <dirty@apple.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-riscv@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/6] target/i386/hvf: Use x86_cpu in
 simulate_[rdmsr|wrmsr]()
Message-ID: <ZSR6nS2k1n8PGjTc@roolebo.dev>
References: <20231009110239.66778-1-philmd@linaro.org>
 <20231009110239.66778-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009110239.66778-6-philmd@linaro.org>
Received-SPF: none client-ip=2a00:1450:4864:20::136;
 envelope-from=roman@roolebo.dev; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 09, 2023 at 01:02:38PM +0200, Philippe Mathieu-Daud� wrote:
> We already have 'x86_cpu = X86_CPU(cpu)'. Use the variable
> instead of doing another QOM cast with X86_CPU().
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>

Reviewed-by: Roman Bolshakov <roman@roolebo.dev>

--
Regards,
Roman

