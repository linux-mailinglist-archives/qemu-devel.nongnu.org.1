Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F9D7F15D7
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:38:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55O7-00010m-6B; Mon, 20 Nov 2023 09:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1r55O5-000106-7X
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:36:33 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1r55O3-0003Zg-7j
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:36:32 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b58d96a3bbso2594071b6e.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 06:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700490989; x=1701095789; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EPFRyXR3cbfHUYFBjvmXjpk69SdGtoR05Bw7MVnbuMo=;
 b=HIv4JWeSVeipYDdBLjkpx3oai+unl7Bkp1hLzIiQWJC+FNYgGDHt4SDkBEdkPDqNbQ
 TR/L0Iumh0UpSQE1mzIobYLrX6vY9w548IiufkCIDQF+Hr5X+CKBSy1PoPPQTEGyuKG8
 9q49EhB2YQZ264ATXRtePZKtOyGKR568hzJBJT6YioPNCMy0o8GWijjmC9mnsAY6eH2y
 VgUN5JVy4tNqmiqY9yG6tsOevL/MA+Cf52U9RTFf8vqXZktZLQCLKzGUNp70w4tstyZP
 lbdyEpjGWM4c2EnAvHzU7hN0MmHCog/dQ9Qa/dwg3K7+PN9ojeuLlejHiqpkMoHSPzFS
 dt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700490989; x=1701095789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPFRyXR3cbfHUYFBjvmXjpk69SdGtoR05Bw7MVnbuMo=;
 b=rP8vpQXOv4qMJzx3SHRaMi2M1Q1zTJpe0MNCN/lJBLZ0vBry2ryIrv2IaFc7T9F2NF
 CwUD6zRFumTxEn0wXNWJevY27SMT+BfOv58gGXy2KpeWZep2P76G5L+P+r6GCgX2S6g2
 aXDGE2WO3K3qpDVAX/w/eNdvJZ8tWzK3VrOqtl899IO8lyYMBoqkVlKdx9CN3L4YrNt5
 xOXNS42+rwB4qrPxHBbW52PkNDGnq+/0N3NnmyaQDC7kUluLpUj9HoRMCzuMhcDBeP4t
 tG2RoGeyNtBq61d4cqjI7vNowLIyspNBYjvZOrrausPNtWv7XlSJ07sw2XqhK7rCCZDL
 Il/g==
X-Gm-Message-State: AOJu0YyqON7kVwoWS/ApSXFyUf387ck7iCugBtQurXNybr6Ve+j7wJNr
 FT8VYNSvASen2CM0Mct2+MUE3A==
X-Google-Smtp-Source: AGHT+IFePPFdx2binXkRwuMVNFnSS0ewm6KM814ZFlGB6TjEYDK4l2tMa0m0nql+mcUe1LrH7GM5FA==
X-Received: by 2002:a05:6808:1a09:b0:3b2:ef9c:d1b1 with SMTP id
 bk9-20020a0568081a0900b003b2ef9cd1b1mr9665527oib.6.1700490988988; 
 Mon, 20 Nov 2023 06:36:28 -0800 (PST)
Received: from sunil-laptop ([106.51.191.97]) by smtp.gmail.com with ESMTPSA id
 dd1-20020a056808604100b003a747ea96a8sm1271035oib.43.2023.11.20.06.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 06:36:28 -0800 (PST)
Date: Mon, 20 Nov 2023 20:06:19 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 0/3] hw/riscv/virt: pflash improvements
Message-ID: <ZVtu44sFAQeWxGjO@sunil-laptop>
References: <20230525164803.17992-1-sunilvl@ventanamicro.com>
 <CABJz62MFZzx3jBgW6TtGFD9emY+DAbbftSybD8ZouC65n3-auA@mail.gmail.com>
 <20230526-b0d8b56e9688dea7ae9d00d5@orel>
 <CABJz62Nk-U+qHQjn6G2-bN8i9RcMEZWdYTyi7wqC=7BVjDSBWQ@mail.gmail.com>
 <20230526-e398cfda73f326653323ea68@orel>
 <CABJz62PXvVNEwpqUz0dUUYTAGjmNU4h0NtFf664oubaJmKxwKw@mail.gmail.com>
 <20230526-cbbe3fe3734dc64264a2ad83@orel>
 <CABJz62N3tBpCtLmQmnYzLHnUNRZcxOxn2iLzPu=V3THVpp698g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJz62N3tBpCtLmQmnYzLHnUNRZcxOxn2iLzPu=V3THVpp698g@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oi1-x22e.google.com
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

On Mon, Nov 20, 2023 at 02:29:28PM +0000, Andrea Bolognani wrote:
> On Fri, May 26, 2023 at 11:10:12AM +0200, Andrew Jones wrote:
> > On Fri, May 26, 2023 at 04:42:57AM -0400, Andrea Bolognani wrote:
> > > On Fri, May 26, 2023 at 10:34:36AM +0200, Andrew Jones wrote:
> > > > On Fri, May 26, 2023 at 03:49:11AM -0400, Andrea Bolognani wrote:
> > > > > So, are edk2 users the only ones who would (temporarily) need to
> > > > > manually turn ACPI off if virt-manager started enabling it by
> > > > > default?
> > > >
> > > > I assume so, but I'm not tracking firmware status. If the firmware
> > > > doesn't extract the ACPI tables from QEMU and present them to the
> > > > guest (afaik only edk2 does that), then the guest kernel falls back
> > > > to DT, which is why it's working for you.
> > > >
> > > > I suppose we should wait until Linux merges the ACPI patches, before
> > > > adding RISC-V to the libvirt capabilities ACPI list.
> > >
> > > That sounds reasonable to me, but note that 1) the libvirt change
> > > might take a while to propagate to distros and 2) someone will have
> > > to remind me to prepare such a patch when the time comes ;)
> >
> > Initial ACPI support will probably be merged for 6.4. So maybe it is
> > time to get the libvirt side of things going.
> 
> Randomly remembered about this. Did ACPI support make it into 6.4
> after all? Is now a good time to change libvirt?
> 
Hi Andrea,

Not yet. While basic ACPI changes are merged, the interrupt controller
support is still going on. Looks like it will take few merge windows to
get ACPI fully supported. So, we still need to wait for libvirt change.

Thanks!
Sunil

