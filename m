Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE2A7B239
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Apr 2025 01:11:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ThG-00008n-UW; Thu, 03 Apr 2025 19:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u0ThD-00007E-5b
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:10:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u0Th5-0003UN-Jc
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743721789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PoJmaLl9SEIUX9mXHkppvj2mmWHNNlmk5+NNU5MPTcM=;
 b=fg/7Bm+Dn6vdRmaRkbTml1xrXWUrz0OFxVv10DyBFLtpZL/y72NFbStzBPPFaOHubYPZyP
 aFvFc5RfPR16xjKOQBibJcS0CerJalSbsX3KFrQRC99SS97Hj4bz45zbGtKBItBwJRXC2K
 KDrhmkVWkm3OeRuog1jIRAVAxKAQ5SY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-eAAHzxMpOiysPTNoKw6Z0A-1; Thu,
 03 Apr 2025 19:09:46 -0400
X-MC-Unique: eAAHzxMpOiysPTNoKw6Z0A-1
X-Mimecast-MFC-AGG-ID: eAAHzxMpOiysPTNoKw6Z0A_1743721786
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E31D219560B6
 for <qemu-devel@nongnu.org>; Thu,  3 Apr 2025 23:09:45 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.8])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B979E1955BC2
 for <qemu-devel@nongnu.org>; Thu,  3 Apr 2025 23:09:44 +0000 (UTC)
Date: Thu, 3 Apr 2025 18:09:41 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL -rce 0/1] NBD patches for 2025-04-03
Message-ID: <mp4mlqlec57v2dkghoijt3rs5yzva2cx7xkgyvn565sorq4hk2@z5nb6p4pyguk>
References: <20250403222139.1317475-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403222139.1317475-3-eblake@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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

Sorry for the typo in the subject line; that should be -rc3 (and not
rce - this is not an exploit).

On Thu, Apr 03, 2025 at 05:19:26PM -0500, Eric Blake wrote:
> The following changes since commit 0adf626718bc0ca9c46550249a76047f8e45da15:
> 
>   Update version for v10.0.0-rc2 release (2025-04-01 13:15:45 -0400)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


