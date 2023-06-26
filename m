Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8773DBA2
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDijx-0006pd-5f; Mon, 26 Jun 2023 05:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qDijd-0006n5-V2
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qDijc-0003oX-Dc
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687772531;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeLIyTH2mrFHC6WR9s4v1St847wIkkzaY3fZ7zbs+FQ=;
 b=DKkDfvpubz2Mtc9J3mbK1TAHEWVzO16oYQPSM9v0kDpuXOzwtajwUl7krO+p5VlW7KWlIm
 bHzyYfekg5GLZbeeItMLcZR+wb5h3KRo3d72U6dwcMzSY9VH3vt/rM2aD0keF1FBbPMno3
 3uCIkg98ikYaNT+1BuXjcIZNjok+0Gk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-cqJPKdtTORGTbt76xeIevg-1; Mon, 26 Jun 2023 05:42:09 -0400
X-MC-Unique: cqJPKdtTORGTbt76xeIevg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 443FE3802263;
 Mon, 26 Jun 2023 09:42:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8F761121319;
 Mon, 26 Jun 2023 09:42:08 +0000 (UTC)
Date: Mon, 26 Jun 2023 10:42:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Henrik Carlqvist <hc981@poolhem.se>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v8] Emulate dip switch language layout settings on SUN
 keyboard
Message-ID: <ZJldbvheYwLOOcIx@redhat.com>
References: <20230430225533.1a57879a.hc981@poolhem.se>
 <20230608181439.7ea3a5c5.hc981@poolhem.se>
 <4e8f027a-ca00-c54f-ef2f-f0df1f5b2f9e@ilande.co.uk>
 <20230610122912.0fc157de.hc981@poolhem.se>
 <20230611014751.22f22674.hc94@poolhem.se>
 <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se>
 <ZJKiGBJNQa5Kx+Dg@redhat.com>
 <20230621201447.712ec73a.hc94@poolhem.se>
 <20230623203007.56d3d182.hc981@poolhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230623203007.56d3d182.hc981@poolhem.se>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jun 23, 2023 at 08:30:07PM +0200, Henrik Carlqvist wrote:
> SUN Type 4, 5 and 5c keyboards have dip switches to choose the language layout 
> of the keyboard. Solaris makes an ioctl to query the value of the dipswitches 
> and uses that value to select keyboard layout.  Also the SUN bios like the one 
> in the file ss5.bin uses this value to support at least some keyboard layouts. 
> However, the OpenBIOS provided with qemu is hardcoded to always use an US 
> keyboard layout.
> 
> Before this patch, qemu allways gave dip switch value 0x21 (US keyboard),
> this patch uses a command line switch like
> "-global escc.chnA-sunkbd-layout=de" to select dip switch value. A table is
> used to lookup values from arguments like:
> 
> -global escc.chnA-sunkbd-layout=fr
> -global escc.chnA-sunkbd-layout=es
> 
> But the patch also accepts numeric dip switch values directly:
> 
> -global escc.chnA-sunkbd-layout=0x2b
> -global escc.chnA-sunkbd-layout=43
> 
> Both values above are the same and select swedish keyboard as explained in
> table 3-15 at
> https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.html
> 
> Unless you want to do a full Solaris installation but happen to have
> access to a Sun bios file, the easiest way to test that the patch works
> is to:
> 
> qemu-system-sparc -global escc.chnA-sunkbd-layout=sv -bios /path/to/ss5.bin
> 
> If you already happen to have a Solaris installation in a qemu disk image
> file you can easily try different keyboard layouts after this patch is
> applied.
> 
> Signed-off-by: Henrik Carlqvist <hc1245@poolhem.se>
> ---

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


