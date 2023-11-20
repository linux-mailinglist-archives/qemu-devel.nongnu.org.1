Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D08BB7F15B3
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:29:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55HO-0006JU-38; Mon, 20 Nov 2023 09:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r55HK-0006Fh-Td
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r55HI-0001JX-Up
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700490571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2WOCks8MX304Xlju4oK5AHdIuQh6qa4nX/Zy1T8yjaQ=;
 b=AjdyHf6R65aGZ/J2O6kKivuLVx3zmPsgzv0G6X3gcb3QFdIQLQpHhkRPjS+/MLvsnXNCEg
 1KSUIp5WUWDlHldOt8SNx61pnRYlZ9WvLZ/fJvnCtXUq7aSEFc9J7FQOlJ0DvplpCAt5xM
 Z3yZURASgvOc+FE3wR2cPX7G54R9F1Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-t1kOvPyJNu-Myo4S8fR7sQ-1; Mon, 20 Nov 2023 09:29:30 -0500
X-MC-Unique: t1kOvPyJNu-Myo4S8fR7sQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41b83b8dbe1so56612001cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 06:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700490569; x=1701095369;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2WOCks8MX304Xlju4oK5AHdIuQh6qa4nX/Zy1T8yjaQ=;
 b=cctR5xrxD/WY55Zs2SaW0neBltonuRGIVFC496eA5ZGwSH9IwJEqlu24U05rv0kUWe
 OqdpuJ7jiElNhl5ApoiUGCdNxSbmSjQbLLfh73XCfU13iFQhpwMkBEa3A1MBVJLr6cF3
 M/9TH2D9QRZ9JkdU1FJ8oIZR5DcSR2t/JwcwWUuFB65WbcerSDm6Q9l7QW0dg9OFkNQo
 VlbK1jVlWv8G8nqoOJOjttlUGZGDZiJRUmEpXUcKtpu0GyQnZ0WjRcdjtD2PNAPMEoki
 +nkB9QutnL6ie454jqCp8XP16ii1v1xsk3K+8PAxjDlT9M8dMHZPS8BYTB8h4yF0AvSo
 nVYA==
X-Gm-Message-State: AOJu0YzDAO9LuwIex8y6SiIyQzXlnGsCaYO3vHw1v3eFxw/29sVfAfx2
 5feGAeWNMXb3TQEDNfYw/tsPvkCseDcjzgs2R5LRe56wbmLPBYA1xRqy/sXj5hkHf5M+vKllpfJ
 ulq0kQSFq5s0ArPKKKsLID3L3QVTtEk1LClUdkh8=
X-Received: by 2002:a05:622a:142:b0:41c:d9e7:7782 with SMTP id
 v2-20020a05622a014200b0041cd9e77782mr9907266qtw.68.1700490569483; 
 Mon, 20 Nov 2023 06:29:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPeD98oYzMjplpOqIeQO/JsczR9PAaAALMP2PQ29tTusNHt7jnZUBP0h1pgGrX33ZkHTvUXeQRFL4HkCvxn8M=
X-Received: by 2002:a05:622a:142:b0:41c:d9e7:7782 with SMTP id
 v2-20020a05622a014200b0041cd9e77782mr9907255qtw.68.1700490569271; Mon, 20 Nov
 2023 06:29:29 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Nov 2023 14:29:28 +0000
From: Andrea Bolognani <abologna@redhat.com>
References: <20230525164803.17992-1-sunilvl@ventanamicro.com>
 <CABJz62MFZzx3jBgW6TtGFD9emY+DAbbftSybD8ZouC65n3-auA@mail.gmail.com>
 <20230526-b0d8b56e9688dea7ae9d00d5@orel>
 <CABJz62Nk-U+qHQjn6G2-bN8i9RcMEZWdYTyi7wqC=7BVjDSBWQ@mail.gmail.com>
 <20230526-e398cfda73f326653323ea68@orel>
 <CABJz62PXvVNEwpqUz0dUUYTAGjmNU4h0NtFf664oubaJmKxwKw@mail.gmail.com>
 <20230526-cbbe3fe3734dc64264a2ad83@orel>
MIME-Version: 1.0
In-Reply-To: <20230526-cbbe3fe3734dc64264a2ad83@orel>
Date: Mon, 20 Nov 2023 14:29:28 +0000
Message-ID: <CABJz62N3tBpCtLmQmnYzLHnUNRZcxOxn2iLzPu=V3THVpp698g@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] hw/riscv/virt: pflash improvements
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 26, 2023 at 11:10:12AM +0200, Andrew Jones wrote:
> On Fri, May 26, 2023 at 04:42:57AM -0400, Andrea Bolognani wrote:
> > On Fri, May 26, 2023 at 10:34:36AM +0200, Andrew Jones wrote:
> > > On Fri, May 26, 2023 at 03:49:11AM -0400, Andrea Bolognani wrote:
> > > > So, are edk2 users the only ones who would (temporarily) need to
> > > > manually turn ACPI off if virt-manager started enabling it by
> > > > default?
> > >
> > > I assume so, but I'm not tracking firmware status. If the firmware
> > > doesn't extract the ACPI tables from QEMU and present them to the
> > > guest (afaik only edk2 does that), then the guest kernel falls back
> > > to DT, which is why it's working for you.
> > >
> > > I suppose we should wait until Linux merges the ACPI patches, before
> > > adding RISC-V to the libvirt capabilities ACPI list.
> >
> > That sounds reasonable to me, but note that 1) the libvirt change
> > might take a while to propagate to distros and 2) someone will have
> > to remind me to prepare such a patch when the time comes ;)
>
> Initial ACPI support will probably be merged for 6.4. So maybe it is
> time to get the libvirt side of things going.

Randomly remembered about this. Did ACPI support make it into 6.4
after all? Is now a good time to change libvirt?

-- 
Andrea Bolognani / Red Hat / Virtualization


