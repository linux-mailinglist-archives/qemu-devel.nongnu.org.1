Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60208831FD6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 20:43:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYI9-0003QU-Ay; Thu, 18 Jan 2024 14:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQYI7-0003Pf-Tq
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 14:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQYI6-0006mC-6m
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 14:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705606985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=47YdBDP206CCVBUm6+ZPoSssdaOt4fSmPcHqiL1ffws=;
 b=Zvr7RGnAWJ/Z80BlyluJ5H7vBjaoYeX1xL3dsEoaxvTJUeY33jehtVpgyb1I9ZrmZUtvZW
 rXT+potre6gOvr6ew6JsTULrryKWD5/w63RM5dSlPQxJXbGkpjf7vhiP1Xfb6e9iIuf6iU
 l/DxAdtoblFwXedHFt/7t0eSv77Vq88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Jst8IB5YPd-0tI3ahRvTUA-1; Thu, 18 Jan 2024 14:43:03 -0500
X-MC-Unique: Jst8IB5YPd-0tI3ahRvTUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 399E38493E9;
 Thu, 18 Jan 2024 19:43:03 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A9821121306;
 Thu, 18 Jan 2024 19:43:02 +0000 (UTC)
Date: Thu, 18 Jan 2024 20:43:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Abhiram Tilak <atp.exp@gmail.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com
Subject: Re: [PATCH v3] qemu-img: Fix Column Width and Improve Formatting in
 snapshot list
Message-ID: <Zal_RMi4wmLGj6k9@redhat.com>
References: <20240111172546.823263-1-atp.exp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111172546.823263-1-atp.exp@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Am 11.01.2024 um 18:25 hat Abhiram Tilak geschrieben:
> When running the command `qemu-img snapshot -l SNAPSHOT` the output of
> VM_CLOCK (measures the offset between host and VM clock) cannot to
> accommodate values in the order of thousands (4-digit).
> 
> This line [1] hints on the problem. Additionally, the column width for
> the VM_CLOCK field was reduced from 15 to 13 spaces in commit b39847a5
> in line [2], resulting in a shortage of space.
> 
> [1]: https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L753
> [2]: https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L763
> 
> This patch restores the column width to 15 spaces and makes adjustments
> to the affected iotests accordingly. Furthermore, addresses a potential source
> of confusion by removing whitespace in column headers. Example, VM CLOCK
> is modified to VM_CLOCK. Additionally a '--' symbol is introduced when
> ICOUNT returns no output for clarity.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2062
> Fixes: b39847a50553 (migration: introduce icount field for snapshots )
> Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>

We can tweak the format a bit, but then we need to save those two
characters somewhere else so that the output still fits in 80
characters. We can probably reduce the size of the ID column.

Maybe what we should also do is decreasing the width of each field by
one and instead writing a space character into the format string. So if
we ever use up the space for one of the fields again, we would lose the
nice column alignment, but you could still recognise the individual
fields.

Kevin


