Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 092D59BB8E3
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Nov 2024 16:25:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ywl-0006ds-0p; Mon, 04 Nov 2024 10:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7ywb-0006d3-Bh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7ywZ-00022z-23
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730733876;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Rpq/uBr2y2YyfHOuA0rZNYcdp3Fhq0ehdI8m+Y3eq0=;
 b=C5uu3UWM+uwUFBilZ2YVZizF2nwT0l8R/kDtsZg8TpDuw81iJ7Qq7u65ocDa0CoHx2QdRu
 QJaz0ABOCKjqYOIJIl+gjhyFyGmx+FLiL7p9SxhgPDNGc+vXdft6+Ljs50zMViq6pbdFJc
 bDrPbRbNkOOVOkb6QRyaVB0noKegPtM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-nFxoB0yaNfuObz_1CF_hXA-1; Mon,
 04 Nov 2024 10:24:33 -0500
X-MC-Unique: nFxoB0yaNfuObz_1CF_hXA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A90081955BC7; Mon,  4 Nov 2024 15:24:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.152])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33BC219560AA; Mon,  4 Nov 2024 15:24:19 +0000 (UTC)
Date: Mon, 4 Nov 2024 15:24:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
Message-ID: <ZyjnIMteSuCvpGPW@redhat.com>
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com>
 <ZxuZkUFz_bwAA1pf@redhat.com>
 <0700af51-a1a6-4b11-a4bf-0eaf6e279c6d@redhat.com>
 <Zxudl5-fZV1vIaEL@redhat.com> <87y128nrfr.fsf@redhat.com>
 <Zx-3OUioG1l47hW3@redhat.com>
 <24ca0278-5018-41e3-a097-ac560a16f8fa@redhat.com>
 <ZyjgWJ3bZ69sueE2@redhat.com> <875xp3nigb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xp3nigb.fsf@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 04, 2024 at 04:10:12PM +0100, Cornelia Huck wrote:
> On Mon, Nov 04 2024, Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> >
> > FYI, in x86 target the -cpu command has had a "migratable=bool" property
> > for a long time , which defaults to 'true' for 'host' model. This causes
> > QEMU to explicitly drop features which would otherwise prevent migration
> > between two hosts with identical physical CPUs.
> >
> > IOW, if there are some bits present in 'host' that cause migration
> > problems on Ampere hosts, ideally either QEMU (or KVM kmod) would
> > detect them and turn them off automatically if migratable=true is
> > set. See commit message in 84f1b92f & 120eee7d1fd for some background
> > info
> 
> How does this work for version-sensitive features -- are they always
> defaulting to off? How many features are left with that in the end?

Do you mean QEMU versions here ? The non-migratable feature list is
just hardcoded in QEMU right now, and there's only 1 of them.
eg grep for 'unmigratable_flags'

Note, that "migratable" property is not defining a general purpose
migration mask between different hw generations. It was specifically
blocking just stuff that is known to make migration impossible, even
if HW is identical on both sides.

> > NB "migratable" is defined in i386 target code today, but conceptually
> > we should expand/move that to apply to all targets for consistency,
> > even if it is effectively a no-op some targets (eg if they are
> > guaranteed migratable out of the box already with '-cpu host').
> 
> How does this compare to s390x, which defines some migration-safe cpu
> models, based upon the different hw generations? If I look at the QEMU
> code for x86 and s390x, the s390x approach seems cleaner to me (probably
> because it came later, and therefore could start afresh without having
> to care for legacy things.) Given that we'll cook up a new model for Arm
> migration as well, we might as well start with a clean implementation :)

The impression I get (as an distant observer) is that CPUs on s390x in
general have less complexity to worry about. A combination of not having
a vendor who creates loads off different SKUs for the same CPU model
family with slight variations between each, and also not seeming to have
a situation where CPU flags a known to disappear (or appear) arbitrarily
in microcode updates.

The s390x idea of a "migratable" and "non migratable" model for each
HW generation is a nice simplification, but I can't see how it could
be made to work for x86 when you can't predict ahead of time what
features are going to be removed from existing HW definition by the
next microcode update, or by the next CPU SKU that removes a feature
you had assumed would always be present in a given HW generation.

I don't know much about how ARM world works, but having lots of vendors
competing with their own custom impls makes me worry complexity will
be closer to x86 than to s390.

If the ARM specifications define a minimum require featureset for each
HW generation, maybe you can define a model based on that ? You might
still want to have vendor specific models though, if there are compelling
features they expose which are optional, or non-standardized. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


