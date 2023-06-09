Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F1A7291BD
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:51:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7WtG-0005KP-Gp; Fri, 09 Jun 2023 03:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7WtC-0005K5-5S
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7WtA-0008Ee-GW
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686297027;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9WukYKVpsXuL7CpFHrxCcfdjzGsv2mMxzaZDzlebmM=;
 b=jHYFduMF032txHrKHynMLM76iSRDc+BpGPwG5wNfetyNxwRht1xXWMWznwOUdtsBCYo/72
 xUWevBYZV2bUXdz6Q5HRQ7VDEhhq57qUlz23TgFWrrDPy4Sx6FEG9vp+Q4btOd/wGBGSFy
 nOIf2Eo/tgI0RQ4z6IGIZcd7ZZ/Vgzk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-Xep2CeMXMDWvl6No2XK8FA-1; Fri, 09 Jun 2023 03:50:20 -0400
X-MC-Unique: Xep2CeMXMDWvl6No2XK8FA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05276280BC7B;
 Fri,  9 Jun 2023 07:50:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EB03C09A07;
 Fri,  9 Jun 2023 07:50:18 +0000 (UTC)
Date: Fri, 9 Jun 2023 08:50:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Henrik Carlqvist <hc981@poolhem.se>
Cc: mark.cave-ayland@ilande.co.uk, hc1245@poolhem.se, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] Emulate dip switch language layout settings on SUN
 keyboard
Message-ID: <ZILZuOranwy1xEo/@redhat.com>
References: <d2850ef0-d825-bb03-09d4-0d1427cf6577@ilande.co.uk>
 <20230123200937.32eb19eb.hc981@poolhem.se>
 <20230304220754.0c6ae562.hc981@poolhem.se>
 <ZCLzUyiDeKLfQqWT@redhat.com>
 <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com>
 <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
 <ZIIAPz/HOqPXjKIs@redhat.com>
 <20230608201221.376ca6ce.hc981@poolhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230608201221.376ca6ce.hc981@poolhem.se>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 08, 2023 at 08:12:21PM +0200, Henrik Carlqvist wrote:
> On Thu, 8 Jun 2023 17:22:23 +0100
> Daniel P. BerrangÃ© <berrange@redhat.com> wrote:
> 
> > On Sun, Apr 30, 2023 at 10:55:33PM +0200, Henrik Carlqvist wrote:
> > > What is the best way to document this kind of global parameters?
> > 
> > You can put it in docs/system/sparc.rst (or sparc64.rst whichever is best?)
> 
> Thanks for your reply! As far as I know those dip switches are only in the
> keyboards of the old 32 bit sparc machines, ultrasparc used USB keyboards
> instead without any dip switches. I will add the text to
> docs/system/target-sparc.rst.
> 
> Would you like the documentation as a separate patch or added to the patch
> which adds the functionality to hw/char/escc.c?

Either way is fine imho, mild perference to have it in the same patch if
the docs are reasonably short.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


