Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E5A7E33F
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Apr 2025 17:08:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1o3d-0007WA-B2; Mon, 07 Apr 2025 11:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u1o3b-0007VZ-4B
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u1o3Z-0004dZ-Gj
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744038393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2fbpwrSV7GanYGCqwNOmtKKV6Z5ZyqN7PeQfAq2fKAs=;
 b=if/QuLON6gqRynuZoEbtiCCYkMKeBP2xUdB7XJUX09+neDCb5z5oNZx3xvdbt2qFaIly6C
 Zlf80SAfUKkNvBXRi7OtjtF4PZ9DC8r+RM8KoM9QvyUtgw0k6gjbqA0Ng5hpd/Q4kmOu4Q
 +29fWiutslQmtyLa0XKV00eCYpDdnWI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-7oJackLgM6-7D5wm9jskaw-1; Mon,
 07 Apr 2025 11:06:29 -0400
X-MC-Unique: 7oJackLgM6-7D5wm9jskaw-1
X-Mimecast-MFC-AGG-ID: 7oJackLgM6-7D5wm9jskaw_1744038388
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE2C7180899B; Mon,  7 Apr 2025 15:06:26 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCA4319560AD; Mon,  7 Apr 2025 15:06:23 +0000 (UTC)
Date: Mon, 7 Apr 2025 10:06:21 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com, 
 kwolf@redhat.com, jsnow@redhat.com, peter.maydell@linaro.org, jiri@resnulli.us,
 qemu-block@nongnu.org
Subject: Re: [PATCH 02/11] qapi/rocker: Tidy up query-rocker-of-dpa-flows
 example
Message-ID: <kbaql55o6yefqrftuypdmeiblwl6mrxat5xih22u6i35emnaf3@5umk7xkgcfcy>
References: <20250404121413.1743790-1-armbru@redhat.com>
 <20250404121413.1743790-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404121413.1743790-3-armbru@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
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

On Fri, Apr 04, 2025 at 02:14:04PM +0200, Markus Armbruster wrote:
> The command can return any number of RockerOfDpaFlow objects.  The
> example shows it returning exactly two, with the second objecy's

object's

> members elided.  Tweak it so it elides elements after the first
> instead.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


