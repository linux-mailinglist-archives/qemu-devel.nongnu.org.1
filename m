Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77867A100C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 23:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qguEJ-0000wu-Ff; Thu, 14 Sep 2023 17:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qguE1-0000wc-1t
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qguDy-0004ol-Pb
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694728208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MooOwcYdDpgJZNL6WcSa91xdmyH+lV/Rbv6wRB3/whI=;
 b=fqX01xggsvj3KZSUpouXcDE0SExscFX2jLVPh5Ss5WI/fTXyIxkEdbFzh2lGlpk4E7E+Yb
 zbfQxN9fFSofFVsOve8+/07FkZCKfxzh37R3JTaenLHPaTfh6NTOEJQyOlYR1OgwgL0Dq4
 7j09y0BkRJQDslPjUApkbx5E4CNAkcc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-_UYA5Vb8MvOA_nIZrRFAjQ-1; Thu, 14 Sep 2023 17:50:07 -0400
X-MC-Unique: _UYA5Vb8MvOA_nIZrRFAjQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6b9de434705so326157a34.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 14:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694728206; x=1695333006;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MooOwcYdDpgJZNL6WcSa91xdmyH+lV/Rbv6wRB3/whI=;
 b=AHgogJKoJoYj8pg7IlT5UOumbOEp9ctH+nWRoX5k3kf49BZyrZ/nYFWFyRpMteuMAw
 Xr5U9DozmGwYEP8OUtwq5DXGzmvV/iiyhMg/vNVY0NcDvYJ9H9GmpoSXqAjwA/wtZX/T
 ZqT3R9iaS2L2r7zkZ6nFraw5fKqiOZtiF/1o2ZZIrQA87a1yxU11yFXrdfqyDV/N7k7v
 vOU0U5OL1Xxp9NwzXgpFUqyWgbc2h0OdkoBPaqPtJxI3ju8SHQzufNQPPG0F7lIZm0J2
 PDibOEcjTph/2oMceoToLoZEC7BJDr5fNN0tVWZ0fFQuHLtAFlc0dn9JtWRWgjQYtZiV
 s2RA==
X-Gm-Message-State: AOJu0YzVQlhlZV+xaYSlYRia2BSieLuogGNC3uwV0sDrZs/JyGFDx/uk
 4M+IbfLOw1doJ3tqfev0InpJ9VvtVC4u4whUm12qy6uAiWOIsgvBxca6IGMIaDclm/6i5Ea1UIF
 Rt/XB4hublXMt05o=
X-Received: by 2002:a05:6358:415:b0:142:d3de:3be9 with SMTP id
 21-20020a056358041500b00142d3de3be9mr67327rwd.0.1694728206546; 
 Thu, 14 Sep 2023 14:50:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9XCKZyW9LXLelOm7KcUJxQZO1HSCSeUmXDKnS6Xr1uUPV0RGJ05JciSfqa4pHdEzSIWZcrg==
X-Received: by 2002:a05:6358:415:b0:142:d3de:3be9 with SMTP id
 21-20020a056358041500b00142d3de3be9mr67304rwd.0.1694728206172; 
 Thu, 14 Sep 2023 14:50:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t2-20020a0cde02000000b0064cff62b310sm761071qvk.13.2023.09.14.14.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 14:50:05 -0700 (PDT)
Date: Thu, 14 Sep 2023 17:50:03 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, quintela@redhat.com,
 leobras@redhat.com, joao.m.martins@oracle.com,
 lizhijian@fujitsu.com, lidongchen@tencent.com
Subject: Re: [PATCH v2 0/1] Qemu crashes on VM migration after an handled
 memory error
Message-ID: <ZQOACz5fHV8niRyf@x1n>
References: <ZQCxg+M2IpecRT8w@x1n>
 <20230914202054.3551250-1-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914202054.3551250-1-william.roche@oracle.com>
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

On Thu, Sep 14, 2023 at 08:20:53PM +0000, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> A Qemu VM can survive a memory error, as qemu can relay the error to the
> VM kernel which could also deal with it -- poisoning/off-lining the impacted
> page.
> This situation creates a hole in the VM memory address space that the VM kernel
> knows about (an unreadable page or set of pages).
> 
> But the migration of this VM (live migration through the network or
> pseudo-migration with the creation of a state file) will crash Qemu when
> it sequentially reads the memory address space and stumbles on the
> existing hole.
> 
> In order to correct this problem, I suggest to treat the poisoned pages as if
> they were zero-pages for the migration copy.
> This fix also works with underlying large pages, taking into account the
> RAMBlock segment "page-size".
> This fix is scripts/checkpatch.pl clean.
> 
> v2:
>   - adding compressed transfer handling of poisoned pages
>  
> Testing: I could verify that migration now works with a poisoned page
> through standard and compressed migration with 4k and large (2M) pages.
> 
> The RDMA transfer is not considered by this patch.
> 
> William Roche (1):
>   migration: skip poisoned memory pages on "ram saving" phase

If there's a new version, please consider adding a TODO above
control_save_page() that poison page is probably broken there, so we can
still remember.

Reviewed-by: Peter Xu <peterx@redhat.com>

Copy:

lizhijian@fujitsu.com, lidongchen@tencent.com

Thanks,

-- 
Peter Xu


