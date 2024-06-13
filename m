Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8F49065E1
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jun 2024 09:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfK5-0003DW-WC; Thu, 13 Jun 2024 03:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHfK4-0003D9-PT
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHfK0-0006XU-RZ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718265395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/YLQd1l00KTFQ07VyVKuBnAoqm47W/9Ae+EMOt2H9Q=;
 b=D6eu2m8AgUIKWmYJycMH2QNoJJkzUpi676/YPg4qY0IylfZGEeX7U7uw0UiogIeP2B3PsT
 9YWMiS/E7V28CKmWLMFvSGWvOl9X5cCIRpRbkWtPcM4U51MwVTDmNdVLJdbgoI9MLRu6eu
 OkZmdC+1fcRDyxn54JYxib3cXEwXEBo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-YyzJe0S1Pve1kxitgPYlfA-1; Thu,
 13 Jun 2024 03:56:31 -0400
X-MC-Unique: YyzJe0S1Pve1kxitgPYlfA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BACDC195608C; Thu, 13 Jun 2024 07:56:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92A5F1956087; Thu, 13 Jun 2024 07:56:24 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:56:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 0/5] Implement ARM PL011 in Rust
Message-ID: <ZmqmJZQGGKRhTvoW@redhat.com>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <ZmleLH1dQvPqPBAY@redhat.com> <f06p3.rb3vk3rb2kt4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f06p3.rb3vk3rb2kt4@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

On Thu, Jun 13, 2024 at 08:13:01AM +0300, Manos Pitsidianakis wrote:
> Good morning Daniel,
> 
> On Wed, 12 Jun 2024 11:37, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
> > On Tue, Jun 11, 2024 at 01:33:29PM +0300, Manos Pitsidianakis wrote:
> > 
> > > 
> > >  .gitignore                     |   2 +
> > >  .gitlab-ci.d/buildtest.yml     |  64 ++--
> > >  MAINTAINERS                    |  13 +
> > >  configure                      |  12 +
> > >  hw/arm/virt.c                  |   4 +
> > >  meson.build                    | 102 ++++++
> > >  meson_options.txt              |   4 +
> > >  rust/meson.build               |  93 ++++++
> > >  rust/pl011/.cargo/config.toml  |   2 +
> > >  rust/pl011/.gitignore          |   2 +
> > >  rust/pl011/Cargo.lock          | 120 +++++++
> > >  rust/pl011/Cargo.toml          |  66 ++++
> > >  rust/pl011/README.md           |  42 +++
> > >  rust/pl011/build.rs            |  44 +++
> > >  rust/pl011/deny.toml           |  57 ++++
> > >  rust/pl011/meson.build         |   7 +
> > >  rust/pl011/rustfmt.toml        |   1 +
> > >  rust/pl011/src/definitions.rs  |  95 ++++++
> > >  rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
> > >  rust/pl011/src/device_class.rs |  95 ++++++
> > >  rust/pl011/src/generated.rs    |   5 +
> > >  rust/pl011/src/lib.rs          | 581 +++++++++++++++++++++++++++++++++
> > >  rust/pl011/src/memory_ops.rs   |  38 +++
> > >  rust/rustfmt.toml              |   7 +
> > >  rust/wrapper.h                 |  39 +++
> > >  scripts/cargo_wrapper.py       | 221 +++++++++++++
> > >  scripts/meson-buildoptions.sh  |   6 +
> > 
> > Given the priority of getting the build system correct, what's missing
> > here is updates/integration into our standard GitLab CI pipeline. If
> > that can be shown to be working, that'll give alot more confidence in
> > the overall solution.
> > 
> > Ideally this should not require anything more than updating the docker
> > container definitions to add in the rust toolchain, plus the appropriate
> > std library build for the given target - we cross compiler for every
> > arch we officially care about.
> > 
> > Most of our dockerfiles these days are managed by lcitool, and it has
> > nearly sufficient support for cross compiling with the rust std library.
> > So to start with, this series should modify tests/lcitool/projects/qemu.yml
> > to add
> > 
> >  - rust
> >  - rust-std
> > 
> > to the package list, and run 'make lcitool-refresh' to re-create the
> > dockerfiles - see the docs/devel/testing.rst for more info about
> > lcitool if needed.
> > 
> > Assuming these 2 rust packages are in the container, I would then
> > expect QEMU to just "do the right thing" when building this rust
> > code. If it does not, then that's a sign of gaps that need closing.
> > 
> > Getting rid of the need to use --rust-target-triple will be the
> > immediate gap that needs fixing, as CI just passes --cross-prefix
> > for cross-builds and expects everything to be set from that.
> > 
> > The main gap we have is that for Windows I need to update lcitool
> > to pull in the mingw std lib target for rust, which I something I
> > missed when adding rust cross compiler support.

I've updated lcitool for this gap:

  https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/492

> The rust project has official Docker images, do you think it's something we
> could use or is it unnecessary?
> 
> https://github.com/rust-lang/docker-rust

They're irrelevant - we need the containers with the full set of QEMU build
dependencies present, and it is the Rust versions that are in the distros
that matter to us.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


