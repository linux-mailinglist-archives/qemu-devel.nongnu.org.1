Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FCEB49623
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 18:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf3Y-0001HR-U6; Mon, 08 Sep 2025 12:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvf3V-0001Gy-EI
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvf3R-0000r2-UN
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350158;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11AdguSATMcsseCEp9KXfxjhq/FQAbnMTZ4i4OMyRm8=;
 b=PLMtMlNJCPP97g2ny1w7Bgo6pO9zpikgVM+zwOsizA+KFztYCVP5eyZZ+4wpvxX3OjgKfZ
 g4a8wgTEZoJtAtsyLNAOBb74irxfVk9nEDBm01NtuiBEnB5VfkUXZS68/m2Ui/I+LpiJAg
 O8hBZixCP4R73ZRTSrzAv53tB7FfcsU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575--DV_8ueJPEmIGKewnFF2pA-1; Mon,
 08 Sep 2025 12:49:17 -0400
X-MC-Unique: -DV_8ueJPEmIGKewnFF2pA-1
X-Mimecast-MFC-AGG-ID: -DV_8ueJPEmIGKewnFF2pA_1757350156
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C1081800359; Mon,  8 Sep 2025 16:49:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5F6619540ED; Mon,  8 Sep 2025 16:49:12 +0000 (UTC)
Date: Mon, 8 Sep 2025 17:49:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Adam Dorsey <adam.dorsey@twosixtech.com>,
 Adam Dorsey <adam@dorseys.email>
Subject: Re: [PATCH v2 07/18] python: backport 'feat: allow setting read
 buffer limit'
Message-ID: <aL8JBfKwfZnyJh07@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
 <20250903051125.3020805-8-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903051125.3020805-8-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 03, 2025 at 01:11:13AM -0400, John Snow wrote:
> From: Adam Dorsey <adam.dorsey@twosixtech.com>
> 
> Expose the limit parameter of the underlying StreamReader and StreamWriter
> instances.
> 
> This is helpful for the use case of transferring files in and out of a VM
> via the QEMU guest agent's guest-file-open, guest-file-read, guest-file-write,
> and guest-file-close methods, as it allows pushing the buffer size up to the
> guest agent's limit of 48MB per transfer.
> 
> Signed-off-by: Adam Dorsey <adam@dorseys.email>
> cherry picked from commit 9ba6a698344eb3b570fa4864e906c54042824cd6
> cherry picked from commit e4d0d3f835d82283ee0e48438d1b154e18303491
> [Squashed in linter fixups. --js]
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/qmp/protocol.py   | 25 ++++++++++++++++---------
>  python/qemu/qmp/qmp_client.py | 18 ++++++++++++++----
>  2 files changed, 30 insertions(+), 13 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


