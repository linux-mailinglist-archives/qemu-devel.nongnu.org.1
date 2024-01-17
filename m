Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09593830C7B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 19:12:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQANL-0002gP-Rz; Wed, 17 Jan 2024 13:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQANG-0002fw-Rr
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:10:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQANE-0003Y6-LV
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705515046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DzqfWS8LTlvjc2z988TTO0ksku7nyi+W4ohKmqqdHTs=;
 b=TzIZGtotwyJ0ONBO28zZRBCRph8rX4A6jFpbYUFQaAY53Et/AgZMj6Wpgoeq7PE87tYZC5
 Fe97dNElQ3XSPKJi7xJWkof+hgTRLyDUuqJhUzvOqgApC7UpKRw8BXN81Rxeo97QeHwX4x
 XmMUmhTRpNxwr3Ap865EV/V46jWqzH4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-fyLS2kiEPTODkuxBsbGODQ-1; Wed,
 17 Jan 2024 13:10:45 -0500
X-MC-Unique: fyLS2kiEPTODkuxBsbGODQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 070483C11CEB;
 Wed, 17 Jan 2024 18:10:45 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7991492BE6;
 Wed, 17 Jan 2024 18:10:43 +0000 (UTC)
Date: Wed, 17 Jan 2024 19:10:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 3/3] monitor: only run coroutine commands in
 qemu_aio_context
Message-ID: <ZagYIiy93JUdaWbA@redhat.com>
References: <20240116190042.1363717-1-stefanha@redhat.com>
 <20240116190042.1363717-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116190042.1363717-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 16.01.2024 um 20:00 hat Stefan Hajnoczi geschrieben:
> monitor_qmp_dispatcher_co() runs in the iohandler AioContext that is not
> polled during nested event loops. The coroutine currently reschedules
> itself in the main loop's qemu_aio_context AioContext, which is polled
> during nested event loops. One known problem is that QMP device-add
> calls drain_call_rcu(), which temporarily drops the BQL, leading to all
> sorts of havoc like other vCPU threads re-entering device emulation code
> while another vCPU thread is waiting in device emulation code with
> aio_poll().
> 
> Paolo Bonzini suggested running non-coroutine QMP handlers in the
> iohandler AioContext. This avoids trouble with nested event loops. His
> original idea was to move coroutine rescheduling to
> monitor_qmp_dispatch(), but I resorted to moving it to qmp_dispatch()
> because we don't know if the QMP handler needs to run in coroutine
> context in monitor_qmp_dispatch(). monitor_qmp_dispatch() would have
> been nicer since it's associated with the monitor implementation and not
> as general as qmp_dispatch(), which is also used by qemu-ga.
> 
> A number of qemu-iotests need updated .out files because the order of
> QMP events vs QMP responses has changed.
> 
> Solves Issue #1933.
> 
> Fixes: 7bed89958bfbf40df9ca681cefbdca63abdde39d ("device_core: use drain_call_rcu in in qmp_device_add")
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215192
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2214985
> Buglink: https://issues.redhat.com/browse/RHEL-17369
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


