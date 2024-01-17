Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A3830C64
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 19:05:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQAH2-0007nB-F7; Wed, 17 Jan 2024 13:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQAGv-0007iS-GB
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:04:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQAGt-0002Cv-CU
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705514652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2uhOy0wGPTIXTH0XerVhRR2c5bwt0g7d8Yk9oRFpxw=;
 b=WwpJPhI1E2xq20lOmjZJOgXUsTwlnwtHOkxop+hzlp+o+Rm1DNcRctYNNEkLRmxPpuruJv
 n+AcO4s4IxYqVOsRjwtDeTOgY0OZTQy4wMlX5dtRExv9Jds9t0yFfA80hgCXOAItQSRL1t
 ixetbCstJiXY3O3F0Sxrsc5bBXSlV3Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-2KGljxQLN9Wok-cI1z0ODg-1; Wed, 17 Jan 2024 13:04:09 -0500
X-MC-Unique: 2KGljxQLN9Wok-cI1z0ODg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2E4B832CA6;
 Wed, 17 Jan 2024 18:04:08 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D75B2166B32;
 Wed, 17 Jan 2024 18:04:07 +0000 (UTC)
Date: Wed, 17 Jan 2024 19:04:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/3] iotests: port 141 to Python for reliable QMP testing
Message-ID: <ZagWlhbvlH4Ff01S@redhat.com>
References: <20240116190042.1363717-1-stefanha@redhat.com>
 <20240116190042.1363717-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116190042.1363717-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 16.01.2024 um 20:00 hat Stefan Hajnoczi geschrieben:
> The common.qemu bash functions allow tests to interact with the QMP
> monitor of a QEMU process. I spent two days trying to update 141 when
> the order of the test output changed, but found it would still fail
> occassionally because printf() and QMP events race with synchronous QMP
> communication.
> 
> I gave up and ported 141 to the existing Python API for QMP tests. The
> Python API is less affected by the order in which QEMU prints output
> because it does not print all QMP traffic by default.
> 
> The next commit changes the order in which QMP messages are received.
> Make 141 reliable first.
> 
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

iotests 297 finds problems with the new Python code:

 === pylint ===
+************* Module 141
+141:82:0: C0301: Line too long (86/79) (line-too-long)
+141:93:0: C0301: Line too long (86/79) (line-too-long)
+141:94:0: C0301: Line too long (80/79) (line-too-long)
+141:106:0: C0301: Line too long (85/79) (line-too-long)
+141:107:0: C0301: Line too long (82/79) (line-too-long)
+141:109:0: C0301: Line too long (82/79) (line-too-long)
+141:117:0: C0301: Line too long (86/79) (line-too-long)
+141:120:0: C0301: Line too long (86/79) (line-too-long)
+141:129:0: C0301: Line too long (86/79) (line-too-long)
 === mypy ===
+141:104: error: Value of type variable "Msg" of "log" cannot be "dict[str, Any] | None"  [type-var]
+141:114: error: Value of type variable "Msg" of "log" cannot be "dict[str, Any] | None"  [type-var]
+Found 2 errors in 1 file (checked 37 source files)

Kevin


