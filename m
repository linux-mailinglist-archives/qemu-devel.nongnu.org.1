Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7353B8B2851
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Apr 2024 20:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s046Z-0001kG-Nv; Thu, 25 Apr 2024 14:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s046I-0001ZO-Vh
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0451-00064T-1X
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714070662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IZNhzlqbb96aONn9HHf0eCw92yR8iUfdxYqmjwWG/dY=;
 b=fAz6bkBoqA2PiMh3EquYSYMimdtREzkwwri4nhWmrMjG3747W07Ri6q/BKGWPjcpuKsuco
 ooI+rnxwuZFFMCnx/NEyJbn2V0ERj9XWO7FP+SVt5+zbP52d3gSBHFcCstOkHO9ynt60Nd
 nA8gbHk12oJwmg6ocr4gbQ0e06+KRTk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-8zcUk8eoO6CSNSqhvufM0Q-1; Thu,
 25 Apr 2024 14:43:18 -0400
X-MC-Unique: 8zcUk8eoO6CSNSqhvufM0Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77794299E75B;
 Thu, 25 Apr 2024 18:43:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B1675AD060;
 Thu, 25 Apr 2024 18:43:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Subject: [PATCH 0/3] Make it possible to compile the x86 binaries without FDC
Date: Thu, 25 Apr 2024 20:43:12 +0200
Message-ID: <20240425184315.553329-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

For downstream versions of QEMU, we'd like to be able to compile QEMU
without the FDC code included (since it's not required for modern VMs
anymore and the FDC code has rather a bad reputation, see the VENOM CVE).

The q35 machine can already be instantiated without FDC, but for being
able to link a binary without the FDC code, the Kconfig file needs some
tweaks and there are two spots in the pc code that directly call functions
from the FDC code - those need to be disabled via #ifdefs.

The third patch changes the i440fx and isapc machine types so that
they can work without the FDC device, too, in case it has not been
compiled into the binary. It's marked as RFC since I assume that the
FDC was originally a fix compononent of these motherboards, so I'm
unsure whether we should allow the disablement there. OTOH, it seems
to work fine, and the FDC is only disabled when it is not available
in the binary, so I hope this patch is fine, too.

Thomas Huth (3):
  hw/i386/pc: Allow to compile without CONFIG_FDC_ISA
  hw/i386/Kconfig: Allow to compile Q35 without FDC_ISA
  hw/i386: Add the possibility to use i440fx and isapc without FDC

 hw/i386/pc.c      | 13 +++++++++----
 hw/i386/pc_piix.c |  6 ++++--
 hw/i386/Kconfig   |  2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.44.0


