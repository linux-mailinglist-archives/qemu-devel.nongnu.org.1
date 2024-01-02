Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C346E822331
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 22:19:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKm8z-0008OM-DC; Tue, 02 Jan 2024 16:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1rKm8y-0008OB-77
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 16:17:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1rKm8w-0001Re-M0
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 16:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704230264;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=2f4Fnx4JCzIgSy72s/r6tZ/ftQoNaJQn6CoK3lfo4Tc=;
 b=Uhu4fmrMgxkZOMEyOBSV5utY/bdtG82/khOCNUvVnJld5cktJmHfMuIaoUGllBE19SxG+y
 i6xD6+Zq6VeuuDK4RZBEup/FxO9aGSxjJ4zTJVPLQRfoWw2q44BNf9va4Fx3EzuLMWbTSh
 Jou+IY0drq4b4LNHFxG5e763BHXxT5Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-UF_jsrZTMbOlHTUZ0PKMog-1; Tue,
 02 Jan 2024 16:17:42 -0500
X-MC-Unique: UF_jsrZTMbOlHTUZ0PKMog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32E9429AC020
 for <qemu-devel@nongnu.org>; Tue,  2 Jan 2024 21:17:42 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F08771121306;
 Tue,  2 Jan 2024 21:17:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: QEMU developers call
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 02 Jan 2024 22:17:40 +0100
Message-ID: <87mstno2ob.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


Uv

Nf V nz yrnivat DRZH qrirybczrag, V pna'g unaqyr guvf pnyy.  Fubhyq
nalbar gnxr pner bs vg?

V unir gnyxrq nobhg guvf jvgu Crgre, naq V guvax gung vs abobql fgrcf
hc, ur pna "ibyhagrre" gb unaqyr vg.

Yngre, Whna.


