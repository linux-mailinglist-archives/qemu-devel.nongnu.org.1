Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43295A713AF
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Mar 2025 10:28:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txN2t-0005GI-86; Wed, 26 Mar 2025 05:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txN2p-0005Fd-JI
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txN2m-0002hO-HL
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742981246;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tehrT5xctE47Pe+fTQR2Yr/KsdVhYPPS35i51tw4rjA=;
 b=AfyVlqKQaKzYst2RqZNGaK8uVZdNV3Ah5VzFjfWtER7/tXi5YDo0sKWBbSmGqKxhv3zgQc
 Q1CUC8IDxOfhD2FCOCDlkLwJgy6TorNa88Xu8YeEFP/c4HXlyg3FJKZR8DrlZsBWMBNB6p
 /ssnZGBzTUCycXLVg9ODfACtCoZMjgo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-gIw1Pj1LOPeOAbLjpR3vNg-1; Wed,
 26 Mar 2025 05:27:25 -0400
X-MC-Unique: gIw1Pj1LOPeOAbLjpR3vNg-1
X-Mimecast-MFC-AGG-ID: gIw1Pj1LOPeOAbLjpR3vNg_1742981244
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 647A31944F0A; Wed, 26 Mar 2025 09:27:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.107])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B966A30001A1; Wed, 26 Mar 2025 09:27:21 +0000 (UTC)
Date: Wed, 26 Mar 2025 09:27:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 02/15] tests/functional: Move the check for the
 parameters from avocado to functional
Message-ID: <Z-PIduHuKP_CU-X7@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
 <20250325200026.344006-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325200026.344006-3-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 25, 2025 at 09:00:10PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> test_x86_64_pc in tests/avocado/boot_linux_console.py only checks
> whether the kernel parameters have correctly been passed to the
> kernel in the guest by looking for them in the console output of the
> guest. Let's move that to the functional test framework now, but
> instead of doing it in a separate test, let's do it for all tuxrun
> tests instead, so it is done automatically for all targets that have
> a tuxrun test.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/avocado/boot_linux_console.py      | 34 ------------------------
>  tests/functional/qemu_test/tuxruntest.py |  9 ++++---
>  2 files changed, 5 insertions(+), 38 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


