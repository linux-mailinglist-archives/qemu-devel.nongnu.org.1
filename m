Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F32BC763C51
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 18:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgye-0002JY-QU; Wed, 26 Jul 2023 12:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOgx0-0001TY-2J
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOgww-00048K-TM
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690387276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhY1Hs7QOV6A70CnYUt6ytS3aAg6p7aC6MnWNaWl6HI=;
 b=ADc9xWwntYLfnlo/nvcn9hTgKwQZj57pmUopoYLKD0RbMslVbM2ES9QUD2mCkYG8jryaME
 XKgSpNo1JVPCXSxhU4B8ZsFDwjV/RAxgO4xSyVCAXav3ODuGOr42YiFTne+47h+YdvZFVd
 0wRsOSqZMi9d+rW82aAYk8LRttcaCRo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-72H-ViqjMHeeNRsX3AisjA-1; Wed, 26 Jul 2023 12:01:13 -0400
X-MC-Unique: 72H-ViqjMHeeNRsX3AisjA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bb3a2c781so133921966b.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 09:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690387273; x=1690992073;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AhY1Hs7QOV6A70CnYUt6ytS3aAg6p7aC6MnWNaWl6HI=;
 b=igINI/fbCC13eXWwGnlbp1r6OXfvbpQoXEUrFRG08+h5YYwSWUD8oXMNcMbUw7qEKS
 4IPdv2wziKS2dd7s9jHjg6rnleuzz2FrdZpeDGkqrQyu8xNibsIoxn0rQXZWg1Yal+aT
 gmahdn85DwmUYLGWkI5TNEwFtQNZCo8+wf20VgtzeVXHn1W1rsjnGCRMIEfjUA9WgrjH
 THij/KYCAA9GqhFJljMrVF6qSHmvYTZ+ymysLOfbTohBahPEeue6xYl5MhEEMpaXHD+I
 itZV43lmmzphmqfxVnJXS12Fo2KXlSZ3ffBTv2evHecgCcmnoDP2txV6ZyMYfz05Dwqn
 2KMw==
X-Gm-Message-State: ABy/qLa7j5a3jQgpFaTpwVG5AeqRbqhDa9eSWdl6nVQWhmacDSYzTdmS
 0YTJBXmizb7vVr4HiSuRoSvlYwf7SjkMAHEosMyvaKdJg1tGhkG7eBZD82xX8fS2vCBCve4owKe
 oO+bx0XC7gbHaBsU=
X-Received: by 2002:a17:906:6495:b0:977:e310:1ce7 with SMTP id
 e21-20020a170906649500b00977e3101ce7mr2239635ejm.38.1690387272806; 
 Wed, 26 Jul 2023 09:01:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG1L+AG4ddmpoqNyrxJMl0PWlzoUaXUY6KXA4UGwKS/61jEW0cDEnSsh6rhCfqHmaoIX95XJg==
X-Received: by 2002:a17:906:6495:b0:977:e310:1ce7 with SMTP id
 e21-20020a170906649500b00977e3101ce7mr2239613ejm.38.1690387272455; 
 Wed, 26 Jul 2023 09:01:12 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 rl6-20020a170907216600b009920a690cd9sm9759284ejb.59.2023.07.26.09.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 09:01:10 -0700 (PDT)
Date: Wed, 26 Jul 2023 12:01:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 slp@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, takahiro.akashi@linaro.org,
 erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
 mathieu.poirier@linaro.org
Subject: Re: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE
 protocol feature for vhost-user
Message-ID: <20230726120004-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
 <87o7krg0sn.fsf@linaro.org>
 <qmwvywoy7lfkgr7kcc6cxghulgd5g2gvnv76mvkuxbqclbwmti@4qyiktfiu2ej>
 <20230720193601.GI210977@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720193601.GI210977@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jul 20, 2023 at 03:36:01PM -0400, Stefan Hajnoczi wrote:
> On Fri, Jul 07, 2023 at 12:27:39PM +0200, Stefano Garzarella wrote:
> > On Tue, Jul 04, 2023 at 04:02:42PM +0100, Alex Bennée wrote:
> > > 
> > > Stefano Garzarella <sgarzare@redhat.com> writes:
> > > 
> > > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> > > > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > > > > index 5a070adbc1..85b1b1583a 100644
> > > > > --- a/docs/interop/vhost-user.rst
> > > > > +++ b/docs/interop/vhost-user.rst
> > > > > @@ -275,6 +275,21 @@ Inflight description
> > > > > 
> > > > > :queue size: a 16-bit size of virtqueues
> > > > > 
> > > > > +Backend specifications
> > > > > +^^^^^^^^^^^^^^^^^^^^^^
> > > > > +
> > > > > ++-----------+-------------+------------+------------+
> > > > > +| device id | config size |   min_vqs  |   max_vqs  |
> > > > > ++-----------+-------------+------------+------------+
> > > > > +
> > > > > +:device id: a 32-bit value holding the VirtIO device ID
> > > > > +
> > > > > +:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
> > > > > +
> > > > > +:min_vqs: a 32-bit value holding the minimum number of vqs supported
> > > > 
> > > > Why do we need the minimum?
> > > 
> > > We need to know the minimum number because some devices have fixed VQs
> > > that must be present.
> > 
> > But does QEMU need to know this?
> > 
> > Or is it okay that the driver will then fail in the guest if there
> > are not the right number of queues?
> 
> I don't understand why min_vqs is needed either. It's not the
> front-end's job to ensure that the device will be used properly. A
> spec-compliant driver will work with a spec-compliant device, so it's
> not clear why the front-end needs this information.
> 
> Stefan



I think this really demonstrates why we should keep separate
messages and not the "standalone" thing which seems to
mean "bundle a bunch of mostly unrelated stuff in one message":
this way each field is carefully documented.


-- 
MST


