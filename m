Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E0079D8E4
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8ND-0000vD-Nx; Tue, 12 Sep 2023 14:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qg8NB-0000ti-12
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qg8N7-0004Y0-Py
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694544264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26MpT7rXMhoB1DTYOdrQylUHhqN43H+2uUmH2u4TRt0=;
 b=MoZZH7FNy/7v6J7YB1ui5wDt8fqFhh4g1DAIivDoWNSVzrVckfXLs5Ljx6mjuoQ5j21nzz
 VOe/mBlxvYAfw5uGmjqt55I7o2yEcAlMexl8ks2US1y64xbi322yUBeiFApgRTWnML6K16
 CLFe2pD+WyclzsHtsawLymjOtYxMlUU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-3rw8Kxj9OC6ZHVUeQxcEqg-1; Tue, 12 Sep 2023 14:44:22 -0400
X-MC-Unique: 3rw8Kxj9OC6ZHVUeQxcEqg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4122babcb87so15992381cf.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 11:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694544262; x=1695149062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26MpT7rXMhoB1DTYOdrQylUHhqN43H+2uUmH2u4TRt0=;
 b=hKzgwHfVV3ULC9cq4s2kA9Ef3m0eU1leVCB4jBIpbqZPPeMhhfx5QRwCQHzqJouBoD
 A7ouq5qtwsFSllp9eEKbMVgf+3O9WXWA0MlSXqE/wcwY3MtwPumQhxkwT/MKqOFFmxzf
 gBPkIAucWIb2p0aosyCKKKYqaxfSkgpyS4lbaKuuJyXV6Aw3gcbhrgX6DOLaCVWa+JWe
 zKN4G/HyDeX1n19qbO1gaJFECCgJql/HnotBV6p+/KSDJ5wGNSn6u8EB88fMX/BoFl//
 JrsQficm7dQ4CKDJMSnJBFsBFDFvIXknaV/tyfF+oT+tMtGtkqhihXntky+pJcyPaSib
 9Icw==
X-Gm-Message-State: AOJu0Yxv7cKB3VzMYJkYM1bZZKFp62aSzQHa9tR6VwPUO1jKeOTqwMB7
 aZhJYb4kx4ZRPeouY+gjFJbNkIhZap60qWaQH6ZXkr+QPSsRy+3K8gr5/UbavzM1QKWmCQSezMN
 XJK5ZMHLv32D0LME=
X-Received: by 2002:a05:620a:458f:b0:76f:27af:2797 with SMTP id
 bp15-20020a05620a458f00b0076f27af2797mr352961qkb.0.1694544262405; 
 Tue, 12 Sep 2023 11:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQFqDlyNXYB8NI/+rtqLaLfYABQILsLyZOafjuS/BbO05a5DeqdFzulQvCdeloynTvMSKsLQ==
X-Received: by 2002:a05:620a:458f:b0:76f:27af:2797 with SMTP id
 bp15-20020a05620a458f00b0076f27af2797mr352950qkb.0.1694544262098; 
 Tue, 12 Sep 2023 11:44:22 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a17-20020a05620a16d100b0076ce061f44dsm3388028qkn.25.2023.09.12.11.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 11:44:21 -0700 (PDT)
Date: Tue, 12 Sep 2023 14:44:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: William Roche <william.roche@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org,
 lizhijian@fujitsu.com, lidongchen@tencent.com
Subject: Re: [PATCH 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Message-ID: <ZQCxg+M2IpecRT8w@x1n>
References: <20230906135951.795581-1-william.roche@oracle.com>
 <20230906135951.795581-2-william.roche@oracle.com>
 <e2adce18-7aef-5445-352a-01e789619fac@oracle.com>
 <ZPiX4YLAT5HjxUAJ@x1n>
 <3968a8e5-4010-0c97-7e1b-0dcba64ade01@oracle.com>
 <40a7a752-7bdd-968d-ec5a-2a58f72a6d32@oracle.com>
 <ZP9vFuY0r29RSU1g@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZP9vFuY0r29RSU1g@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 11, 2023 at 03:48:38PM -0400, Peter Xu wrote:
> On Sat, Sep 09, 2023 at 03:57:44PM +0100, Joao Martins wrote:
> > > Should I continue to treat them as zero pages written with
> > > save_zero_page_to_file ? 
> > 
> > MCE had already been forward to the guest, so guest is supposed to not be using
> > the page (nor rely on its contents). Hence destination ought to just see a zero
> > page. So what you said seems like the best course of action.
> > 
> > > Or should I consider the case of an ongoing compression
> > > use and create a new code compressing an empty page with save_compress_page() ?
> > > 
> > The compress code looks to be a tentative compression (not guaranteed IIUC), so
> > I am not sure it needs any more logic that just adding at the top of
> > ram_save_target_page_legacy() as Peter suggested?
> > 
> > > And what about an RDMA memory region impacted by a memory error ?
> > > This is an important aspect.
> > > Does anyone know how this situation is dealt with ? And how it should be handled
> > > in Qemu ?
> > > 
> > 
> > If you refer to guest RDMA MRs that is just guest RAM, not sure we are even
> > aware of those from qemu. But if you refer to the RDMA transport that sits below
> > the Qemu file (or rather acts as an implementation of QemuFile), so handling in
> > ram_save_target_page_legacy() already seems to cover it.
> 
> I'm also not familiar enough with RDMA, but it looks tricky indeed. AFAIU
> it's leveraging RDMA_CONTROL_COMPRESS for zero pages for now (with
> RDMACompress.value==0), so it doesn't seem to be using generic migration
> protocols.
> 
> If we want to fix all places well, one way to consider is to introduce
> migration_buffer_is_zero(), which can be a wrapper for buffer_is_zero() by
> default, but also returns true for poisoned pages before reading the
> buffer.  Then we use it in all three places:
> 
>   - For compression, in do_compress_ram_page()
>   - For RDMA, in qemu_rdma_write_one()

Ah, this may not be enough.. sorry.

It seems this is only one path that RDMA will use to save a target page,
for (!rdma->pin_all || !block->is_ram_block) && !block->remote_keys[chunk].

RDMA seems to also possible to merge buffers if virtually continuous
(qemu_rdma_buffer_mergable()), so IIUC it may not trigger an immediate
access to the guest page until later if it finds continuous pages and skip
even more logic.  I suspect that's also problematic for poisoned pages so
we should not allow any merged buffer to contain a poisoned page.

Not sure how complicated will it be to fix rdma specifically, copy again
two rdma developers.  One option is we state the issue in rdma and fix
non-rdma first.  Looks like rdma needs its own fix anyway.

>   - For generic migration, in save_zero_page_to_file() (your current patch)
> 
> I suppose then all cases will be fixed.  We need to make sure we'll always
> use migration_buffer_is_zero() as the 1st thing to call when QEMU wants to
> migrate a target page.  Maybe it'll worth a comment above that function.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


