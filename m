Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF87E9D53
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 14:37:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2X71-0002By-BW; Mon, 13 Nov 2023 08:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1r2X6y-000281-8N
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:36:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1r2X6j-00058M-VF
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699882563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w0ScV907uadhC4WyMD57whs7/7sUsi6u8ESXYamvt98=;
 b=bJjtmxyR8YmDbRnS+B5fJof+XCbdphXJApDKmC3HVoscqcFzkMxi7HyRVcOfg7CLOmpV1T
 Kq+dR0fCF/7Ndlz8jt6IZY+yNg82C4rT0pK/9fcbT8GLPhfhBafFkID/flOryf5+Brnlx3
 FSQZJYqMBdN/6d92pUZmFavfeDomcOg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-xXppnjgVMlujZnqNrkzkeA-1; Mon,
 13 Nov 2023 08:35:59 -0500
X-MC-Unique: xXppnjgVMlujZnqNrkzkeA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9ED363822E80;
 Mon, 13 Nov 2023 13:35:58 +0000 (UTC)
Received: from localhost (unknown [10.39.192.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24B45492BFD;
 Mon, 13 Nov 2023 13:35:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 opnfv-tech-discuss@lists.opnfv.org, dev@dpdk.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paul Knight
 <paul.knight@oasis-open.org>
Subject: Re: [virtio] Invitation to comment on Virtual I/O Device (VIRTIO)
 Version 1.3 - ends December 8th
In-Reply-To: <CADgeAH_67CQZoVGEB_ddGEZA5+kUzmQe_3yfA1U6-c-K2mJi7g@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <CADgeAH_67CQZoVGEB_ddGEZA5+kUzmQe_3yfA1U6-c-K2mJi7g@mail.gmail.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 13 Nov 2023 14:35:56 +0100
Message-ID: <87a5rhpygz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
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

It seems that the original mail did not make it to some of the mailing
lists it was intended to go to, possibly due to the html part of the
original mail. Therefore, I'm trying again, this time with plain text
only. Apologies in advance for any duplicates.

On Wed, Nov 08 2023, Paul Knight <paul.knight@oasis-open.org> wrote:

> OASIS members and other interested parties,
>
> OASIS and the OASIS Virtual I/O Device (VIRTIO) TC are pleased to announce
> that Virtual I/O Device (VIRTIO) Version 1.3 is now available for public
> review and comment.
>
> Specification Overview:
>
> This document describes the specifications of the 'virtio' family of
> devices. These devices are found in virtual environments, yet by design
> they look like physical devices to the guest within the virtual machine -
> and this document treats them as such. This similarity allows the guest to
> use standard drivers and discovery mechanisms. The purpose of virtio and
> this specification is that virtual environments and guests should have a
> straightforward, efficient, standard and extensible mechanism for virtual
> devices, rather than boutique per-environment or per-OS mechanisms.
>
> The documents and related files are available here:
>
> Virtual I/O Device (VIRTIO) Version 1.3
> Committee Specification Draft 01
> 06 October 2023
>
> Editable source (Authoritative):
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/tex/
> HTML:
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html
> PDF:
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.pdf
> Example driver listing:
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/listings/
> PDF file marked to indicate changes from Version 1.2 Committee
> Specification 01:
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01-diff-from-v1.2-cs01.pdf
>
> For your convenience, OASIS provides a complete package of the
> specification document and any related files in ZIP distribution files. You
> can download the ZIP file at:
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.zip
>
> A public review metadata record documenting this and any previous public
> reviews is available at:
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01-public-review-metadata.html
>
> How to Provide Feedback
>
> OASIS and the OASIS Virtual I/O Device (VIRTIO) TC value your feedback. We
> solicit input from developers, users and others, whether OASIS members or
> not, for the sake of improving the interoperability and quality of its
> technical work.
>
> The public review starts 09 November 2023 at 00:00 UTC and ends 08 December
> 2023 at 23:59 UTC.
>
> Comments may be submitted to the TC by any person through the use of the
> OASIS TC Comment Facility which can be used by following the instructions
> on the TC's "Send A Comment" page (
> https://www.oasis-open.org/committees/comments/index.php?wg_abbrev=virtio).
>
> Comments submitted by TC non-members for this work and for other work of
> this TC are publicly archived and can be viewed at:
>
> https://lists.oasis-open.org/archives/virtio-comment/
>
> All comments submitted to OASIS are subject to the OASIS Feedback License,
> which ensures that the feedback you provide carries the same obligations at
> least as the obligations of the TC members. In connection with this public
> review, we call your attention to the OASIS IPR Policy [1] applicable
> especially [2] to the work of this technical committee. All members of the
> TC should be familiar with this document, which may create obligations
> regarding the disclosure and availability of a member's patent, copyright,
> trademark and license rights that read on an approved OASIS specification.
>
> OASIS invites any persons who know of any such claims to disclose these if
> they may be essential to the implementation of the above specification, so
> that notice of them may be posted to the notice page for this TC's work.
>
> Additional information about the specification and the VIRTIO TC can be
> found at the TC's public home page:
> https://www.oasis-open.org/committees/virtio/
>
> ========== Additional references:
>
> [1] https://www.oasis-open.org/policies-guidelines/ipr/
>
> [2] https://github.com/oasis-tcs/virtio-admin/blob/master/IPR.md
> https://www.oasis-open.org/policies-guidelines/ipr/#Non-Assertion-Mode
> Non-Assertion Mode
> -- 
> Paul Knight <paul.knight@oasis-open.org>....Document Process Analyst
> <https://www.oasis-open.org/people/staff/paul-knight>
> OASIS <https://www.oasis-open.org/>...Setting the standard for open
> collaboration


