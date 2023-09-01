Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0987978FDE0
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:57:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc3hF-0003FW-BZ; Fri, 01 Sep 2023 08:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qc3hB-00035M-4K
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qc3h4-0007XG-4R
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693572969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+E2jSoiMFX5YHgVS9K/PmZgN+QZrcxZHsfz9+TmRs4=;
 b=EJqZn8gI3GOcrLxNT38v1BL/3fvw8Eftn0YvItyNjH1UiSGJ/uWupFMap57A9sWetYg7/O
 gFajciVNa8hocrHv5xGLvAJOfPodRJh8LQr+7G8L5EMzBQyIprMKUzGwiFrA0GiGpTFlCB
 4g1swqRpnBUWWiIVb636PbsFfd7lHc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-QmAzBDKOP4StxFcvI2b8SA-1; Fri, 01 Sep 2023 08:56:05 -0400
X-MC-Unique: QmAzBDKOP4StxFcvI2b8SA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A60A1927C47;
 Fri,  1 Sep 2023 12:56:04 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DA86493110;
 Fri,  1 Sep 2023 12:56:04 +0000 (UTC)
Date: Fri, 1 Sep 2023 07:56:02 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 0/7] move softmmu options processing from os-posix.c
 to vl.c
Message-ID: <hp2v3a577nfuninxwxxjmkanzrfspqlplvb4jfqogaluhjvorl@cvh3tobx2glm>
References: <cover.1691843673.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691843673.git.mjt@tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, Aug 12, 2023 at 03:47:54PM +0300, Michael Tokarev wrote:
> qemu_init() calls os_parse_cmd_args(), which is obviously a very vl.c-specicic
> piece of code.  It looks like when moving vl.c to softmmu/, os-posix.c should've
> been moved too (together with os-win32.c).  But there are other functions in
> os-posix.c which are used by other parts of the code, eg qemu-nbd or
> qemu-storage-daemon both uses parts from there.  The result is rather ugly.
> One of the side-effects is that even if system build is disabled, we still
> have to compile util/async-teardown.c, since it is used in os-posix.c, - and
> this one can not be built on ia64 due to lack of clone syscall.  But qemu-nbd
> does not need async-teardown, which is also very softmmu-specific.
> 
> This patchset tries to address these defects.  It moves the "bottom half" of
> vl.c options processing back into vl.c, effectively undoing commit 59a5264b99434
> from 2010.  We do not have many os-specific options, and this move makes
> qemu_init() the only function which processes options, all in the single
> place, which is, in my opinion, easier to manage.
> 
> Before this move, lower-level constructs (chroot, runas) are being exported.
> 
> In the end, we have almost no softmmu-related things in os-posix.c, and the
> same functionality can be actually used in qemu-storage-daemon or qemu-nbd.
> For qemu-nbd, it is now possible to switch to using -runas/-chroot/etc the
> same way as qemu-storage-daemon does, instead of having one more abstraction
> named qemu_daemon().

Given that qemu-nbd is affected, I'm happy to queue this through my
NBD tree if no one else picks it up first.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


