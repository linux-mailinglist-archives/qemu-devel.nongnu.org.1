Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF8E793791
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 10:58:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdoME-0006Jf-SA; Wed, 06 Sep 2023 04:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdoM2-0006EH-Jk
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdoLy-0001j0-Dq
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693990657;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XxSaDnlpwHYOESdxRDulj9a0K33VO4i7sPlWwBchjPQ=;
 b=gW9hy4zX0uvKwN1B2q8gCFGWeO2+UQ0CNNkomAurdQXtCdQwBoQ6GZMLco+8R32BNZkJb5
 sPXOxolDHm+Vqs3Ty2B3XIjenf376QGKKi1XCIMnHTzCc3v+IhpSBFPWYfGiROJ7FOML6X
 LuX88pZgbzLETkJyMC/46kY6HbqlkmM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-bBV-BMf7M42huruY4U_ShQ-1; Wed, 06 Sep 2023 04:57:36 -0400
X-MC-Unique: bBV-BMf7M42huruY4U_ShQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D334B8015AA;
 Wed,  6 Sep 2023 08:57:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFC9946F520;
 Wed,  6 Sep 2023 08:57:34 +0000 (UTC)
Date: Wed, 6 Sep 2023 09:57:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v4 12/14] simpletrace: added simplified Analyzer2 class
Message-ID: <ZPg+/DwZQOVeYVgz@redhat.com>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-13-mads@ynddal.dk>
 <ZPciRnEvDK0IPNEA@redhat.com>
 <7DC8DA17-6848-4981-B576-A13025E1BB21@ynddal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7DC8DA17-6848-4981-B576-A13025E1BB21@ynddal.dk>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Wed, Sep 06, 2023 at 10:32:14AM +0200, Mads Ynddal wrote:
> 
> > AFAIK, we don't consider simpletrace.py python code to be a
> > supported public API, just a command line tool.
> > 
> > IOW, we can change the python code at will, as long as the
> > command line doesn't alter its behaviour. Thus I don't see
> > a need to add new classes, just change the existing ones.
> > 
> > 
> > With regards,
> > Daniel
> > -- 
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> > 
> 
> This was based on feedback from Stefan in v2. I don't have strong opinions
> about the one or the other. But now that the work has already been done,
> I'd think the easiest would be to follow-through on the two versions.
> 
> https://lore.kernel.org/qemu-devel/20230504180326.GB581920@fedora/

I don't really agree with that feedback. We never document simpletrace.py
as being a public facing Python API, only its usage as a CLI tool. It is
also never installed into any Python library path, nor packaged as a PyPI
module AFAIK.

If someone is none the less importing simpletrace.py from their app
then they should copy the file wholesale into that code and take the
responsibility for their usage.

I don't think QEMU should take on the burden of maintaining API
compatibility for something we have never presented as a public API.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


