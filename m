Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 590FA88A521
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Mar 2024 15:48:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolbu-0005tO-Lz; Mon, 25 Mar 2024 10:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rolbt-0005t7-3V
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rolbq-0002fO-Ox
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711378052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WM1+IU0xNyrYhER5wVdwgTjr8eQSLSe1Sd7ZFSpQIc4=;
 b=Rqr6BFSSEgEbOt2f1vs7qHox/kqQRp4ZLavqPrV397yPJO/1kLApPwfcb31MsJIMC4sIYN
 0d3GaHWzMqdKIM+4k7VHnYm4xUHEgFUhYwHReOq7Vm/MtorlSMJ2hyJyYIYl+0zRKuwzjQ
 vEl8xcKLOCMIElny9OI3f1X0Sk4uoFA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-BdP2kmpgNAa2m7Afp3y_wA-1; Mon,
 25 Mar 2024 10:47:31 -0400
X-MC-Unique: BdP2kmpgNAa2m7Afp3y_wA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C79C11C004E8;
 Mon, 25 Mar 2024 14:47:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67EB8492BC4;
 Mon, 25 Mar 2024 14:47:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2BB961801497; Mon, 25 Mar 2024 15:47:25 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v5 0/2] kvm: add support for guest physical bits
Date: Mon, 25 Mar 2024 15:47:22 +0100
Message-ID: <20240325144725.1089192-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

The matching kernel bits are here:
https://lore.kernel.org/kvm/20240313125844.912415-1-kraxel@redhat.com/T/

ovmf test patches are here:
https://github.com/kraxel/edk2/commits/devel/guest-phys-bits/

Gerd Hoffmann (2):
  kvm: add support for guest physical bits
  target/i386: add guest-phys-bits cpu property

 target/i386/cpu.h         |  1 +
 target/i386/cpu.c         | 14 ++++++++++++++
 target/i386/kvm/kvm-cpu.c | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.44.0


