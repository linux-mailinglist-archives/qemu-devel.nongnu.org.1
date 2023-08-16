Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E869477E107
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 14:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWFEv-000291-8k; Wed, 16 Aug 2023 08:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWFEW-00027Q-DO
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWFES-0008AF-7b
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692187355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N1bQhdRSwzH1T1WrX1WOX1rYc0BOfoEU+y0xhy2NOyg=;
 b=CvEE6UdGOPsYa7QXcd3j9f8kSAVMUB4NPqTY8yrOorG0DjNjsVU3UDqIxqBPKBgMH5B2QZ
 BW46K0Tt3HdKaIPmNOlZUxtE4LVYaPrgNHHp/1cIJy9oCHGmfavmuNPZTBkN8/BfTMaAFd
 h9d8PX34DiekXC201RufGIHUDrUB/F0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-RQ4RugOxM4W8EJiIJUKNKg-1; Wed, 16 Aug 2023 08:02:30 -0400
X-MC-Unique: RQ4RugOxM4W8EJiIJUKNKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18E8E8007A4;
 Wed, 16 Aug 2023 12:02:30 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CB79140E963;
 Wed, 16 Aug 2023 12:02:28 +0000 (UTC)
Date: Wed, 16 Aug 2023 14:02:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, t.lamprecht@proxmox.com,
 qemu-stable@nongnu.org, hreitz@redhat.com, thuth@redhat.com
Subject: Re: [PATCH] qemu_cleanup: begin drained section after vm_shutdown()
Message-ID: <ZNy60x4ZgcmBjr4P@redhat.com>
References: <20230706131418.423713-1-f.ebner@proxmox.com>
 <20230706144356.16209-1-pbonzini@redhat.com>
 <ZNoxxoSZmCNdy4Ih@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNoxxoSZmCNdy4Ih@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 14.08.2023 um 15:53 hat Kevin Wolf geschrieben:
> Am 06.07.2023 um 16:43 hat Paolo Bonzini geschrieben:
> > Queued, thanks.
> 
> This patch broke qemu-iotests 109 (for raw images), some block jobs get
> now paused once more. This is probably okay, but please double check and
> fix either the reference output or the code.

It actually also broke 185. I'm less sure if not going through
"aborting" is completely harmless. Can you please check why this
happens?

Kevin

--- /home/kwolf/source/qemu/tests/qemu-iotests/185.out
+++ /home/kwolf/source/qemu/build-clang/scratch/qcow2-file-185/185.out.bad
@@ -137,7 +137,7 @@
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "mirror"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "mirror", "len": 33554432, "offset": (filtered), "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "mirror"}}
@@ -160,7 +160,7 @@
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "commit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "commit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "commit", "len": 33554432, "offset": (filtered), "speed": 0, "type": "commit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "commit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "commit"}}


