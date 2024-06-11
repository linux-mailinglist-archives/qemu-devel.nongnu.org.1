Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2E79035FE
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jun 2024 10:23:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwmX-0004zI-OX; Tue, 11 Jun 2024 04:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGwmV-0004xq-MK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGwmR-0002wR-PK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718094178;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=deMu8Fgzhf8RXQ/fW8aeaRQ/fV0OhhmCDqqteKj0fow=;
 b=HUZVtU+Ywzynzxh0vqbYwLuwHtEsQzuIsjpqeg6ncTqP4kos7vlOhx5mnL4zGBZfO/6llH
 LDuYW3HvmJ6klP/+uzGVR+EfWG69DZ3Tja2N8wbEJ7x9qyZLsc4F6e6Q49669LV6uKyhlo
 C/rRIBhL7ECdJQGB5/0wt1YZV5F+3TE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-mGj0idIzOpmOQtn71vKndw-1; Tue,
 11 Jun 2024 04:22:55 -0400
X-MC-Unique: mGj0idIzOpmOQtn71vKndw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97CB719560AF; Tue, 11 Jun 2024 08:22:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.73])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B30E1956048; Tue, 11 Jun 2024 08:22:47 +0000 (UTC)
Date: Tue, 11 Jun 2024 09:22:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
Message-ID: <ZmgJVGMx81aHjg5f@redhat.com>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 10, 2024 at 09:22:35PM +0300, Manos Pitsidianakis wrote:
> Hello everyone,
> 
> This is an early draft of my work on implementing a very simple device, 
> in this case the ARM PL011 (which in C code resides in hw/char/pl011.c 
> and is used in hw/arm/virt.c).

looking at the diffstat:

>  .gitignore                     |   2 +
>  .gitlab-ci.d/buildtest.yml     |  64 ++--
>  configure                      |  12 +
>  hw/arm/virt.c                  |   2 +-
>  meson.build                    |  99 ++++++
>  meson_options.txt              |   4 +
>  rust/meson.build               |  93 ++++++
>  rust/pl011/.cargo/config.toml  |   2 +
>  rust/pl011/.gitignore          |   2 +
>  rust/pl011/Cargo.lock          | 120 +++++++
>  rust/pl011/Cargo.toml          |  26 ++
>  rust/pl011/README.md           |  42 +++
>  rust/pl011/build.rs            |  44 +++
>  rust/pl011/meson.build         |   7 +
>  rust/pl011/rustfmt.toml        |  10 +
>  rust/pl011/src/definitions.rs  |  95 ++++++
>  rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
>  rust/pl011/src/device_class.rs |  95 ++++++
>  rust/pl011/src/generated.rs    |   5 +
>  rust/pl011/src/lib.rs          | 575 +++++++++++++++++++++++++++++++++
>  rust/pl011/src/memory_ops.rs   |  38 +++

My thought is that if we're going to start implementing devices
or other parts of QEMU, in Rust, then I do not want to see it
placed in a completely separate directory sub-tree.

In this example, I would expect to have hw/arm/pl011.rs, or hw/arm/pl011/*.rs
so that the device is part of the normal Arm hardware directory structure 
and maintainer assignments.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


