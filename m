Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05127956FDC
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Aug 2024 18:11:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4yE-0005Ak-JW; Mon, 19 Aug 2024 12:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sg4yC-00059n-Ei
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 12:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sg4yA-0007Kn-6Q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 12:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724083856;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNvQ1DLubKumkjxJ4RP5XGzEkv4D0xW815rnip4Ks04=;
 b=QTkPBsyVWIooM2/sfNNGP7kiDsvuTJtl93Ga8CLPqNm/uUgnMVXUEutT5n/DdVrL+neof5
 SO+/iI1igYHk6FwnyOwFZqE85foKMck1DffVTla1h1lUeQ0KWR38O1A2qchAij07PDwopC
 n2FNUNKptx2Rg6+BOSNrY9CwEmXcbxw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-H_nIklH5Pwywaizz2vKuvQ-1; Mon,
 19 Aug 2024 12:10:53 -0400
X-MC-Unique: H_nIklH5Pwywaizz2vKuvQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A97351955BF6; Mon, 19 Aug 2024 16:10:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 245E81955BFA; Mon, 19 Aug 2024 16:10:42 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:10:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org,
 agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
Message-ID: <ZsNuf4jSSF4F37Pp@redhat.com>
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-5-dorjoychy111@gmail.com>
 <bffedf65-6046-4264-a2fe-011ff8c58860@amazon.com>
 <CAFfO_h7+FEzp-FrYM68A104CyNKgUfEReB+o9gYg5i-f=5DsVg@mail.gmail.com>
 <ZsNqerjjLCJ2OICd@redhat.com>
 <CAFfO_h5uQWrEKVK+E_QW7x64kdPms4uFeP8TjDVq7JEWANKXPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h5uQWrEKVK+E_QW7x64kdPms4uFeP8TjDVq7JEWANKXPw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 19, 2024 at 10:07:02PM +0600, Dorjoy Chowdhury wrote:
> On Mon, Aug 19, 2024 at 9:53 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Aug 19, 2024 at 09:32:55PM +0600, Dorjoy Chowdhury wrote:
> > > On Mon, Aug 19, 2024 at 4:13 PM Alexander Graf <graf@amazon.com> wrote:
> > > >
> > > > Hey Dorjoy,
> > > >
> > > > On 18.08.24 13:42, Dorjoy Chowdhury wrote:
> > > > > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
> > > > > is used for stripped down TPM functionality like attestation. This commit
> > > > > adds the built-in NSM device in the nitro-enclave machine type.
> > > > >
> > > > > In Nitro Enclaves, all the PCRs start in a known zero state and the first
> > > > > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR8
> > > > > contain the SHA384 hashes related to the EIF file used to boot the
> > > > > VM for validation.
> > > > >
> > > > > Some optional nitro-enclave machine options have been added:
> > > > >      - 'id': Enclave identifier, reflected in the module-id of the NSM
> > > > > device. If not provided, a default id will be set.
> > > > >      - 'parent-role': Parent instance IAM role ARN, reflected in PCR3
> > > > > of the NSM device.
> > > > >      - 'parent-id': Parent instance identifier, reflected in PCR4 of the
> > > > > NSM device.
> > > > >
> > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > > ---
> > > > >   crypto/meson.build              |   2 +-
> > > > >   crypto/x509-utils.c             |  73 +++++++++++
> > > >
> > > >
> > > > Can you please put this new API into its own patch file?
> > > >
> > > >
> > > > >   hw/core/eif.c                   | 225 +++++++++++++++++++++++++++++---
> > > > >   hw/core/eif.h                   |   5 +-
> > > >
> > > >
> > > > These changes to eif.c should ideally already be part of the patch that
> > > > introduces eif.c (patch 1), no? In fact, do you think you can make the
> > > > whole eif logic its own patch file?
> > > >
> > > >
> > > > >   hw/core/meson.build             |   4 +-
> > > > >   hw/i386/Kconfig                 |   1 +
> > > > >   hw/i386/nitro_enclave.c         | 141 +++++++++++++++++++-
> > > > >   include/crypto/x509-utils.h     |  22 ++++
> > > > >   include/hw/i386/nitro_enclave.h |  26 ++++
> > > > >   9 files changed, 479 insertions(+), 20 deletions(-)
> > > > >   create mode 100644 crypto/x509-utils.c
> > > > >   create mode 100644 include/crypto/x509-utils.h
> > > > >
> > > > > diff --git a/crypto/meson.build b/crypto/meson.build
> > > > > index c46f9c22a7..09633194ed 100644
> > > > > --- a/crypto/meson.build
> > > > > +++ b/crypto/meson.build
> > > > > @@ -62,7 +62,7 @@ endif
> > > > >   if gcrypt.found()
> > > > >     util_ss.add(gcrypt, files('random-gcrypt.c'))
> > > > >   elif gnutls.found()
> > > > > -  util_ss.add(gnutls, files('random-gnutls.c'))
> > > > > +  util_ss.add(gnutls, files('random-gnutls.c', 'x509-utils.c'))
> > > >
> > > >
> > > > What if we don't have gnutls. Will everything still compile or do we
> > > > need to add any dependencies?
> > > >
> > > >
> > >
> > > [...]
> > >
> > > > >
> > > > > diff --git a/hw/core/meson.build b/hw/core/meson.build
> > > > > index f32d1ad943..8dc4552e35 100644
> > > > > --- a/hw/core/meson.build
> > > > > +++ b/hw/core/meson.build
> > > > > @@ -12,6 +12,8 @@ hwcore_ss.add(files(
> > > > >     'qdev-clock.c',
> > > > >   ))
> > > > >
> > > > > +libcbor = dependency('libcbor', version: '>=0.7.0')
> > > > > +
> > > > >   common_ss.add(files('cpu-common.c'))
> > > > >   common_ss.add(files('machine-smp.c'))
> > > > >   system_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fit.c'))
> > > > > @@ -24,7 +26,7 @@ system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
> > > > >   system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
> > > > >   system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
> > > > >   system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
> > > > > -system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), zlib])
> > > > > +system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), zlib, libcbor, gnutls])
> > > >
> > > >
> > > > Ah, you add the gnutls dependency here. Great! However, this means we
> > > > now make gnutls (and libcbor) a mandatory dependency for the default
> > > > configuration. Does configure know about that? I believe before gnutls
> > > > was optional, right?
> > > >
> > >
> > > I see gnutls is not a required dependency in the root meson.build. I
> > > am not sure what we should do here.
> > >
> > > Hey Daniel, do you have any suggestions about how this dependency
> > > should be included?
> >
> > Unconditionally build the crypto/x509-utils.c file, but in that put
> > file #ifdef CONFIG_GNUTLS, and in the #else put a stub impl of the
> > method that just calls error_setg().
> >
> > That way you can compile everything without any hard dep on gnutls,
> > but if someone tries to use it they'll get a runtime error when
> > gnutls is not built
> >
> 
> Understood. Thanks! What should I do about libcbor? That one is
> required for building nitro-enclave and virtio-nsm. Should I make that
> required in the root meson.build file?

No, we can't introduce new mandatory dependancies for a such a niche
use case.

In retrospect, I think you'll need to conditionalize meson.build to
avoid building any of the nitro-enclave & virtio-nsm code, when
either gnutls or cbor are missing.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


