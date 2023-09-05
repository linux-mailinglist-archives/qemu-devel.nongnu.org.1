Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5594779242D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:52:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYKq-0001g2-5T; Tue, 05 Sep 2023 11:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYKa-0001Ww-6E
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYKW-000801-Rb
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693929064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gsjyXrSASazJSH1qfhm4Cu4pTLOJ+2sbouv1USxHuJ8=;
 b=Qn1RR09/mCT5eAhgoPlj8P3t+osnEBq4wg0iX7RLUuqER0HtHjuQAJfSfDk6v5khUlBnN1
 3xzulOhBO8avNvL8sirqYZbByO90uiZ1gDqsQGGIa3ChyGFEtOZfBqTSnCVWoRq0Wngt2q
 l6y41T9cjqcJCrwKzNBvNun+uhGkYWk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-n-DHULpONXyHdDQW-zls9Q-1; Tue, 05 Sep 2023 11:51:02 -0400
X-MC-Unique: n-DHULpONXyHdDQW-zls9Q-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6515b44388fso3924176d6.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 08:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693929061; x=1694533861;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gsjyXrSASazJSH1qfhm4Cu4pTLOJ+2sbouv1USxHuJ8=;
 b=WS/hf5psDO3XNWpzvcLNJZZSio4SEA2I1ingKF+hvgLiw4FE/FK2y3xywJETAifvam
 8yG+70cJq275nTjnrXY6q4LpgCFTDV40w5RVVQQy5HScoOQKtHBXdA+Re/FJDXJk9+bd
 l+OmQYvPIEjB0jiwfPHwZruOojLmxwiKhU4dPUIWZftGJHZ3r9JOgxQd/GYzfs1P86bX
 X55Sk6x11MoUJORRmX+eWH8adEKDCBoQgYKGe/4yvlew9zQDmshAMXL6btaX0jSn9li8
 Vhd1LdMImx1Y4ZBKAHQaIG6T3EBxjw2EKBVcAwBCBlAzTSJCz9V1nV7jrE4x9KP6CZB/
 g6fw==
X-Gm-Message-State: AOJu0YwTubSfNuooBhZlU8/+Yc3MxOWnhtS/NkPODvTy2yuxBnlP+zlp
 +h74ytVclioQxGDMbqDmMWLJZGfkS398Y2Zf8ApcQT2r0odq0xSmWxId070Gl52MgJY2nzsGUdp
 TfBEjLMi6miHvsEQLQvmILXs=
X-Received: by 2002:a05:6214:f69:b0:649:5f43:245f with SMTP id
 iy9-20020a0562140f6900b006495f43245fmr15094551qvb.6.1693929061454; 
 Tue, 05 Sep 2023 08:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETDgfKWiQCfxJOwn9rjg1EBU6l1IsSgAH7S+sM6QGJHEUncTUIaJk5uZFMdVOYrJajWuyGVg==
X-Received: by 2002:a05:6214:f69:b0:649:5f43:245f with SMTP id
 iy9-20020a0562140f6900b006495f43245fmr15094540qvb.6.1693929061221; 
 Tue, 05 Sep 2023 08:51:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j6-20020a0c9cc6000000b0064f72cc5f4csm4612997qvf.11.2023.09.05.08.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 08:51:00 -0700 (PDT)
Date: Tue, 5 Sep 2023 11:50:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v2 22/22] softmmu/physmem: Clean up local variable
 shadowing
Message-ID: <ZPdOYhOMgMATgQRE@x1n>
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-23-philmd@linaro.org>
 <ZPYGYgs88/zgOHLc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPYGYgs88/zgOHLc@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Sep 04, 2023 at 05:31:30PM +0100, Daniel P. Berrangé wrote:
> On Mon, Sep 04, 2023 at 06:12:34PM +0200, Philippe Mathieu-Daudé wrote:
> > Fix:
> > 
> >   softmmu/physmem.c: In function ‘cpu_physical_memory_snapshot_and_clear_dirty’:
> >   softmmu/physmem.c:916:27: warning: declaration of ‘offset’ shadows a parameter [-Wshadow=compatible-local]
> >     916 |             unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
> >         |                           ^~~~~~
> >   softmmu/physmem.c:892:31: note: shadowed declaration is here
> >     892 |     (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client)
> >         |                        ~~~~~~~^~~~~~
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> > RFC: Please double-check how 'offset' is used few lines later.
> 
> I don't see an issue - those lines are in an outer scope, so won't
> be accessing the 'offset' you've changed, they'll be the parameter
> instead. If you want to sanity check though, presumably the asm
> dissassembly for this method should be the same before/after this
> change

(and if it didn't do so then it's a bug..)

> 
> > ---
> >  softmmu/physmem.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


