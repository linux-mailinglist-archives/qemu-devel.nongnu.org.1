Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9BE7651CD
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 12:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOyPF-0005eN-GP; Thu, 27 Jul 2023 06:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOyPB-0005e0-08
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 06:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOyP9-0000WS-3T
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 06:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690454373;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csj4A8kp0waFUSPqH7/5lnv5CZEMtkA4hJrYhIPW6zc=;
 b=J8fwLZaGY8+Pv0iYa9JFMfbNzLvOmMfS6WKlo294SKWugyZ7xMjEmWshIzP+R6al2R95cy
 TxU/SzprbVo2zn7CV4HN+gSE0hhntHi4pe5hDRFCTomHAABtj5R08dh8D/IvNFfqfvdKcg
 1BTTFzoBgTiFoDltD0f2Y97chuM8RQs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-TRK1ejuMMYSZ-7Jqyvz-xg-1; Thu, 27 Jul 2023 06:39:29 -0400
X-MC-Unique: TRK1ejuMMYSZ-7Jqyvz-xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C7661C0896E;
 Thu, 27 Jul 2023 10:39:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01E7E1121330;
 Thu, 27 Jul 2023 10:39:27 +0000 (UTC)
Date: Thu, 27 Jul 2023 11:39:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Bin Meng <bin.meng@windriver.com>
Subject: Re: [PATCH] gitlab: remove duplication between msys jobs
Message-ID: <ZMJJS5lUtPKpld0q@redhat.com>
References: <20230726161942.229093-1-berrange@redhat.com>
 <0d0f9f65-2ead-6852-20c2-a83e256eecac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d0f9f65-2ead-6852-20c2-a83e256eecac@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 26, 2023 at 08:21:33PM +0200, Thomas Huth wrote:
> On 26/07/2023 18.19, Daniel P. Berrangé wrote:
> > Although they share a common parent, the two msys jobs still have
> > massive duplication in their script definitions that can easily be
> > collapsed.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   .gitlab-ci.d/windows.yml | 132 +++++++++++++++------------------------
> >   1 file changed, 49 insertions(+), 83 deletions(-)
> 
> We originally had different sets of packages in the 32-bit and 64-bit jobs,
> to distribute the load between the two jobs ... but it got unified in commit
> 14547e0877f3522. Now considering that we are facing timeouts again, we
> should maybe rather revert that commit instead of unifying the lists
> forever?

IMHO we shouldn't be maintaining package lists at all, because they get
stale over time. IOW, I would like to make this job use the package list
from lcitool.

We could get the same end result, however, but having a package exclude
list defined as a variable per job

 variables:
   MINGW_TARGET: mingw-w64-i686
   MSYSTEM: MINGW32
   CONFIGURE_ARGS:  --target-list=ppc64-softmmu
   TEST_ARGS: --no-suite qtest
   PACKAGE_EXCLUDE: mingw-w64-gtk3 mingw-w64-nettle mingw-w64-zstd

> Anyway, before we unify the compiler package name suffix between the two
> jobs, I really would like to see whether the mingw Clang builds QEMU faster
> in the 64-bit job ... but so far I failed to convince meson to accept the
> Clang from the mingw package ... does anybody know how to use Clang with
> MSYS2 properly?

AFAIK it shouldn't be anything worse than

  CC=clang ./configure ....

if that doesn't work then its a bug IMHO

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


