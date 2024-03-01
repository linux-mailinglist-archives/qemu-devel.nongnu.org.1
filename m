Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C5586DF1F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Mar 2024 11:18:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfzxD-0007I1-Cy; Fri, 01 Mar 2024 05:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rfzxA-0007Cj-JI
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rfzx9-000596-6H
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709288237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4J6rEqJBkCC60PIxRAp1B56NSk+P6kQFPzL/uAnbbpk=;
 b=UMpXpmKazB/DfuMqHaMDqPt+tZ50A/GSdA7Xd8E8Tv4JxJTwulnlVf6/T670SpqCEBMTy0
 P2Og0JuRLn+dhHsErifC90o9E60epcvUOdZ/4fpKIgNAHdbsnResHyMDTK//4DBoN4B7zW
 tzdaX2U5bZMolVT6YQE3mWUA8Jv6/N8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-EH-v6C7EOWKSe5ArRQepjQ-1; Fri,
 01 Mar 2024 05:17:15 -0500
X-MC-Unique: EH-v6C7EOWKSe5ArRQepjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D7A728EC110;
 Fri,  1 Mar 2024 10:17:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2C252166B31;
 Fri,  1 Mar 2024 10:17:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EA21E1800DFF; Fri,  1 Mar 2024 11:17:13 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/1] kvm: add support for guest physical bits
Date: Fri,  1 Mar 2024 11:17:12 +0100
Message-ID: <20240301101713.356759-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

The matching kernel bits are here:
https://lore.kernel.org/kvm/20240301101410.356007-1-kraxel@redhat.com/T/

Gerd Hoffmann (1):
  kvm: add support for guest physical bits

 target/i386/cpu.h     | 1 +
 target/i386/cpu.c     | 1 +
 target/i386/kvm/kvm.c | 8 ++++++++
 3 files changed, 10 insertions(+)

-- 
2.44.0


