Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC167F72DF
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:37:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UUz-000067-Bq; Fri, 24 Nov 2023 06:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6UUx-00005o-S9
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:37:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6UUv-00083M-TD
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700825844;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukyEqZY67Q7RRBdJFshQ6oJ0XhudxY0+BjsIEuQTtU4=;
 b=E8DOBYi0u/OlLxqhhkNNI3nmzcBIcfs21lv8Nm3fCBiJXs0LDAh4vDkJXS1avt5cgFrmmD
 8B3cm1d4tjij5NrwGlIlg7p8xwtk78EZTDabUx0T5lXY6wo1p1NzZlSuCvhJlU2AwVCXkF
 r/ByShXISSEEn+oz+rlXLgZx/Nwu17Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-XTLuMTOaPCuAI7GY5tymWg-1; Fri, 24 Nov 2023 06:37:21 -0500
X-MC-Unique: XTLuMTOaPCuAI7GY5tymWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9675B185A783;
 Fri, 24 Nov 2023 11:37:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C428E40C6EBB;
 Fri, 24 Nov 2023 11:37:17 +0000 (UTC)
Date: Fri, 24 Nov 2023 11:37:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <ZWCK67xSasXOhU0m@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <87r0kgeiex.fsf@draig.linaro.org> <ZV-P6M8seKmMKGCB@redhat.com>
 <20231123183245-mutt-send-email-mst@kernel.org>
 <ZWB4MMrW1JttcxqI@redhat.com> <87edgfcueq.fsf@draig.linaro.org>
 <20231124053749-mutt-send-email-mst@kernel.org>
 <CAFEAcA-0Kusbm_YGo5xu7ztNxdMMe28U5+9Xp=Rp=UG+Ur6EFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-0Kusbm_YGo5xu7ztNxdMMe28U5+9Xp=Rp=UG+Ur6EFg@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

On Fri, Nov 24, 2023 at 10:43:05AM +0000, Peter Maydell wrote:
> On Fri, 24 Nov 2023 at 10:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Nov 24, 2023 at 10:33:49AM +0000, Alex Bennée wrote:
> > > That probably means we can never use even open source LLMs to generate
> > > code for QEMU because while the source data is all open source it won't
> > > necessarily be GPL compatible.
> >
> > I would probably wait until the dust settles before we start accepting
> > LLM generated code.
> 
> I think that's pretty much my take on what this policy is:
> "say no for now; we can always come back later when the legal
> situation seems clearer".

Yes, that was my thoughts exactly.

And if anyone comes along with a specific LLM/AI code generator that
they believe can be used in a way compatible with the DCO, they can
ask for an exception to the general policy which we can discuss then.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


