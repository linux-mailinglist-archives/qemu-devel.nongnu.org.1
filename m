Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F78BC8EFE
	for <lists+qemu-devel@lfdr.de>; Thu, 09 Oct 2025 14:03:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6pKT-00078v-Mr; Thu, 09 Oct 2025 08:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6pK5-00074t-1T
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6pJx-0007YQ-Gk
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760011229;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OuNT4n/PNxXJl/TCuE4y4RKdFSX/7th2ucL46KdeMz8=;
 b=cvyBebAY5manGJFoxeIGBpvXDHuWzkz8zjtBaUnxlwp5nb13ymG96zjqhvbwvkM8NJJ7Hp
 ypzi0C8QMwtiKux+8yP7TLrAZkfuAl21Kji9UmyGD8QycT4CuQx8kujRIR3caQRUDvSDUP
 p39vby0ek8hDRLidvUpPIINw9I6atMI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-9uLKwMdnMXWjcGV7stfQTg-1; Thu,
 09 Oct 2025 08:00:26 -0400
X-MC-Unique: 9uLKwMdnMXWjcGV7stfQTg-1
X-Mimecast-MFC-AGG-ID: 9uLKwMdnMXWjcGV7stfQTg_1760011224
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26DD11800357; Thu,  9 Oct 2025 12:00:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.196])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 019DD1955F2D; Thu,  9 Oct 2025 12:00:18 +0000 (UTC)
Date: Thu, 9 Oct 2025 13:00:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] hw/uefi: add "info ovmf-log" + "query-ovmf-log"
 monitor commands
Message-ID: <aOejzqM74_NiOHJJ@redhat.com>
References: <20251007135216.1687648-1-kraxel@redhat.com>
 <aOcWOQJt-zLbiyUK@gallifrey> <aOdggKKyDtf3z57J@redhat.com>
 <aOefUN5_bSKjWPLc@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOefUN5_bSKjWPLc@gallifrey>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 09, 2025 at 11:41:04AM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > On Thu, Oct 09, 2025 at 01:56:09AM +0000, Dr. David Alan Gilbert wrote:
> > > * Gerd Hoffmann (kraxel@redhat.com) wrote:
> > > > Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
> > > > optional support for logging to a memory buffer.  There is guest side
> > > > support -- for example in linux kernels v6.17+ -- to read that buffer.
> > > > But that might not helpful if your guest stops booting early enough that
> > > > guest tooling can not be used yet.  So host side support to read that
> > > > log buffer is a useful thing to have.
> > > > 
> > > > This patch implements both qmp and hmp monitor commands to read the
> > > > firmware log.
> > > > 
> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > 
> > > I'm OK with that, but I wonder if it would be better to have a command
> > > that wrote the buffer to a file rather than displaying it directly; I don't
> > > think we normally have anything else which outputs that much raw guest
> > > provided data directly.
> > > I assume when it goes wrong you end up with random unprintable junk in
> > > the buffer.
> > 
> > 128 KB is on the high side, but is not terrible. Libvirt (arbitrarily)
> > caps a QMP reply at 10 MB. Libvirt is going to want to send this on to
> > the client app and will likely do that streaming in memory, so having
> > it iin a file is not required from our POV.
> > 
> > IIRC, some of the query-block command replies can get insanely huge
> > when the qcow2 chain is very long.
> 
> OK, what about sanitisation - if that text contains random binary what happens,
> or should we make sure it's sanitised?

As prior art, the QGA  'guest-exec' command will return stdout/stderr
of the command in base64 format.  The downside is that it is bloated
in size, but it is at least safe wrt JSON encoding.  The HMP command
could still dump the raw data IMHO, as that's human facing and base64
is horrible for human consumption.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


