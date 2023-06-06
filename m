Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DEF723EC0
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:01:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TUX-0005T7-AD; Tue, 06 Jun 2023 06:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6TUN-0005Sp-Ik
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6TUJ-00012Q-BI
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686045626;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hU+2OkadtMcGYLfp22M/LClnLgIQP5q+YqaziExopoo=;
 b=bxYFD6R8suR+FQ6rCoFbm+0Kc6vDib2WZ2Z8DCRT7rlESayNKovW7IeEmm1LhtAz4PRgEE
 S7MBWWVNnpwTHWhVO+59Ol5X5cM7sJ64laFSXlSodofXc+Mb7uQIKv7AnEK48KmFoJnxHx
 5r6RihO5lSBlx/ZeouHs9e35LAWSIaI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-e5v-4jCvM7ysHrRE5jakRw-1; Tue, 06 Jun 2023 06:00:24 -0400
X-MC-Unique: e5v-4jCvM7ysHrRE5jakRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A2DD802BF5
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 10:00:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6B012166B25;
 Tue,  6 Jun 2023 10:00:23 +0000 (UTC)
Date: Tue, 6 Jun 2023 11:00:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: [PATCH 10/10] configure: remove --with-git-submodules=
Message-ID: <ZH8DtC2o8NJxBegU@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230605095223.107653-11-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 05, 2023 at 11:52:23AM +0200, Paolo Bonzini wrote:
> Reuse --enable/--disable-download to control git submodules as well.
> Adjust the error messages of git-submodule.sh to refer to the new
> option.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                                     | 40 +++++--------------
>  .../ci/org.centos/stream/8/x86_64/configure   |  1 -
>  scripts/git-submodule.sh                      |  8 ++--
>  3 files changed, 12 insertions(+), 37 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


