Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B367D939910
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jul 2024 07:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7hM-0005lA-J5; Tue, 23 Jul 2024 01:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sW7hH-0005ci-98
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sW7hF-0007AW-K4
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721711059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RQqADbC6Lqwv47IcXz5qzJXV0xATq5WvUW5imZg2/QI=;
 b=EY21JThJgGiF48Sv/PZHJKmJ3wIuMc4zGf4WFi/w1H2rgqZGdaEGFoEBSMrRg5iRs8pAZO
 q8jwJRuQLG0RgiPoQCNfBgVi4BZnT/QfarIhrvDE3E6syIWQeEOamGM0oCCywybP1gv5Oy
 X6uVW8H02Zwm+c3EIttQfogRQ/2bw/8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-w_S8RgckO6OOoxTGyJ6wbw-1; Tue, 23 Jul 2024 01:04:16 -0400
X-MC-Unique: w_S8RgckO6OOoxTGyJ6wbw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4266edc9c85so34298735e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 22:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721711055; x=1722315855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RQqADbC6Lqwv47IcXz5qzJXV0xATq5WvUW5imZg2/QI=;
 b=fCBZ5izqZKAf1YaGI7eIOgy6zgKXMlfv5XNH5DpW9n9yxylWJtjAZqEypJHQdwDglh
 PWjCvZFamHarLJlDjchf4BIbfuOoBS7UN61B6OKT5UXqvp3FZfLRkz3ELygPfTWm9ivj
 HR2ApsbafjEn61WYroAMuK42yY1VEzrHz9NS3DzNwU1LS/f2dD9S57lymBKiADYRVIRq
 y4BZxbYBive8i+iJDJmhxrw0oJnF+cj09hNMT0p8KFMDaMiz3rxLOiDjyFnw68tuUrbI
 bmqJfqw5ebHsfk3l6+jexJvehXzcDrxiQJK9+kxdh6lRsX4lfNJW5ps435cdbGuTCwpV
 tAwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMrpITzL2Uxe0Z7PrqP1/KQ1thBU0TkiaPTFSi5S9K9JS7owsvcPRc6d8440F9KToOSw5bkuIU+PDtnmldpvGapvT2SWA=
X-Gm-Message-State: AOJu0YxC1bhHdxfgOENlWT7r3qIYBdClkl2sYIOtfZ04OdK2vR4OZwkf
 WPy2DMAKzMYQymB8R/iVKTy4n2T9eAiXnB8o7qeBS8UmGxqLRkpNn9SoM/mASi6WrEAOw0CIoTH
 kYsGl2SjWBvmJFnLwIm5bK6+GILbV8JL7eETj5Y7/Ac/jb0JQbU77xzpLNxN1GDgYKdHnA7HBVE
 J20Kb8919ujySHdrTxt+vnxv8Q99zRDaiUknI=
X-Received: by 2002:a05:600c:458d:b0:426:5ad9:e1a2 with SMTP id
 5b1f17b1804b1-427ecff2a98mr12748835e9.9.1721711054869; 
 Mon, 22 Jul 2024 22:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWSKi8cAFzYUUkPPc/rkLgTmKa0Ilaosmzo0seJVAAAJ0Ce1VQBXxqV7NDd8H18fvf92MfjCVD5xCsbXhCVdY=
X-Received: by 2002:a05:600c:458d:b0:426:5ad9:e1a2 with SMTP id
 5b1f17b1804b1-427ecff2a98mr12748715e9.9.1721711054591; Mon, 22 Jul 2024
 22:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
 <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
 <ZpUmrTrEnx0RcO2y@x1n>
 <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
 <ZpbuChi9QMIogmuS@x1n> <20240717045335-mutt-send-email-mst@kernel.org>
 <ZpfIDUwS9vawpzT5@x1n> <20240717093911-mutt-send-email-mst@kernel.org>
 <ZpfLZbiJ3cn6fEba@x1n> <20240720154116-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240720154116-mutt-send-email-mst@kernel.org>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 23 Jul 2024 10:33:58 +0530
Message-ID: <CAE8KmOwv-NiXwmeCAjFNu=R67D2GcNLffV8NedfMBXhY9ODh8w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Sun, 21 Jul 2024 at 01:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Wed, Jul 17, 2024 at 04:55:52AM -0400, Michael S. Tsirkin wrote:
> > > > > I just want to understand how we managed to have two threads
> > > > > talking in parallel. BQL is normally enough, which path
> > > > > manages to invoke vhost-user with BQL not taken?
> > > > > Just check BQL taken on each vhost user invocation and
> > > > > you will figure it out.
> > > >
> > > OK, so postcopy_ram_ things run without the BQL?
> >
> > There are a lot of postcopy_ram_* functions, I didn't check all of them but
> > I think it's true in this case.  Thanks.
> >
> So pls document this in the commit log.

* ie. IIUC, if we take BQL in postcop_ram_* functions, we don't need
this 'vhost_user_request_reply_lock patch'? I'll check the
postcopy_ram_* functions to see what's happening there.

Thank you.
---
  - Prasad


