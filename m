Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3455A2AE98
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 18:13:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5R4-0008Qq-MT; Thu, 06 Feb 2025 12:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tg5R0-0008QA-Oh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:13:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tg5Qx-0004jG-FU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738861978;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9D14+ttmEpbIjxxs+8RIc6XcrX92xYxztdX0W95HbA=;
 b=ia3zpU3g4pr+dCdBp+I4PkV1mDGzGpi5l4XUtl2UYJFP09RyIuMqAJizNhxBaz8mFhD4gv
 B4zjZy+8oIJ6ymtsMXMm5s7/5Bd7jqEFfgvvQMb94H+Y1/RMXE95E3uyM2+3HZzWiic0v+
 l+yTg1uMQYLoB50UUC8W6j6a1gTfRys=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-cxgIoaijOxOqJSkwXVbYJA-1; Thu,
 06 Feb 2025 12:12:52 -0500
X-MC-Unique: cxgIoaijOxOqJSkwXVbYJA-1
X-Mimecast-MFC-AGG-ID: cxgIoaijOxOqJSkwXVbYJA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82551195604F; Thu,  6 Feb 2025 17:12:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7D721800360; Thu,  6 Feb 2025 17:12:45 +0000 (UTC)
Date: Thu, 6 Feb 2025 17:12:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
Message-ID: <Z6TtisO7JGAMGILH@redhat.com>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org>
 <Z6S3Mgt1G7fIjeBB@redhat.com>
 <4624f149-76d0-4da5-8f13-8c015043c335@linaro.org>
 <Z6THtfjL6UVhBiW7@redhat.com>
 <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Feb 06, 2025 at 04:04:20PM +0100, Philippe Mathieu-Daudé wrote:
> On 6/2/25 15:31, Daniel P. Berrangé wrote:
> > On Thu, Feb 06, 2025 at 02:53:58PM +0100, Philippe Mathieu-Daudé wrote:
> > > Hi Daniel,
> > > 
> > > On 6/2/25 14:20, Daniel P. Berrangé wrote:
> > > > On Thu, Feb 06, 2025 at 02:10:47PM +0100, Philippe Mathieu-Daudé wrote:
> > > > > Introduce an abstract machine parent class which defines
> > > > > the 'little_endian' property. Duplicate the current machine,
> > > > > which endian is tied to the binary endianness, to one big
> > > > > endian and a little endian machine; updating the machine
> > > > > description. Keep the current default machine for each binary.
> > > > > 
> > > > > 'petalogix-s3adsp1800' machine is aliased as:
> > > > > - 'petalogix-s3adsp1800-be' on big-endian binary,
> > > > > - 'petalogix-s3adsp1800-le' on little-endian one.
> > > > 
> > > > Does it makes sense to expose these as different machine types ?
> > > > 
> > > > If all the HW is identical in both cases, it feels like the
> > > > endianness could just be a bool property of the machine type,
> > > > rather than a new machine type.
> > > 
> > > Our test suites expect "qemu-system-foo -M bar" to work out of
> > > the box, we can not have non-default properties.
> > > 
> > > (This is related to the raspberry pi discussion in
> > > https://lore.kernel.org/qemu-devel/20250204002240.97830-1-philmd@linaro.org/).
> > > 
> > > My plan is to deprecate 'petalogix-s3adsp1800', so once we
> > > remove it we can merge both qemu-system-microblaze and
> > > qemu-system-microblazeel into a single binary.
> > > 
> > > If you don't want to add more machines, what should be the
> > > endianness of the 'petalogix-s3adsp1800' machine in a binary
> > > with no particular endianness? Either we add for explicit
> > > endianness (fixing test suites) or we add one machine for
> > > each endianness; I fail to see other options not too
> > > confusing for our users.
> > 
> > We would pick an arbitrary endianness of our choosing
> > I guess. How does this work in physical machines ? Is
> > the choice of endianess a firmware setting, or a choice
> > by the vendor when manufacturing in some way ?
> 
> Like MIPS*, SH4* and Xtensa*, it is a jumper on the board
> (wired to a CPU pin which is sampled once at cold reset).

That makes me thing even more it is just a machine type property.

None the less, since you've already taken this pattern of
dual machine types for BE & LE on  MIPS/SH4/XTensa, I think
we should stick with your precedent. Consistent modelling
of endian handling across all machine types is most important
IMHO


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


