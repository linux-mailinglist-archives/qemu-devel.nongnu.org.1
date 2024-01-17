Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B7F830508
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:16:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ4pn-0002ua-St; Wed, 17 Jan 2024 07:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rQ4pj-0002sf-PM
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rQ4pd-0005b8-Vp
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705493744;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E58t8Y2R+LEx17cgShvopzsVmM47jvEGDZJ0BKUaCho=;
 b=AAJZEWkc0uM8b3PtpCi6Lo8Ntce9UZhaZ3HpWhNAjJWi8uRSj8D+e6WY0W8ZxmARiaGz2U
 HlIAhNB1nT04Ddbp6zpT1urDUZuc4Nw7VGAUEE232RQ+uTpLyBzQK0f9RWq72XSHwqYRRR
 VJb39dwKXzVmz+Kle/9coh6hQhKLtVQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-8_1YauKyOVGr-qawGtYvfw-1; Wed,
 17 Jan 2024 07:15:39 -0500
X-MC-Unique: 8_1YauKyOVGr-qawGtYvfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE7961C068CC;
 Wed, 17 Jan 2024 12:15:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7814C40C6EB9;
 Wed, 17 Jan 2024 12:15:37 +0000 (UTC)
Date: Wed, 17 Jan 2024 12:15:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Markus Frank <m.frank@proxmox.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] ui: reject extended clipboard message if not activated
Message-ID: <ZafE54y1-9QYfgnz@redhat.com>
References: <20240115095119.654271-1-berrange@redhat.com>
 <05616f9e-82a8-44c2-860d-68074fc4c2f5@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05616f9e-82a8-44c2-860d-68074fc4c2f5@tls.msk.ru>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jan 17, 2024 at 03:10:30PM +0300, Michael Tokarev wrote:
> 15.01.2024 12:51, Daniel P. Berrangé wrote:
> > The extended clipboard message protocol requires that the client
> > activate the extension by requesting a psuedo encoding. If this
> > is not done, then any extended clipboard messages from the client
> > should be considered invalid and the client dropped.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> > 
> > The need for fix was identified as part of investigation for
> > CVE-2023-6683. This does NOT, however, fix that CVE as it only
> > addresses one of the problem codepaths that can trigger that
> > CVE.
> 
> This might be a good pick for -stable too, in addition to the actual
> CVE-2023-6683 fix (adding -stable).

Agreed, both would be a good idea for stable.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


