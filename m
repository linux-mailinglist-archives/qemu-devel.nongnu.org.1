Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D6A68F06
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Mar 2025 15:28:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuOB-0005KP-Du; Wed, 19 Mar 2025 10:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuuNU-0005B6-QP
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuuNK-0003ZR-P5
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742394389;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTreDvePXw5d/c0DMVJDI6RBnpqpaHZJJOmE+Jo1tQk=;
 b=i/quOIF0NePqUp0ijQkE0yWg+hrgm0q9wEzbyG8LcdCWt3IwFjOg/UMzSVV7nHBD99CHMj
 jW9+gGOgUpFsWMiAA7XnB4OT/PvkTpyADi/w/8ji/bksclfvhwDShykBK7tILPk8XZkpib
 fY/GX10CjtZyEKY2+spQAC/JSuIzgLo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-GpP208zkPd-sNfQ4Lubtgg-1; Wed,
 19 Mar 2025 10:26:25 -0400
X-MC-Unique: GpP208zkPd-sNfQ4Lubtgg-1
X-Mimecast-MFC-AGG-ID: GpP208zkPd-sNfQ4Lubtgg_1742394384
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46F8C18011C0; Wed, 19 Mar 2025 14:26:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F8991800944; Wed, 19 Mar 2025 14:26:22 +0000 (UTC)
Date: Wed, 19 Mar 2025 14:26:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Tanish Desai <tanishdesai37@gmail.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Fix duplicate symbol error on MacOS build
Message-ID: <Z9rUC1hAcQN39VpQ@redhat.com>
References: <20250319023036.71493-1-tanishdesai37@gmail.com>
 <b642a46c-6b7d-4afe-a9fe-0c4ee9f734a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b642a46c-6b7d-4afe-a9fe-0c4ee9f734a0@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Mar 19, 2025 at 02:52:43PM +0100, Philippe Mathieu-Daudé wrote:
> Cc'ing CI maintainers.
> 
> On 19/3/25 03:30, Tanish Desai wrote:
> > The issue started after commit https://github.com/qemu/qemu/commit/59f4d65584bd3372070e2484876436c8d02505e4
> > 
> > Reproduction:
> >    1. In the build directory on MacOS (haven't tried on other OS), run:
> >         ../configure --enable-rust --target-list=aarch64-softmmu
> 
> This config isn't covered on our CI, we only test --enable-rust on
> Linux. Should we also test it for all non-Linux hosts? I'd rather not...

Bear in mind that Rust is still an experimental feature. If it is
broken in some build scenarios & not exhaustively tested, so be it,
that's what it means to be "experimental".

When we make Rust an on-by-default feature, then we'll get
coverage across all CI scenarios automatically. Of course we then
have the reverse question of CI testing of "rust disabled" scenarios,
Ideally we make Rust mandatory and thus avoid those non-Rust scenarios.

So I agree we don't need to expand CI coverage currently, just
fix bugs when they're pointed out.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


