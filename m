Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981F7AB4AE
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:22:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhyx-0001x4-CR; Fri, 22 Sep 2023 11:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qjhyv-0001wg-FZ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qjhyf-0006zY-RD
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695396116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qapF6dVn5prxXuSbMyB/atAhijoG9vTiO4cPktYVKSY=;
 b=gntezQ58GlfXrh7xCVKojyvNioNgGH0j/MqgqkYM9DmFl/Dw7o+dTwa93ui/y2Ajr2EaJ4
 XrCsLl8aSCgsFBD12nvRuYNqSRGad89wqJ/mqGmg3eRiZtPth9zeFtheSxTGPsDecCxjUd
 A/A71Y+/ZRj2Ju2Vxr0LZlx48Nj0nXU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-kRYBSSXrOZaRxa_jgVb2aA-1; Fri, 22 Sep 2023 11:21:54 -0400
X-MC-Unique: kRYBSSXrOZaRxa_jgVb2aA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7741abfbe9fso15026585a.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695396114; x=1696000914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qapF6dVn5prxXuSbMyB/atAhijoG9vTiO4cPktYVKSY=;
 b=ZhEFOQStTgMF87TrbUetsQgB3BQ2SW4ICVQqvZMUU0k4aEojuQQiKa/oA2C2gAVKXI
 1kCfE/mapvwaOGE+LaCdW5ODMt3kwgOQ0eOgOToPeaE5NbEX51kWxyZ770HMTLnIXErs
 B2FHjg8e9pyrXUl7NakZtkDc9rRSYClbLbcJNfp8Ih5kBfo3wBP516c3cQQ7TWF9ymXW
 4M0aRnb4TUfhRve+9ggWmmx/SMq5U/TAaktp+f2X7CX8NtVkdf61ahxgwZpMsCXr+ONg
 SL7S34E3j2Va3zLuRqB0PX6+KwrPqFszZEG7h9haxquRMGtkkJs1f0wxLNKuMEqmVOVf
 JqIw==
X-Gm-Message-State: AOJu0Yz3xDJN/Y/PA8u73ezcVgC0Tnn5OA7C4/KUgg6vSJ3w/2pXkBS0
 5/n50i6gQQM8vXdeAnpgSDws1DSZAUibmXSwh5fmggBZJeS2tOqqzhbBkXhOe1NuJbxZJR9iwLx
 bl4gA5rNt8EO3oBM=
X-Received: by 2002:a05:620a:1a83:b0:767:e04f:48c8 with SMTP id
 bl3-20020a05620a1a8300b00767e04f48c8mr9700836qkb.7.1695396113819; 
 Fri, 22 Sep 2023 08:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpAiG3Zmty8e14oDTXUx1oYAd98gTzCETpzp+DU4bER1zAhGYus0WnD1ywEW6o/y2nbCbsXw==
X-Received: by 2002:a05:620a:1a83:b0:767:e04f:48c8 with SMTP id
 bl3-20020a05620a1a8300b00767e04f48c8mr9700821qkb.7.1695396113541; 
 Fri, 22 Sep 2023 08:21:53 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ow10-20020a05620a820a00b0076d9df37949sm1485678qkn.36.2023.09.22.08.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:21:53 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:21:50 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 00/52] migration/rdma: Error handling fixes
Message-ID: <ZQ2xDgV8pFQN7qBc@x1n>
References: <20230918144206.560120-1-armbru@redhat.com> <ZQnRKjo0M50BRbZh@x1n>
 <9224534e-2f95-4c7f-a082-725dd5eb9cab@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9224534e-2f95-4c7f-a082-725dd5eb9cab@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Sep 21, 2023 at 08:27:24AM +0000, Zhijian Li (Fujitsu) wrote:
> I'm worried that I may not have enough time, ability, or environment to review/test
> the RDMA patches. but for this patch set, i will take a look later.

That'll be helpful, thanks!

So it seems maybe at least we should have an entry for rdma migration to
reflect the state of the code there.  AFAIU we don't strictly need a
maintainer for the entries; an empty entry should suffice, which I can
prepare a patch for it:

RDMA Migration
S: Odd Fixes
F: migration/rdma*

Zhijian, if you still want to get emails when someone changes the code,
maybe you still wanted be listed as a reviewer (even if not a maintainer)?
So that you don't necessarily need to review every time, but just in case
you still want to get notified whenever someone changes it, that means one
line added onto above:

R: Li Zhijian <lizhijian@fujitsu.com>

Do you prefer me to add that R: for you when I send the maintainer file
update?

I'm curious whether Fujitsu is using this code in production, if so it'll
be great if you can be supported as, perhaps part of, your job to maintain
the rdma code.  But maybe that's not the case.

In all cases, thanks a lot for the helps already.

-- 
Peter Xu


