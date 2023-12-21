Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E98C581B616
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 13:41:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGILI-0005b5-9I; Thu, 21 Dec 2023 07:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGILF-0005ak-PC
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 07:39:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGILE-0002Dk-5W
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 07:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703162394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HXeDIGnQrgDfqiyJaifg9Gk6BsLAMtAKAG/DYCO8STQ=;
 b=XbeF7fzE45X10gdopqB9YQC6zexVsi3QhR2DDsNMV8abvTbvZ2aBabxcWDVA19AjFLsmDO
 TZ6/sC2Ly7kfiRon2yexiUPc9VQ2Wldg4P1L7mZS3EBOXnQXSGXZgxf8TOjGjXnqb68wqJ
 TNeGpWmfyboxZZu5AiW7/VRDuokn5h0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-eL0p0_8EOXOfVliDSERqWg-1; Thu, 21 Dec 2023 07:39:51 -0500
X-MC-Unique: eL0p0_8EOXOfVliDSERqWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02A04101A52A;
 Thu, 21 Dec 2023 12:39:51 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5726C40C6EB9;
 Thu, 21 Dec 2023 12:39:49 +0000 (UTC)
Date: Thu, 21 Dec 2023 13:39:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/4] qdev-properties: alias all object class properties
Message-ID: <ZYQyFLfsOvUmeuco@redhat.com>
References: <20231220134755.814917-1-stefanha@redhat.com>
 <20231220134755.814917-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220134755.814917-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

Am 20.12.2023 um 14:47 hat Stefan Hajnoczi geschrieben:
> qdev_alias_all_properties() aliases a DeviceState's qdev properties onto
> an Object. This is used for VirtioPCIProxy types so that --device
> virtio-blk-pci has properties of its embedded --device virtio-blk-device
> object.
> 
> Currently this function is implemented using qdev properties. Change the
> function to use QOM object class properties instead. This works because
> qdev properties create QOM object class properties, but it also catches
> any QOM object class-only properties that have no qdev properties.
> 
> This change ensures that properties of devices are shown with --device
> foo,\? even if they are QOM object class properties.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

We should also update the comment to refer to properties in general
rather than just qdev properties. I can squash in the following hunk.

Kevin


diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 25743a29a0..09aa04ca1e 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -230,8 +230,8 @@ void qdev_property_add_static(DeviceState *dev, Property *prop);
  * @target: Device which has properties to be aliased
  * @source: Object to add alias properties to
  *
- * Add alias properties to the @source object for all qdev properties on
- * the @target DeviceState.
+ * Add alias properties to the @source object for all properties on the @target
+ * DeviceState.
  *
  * This is useful when @target is an internal implementation object
  * owned by @source, and you want to expose all the properties of that


