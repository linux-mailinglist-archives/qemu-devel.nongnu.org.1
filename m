Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5F77F47B
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 12:51:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWaZi-0008Dy-PY; Thu, 17 Aug 2023 06:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWaZe-0008De-4D
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWaZa-0001Ta-Ha
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692269389;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=X0v7Me8rgYKDAf6VTKVckm9++IXMVHXMSa/puah3VSU=;
 b=YpbD3W39MJkqpMQxIOnmngqmZy68Xu/ZyZJWI38EPXaahCkZL2Zf95wY3sGty6br8Kg1bN
 vPtUZ7JDa0E+lZbRMWSDvGC4J7o//5hmdhLT/fj9+OXKS0xi7DGH6RjLsdoIhbVPMQuWcE
 w0l7SgX3+o5783IUz0+k+hNI9sVR35w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-RAEyWhGSNxKuiMpkgzSr4A-1; Thu, 17 Aug 2023 06:49:46 -0400
X-MC-Unique: RAEyWhGSNxKuiMpkgzSr4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2D3785CCE2;
 Thu, 17 Aug 2023 10:49:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B27540C6F4E;
 Thu, 17 Aug 2023 10:49:45 +0000 (UTC)
Date: Thu, 17 Aug 2023 11:49:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yu Zhang <yu.zhang@ionos.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jinpu Wang <jinpu.wang@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>
Subject: Re: about QEMU TLS
Message-ID: <ZN37R//1H+rDTzeS@redhat.com>
References: <CAHEcVy6_HUjwvww9WrqeqruYRyEDwq1Tee-tm3mxaQE=w92-HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHEcVy6_HUjwvww9WrqeqruYRyEDwq1Tee-tm3mxaQE=w92-HA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Mon, Aug 07, 2023 at 12:07:31AM +0200, Yu Zhang wrote:
> Hi all,
> 
> According to qemu docs [1], TLS parameters are specified as an object in
> the QEMU command line:
> 
>    -object tls-creds-x509,id=id,endpoint=endpoint,dir=/path/to/cred/dir ...
> 
> of which "endpoint" is a type of "QCryptoTLSCredsEndpoint" and can be
> either a "server" or a "client".
> 
> I'd like to know:
> 
> - When a VM is started with this config, is there a way (e.g. QMP) to
> change the value of "endpoint"?
>   If possible, how to do this? or else after the first migration of a VM,
> the VM has "endpoint=server",
>   which can't be migrated without stop / start.

Use object_del + object_add to delete the old credentials and
create new ones.

> - In which case does the QEMU reload its TLS certificate, e.g. when a QEMU
> VM has been run longer
>   than the valid period of its TLS certificate?

The certs are loaded at the time the incoming/outgoing migration
operation is initiated, so they are always fresh.

> - The migration is done by using HMP monitor on both source and target
> side. Is it possible to do it
>   by using QMP commands?

Almost everything in HMP has an equivalent QMP command.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


