Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3C274F38C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFKy-0004zv-AE; Tue, 11 Jul 2023 11:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJFKq-0004yz-V1
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJFKp-0004tF-7Z
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689089484;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eoqlMXP93e9NJjxIiZaSVQGzQuJUgUsQjxZWxOthOYQ=;
 b=iRI08Y82nADX9vZFgaRXdpAdqQhCVCOZlcOePZm8cE0XGnd14OUS+O0vatanst2jkNLhFw
 d9R+QGeY/eK4dEk6jp/zJ8GKGwnSBDhC7rEerq5DkfoYENlX0ch1/kXxHM7TJFocuIvXeX
 pwQ4TTlLCdtOzlmyksAs0/ye0qIowb8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-CswWH2SxMsaf6OqDENHMEg-1; Tue, 11 Jul 2023 11:31:22 -0400
X-MC-Unique: CswWH2SxMsaf6OqDENHMEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89862834772;
 Tue, 11 Jul 2023 15:31:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 707C91121315;
 Tue, 11 Jul 2023 15:31:20 +0000 (UTC)
Date: Tue, 11 Jul 2023 16:31:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v3 1/4] tests/lcitool: Generate distribution packages
 list in JSON format
Message-ID: <ZK11xijLUOkJlIQn@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711144922.67491-2-philmd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Tue, Jul 11, 2023 at 04:49:19PM +0200, Philippe Mathieu-Daudé wrote:
> Add the generate_pkglist() helper to generate a list of packages
> required by a distribution to build QEMU.
> 
> Since we can not add a "THIS FILE WAS AUTO-GENERATED" comment in
> JSON, create the files under tests/vm/generated/ sub-directory;
> add a README mentioning the files are generated.
> 
> Suggested-by: Erik Skultety <eskultet@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/lcitool/refresh     | 11 +++++++++++
>  tests/vm/generated/README |  5 +++++

Or 's/generated/packages/' perhaps ?

>  2 files changed, 16 insertions(+)
>  create mode 100644 tests/vm/generated/README

Either way, at your discretion

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


