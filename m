Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF68093F372
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jul 2024 13:00:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYO6X-0001ZG-Mg; Mon, 29 Jul 2024 06:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYO6V-0001Rx-Si
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 06:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYO6R-0000SL-UI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 06:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722250782;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFddE/KnwkER6UAYALyDN4no1tJhTjqMvlEdSKIcCog=;
 b=hz/vgcXFEnTRtx1GOxAzpOvhS2umIa63KprQ2GbHsB+ojomkYsXxdxZc+BFabaiAYFC7pE
 OnD8K1LlcGVWGxJgSgZb9/dsrGWQBktbW2cLFnvX8ToSvFge6ecRSxFTM0XR03dJgcdznt
 p1JE2nNfr8fv4wY2HRFsFpPP67OcJ5Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-AyMedb8oPt29atOdHuSslQ-1; Mon,
 29 Jul 2024 06:59:38 -0400
X-MC-Unique: AyMedb8oPt29atOdHuSslQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85E7D1955D58; Mon, 29 Jul 2024 10:59:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3B7E1955F40; Mon, 29 Jul 2024 10:59:29 +0000 (UTC)
Date: Mon, 29 Jul 2024 11:59:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH 08/13] testa/avocado: test_arm_emcraft_sf2: handle RW
 requirements for asset
Message-ID: <Zqd2Dg8RChDn0B4t@redhat.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-9-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726134438.14720-9-crosa@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 26, 2024 at 09:44:33AM -0400, Cleber Rosa wrote:
> The asset used in the mentioned test gets truncated before it's used
> in the test.  This means that the file gets modified, and thus the
> asset's expected hash doesn't match anymore.  This causes cache misses
> and re-downloads every time the test is re-run.
> 
> Let's make a copy of the asset so that the one in the cache is
> preserved and the cache sees a hit on re-runs.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/avocado/boot_linux_console.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


