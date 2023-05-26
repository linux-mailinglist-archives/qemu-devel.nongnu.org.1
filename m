Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A55857126E9
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:49:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Wri-0005ei-H1; Fri, 26 May 2023 08:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q2WrS-0005dY-Lo
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q2WrP-0008HL-7o
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685105278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F6B4dRALKH5sfFoxuEMyrCbIa8hTVTVo6ka4rxPj5lE=;
 b=ZT/sF3A9GvpW/YsghGa2cC2hgz0ToYQrFrYnxNf1sLcQDDuXXeydHzxTtdsw5qpR2UbrVB
 W8vARqJqQjXgCnlY4i0wrVqvSBSkqqwR8iiiJrmtGQ2PnP0BRUa7vyBVbpymblYmObiRLw
 3F/N1N7/nG/xYhTEqv5Z+F4BoCgJyP8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-LpIkfOXvP32u0PXFL5dXIQ-1; Fri, 26 May 2023 08:47:56 -0400
X-MC-Unique: LpIkfOXvP32u0PXFL5dXIQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1ae721230a1so8682735ad.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 05:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685105275; x=1687697275;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F6B4dRALKH5sfFoxuEMyrCbIa8hTVTVo6ka4rxPj5lE=;
 b=kQt7JLhiltloI13ejPNlHLDLDMXdV1Xe9D6sohCf3ZItXZGHWtWUAa435YmFEXcUfT
 H06BsbKzmL3Tic+ZmsKfwn9xKrjMo40zRWX31oCtOacm41z8ucX4zDHafIEmH5nWFNXk
 9+rS/dBvGSUmSwM/d+4RlQJM40lUfIYf4e5bSa7h1NYh7S/5PdVLlchxrN30vnZWYmTg
 TOPt5knJIz1XvFIsdTcao++MDj0QG4LRnAoXD6ub6wTg2MjHOuam/cgsAW+ycdEa7XT+
 k8U+zgJMi0I7hdAXaPPfiVPQqaL5iuy6JNBis5U90uY9aWetqD8AAa/deihOQw4mhJYX
 swkQ==
X-Gm-Message-State: AC+VfDyhAqtfMMQ17pY547UqCA6goEMpHF7ZdU5c0YcHB150b5C0OMGh
 DXZzAyThp5np0uQsHldhm652psoHEOSUUF9ZS4p2aaJIHDImSs/5f4RzeRu6f01iwOmrpspCpbe
 GWPE6CRuaRBteznl9ffcyjuAHXtgJlBM=
X-Received: by 2002:a17:903:4095:b0:1aa:ee36:40a5 with SMTP id
 z21-20020a170903409500b001aaee3640a5mr1876034plc.34.1685105275692; 
 Fri, 26 May 2023 05:47:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Y4V7vhMTtwb1xST7nZ0UFKAs7mtCfXTvQd/eYOMFZExyBAix+acKMmXnh828gYKdt10/qJxWfvuVC58SE4ks=
X-Received: by 2002:a17:903:4095:b0:1aa:ee36:40a5 with SMTP id
 z21-20020a170903409500b001aaee3640a5mr1876016plc.34.1685105275326; Fri, 26
 May 2023 05:47:55 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 May 2023 08:47:54 -0400
From: Andrea Bolognani <abologna@redhat.com>
References: <20230526121006.76388-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
In-Reply-To: <20230526121006.76388-1-sunilvl@ventanamicro.com>
Date: Fri, 26 May 2023 08:47:54 -0400
Message-ID: <CABJz62OvBz43LLPyqT7f-ktn9f9hyMed-Wm8ezVom2chQmX5Mw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] hw/riscv/virt: pflash improvements
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, May 26, 2023 at 05:40:03PM +0530, Sunil V L wrote:
> This series improves the pflash usage in RISC-V virt machine with solutions to
> below issues.
>
> 1) Currently the first pflash is reserved for ROM/M-mode firmware code. But S-mode
> payload firmware like EDK2 need both pflash devices to have separate code and variable
> store so that OS distros can keep the FW code as read-only.
>
> The issue is reported at
> https://salsa.debian.org/qemu-team/edk2/-/commit/c345655a0149f64c5020bfc1e53c619ce60587f6
>
> 2) The latest way of using pflash devices in other architectures and libvirt
> is by using -blockdev and machine options. However, currently this method is
> not working in RISC-V.
>
> With above issues fixed, added documentation on how to use pflash devices
> in RISC-V virt machine.
>
> This patch series is based on Alistair's riscv-to-apply.next branch.
>
> Changes since v4:
> 	1) Updated patch 2 to avoid accessing private field as per feedback from Philippe.
> 	2) Updated documentation patch to add read-only for ROM usage.
> 	3) Rebased to latest riscv-to-apply.next branch and updated tags.

Still works great :)

Tested-by: Andrea Bolognani <abologna@redhat.com>

-- 
Andrea Bolognani / Red Hat / Virtualization


