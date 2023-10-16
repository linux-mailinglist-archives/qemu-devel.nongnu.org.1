Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17367CAF31
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:30:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQTI-0002jf-KO; Mon, 16 Oct 2023 12:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsQTG-0002jH-EC
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsQTD-0000in-Up
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697473770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j237KHbiLaLBf9qXvG5Mbn3qqwkHVRCKu+/sAKwuFCU=;
 b=PJmMxD15obPj4pzJJj50hOpzT2Jz2Q/6v1IO9tyj9IgRF+8dKPnhVLde4MH1swghSo/d3H
 0f3ZkCOQgq4ccOqRyE9NQ0mPs7+2gwmxeFaqiBaGo+u1DZHoQDFYU2l+q5stpvrbMPIFz+
 1Y8x5YOUnZU+K5mAhM0pucyfFoMZj6s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-HwPp5n5ZPEe8buxojxLAlQ-1; Mon, 16 Oct 2023 12:29:22 -0400
X-MC-Unique: HwPp5n5ZPEe8buxojxLAlQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66011f0d521so5563696d6.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697473761; x=1698078561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j237KHbiLaLBf9qXvG5Mbn3qqwkHVRCKu+/sAKwuFCU=;
 b=OJ2BnZeyLoTRo2y6a+KnvriAZUbuFZs2JhvfYXU2DkbPs92n0Zp+sbXGfOdvnplBZ8
 aHSdqYgZXdbOwU0tJb22ErcEkAjUI3mUtK7reBwpmFJ1dLFliIm7VpwvrShTrJvgZcVv
 CSEEcOsrmWZEn6VDXGAf1W/Erj33C9J973EQ77dZDfx4uTMKqahlzjhr9MEVPvqmbRRD
 zw4vv9IH+5++uy1DbgQasmwvySfO/wH7t3aZVnO2kybtKk/9i4vpTYRxNV/oykDjSnQT
 kXjMDNuzJvFutM3qYHrN4xXIdytxGz4bCSICOraNgGqTEapDYkaEKa0Ytwh4WmjaYfTm
 IZ4w==
X-Gm-Message-State: AOJu0Yxy4btktIfNheV2yAcQil+chiI+CyGlw02l7uxUvu5EVdEi5EBv
 BcOWUfbJECKQJ44+utXL8GONjBZxA7O45XTBYKvBtkGulx91jjTzDWvZUtnfh+X28m/qjjx2A0y
 QE6HqiOL/Y3DrfoYgiOfgbIY=
X-Received: by 2002:a05:6214:176d:b0:66d:1b9b:196c with SMTP id
 et13-20020a056214176d00b0066d1b9b196cmr10918646qvb.2.1697473761534; 
 Mon, 16 Oct 2023 09:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWPJh1k7IdbxhYdoHc+fjnp/c+E+EYuJOui5xSEgL0K5HET/9AumLnNqslVkOwOTwQD4NP+g==
X-Received: by 2002:a05:6214:176d:b0:66d:1b9b:196c with SMTP id
 et13-20020a056214176d00b0066d1b9b196cmr10918630qvb.2.1697473761246; 
 Mon, 16 Oct 2023 09:29:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c12-20020a0ce14c000000b0065afedf3aabsm3526081qvl.48.2023.10.16.09.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 09:29:20 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:29:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 0/4] qapi/migration: Dedup migration parameter objects
 and fix tls-authz crash
Message-ID: <ZS1k3mBVHgIPrjfO@x1n>
References: <20230905162335.235619-1-peterx@redhat.com>
 <87h6mqixya.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6mqixya.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 16, 2023 at 09:08:40AM +0200, Markus Armbruster wrote:
> Let me try to summarize our findings so far.

Thanks.  I'll reply here instead of all the rest places.

> 
> PATCH 1 has been merged.  PATCH 2 has been queued, but not merged (not
> sure why, accident?).

(I don't know, either; could be in the next pull)

> 
> The remaining two are the actual de-triplication:
> 
> PATCH 3: Fuse MigrationParameters and MigrateSetParameters
> 
> PATCH 4: De-document MigrationParameter
> 
> The latter is a much simpler problem, so let's discuss it first.
> 
> 
> Enum MigrationParameter is used only internally.  It's in the QAPI
> schema just because we want code generated for it.  It shouldn't be
> documented in the QEMU QMP Reference Manual, but is, because the
> generator is too stupid to elide internal-only stuff.
> 
> PATCH 4 moves it out of the schema.  It has to add back the lost
> generated code in hand-written form, which is a bit unfortunate.  I
> proposed to instead drop most of the useless doc comment by exploiting a
> QAPI generator loophole.
> 
> Aside: the QAPI generator should elide internal-only stuff from the QEMU
> QMP Reference manual, and it should not require doc comments then.
> Future work, let's not worry about it now.

Just to double check: @MigrationParameter will not be exported in any form
even today, including query-qmp-schema, am I right?

> 
> 
> The fusing of MigrationParameters and MigrateSetParameters is kind of
> stuck.  Several options, all with drawbacks or problems:
> 
> 1. Pick StrOrNull for the tls_FOO members
> 
>    This is what PATCH 3 does.  Blocked on the pre-existing class of
>    crash bugs discussed in
> 
>     Subject: QAPI string visitors crashes
>     Message-ID: <875y3epv3y.fsf@pond.sub.org>
>     https://lore.kernel.org/qemu-devel/875y3epv3y.fsf@pond.sub.org/
> 
>    Needs fixing, but when a fix will be available is unclear.
> 
> 2. Pick str for the tls_FOO members
> 
>    This is what v1 did.  Incompatible change: JSON null no longer works.
>    Libvirt doesn't use it (it uses deprecated "" instead), but we cannot
>    know for sure nothing else out there uses it.
> 
>    I don't think reducing development friction (that's what
>    de-duplication accomplishes) justifies breaking our compatibility
>    promise.
> 
>    To keep the promise, we'd have to deprecate null, un-deprecate "",
>    let the grace period pass, and only then de-duplicate.

Is "" deprecated already anywhere?

> 
> 3. Do nothing, live with the duplication
> 
>    Giving up like this would be sad.  Unless we commit to a more
>    complete overhaul of migration's QAPI/QMP configuration interface,
>    but I doubt we're ready for that.
> 
> Thoughts?

I already went 3) on the patch I posted for avail-switchover-bw.  I don't
know what's the best for 1) and 2), but if we can at least reduce
duplication from 3->2 that's a progress.  I replied in the other thread for
that loophole experiment.

How hard it is to mark an object not requiring documentation on each of its
field, if that's what we want in this case?  Currently the loophole didn't
work for me for some reason.  If we can have a marker for objects to escape
doc check legally, we can apply that to both @MigrationParameter and one
other (perhaps @MigrationSetParameters).

Thanks,

-- 
Peter Xu


