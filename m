Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B70870B6DF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 09:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q10ET-0007KR-HH; Mon, 22 May 2023 03:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q10EP-0007Js-Tg
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q10EO-0004B0-DS
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684741523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N7k/PTI8dRIIFL0er+47FZ+kl8Ers0OY2Yto4p9ntZ8=;
 b=dFX5q5iPYWobcWFbarEp5fz/eYqzbwd4Mb/1lHbBNVe3jnvECt5FUuAQqTAZOafLQBXhf2
 n4AFrDXF4HrR/dO6RzfPfqLt8krf5IVTYxuZhK1LwaS2ZpFDiYA648W4SE95mlAWSSjfaD
 tDrgN5WZhbBzqGfztk7QACFAAw0V9i0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-pvVv4835Nd-aMNSXj6vMAg-1; Mon, 22 May 2023 03:45:19 -0400
X-MC-Unique: pvVv4835Nd-aMNSXj6vMAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61B741C03375;
 Mon, 22 May 2023 07:45:19 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6EC820296C6;
 Mon, 22 May 2023 07:45:18 +0000 (UTC)
Date: Mon, 22 May 2023 09:45:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/21] Block layer patches
Message-ID: <ZGsdjRQIbgIcaAhA@redhat.com>
References: <20230519171806.435109-1-kwolf@redhat.com>
 <1513489b-2d86-3722-94fa-1a560ac31aa8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513489b-2d86-3722-94fa-1a560ac31aa8@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Am 19.05.2023 um 21:11 hat Richard Henderson geschrieben:
> On 5/19/23 10:18, Kevin Wolf wrote:
> > The following changes since commit d009607d08d22f91ca399b72828c6693855e7325:
> > 
> >    Revert "arm/kvm: add support for MTE" (2023-05-19 08:01:15 -0700)
> > 
> > are available in the Git repository at:
> > 
> >    https://repo.or.cz/qemu/kevin.git  tags/for-upstream
> > 
> > for you to fetch changes up to 95fdd8db61848d31fde1d9b32da7f3f76babfa25:
> > 
> >    iotests: Test commit with iothreads and ongoing I/O (2023-05-19 19:16:53 +0200)
> > 
> > ----------------------------------------------------------------
> > Block layer patches
> > 
> > - qcow2 spec: Rename "zlib" compression to "deflate"
> > - Honour graph read lock even in the main thread + prerequisite fixes
> > - aio-posix: do not nest poll handlers (fixes infinite recursion)
> > - Refactor QMP blockdev transactions
> > - graph-lock: Disable locking for now
> > - iotests/245: Check if 'compress' driver is available
> 
> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as
> appropriate.

Hm, I just pulled, and it doesn't seem to be actually there in master?

Kevin


