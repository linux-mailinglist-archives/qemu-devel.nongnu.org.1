Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D0471227D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:43:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2T2S-0002Cw-4Y; Fri, 26 May 2023 04:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q2T2P-0002CC-IR
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q2T2O-0003b2-5x
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685090583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YmMhBzprK4RE21VMHkMedyd2ZgvJU7kdyhV5ySnVC/E=;
 b=HLVouDcNilBj+ER4g1OHEqbVGWfgsdjz2tR9tLRg5zx+pBTmiUIaXsXTFCHvCIbxoTF6Og
 GYqtqVwZ5tr/reeQVMP3KCYgLNvdmi5zZ/9BE0M2ZsSTocserVNAam7RIw38aup4ZrhgVM
 cLHF7qWrzX8+tETlVPOtn1HeimkpufY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-jtCglx3hN5GwR4Plkr2LSw-1; Fri, 26 May 2023 04:43:00 -0400
X-MC-Unique: jtCglx3hN5GwR4Plkr2LSw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-53f44c25595so352442a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685090579; x=1687682579;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YmMhBzprK4RE21VMHkMedyd2ZgvJU7kdyhV5ySnVC/E=;
 b=W2jWj2ZsYlLzGmTpGxzdhUceKMmc4qNKWUBeyO+dRxSVrLB2y/hP9te0v/oUIedJpG
 pLJwEs7D1AKRFUKLlKV0Ilt6Wt5BH6dAJPidK91vqZOWwx7p0ccEdYwIJ9r43r1lTMzK
 6xMcQkFLQlnWVBZeirKeJDSpShdAI+lSwgBb/Q1g1tWBoWa5/L5mjfNtCRVrTGJyBTOe
 Z+pLGGcDelAwlnFIBWhqL2gewpnwQwo8ZrTv0tcXTJ5qVtaMvUfshI3dx6SlWU5S2J9u
 sstxTUKZ5JDTKLdWjvP44mj56ljIXysjTgC9wZFbDifLoWhU+VmZbAfqs8jNUGsLNUMK
 VIyQ==
X-Gm-Message-State: AC+VfDwLMWM4caZXBtxSycBBhwGltYs24Kx2Glq2ZOJ3t6k5DqOr2Flu
 PToK8VH9oNm81zTIn8cQf9thFIWQXC43DaxWa1GNAm+4cRaA0Ib/NpuLRnNwbviMnwtvfOK8b+X
 IrISbBWj8WyKNZWEWr3lKXtqpTNlFXPw=
X-Received: by 2002:a17:90a:4ec8:b0:244:a412:47d7 with SMTP id
 v8-20020a17090a4ec800b00244a41247d7mr1898398pjl.20.1685090579044; 
 Fri, 26 May 2023 01:42:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hD79dUBHIEmgtQTLLl95Oj4gi/srxwy+XXXsEga460/7r2Kgukw/on7P9AYeRFFl49FE3mrHeazyPBf+4hSY=
X-Received: by 2002:a17:90a:4ec8:b0:244:a412:47d7 with SMTP id
 v8-20020a17090a4ec800b00244a41247d7mr1898382pjl.20.1685090578730; Fri, 26 May
 2023 01:42:58 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 May 2023 04:42:57 -0400
From: Andrea Bolognani <abologna@redhat.com>
References: <20230525164803.17992-1-sunilvl@ventanamicro.com>
 <CABJz62MFZzx3jBgW6TtGFD9emY+DAbbftSybD8ZouC65n3-auA@mail.gmail.com>
 <20230526-b0d8b56e9688dea7ae9d00d5@orel>
 <CABJz62Nk-U+qHQjn6G2-bN8i9RcMEZWdYTyi7wqC=7BVjDSBWQ@mail.gmail.com>
 <20230526-e398cfda73f326653323ea68@orel>
MIME-Version: 1.0
In-Reply-To: <20230526-e398cfda73f326653323ea68@orel>
Date: Fri, 26 May 2023 04:42:57 -0400
Message-ID: <CABJz62PXvVNEwpqUz0dUUYTAGjmNU4h0NtFf664oubaJmKxwKw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] hw/riscv/virt: pflash improvements
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
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

On Fri, May 26, 2023 at 10:34:36AM +0200, Andrew Jones wrote:
> On Fri, May 26, 2023 at 03:49:11AM -0400, Andrea Bolognani wrote:
> > So, are edk2 users the only ones who would (temporarily) need to
> > manually turn ACPI off if virt-manager started enabling it by
> > default?
>
> I assume so, but I'm not tracking firmware status. If the firmware
> doesn't extract the ACPI tables from QEMU and present them to the
> guest (afaik only edk2 does that), then the guest kernel falls back
> to DT, which is why it's working for you.
>
> I suppose we should wait until Linux merges the ACPI patches, before
> adding RISC-V to the libvirt capabilities ACPI list.

That sounds reasonable to me, but note that 1) the libvirt change
might take a while to propagate to distros and 2) someone will have
to remind me to prepare such a patch when the time comes ;)

> Then, is it
> possible to use something like libosinfo to inform virt-manager
> when it should enable ACPI and when not? Later distro images, with
> later kernels, will want to use ACPI by default, but older images
> will still need to use DT.

Something like that would definitely be possible, but I don't think
the scaffolding for it exists at the moment, so someone would have to
wire it up across the stack. Given how relatively immature the RISC-V
distro ecosystem is at the moment, I think it's fine to do nothing
and wait for the problem to go away on its own :)

-- 
Andrea Bolognani / Red Hat / Virtualization


