Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF6B492D2
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 17:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvdar-00064m-39; Mon, 08 Sep 2025 11:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvdak-00062Q-LP
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvdae-0000q4-Dg
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757344530;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AVUI8ixWKkoyfobkSNSsDEPeZCTJSfE7qCeKVtnOv88=;
 b=gsNL/37pvrj9SpqXayo33m3X9rsO8aiObPPIx+2LvwRsxmk+39VMpIAFankW7w9vBmVGpc
 v65JIK8fbeuUgnV77QyIoI5BYUZCPChQbLibE4cNE3s/fP1Xg1pnjxeXx5zHdxVoOrcL2F
 XURpEofYg74TeKZ5/hoGFTK3JMLxR9s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-aKMJ3-meMq6gAS-Obk9ziQ-1; Mon,
 08 Sep 2025 11:15:27 -0400
X-MC-Unique: aKMJ3-meMq6gAS-Obk9ziQ-1
X-Mimecast-MFC-AGG-ID: aKMJ3-meMq6gAS-Obk9ziQ_1757344525
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DC7B19560B2; Mon,  8 Sep 2025 15:15:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A57841800451; Mon,  8 Sep 2025 15:15:17 +0000 (UTC)
Date: Mon, 8 Sep 2025 16:15:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Message-ID: <aL7zAV3xh-idgX8P@redhat.com>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908104125-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 08, 2025 at 10:45:40AM -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
> > Currently our security policy defines a "virtualization use case"
> > where we consider bugs to be security issues, and a
> > "non-virtualization use case" where we do not make any security
> > guarantees and don't consider bugs to be security issues.
> > 
> > The rationale for this split is that much code in QEMU is older and
> > was not written with malicious guests in mind, and we don't have the
> > resources to audit, fix and defend it.  So instead we inform users
> > about what the can in practice rely on as a security barrier, and
> > what they can't.
> > 
> > We don't currently restrict the "virtualization use case" to any
> > particular set of machine types.  This means that we have effectively
> > barred ourselves from adding KVM support to any machine type that we
> > don't want to put into the "bugs are security issues" category, even
> > if it would be useful for users to be able to get better performance
> > with a trusted guest by enabling KVM. This seems an unnecessary
> > restriction, and in practice the set of machine types it makes
> > sense to use for untrusted-guest virtualization is quite small.
> > 
> > Specifically, we would like to be able to enable the use of
> > KVM with the imx8 development board machine types, but we don't
> > want to commit ourselves to having to support those SoC models
> > and device models as part of QEMU's security boundary:
> > https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
> > 
> > This patch updates the security policy to explicitly list the
> > machine types we consider to be useful for the "virtualization
> > use case".
> 
> This use-case sounds reasonable to me. I also imagine that
> some machines can get fixed down the road perhaps to
> the point where they enter the "virtualization use case".
> 
> However, since we are
> getting this elaborate, would my old idea of a runtime flag
> make sense now?
> 
> To recap, the idea was to add a "-virt" flag that will
> block any machines, devices and so on not considered
> part of the "virtualization use case".
> 
> We could also create a mechanism for downstreams to
> tweak this as they see fit.

I would not consider "virtualization use case" to be something we
want to represent in code. It was just a crude hack for the docs
to approximate what we wanted to /initially/ aim to support.

The ideal theoretical end state would be for everything to be
in scope for security fixes, but we'll probably never get that
far. The reality is that we have a granular decision likely at
the level of individaul QOM/QDev types.

If we wanted any flag it would be better expressed as something
like "security-boundary=yes|no', and then each object would need
to have a tri-state property "security-boundary=undefined|yes|no".

Initially everything would be in the 'undefined' category and
over a long series of patches we would then reclassify as much
as possible to "yes" or "no".

.... a mere matter of someone having time to actually do the
work, which is how we ended up with our current fuzzy doc
rather than anything expressed in code.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


