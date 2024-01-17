Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA43830AB3
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:14:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8Xc-0002lM-Nd; Wed, 17 Jan 2024 11:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQ8XY-0002kq-S6
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:13:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQ8XW-0001JL-Qf
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705507996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JeLOkv7skOUjYVfajSS35W2Bfx8i3J9+PlAH4TDx+MQ=;
 b=Qsi5Z/VTquXcREqGzzR9nmdMeO5lEy7s4Uf21KP6fbd3cVtl7OyQLdUZXSJyRTnAz7D2SL
 KnYcnQXKDHq/DXb1l8E0Bqkk2cu9K5uZomk5GtvGaaC+0BQJyv0hK6zfl79zAaB2pt2Too
 WgvWKzRWYJpFR+o4n44q8oeSWgRw318=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-TD96iiaLOf-5GSSqbfkxAg-1; Wed, 17 Jan 2024 11:13:12 -0500
X-MC-Unique: TD96iiaLOf-5GSSqbfkxAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC0E0102B626;
 Wed, 17 Jan 2024 16:13:06 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B861C066AC;
 Wed, 17 Jan 2024 16:13:05 +0000 (UTC)
Date: Wed, 17 Jan 2024 17:13:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/3] iotests: port 141 to Python for reliable QMP testing
Message-ID: <Zaf8kOIJCBsS6Udy@redhat.com>
References: <20240116190042.1363717-1-stefanha@redhat.com>
 <20240116190042.1363717-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116190042.1363717-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 16.01.2024 um 20:00 hat Stefan Hajnoczi geschrieben:
> The common.qemu bash functions allow tests to interact with the QMP
> monitor of a QEMU process. I spent two days trying to update 141 when
> the order of the test output changed, but found it would still fail
> occassionally because printf() and QMP events race with synchronous QMP
> communication.
> 
> I gave up and ported 141 to the existing Python API for QMP tests. The
> Python API is less affected by the order in which QEMU prints output
> because it does not print all QMP traffic by default.
> 
> The next commit changes the order in which QMP messages are received.
> Make 141 reliable first.
> 
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
> index 63203d9944..986f9f7598 100644
> --- a/tests/qemu-iotests/141.out
> +++ b/tests/qemu-iotests/141.out
> @@ -1,179 +1,69 @@
> -QA output created by 141
> -Formatting 'TEST_DIR/b.IMGFMT', fmt=IMGFMT size=1048576
> -Formatting 'TEST_DIR/m.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/b.IMGFMT backing_fmt=IMGFMT
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/m.IMGFMT backing_fmt=IMGFMT
> -{'execute': 'qmp_capabilities'}
> -{"return": {}}
> -
> +Creating bottom <- middle <- top backing file chain...
> +Starting VM...
>  === Testing drive-backup ===
> -
> -{'execute': 'blockdev-add',
> -          'arguments': {
> -              'node-name': 'drv0',
> -              'driver': 'IMGFMT',
> -              'file': {
> -                  'driver': 'file',
> -                  'filename': 'TEST_DIR/t.IMGFMT'
> -              }}}
> +{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-top"}, "node-name": "drv0"}}

This and other lines in the test output need image format filtering. You
have a literal "qcow2" in there, but the test case also runs (and fails
because of this) for qed.

Apart from this, the patch looks good to me.

Kevin


