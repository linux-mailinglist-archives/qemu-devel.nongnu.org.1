Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7ABB039C8
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 10:47:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEow-0001Vf-A0; Mon, 14 Jul 2025 04:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubESJ-0003ND-LL
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubESH-0006Yu-Ki
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752481351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0S6SIp8CfOLSA9YxHzrvsHzcxCr1KclbvOloeN0Wp0=;
 b=FrwOx9eRmoiMqiAJgzqbgg8EJ8rA4eC8d6jo6HO2gyP60Yh3iTdmwTdIaM7uecUoA4XifX
 WRu65bMiY02/B5/+QUStOc4l43gqKIGIi+LaIZL8tDdDQDFkzy+u9Bse8EY8vFEUc9IEXc
 FW2sC3a02OHtTVzpPLY4EH23BJlkAbQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-LbSLjHM-M3e1z7SYbPwfpw-1; Mon,
 14 Jul 2025 04:22:30 -0400
X-MC-Unique: LbSLjHM-M3e1z7SYbPwfpw-1
X-Mimecast-MFC-AGG-ID: LbSLjHM-M3e1z7SYbPwfpw_1752481349
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA3A6180029E; Mon, 14 Jul 2025 08:22:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12F9919560A3; Mon, 14 Jul 2025 08:22:25 +0000 (UTC)
Date: Mon, 14 Jul 2025 09:22:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/2] ui: fix VNC endian regression & improve tracing
Message-ID: <aHS-Pm54ZIZTDpbd@redhat.com>
References: <20250604162243.452791-1-berrange@redhat.com>
 <887fbbd8-9e92-45b1-bdac-77d18a9b82bb@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <887fbbd8-9e92-45b1-bdac-77d18a9b82bb@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sat, Jul 12, 2025 at 11:26:29AM +0300, Michael Tokarev wrote:
> On 04.06.2025 19:22, Daniel P. Berrangé wrote:
> > 
> > Daniel P. Berrangé (2):
> >    ui: fix setting client_endian field defaults
> >    ui: add trace events for all client messages
> > 
> >   ui/trace-events | 14 +++++++++++++
> >   ui/vnc.c        | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 67 insertions(+)
> 
> Hi!
> 
> Has this series been forgotten?  It seems it should be in 10.1
> and in 10.0.3.   It has 2 R-Bs.  Is it time to send a PullReq?

I have it pending a PR

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


