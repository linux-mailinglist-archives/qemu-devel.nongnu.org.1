Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E80388A7A1
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Mar 2024 16:51:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romap-0006jm-99; Mon, 25 Mar 2024 11:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1romal-0006jP-US
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1romak-0003xz-Dl
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711381829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qIkcHuoRgkRTQhV8FxRZ4XjAMpsTZC9+UBQwHoz1qKc=;
 b=QAOi6Jask0aMp6DO0zYAnfeposxd9/N0IA4jg4lDWY6fS4p5DOxDYRRctlOU7UYyyfMEG5
 pxFsPb2ssEeT2FlO7vBKpNJlT9MCBLkULmRpmb3LXsWzkrO2d5K63wXpoCKoDgpqO8fZ+C
 gFwrcJZo+Hd2KNoqXe0qi8hko5ozkOY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-840LDykoPaijcp3ViABptQ-1; Mon, 25 Mar 2024 11:50:26 -0400
X-MC-Unique: 840LDykoPaijcp3ViABptQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51FF8800262
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 15:50:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32C4410189
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 15:50:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 494B421E669D; Mon, 25 Mar 2024 16:50:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi: document leftover members in qapi/stats.json
In-Reply-To: <20240325104504.1358734-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 25 Mar 2024 11:45:04 +0100")
References: <20240325104504.1358734-1-pbonzini@redhat.com>
Date: Mon, 25 Mar 2024 16:50:21 +0100
Message-ID: <87ttkuz4xu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

Squashing in

diff --git a/qapi/pragma.json b/qapi/pragma.json
index 1a302981c1..99e4052ab3 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -75,8 +75,6 @@
         'Qcow2OverlapCheckFlags',
         'RbdAuthMode',
         'RbdImageEncryptionFormat',
-        'StatsFilter',
-        'StatsValue',
         'String',
         'StringWrapper',
         'SysEmuTarget',
@@ -91,8 +89,7 @@
         'query-cpu-model-comparison',
         'query-cpu-model-expansion',
         'query-rocker',
-        'query-rocker-ports',
-        'query-stats-schemas' ],
+        'query-rocker-ports' ],
     # Externally visible types whose member names may use uppercase
     'member-name-exceptions': [     # visible in:
         'ACPISlotType',             # query-acpi-ospm-status


