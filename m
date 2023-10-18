Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C30167CDA56
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4jL-0003jX-Kr; Wed, 18 Oct 2023 07:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt4jD-0003eT-Dc
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt4jB-0005cq-Gb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697628521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i2D2jZX3xzsm+mIYwcT+Bj6LW/d3j1ho52V8Cq4E4kw=;
 b=ZUwID3aQNpBfpKlbMl6QUg7M3W0Xwu0mH05PeVmTvUXt/bnP/gvjKG2fCUM75AxEe2Z0tp
 F7WG97LDCu/Wq/VCDhA224l2+H4XQU+WJmgjLhpj9VwvOqOsVDQLUM1OYuioMY6fV1C2aT
 zKLBjMUVmdRu79O/+5iZslSig42HPAc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-XJRZ_b3nO26d3ChjS6nCPQ-1; Wed, 18 Oct 2023 07:28:29 -0400
X-MC-Unique: XJRZ_b3nO26d3ChjS6nCPQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC0F83823324;
 Wed, 18 Oct 2023 11:28:28 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0682B492BEE;
 Wed, 18 Oct 2023 11:28:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 0/4] Migration documentation
Date: Wed, 18 Oct 2023 13:28:23 +0200
Message-ID: <20231018112827.1325-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

on this v4:
- Add ..contents
- Address all comments
- Create a new Backwards Compatibility section at the end of the file for this.

Please review.

Thanks, Juan.

Continuing on my saga to not have a pointer about how migration
works/should work, this are the doc for the long mails that I had to do last week:

1 - Document how backwards compatibility is supposed to work (that is
    what it was on v1 and v2)

2 - Document how to handle features that depend of things outside of qemu
    a.k.a. we make this a libvirt/management app problem.

3 - Document how we are supposed to fix backwards compatibility
    brokenness.

You can see that I was able to find commits on tree to illustrate 1
and 3.  The problem for 2 appeared from a discussion with Avihai about
future vfio devices.  Do anyone have a good idea about a commit
already on tree to document it?

Please review.

Later, Juan.

Juan Quintela (4):
  migration/doc: Add contents
  migration/doc: Add documentation for backwards compatiblity
  migration/doc: How to migrate when hosts have different features
  migration/doc: We broke backwards compatibility

 docs/devel/migration.rst | 520 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 520 insertions(+)

-- 
2.41.0


