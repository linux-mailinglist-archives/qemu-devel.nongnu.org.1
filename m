Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE803A45A9D
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 10:51:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnE2r-0006k9-Q6; Wed, 26 Feb 2025 04:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnE2g-0006hv-GK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnE2c-0006eF-US
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjMYlQITNoixhXNEiHlkCOqTz/eRJaGUmOufpNlVX5o=;
 b=PUeIDoAquXx4SuUHUAU6QS9Lx7nFW294GNh1zBfN6zmsMdWumjHVrMOnF57LtcEPKU1c4r
 wt3HSe57OV9z4YLUeOEBrE6ThkigmKA8uFZpQctvm/4dJ5vGEnTL120AJlgXGk9lr1GlbI
 ywWe9MJEF1Owe+0Z4vzarD6c+x5jlYY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-enDWLv3yM2aZi-anRdoxhg-1; Wed,
 26 Feb 2025 04:49:16 -0500
X-MC-Unique: enDWLv3yM2aZi-anRdoxhg-1
X-Mimecast-MFC-AGG-ID: enDWLv3yM2aZi-anRdoxhg_1740563354
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8A041801A1B; Wed, 26 Feb 2025 09:49:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49EFD19560AB; Wed, 26 Feb 2025 09:49:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D18E421E675E; Wed, 26 Feb 2025 10:49:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  qemu-arm@nongnu.org,  Ard
 Biesheuvel <ardb@kernel.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 graf@amazon.com,  Eric Blake <eblake@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v5 14/24] hw/uefi: add var-service-json.c + qapi for NV
 vars.
In-Reply-To: <pji24p6oag7cn2rovus7rquo7q2c6tokuquobfro2sqorky7vu@tk7cxud6jw7f>
 (Gerd Hoffmann's message of "Wed, 26 Feb 2025 10:12:02 +0100")
References: <20250225163031.1409078-1-kraxel@redhat.com>
 <20250225163031.1409078-15-kraxel@redhat.com>
 <87zfi95khl.fsf@pond.sub.org>
 <wyrnw2ur2xp7e6yr7f7hdbn3zbvolnvjojjrlaoax7hb2psxzo@xw7arzdtroer>
 <87bjup3y76.fsf@pond.sub.org>
 <pji24p6oag7cn2rovus7rquo7q2c6tokuquobfro2sqorky7vu@tk7cxud6jw7f>
Date: Wed, 26 Feb 2025 10:49:11 +0100
Message-ID: <87a5a911ew.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Gerd Hoffmann <kraxel@redhat.com> writes:

>> >> > +# @digest: variable certificate digest.  Used to verify the signature
>> >> > +#     of updates for authenticated variables.
>> >> 
>> >> How to create and verify these digests will be obvious enough to users
>> >> of this interface?
>> >
>> > Well, no.  It's a somewhat complicated story ...
>
>> I wonder how much of this, if anything, should be worked into the doc
>> comment.  You decide :)
>
> A bit verbose for something rarely used.  Tried to summarize it,
> incremental update below:

Looks good to me; Acked-by stands.  Thanks!


