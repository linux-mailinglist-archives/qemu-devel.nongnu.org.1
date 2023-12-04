Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA3803A22
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:25:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABk7-0000US-5p; Mon, 04 Dec 2023 11:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rABk5-0000UJ-Vp
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rABk3-0003Gu-Tt
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701707058;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9QV1TungJou5kjZGFS5XGVjT9Dxgwyj1auyL1NUzlN8=;
 b=F40N8tO3p0rr55a0KJezCt20En/PNGwvzKER5stt+BqFHnmVMqYFd1xXbrNkrplIrLQ8C2
 Ejxj7YNDY19H93X3mSJWbqC08t8TeEYwG+xmfevb8Zxc0LaDF/hbgacnn8zQhJnJswTB9A
 fBuvhxnZBPgE/e4Ms4EwdiX/BdeYniM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-PL9RjHR1Pl-NpgoBKW29FA-1; Mon,
 04 Dec 2023 11:24:15 -0500
X-MC-Unique: PL9RjHR1Pl-NpgoBKW29FA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C199C3816C8E;
 Mon,  4 Dec 2023 16:24:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 999F65028;
 Mon,  4 Dec 2023 16:24:13 +0000 (UTC)
Date: Mon, 4 Dec 2023 16:24:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC 0/8] Support generic Luks encryption
Message-ID: <ZW39KzXUbWrJUdQH@redhat.com>
References: <cover.1701705003.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701705003.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Dec 05, 2023 at 12:06:17AM +0800, Hyman Huang wrote:
> This functionality was motivated by the following to-do list seen
> in crypto documents:
> https://wiki.qemu.org/Features/Block/Crypto 
> 
> The last chapter says we should "separate header volume": 
> 
> The LUKS format has ability to store the header in a separate volume
> from the payload. We should extend the LUKS driver in QEMU to support
> this use case.
> 
> As a proof-of-concept, I've created this patchset, which I've named
> the Gluks: generic luks. As their name suggests, they offer encryption
> for any format that QEMU theoretically supports.

I don't see the point in creating a new driver.

I would expect detached header support to be implemented via an
optional new 'header' field in the existing driver. ie

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ca390c5700..48d1f2a974 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3352,11 +3352,15 @@
 #     decryption key (since 2.6). Mandatory except when doing a
 #     metadata-only probe of the image.
 #
+# @header: optional reference to the location of a blockdev
+#     storing a detached LUKS heaer
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsLUKS',
   'base': 'BlockdevOptionsGenericFormat',
-  'data': { '*key-secret': 'str' } }
+  'data': { '*key-secret': 'str',
+            "*header-file': 'BlockdevRef'} }
 
 ##
 # @BlockdevOptionsGenericCOWFormat:
@@ -4941,9 +4945,18 @@
 #
 # Driver specific image creation options for LUKS.
 #
-# @file: Node to create the image format on
+# @file: Node to create the image format on. Mandatory
+#     unless a detached header file is specified using
+#     @header.
 #
-# @size: Size of the virtual disk in bytes
+# @size: Size of the virtual disk in bytes.  Mandatory
+#     unless a detached header file is specified using
+#     @header.
+#
+# @header: optional reference to the location of a blockdev
+#     storing a detached LUKS heaer. The @file option is
+#     is optional when this is given, unless it is desired
+#     to perform pre-allocation
 #
 # @preallocation: Preallocation mode for the new image (since: 4.2)
 #     (default: off; allowed values: off, metadata, falloc, full)
@@ -4952,8 +4965,9 @@
 ##
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
-  'data': { 'file':             'BlockdevRef',
-            'size':             'size',
+  'data': { '*file':            'BlockdevRef',
+            '*size':            'size',
+            '*header':          'BlockdevRef'
             '*preallocation':   'PreallocMode' } }
 
 ##

It ends up giving basicallly the same workflow as you outline,
without needing the new block driver

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


