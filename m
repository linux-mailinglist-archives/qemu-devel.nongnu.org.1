Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CA774F14D
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:12:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJE53-00086q-LR; Tue, 11 Jul 2023 10:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJE4y-00082p-MR
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJE4v-000291-B4
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689084649;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0KEIGuUs+ZCUKqzDwkxlbPNyDbxRbGMzTWOTMaNwCX4=;
 b=e1va8pHQaJLMvq416htael7Q8AxG9CLUMurrFap4gHEO206bSmsME314cE+fNCzpWVQhG2
 VwIqYx1xWQ7BOmyf0UZK/RR9IR+IidwOZqy5urY6uB4hd+qExFHSjhEwohmvzgOIxfXtUg
 A9ASHvbzgGBIPJzbyWTzUyr5X4SB2AU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-d9upyDEpMM-6g1QSYszDiA-1; Tue, 11 Jul 2023 10:10:19 -0400
X-MC-Unique: d9upyDEpMM-6g1QSYszDiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08D5D1869B78;
 Tue, 11 Jul 2023 14:08:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A284DC09A09;
 Tue, 11 Jul 2023 14:08:07 +0000 (UTC)
Date: Tue, 11 Jul 2023 15:08:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kyle Evans <kevans@freebsd.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH v2 2/3] tests/vm: Introduce
 get_qemu_packages_from_lcitool_json() helper
Message-ID: <ZK1iRcctZmVJPT5f@redhat.com>
References: <20230711140143.65818-1-philmd@linaro.org>
 <20230711140143.65818-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711140143.65818-3-philmd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On Tue, Jul 11, 2023 at 04:01:42PM +0200, Philippe Mathieu-Daudé wrote:
> Add the get_qemu_packages_from_lcitool_json() helper which return
> such package list from a lcitool env var file in JSON format.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/vm/Makefile.include | 4 ++++
>  tests/vm/basevm.py        | 9 +++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index c2a8ca1c17..b021b344b5 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -106,6 +106,10 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>  		--build-image $@, \
>  		"  VM-IMAGE $*")
>  
> +$(SRC_PATH)/tests/vm/%.json:
> +	$(call quiet-command, \
> +		make lcitool-refresh)

'lcitool-refresh' is something we only run explicitly when we
change something about the lcitool, and also isn't provided
to end users running from tarballs IIRC. So we shouldn't need
to wire it up to build targets, just commit its output JSON
file.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


