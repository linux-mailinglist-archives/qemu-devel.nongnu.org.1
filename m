Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA347D4BDF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 11:22:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDan-0000yW-Nk; Tue, 24 Oct 2023 05:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvDal-0000yK-9A
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvDai-0004OS-RP
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698139247;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=srw5xomrz6zrbzPUE4pZylI2l+rLJf/8ke279HJcYVI=;
 b=at92iOy8L4TsOaMIV7hxK/0nIxmEtWwh4rVOqmgkCrFdDU2p2gH7foggoZ/C3NV8aIaqIN
 PulzXUlevWE+OvBVjblnlgEZa1UWSXTUAFPw3+z2UJ3Hkks+fFf+Z+wtDjpps6xlv9hzRm
 pZHbYQHluc4lR2aO4UJA6XgGdyIJnxo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-24r_EkmROeyf753zW0RlVA-1; Tue,
 24 Oct 2023 05:20:41 -0400
X-MC-Unique: 24r_EkmROeyf753zW0RlVA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67EC82825E97;
 Tue, 24 Oct 2023 09:20:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E5022026D4C;
 Tue, 24 Oct 2023 09:20:40 +0000 (UTC)
Date: Tue, 24 Oct 2023 10:20:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lu Gao <Lu.Gao@verisilicon.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jianxian Wen <Jianxian.Wen@verisilicon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] qom/object_interfaces: Handle `len-` property first
Message-ID: <ZTeMZbluC1EHa3rh@redhat.com>
References: <20230921141634.26233-1-lu.gao@verisilicon.com>
 <34781C803212B140A51E6B66D9092E5D02BEDA7B26@SHASXM06.verisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34781C803212B140A51E6B66D9092E5D02BEDA7B26@SHASXM06.verisilicon.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 24, 2023 at 08:53:31AM +0000, Lu Gao wrote:
> ping
> 
> https://patchew.org/QEMU/20230921141634.26233-1-lu.gao@verisilicon.com/
> 
> Could you please help review the patch?
> 
> Thanks.
> B.R.
> 
> -----Original Message-----
> From: Lu Gao 
> Sent: Thursday, September 21, 2023 10:17 PM
> To: qemu-devel@nongnu.org
> Cc: Lu Gao; Jianxian Wen; Paolo Bonzini; Daniel P. Berrangé; Eduardo Habkost
> Subject: [PATCH] qom/object_interfaces: Handle `len-` property first
> 
> From: "Gao, Lu" <lu.gao@verisilicon.com>
> 
> Array property needs corresponding `len-` property set first to add
> actual array properties. Then we need to make sure `len-` property is
> set first before array property.
> 
> But when the model is used with like
> `-device driver[,prop[=value][,...]]`
> in QEMU command line options, this is not guaranteed in current
> property set from qdict. Array property might be
> handled before 'len-' property, then leads to an error.
> 
> Signed-off-by: Lu Gao <lu.gao@verisilicon.com>
> Signed-off-by: Jianxian Wen <jianxian.wen@verisilicon.com>
> ---
>  qom/object_interfaces.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

This approach has already been rejected in favour of a new impl
strategy for array properties shown in this series:

https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg01832.html

NB the syntax will change on the CLI


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


