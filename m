Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0387A48B65
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Feb 2025 23:24:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnmIA-0005QC-8A; Thu, 27 Feb 2025 17:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tnmI8-0005PT-6J
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:23:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tnmI5-0002Ru-Pg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740695016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlbWbQg1KXBq4F7/AmWaBdbETYLZD0bgyo/KQsRioKw=;
 b=Shl7tEleOdOtZuI7I6DI3f17jgsW2hIIcI0FFLyuh08YcglcFYtmQHuPJYbrnvbFRzyo7t
 9dHbvbQF5Q2dsfr0i1itHSLAMYWBX1K/4u5BBkAnrLLE/4ml6HeJf2qeOt4qYhvUfjGNjj
 FzWl+ZnnXlA+WKYYAwvxkLaswuhtyU8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-Nl4BDsqVOUq5ggqRxeLMDg-1; Thu,
 27 Feb 2025 17:23:32 -0500
X-MC-Unique: Nl4BDsqVOUq5ggqRxeLMDg-1
X-Mimecast-MFC-AGG-ID: Nl4BDsqVOUq5ggqRxeLMDg_1740695011
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83FBE193578F; Thu, 27 Feb 2025 22:23:31 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.162])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62E8B1955BCB; Thu, 27 Feb 2025 22:23:29 +0000 (UTC)
Date: Thu, 27 Feb 2025 16:23:26 -0600
From: Eric Blake <eblake@redhat.com>
To: prashant patil <pmgpatil@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Query on the dirty bitmap
Message-ID: <d2276vugq6wureu6zzrwci5sdtg3b6gllqskjv7hfvuulsmhyn@anl3d5htudty>
References: <CAFvsdYns1yO6Wsm8VKP_khbTPm09Kf5KDmBpeMSrjboyccK4Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFvsdYns1yO6Wsm8VKP_khbTPm09Kf5KDmBpeMSrjboyccK4Aw@mail.gmail.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

On Wed, Feb 19, 2025 at 04:23:26PM +0530, prashant patil wrote:
> Hello All,
> Hope this email finds you well.
> 
> I have been trying with qemu for a while now, and have come across a
> problem specific to dirty bitmaps. I have enabled bitmap on the qcow2 disk
> image using 'qemu-img bitmap' command, exposed the bitmap over a unix
> socket using 'qemu-nbd' command. Now when I try to read the bitmap using
> 'qemu-img map' command with 'x-dirty-bitmap=qemu:dirty-bitmap:{bitmap}'
> option, I get one single extent which shows that the entire disk is dirty.
> Note that the disk size is 5 GB, and has only a few MB of data in it, and
> had added very small data after the bitmap was enabled. Bitmap output has
> been pasted below.

Can you show the exact sequence of command lines you used to create
the image, dirty a portion of it, then start up the qemu-nbd process
to inspect it?  As written, I can't reproduce your issue, but I know
it sounds similar to tests/qemu-iotests/tests/qemu-img-bitmaps which
does what you're talking about, so I know the code works and have to
suspect you may have missed a step or reordered things in such a way
that the entire bitmap is reading as dirty.

> 
> [{ "start": 0, "length": 5368709120, "depth": 0, "present": true, "zero":
> false, "data": true, "compressed": false, "offset": 0}]
> 
> Can someone please help me understand why the bitmap content shows the
> entire disk as dirty?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


