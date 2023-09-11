Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB2D79AB1B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 21:50:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfmtt-0004Cy-6H; Mon, 11 Sep 2023 15:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qfmtq-0004Cm-QJ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 15:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qfmto-0005qp-FU
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 15:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694461723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ifWUAVfDqho/o27FddblXTrLsY/E7hxDXNLl04QY1Y=;
 b=cVJCI82Up+j65xgyC+gZ73hDmjjaI4DICavjE3wWnRkCEzxWXG0risXp4QcXNhPr3g2uSg
 7fWBT10EAWlRaZMuQB97bSqDgzHYcrvZ0RPVMGSP190L44XpvgwkNJK51GncxT/yrkdOag
 +K70qQMhil436jlTf2I8xOltBX9LyWg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-qF--A_oyPn2mThLAg56Ssg-1; Mon, 11 Sep 2023 15:48:41 -0400
X-MC-Unique: qF--A_oyPn2mThLAg56Ssg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76f025ed860so69781185a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 12:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694461721; x=1695066521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ifWUAVfDqho/o27FddblXTrLsY/E7hxDXNLl04QY1Y=;
 b=i5D4aidP3Dwm8hqEeR4ivkd9mSAN9IeCezDF4J4vrgQALN2aoSc9dKmngN0XyQBTVe
 8zEeYZXVVtDZVYsgPRbAEi+nYYXuwsObxbMW4gh0a3ukqIYXzXoLQSacroidDiDX6GhZ
 wRMH4ofm2g8rjoOAqYGxSZ2VehsghcMnSYCo/8nUog8uwUk7CME5DVsHKeji7K2avB0c
 9kcgQivFzzYj6X4XtUoOMYN0F4Pcw8QcIpA26mR6nigO2d1uc+7RXpcSLaOkHmg71yHX
 yEaxgvQaSg8Q+QDO8if1pKwJVc884Ut0tRkpFj7KrMeJgkCl3EF//xUOo2vOfi+Lq/u0
 Xd/g==
X-Gm-Message-State: AOJu0YwKBQAL3q9TVpGKPgZ04ni8k+JtQjueaH3awKJ3fkEf5wQ7JpeH
 CkTt7BBj177IZBJnSdGuOPH/2OQe80H7KGnNdTgmHMoZrSpcKI4yZI0AYxb66mmmziYn9dXO+nn
 NQM7juASWZKSfQ5c=
X-Received: by 2002:a05:620a:4403:b0:76f:1118:9b62 with SMTP id
 v3-20020a05620a440300b0076f11189b62mr11504556qkp.3.1694461721294; 
 Mon, 11 Sep 2023 12:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgzF5/Ezx4XSzszoln295XxlRI7kG8lRay3VpJiYXPU0rw+wygkOcDSpOBMTION77VW76TdA==
X-Received: by 2002:a05:620a:4403:b0:76f:1118:9b62 with SMTP id
 v3-20020a05620a440300b0076f11189b62mr11504541qkp.3.1694461721053; 
 Mon, 11 Sep 2023 12:48:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s16-20020a05620a16b000b0076d0312b8basm2694674qkj.131.2023.09.11.12.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 12:48:40 -0700 (PDT)
Date: Mon, 11 Sep 2023 15:48:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: William Roche <william.roche@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Message-ID: <ZP9vFuY0r29RSU1g@x1n>
References: <20230906135951.795581-1-william.roche@oracle.com>
 <20230906135951.795581-2-william.roche@oracle.com>
 <e2adce18-7aef-5445-352a-01e789619fac@oracle.com>
 <ZPiX4YLAT5HjxUAJ@x1n>
 <3968a8e5-4010-0c97-7e1b-0dcba64ade01@oracle.com>
 <40a7a752-7bdd-968d-ec5a-2a58f72a6d32@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40a7a752-7bdd-968d-ec5a-2a58f72a6d32@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Sep 09, 2023 at 03:57:44PM +0100, Joao Martins wrote:
> > Should I continue to treat them as zero pages written with
> > save_zero_page_to_file ? 
> 
> MCE had already been forward to the guest, so guest is supposed to not be using
> the page (nor rely on its contents). Hence destination ought to just see a zero
> page. So what you said seems like the best course of action.
> 
> > Or should I consider the case of an ongoing compression
> > use and create a new code compressing an empty page with save_compress_page() ?
> > 
> The compress code looks to be a tentative compression (not guaranteed IIUC), so
> I am not sure it needs any more logic that just adding at the top of
> ram_save_target_page_legacy() as Peter suggested?
> 
> > And what about an RDMA memory region impacted by a memory error ?
> > This is an important aspect.
> > Does anyone know how this situation is dealt with ? And how it should be handled
> > in Qemu ?
> > 
> 
> If you refer to guest RDMA MRs that is just guest RAM, not sure we are even
> aware of those from qemu. But if you refer to the RDMA transport that sits below
> the Qemu file (or rather acts as an implementation of QemuFile), so handling in
> ram_save_target_page_legacy() already seems to cover it.

I'm also not familiar enough with RDMA, but it looks tricky indeed. AFAIU
it's leveraging RDMA_CONTROL_COMPRESS for zero pages for now (with
RDMACompress.value==0), so it doesn't seem to be using generic migration
protocols.

If we want to fix all places well, one way to consider is to introduce
migration_buffer_is_zero(), which can be a wrapper for buffer_is_zero() by
default, but also returns true for poisoned pages before reading the
buffer.  Then we use it in all three places:

  - For compression, in do_compress_ram_page()
  - For RDMA, in qemu_rdma_write_one()
  - For generic migration, in save_zero_page_to_file() (your current patch)

I suppose then all cases will be fixed.  We need to make sure we'll always
use migration_buffer_is_zero() as the 1st thing to call when QEMU wants to
migrate a target page.  Maybe it'll worth a comment above that function.

Thanks,

-- 
Peter Xu


