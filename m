Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8B8230BE
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 16:45:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL3Pj-0007WI-VG; Wed, 03 Jan 2024 10:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rL3Pi-0007W5-NB
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 10:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rL3Pg-0000Yv-Pe
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 10:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704296651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CV5UVhrlmBlvqNeo+9LwULV/Dxx7vSEHXvg20ocEy4Q=;
 b=UBjXgXRxv8gPpcFUMinYHCFNM0qIyWtZ2rkLTilv1pIf+ig3X8l2pEgNvsRl/86Hnq/24E
 oFntHZD11IydaEUxob529xO1EaT4boQ+dKQnirKLIkh8MLQ76dA569tfY9WxAe7eMTQPxE
 EUZ2QX15fc85pZ4XJiAmCk0fVjgz2SI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-PziTXXQRPkmrm-qejvWT9A-1; Wed,
 03 Jan 2024 10:44:09 -0500
X-MC-Unique: PziTXXQRPkmrm-qejvWT9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 845321C41B22
 for <qemu-devel@nongnu.org>; Wed,  3 Jan 2024 15:44:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 622EA40C6EBC;
 Wed,  3 Jan 2024 15:44:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3F0FA1800605; Wed,  3 Jan 2024 16:44:08 +0100 (CET)
Date: Wed, 3 Jan 2024 16:44:08 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Cole Robinson <crobinso@redhat.com>, qemu-devel@nongnu.org, 
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Re: [PATCH] pc-bios/optionrom: Fix pvh.img ld build failure on
 fedora rawhide
Message-ID: <pxcc3rmq7g7zriwgyv2uiovwicnzfvtvdsngmt47r746sukwxb@shbiglopqrrw>
References: <20231128143647.847668-1-crobinso@redhat.com>
 <ZZVWtxyGkVzBjf0O@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZVWtxyGkVzBjf0O@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

On Wed, Jan 03, 2024 at 12:44:39PM +0000, Daniel P. Berrangé wrote:
> On Tue, Nov 28, 2023 at 09:36:47AM -0500, Cole Robinson wrote:
> > binutils 2.39 shows some warnings when building pvh.img
> > 
> > /usr/bin/ld: warning: pvh.o: missing .note.GNU-stack section implies executable stack
> > /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> > /usr/bin/ld: warning: pvh.img has a LOAD segment with RWX permissions
> > 
> > The latter of which is fatal on Fedora rawhide for some reason.
> > 
> > Add linker options to suppress the errors
> 
> This makes it silent, but I guess someone needs to confirm that this
> option ROM code genuinely does NOT need to have executable stack,
> otherwise the future change that is being warned about could impact
> it ?

Skimming the code it does not look like it depends on a execute-able
stack.  Beside that the option rom will be loaded as raw binary by
seabios and run without paging.  There is nothing which could actually
setup and enforce an NX stack ...

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


