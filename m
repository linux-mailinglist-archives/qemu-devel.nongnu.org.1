Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86494906869
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jun 2024 11:20:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgd0-0002co-Ct; Thu, 13 Jun 2024 05:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHgcz-0002cc-20
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHgcx-0004qK-4c
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718270413;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gY2sxvKij9qkaVzGuqmlQ0pI61E1G61Suv+rUZzccjo=;
 b=B6D8HBDsAiVY28gH8vZv0B2ovTYI6te3YrMItQGEpJOTyLLQ0cGCtPZ7dFKdrBRbcTVugD
 DVEwfIFnZwSnmgge1zFWG607EHLJACLf9d1c6r79J8fxpAkxoE//1Xlx252Rm2U1sZRNvj
 sPA9+b713LrGOOl8TgklA+FMqFwYvHs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137--SwMIWFyMkampSnZKOefrg-1; Thu,
 13 Jun 2024 05:20:10 -0400
X-MC-Unique: -SwMIWFyMkampSnZKOefrg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FF2619560AE; Thu, 13 Jun 2024 09:20:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4600A1956053; Thu, 13 Jun 2024 09:20:04 +0000 (UTC)
Date: Thu, 13 Jun 2024 10:20:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
Message-ID: <Zmq5wSsKSmneM22M@redhat.com>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <ZmquNSnnVSdOe0Z3@intel.com> <f0gdl.ugeo9rfbpd5e@linaro.org>
 <Zmqzf6C9QyacG0Fn@redhat.com> <f0h5e.89ncc7cio1kx@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0h5e.89ncc7cio1kx@linaro.org>
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

On Thu, Jun 13, 2024 at 11:59:12AM +0300, Manos Pitsidianakis wrote:
> On Thu, 13 Jun 2024 11:53, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
> > On Thu, Jun 13, 2024 at 11:41:38AM +0300, Manos Pitsidianakis wrote:
> > > > > diff --git a/rust/rustfmt.toml b/rust/rustfmt.toml
> > > > > new file mode 100644
> > > > > index 0000000000..ebecb99fe0
> > > > > --- /dev/null
> > > > > +++ b/rust/rustfmt.toml
> > > > > @@ -0,0 +1,7 @@
> > > > > +edition = "2021"
> > > > > +format_generated_files = false
> > > > > +format_code_in_doc_comments = true
> > > > > +format_strings = true
> > > > > +imports_granularity = "Crate"
> > > > > +group_imports = "StdExternalCrate"
> > > > > +wrap_comments = true
> > > > > > > About the Rust style, inspired from the discussion on my
> > > previous
> > > > simpletrace-rust [1], it looks like people prefer the default rust style
> > > > and use the default check without custom configurations.
> > > > > More style requirements are also an open, especially for
> > > unstable ones,
> > > > and it would be better to split this part into a separate patch, so that
> > > > the discussion about style doesn't overshadow the focus on your example.
> > > > > [1]:
> > > https://lore.kernel.org/qemu-devel/ZlnBGwk29Ds9FjUA@redhat.com/
> > > >
> > > 
> > > I had read that discussion and had that in mind. There's no need to worry
> > > about format inconsistencies; these options are unstable  -nightly only-
> > > format options and they don't affect the default rust style (they actually
> > > follow it). If you run a stable cargo fmt you will see the code won't change
> > > (but might complain that these settings are nightly only).
> > > 
> > > What they do is extra work on top of the default style. If anything ends up
> > > incompatible with stable I agree it must be removed, there's no sense in
> > > having a custom Rust style when the defaults are so reasonable.
> > 
> > This doesn't make sense. One the one hand you're saying the rules don't
> > have any effect on the code style vs the default, but on the otherhand
> > saying they do "extra work" on top of the default style. Those can't
> > both be true.
> 
> No, I fear there's a confusion here. It means that if you run the stable
> rustfmt with the default options the code doesn't change. I.e. it does not
> conflict with the default style.
> 
> What it does is group imports, format text in doc comments (which stable
> rustfmt doesn't touch at all) and also splits long strings into several
> lines, which are all helpful for e-mail patch reviews.

Ah ok.  Are we expecting these options to become part of stable rustfmt ?

I would expect our contributors to primarily be using the Rust toolchain
that comes with their distro, and not unstable -nightly toolchain. So I
still wonder if this rustfmt config will have much real world benefit ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


