Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2335977F4BA
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 13:04:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWan2-0005e9-Hm; Thu, 17 Aug 2023 07:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWamw-0005dO-M1
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWamu-00082G-7B
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692270215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wODv7FT4H+kkqnrUY8l7XQNOuLWYODXxza0YH8GITuU=;
 b=epRuet79PoD4uT+yVXqzxWgC7Mm71RVmQaYxokFG8sjq9dn1tN0e5jC/F8IkyaGSFRPxCV
 QIJSy6n+PE+yIWkjWjXd1dI74ZeLWGSc1oTzWZyVrs+6PnPjdqZQUXX2zRf55T11DoPQ70
 8sYEoeW2l3zOWYpVRKw2VFdF5f76vHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-0pvmeSuSNymk3LHSmyM3Ig-1; Thu, 17 Aug 2023 07:03:32 -0400
X-MC-Unique: 0pvmeSuSNymk3LHSmyM3Ig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E326A858EED;
 Thu, 17 Aug 2023 11:03:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E5AA140E950;
 Thu, 17 Aug 2023 11:03:31 +0000 (UTC)
Date: Thu, 17 Aug 2023 12:03:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] Fix the build on CentOS 7
Message-ID: <ZN3+gX/I2OWW0/tV@redhat.com>
References: <20230810215706.1394220-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810215706.1394220-1-iii@linux.ibm.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

On Thu, Aug 10, 2023 at 11:51:30PM +0200, Ilya Leoshkevich wrote:
> Hi,
> 
> I know that CentOS 7 is not tested anymore, but unfortunately it's the
> only ppc64le system that I have, so I had to fix a few build issues
> that crept in since the testing stopped. The fixes are simple and may
> be helpful to people in the same situation.

Actually it is more than not tested. CentOS 7 is explicitly
unsupported per our platform support matrix:

https://www.qemu.org/docs/master/about/build-platforms.html

and thus we will *intentionally* delete backwards compatibility code
that it needs, in order to simplify QEMU's codebase.

> Ilya Leoshkevich (3):
>   linux-user: Fix the build on systems without SOL_ALG
>   linux-user: Fix the build on systems without MAP_SHARED_VALIDATE
>   linux-user: Fix the build on systems without MADV_{KEEP,WIPE}ONFORK

We explicitly do NOT want to add this kind of back compat code
for unsupported platforms.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


