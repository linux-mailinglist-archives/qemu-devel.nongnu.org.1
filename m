Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F08167E602C
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 22:49:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0qQZ-00083y-ED; Wed, 08 Nov 2023 16:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r0qQX-00083W-DF
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r0qQV-0007p0-FZ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699480170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ez8IJy1a3BA4fs9XHfB8x7X2MAdhj78GynjkmlHeeOM=;
 b=bPca4mtZIqYfusYj9I+nZCQJessnA+o77wlVI5VPqVe5MvWfQMD9AzJGFDwVmFZiaAl3KS
 TdZmhpND3d/uavSr8Tl51f03pPTTYxDl1upj/Sh7DebckonzPS+b/+uSryRC3/slolQ9JP
 CgU+klvOwFPQbA4XfEz4ZDPPfs6cbUM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-LDhLsIV0PL2Nowk0t98rRg-1; Wed, 08 Nov 2023 16:49:28 -0500
X-MC-Unique: LDhLsIV0PL2Nowk0t98rRg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77a02ceef95so2509985a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 13:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699480168; x=1700084968;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ez8IJy1a3BA4fs9XHfB8x7X2MAdhj78GynjkmlHeeOM=;
 b=s/EMe9EGj81KGTQNld6d6O50yZ5PunYewnAaosJtJWLtzskWoPaswLo3DT66XJ5cwM
 SX17ZhCyW8C0HH2FthFNBud0hdhzXPDHxLuGrUFoFDVQz+WPlNBl+esXvlJqOBftt6jY
 d0+gbfMCXXqv3XtfzK1nE7AJdUGl5BB2QTU1uZ+KB/D8yACAeJ2dMoCRntAlYW1Jo/0r
 DkwepLI7/3MUJrV4swTPmZ92e8b3VJ9WY4o245ZCPqDM1+6ztNRAne28xb/TV8Li/E76
 H78cBpe3J00CltuPEdSNOZe/BqAJgHswJwFQXT9dvhjRJtAfYyaj8fVjgJ3mIgci3s9M
 t7qQ==
X-Gm-Message-State: AOJu0YxTLOgeAcbQmMzKA39FOWBE9B9tijLOVMHRFeuNMPpeitd3k5LO
 65ANiLM1L/+XUQdR6XlktrCVWwAmoDAdqP3uArSjgxu0jpFJKbQ47td9QsUFChkrpuvZJjHFLLE
 Dt0fPlas6Vxlccl0=
X-Received: by 2002:ad4:4a02:0:b0:670:b357:82bd with SMTP id
 m2-20020ad44a02000000b00670b35782bdmr3060657qvz.6.1699480168267; 
 Wed, 08 Nov 2023 13:49:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX2Q5Zj+ZE6gAUHwPreew7m5IIEHQDHzbSYv0E5vkd5egXaqTMSUJqNVG5MlTYunLxrtvevw==
X-Received: by 2002:ad4:4a02:0:b0:670:b357:82bd with SMTP id
 m2-20020ad44a02000000b00670b35782bdmr3060643qvz.6.1699480167890; 
 Wed, 08 Nov 2023 13:49:27 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u16-20020a0cec90000000b0064f4ac061b0sm1491509qvo.12.2023.11.08.13.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 13:49:27 -0800 (PST)
Date: Wed, 8 Nov 2023 16:49:25 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, lizhijian@fujitsu.com,
 pbonzini@redhat.com, quintela@redhat.com, leobras@redhat.com,
 joao.m.martins@oracle.com, lidongchen@tencent.com
Subject: Re: [PATCH v5 0/2] Qemu crashes on VM migration after an handled
 memory error
Message-ID: <ZUwCZdZj-vZD1NJC@x1n>
References: <ZS6ksf8o7dJ8mzUe@x1n>
 <20231106220319.456765-1-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106220319.456765-1-william.roche@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Nov 06, 2023 at 10:03:17PM +0000, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> 
> Note about ARM specificities:
> This code has a small part impacting more specificaly ARM machines,
> that's the reason why I added qemu-arm@nongnu.org -- see description.
> 
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
> In order to thoroughly correct this problem, the poison information should
> follow the migration which represents several difficulties:
> - poisoning a page on the destination machine to replicate the source
>   poison requires CAP_SYS_ADMIN priviledges, and qemu process may not
>   always run as a root process
> - the destination kernel needs to be configured with CONFIG_MEMORY_FAILURE
> - the poison information would require a memory transfer protocol
>   enhancement to provide this information
> (The current patches don't provide any of that)
> 
> But if we rely on the fact that the a running VM kernel is correctly
> dealing with memory poison it is informed about: marking the poison page
> as inaccessible, we could count on the VM kernel to make sure that
> poisoned pages are not used, even after a migration.
> In this case, I suggest to treat the poisoned pages as if they were
> zero-pages for the migration copy.
> This fix also works with underlying large pages, taking into account the
> RAMBlock segment "page-size".
> 
> Now, it leaves a case that we have to deal with: if a memory error is
> reported to qemu but not injected into the running kernel...
> As the migration will go from a poisoned page to an all-zero page, if
> the VM kernel doesn't prevent the access to this page, a memory read
> that would generate a BUS_MCEERR_AR error on the source platform, could
> be reading zeros on the destination. This is a memory corruption.
> 
> So we have to ensure that all poisoned pages we set to zero are known by
> the running kernel. But we have a problem with platforms where BUS_MCEERR_AO
> errors are ignored, which means that qemu knows about the poison but the VM
> doesn't. For the moment it's only the case for ARM, but could later be
> also needed for AMD VMs.
> See https://lore.kernel.org/all/20230912211824.90952-3-john.allen@amd.com/
> 
> In order to avoid this possible silent data corruption situation, we should
> prevent the migration when we know that a poisoned page is ignored from the VM.
> 
> Which is, according to me, the smallest fix we need  to avoid qemu crashes
> on migration after an handled memory error, without introducing a possible
> corruption situation.
> 
> This fix is scripts/checkpatch.pl clean.
> Unit test: Migration blocking succesfully tested on ARM -- injected AO error
> blocks it. On x86 the same type of error being relayed doesn't block.
> 
> v2:
>   - adding compressed transfer handling of poisoned pages
> 
> v3:
>   - Included the Reviewed-by and Tested-by information on first patch
>   - added a TODO comment above control_save_page()
>     mentioning Zhijian's feedback about RDMA migration failure.
> 
> v4:
>   - adding a patch to deal with unknown poison tracking (impacting ARM)
>     (not using migrate_add_blocker as this is not devices related and
>     we want to avoid the interaction with --only-migratable mechanism)
> 
> v5:
>   - Updating the code to the latest version
>   - adding qemu-arm@nongnu.org for a complementary review
> 
> 
> William Roche (2):
>   migration: skip poisoned memory pages on "ram saving" phase
>   migration: prevent migration when a poisoned page is unknown from the
>     VM

I hope someone from arch-specific can have a quick look at patch 2..

One thing to mention is unfortunately waiting on patch 2 means we'll miss
this release. Actually it is already missed.. softfreeze yesterday [1].  So
it may likely need to wait for 9.0.

[1] https://wiki.qemu.org/Planning/8.2

-- 
Peter Xu


