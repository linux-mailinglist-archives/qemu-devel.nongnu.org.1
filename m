Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FF081CE3D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:01:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGjod-0001ua-7R; Fri, 22 Dec 2023 13:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjoZ-0001ts-AL
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjoW-00040Q-Qy
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703267998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QpFHigcIPQ9FyG9l1MiUupODPjX4ITJjwAmklDIkkU0=;
 b=Ug8wHlkf2rW++yCdxApJAJeJ2iJJKrbwVqTQmtJXM5AT24IErOL+DMJ12NXdIpdBN9r0S6
 5PhSX+3GkacNR8mmQCu+lE12/n675d5C8X6XpzLRoVMT3X1rC4lsAeMDGay4azK5hdrRMS
 7J+5XnzEVLGyeo/3Krix4WuGSadERK0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-gSdBMcszNDWV5LyL-Z7WGg-1; Fri, 22 Dec 2023 12:59:57 -0500
X-MC-Unique: gSdBMcszNDWV5LyL-Z7WGg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d2fa6b23eso17652805e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 09:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703267995; x=1703872795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpFHigcIPQ9FyG9l1MiUupODPjX4ITJjwAmklDIkkU0=;
 b=w/EaHWNSR1Bw7sHzrEkGdMoeOckoBxG9TsnvTWVjPzfACk3HrjoQaxN5xb+ESDiE0u
 gXe5v37lZYHv8zCru4DRr4wbuj+unBqqdErS+Wym1DnsVIjjdLEkGkKa2oeszoFfDNdT
 U+KtjwBUm6zQd0W+PRl6KIxvdzbHghtiq4JEFooJjcmVCRpXML3RWoupGCZC9hEt4ron
 GrnMJiUIczb+1H1Fnh+LAbO2pnOdkMelhUppHl5pQKvxd+fdmjAzh9dk+mPrQwJ2E7IY
 ts4OYpjMcUbIbX9jttxgEApigP0QxNWE1BVpT23N0pU8K389c1U9ZjkMlSQ6+gNykwxG
 xBpw==
X-Gm-Message-State: AOJu0YzeTj8N/Iau6ySQNoMXDiG0uMjbYRfZQwWcaU5XJQXaRLnci1bH
 j63iHdXT3ntvwFtcRbWX7TC7o9lzX1s5HRZSMnmPh2cPWkfK6Xd7gujVsAGCGXJUNqyQALAgOIV
 zJ0eWkiMEqnT+6tr7URImLegBdGn4kBEcyjF5NWyCI5NchfPxx8ta93JJ4e+jgzNrUDwo8gfem5
 JPTBq2KQk=
X-Received: by 2002:a1c:6a07:0:b0:40c:26a3:d778 with SMTP id
 f7-20020a1c6a07000000b0040c26a3d778mr573069wmc.208.1703267995632; 
 Fri, 22 Dec 2023 09:59:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEruxpHOLSRbXBm+vlKcyobSVD0y/aGXx2z6S9RB4gG8VLUd+GvOT9R3t89sDTOQmzv/T9X6g==
X-Received: by 2002:a1c:6a07:0:b0:40c:26a3:d778 with SMTP id
 f7-20020a1c6a07000000b0040c26a3d778mr573063wmc.208.1703267995139; 
 Fri, 22 Dec 2023 09:59:55 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 w18-20020adfee52000000b0033657376b62sm4822613wro.105.2023.12.22.09.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 09:59:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org
Subject: [PATCH 0/5] target/i386: Fix physical address masking bugs
Date: Fri, 22 Dec 2023 18:59:46 +0100
Message-ID: <20231222175951.172669-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The address translation logic in get_physical_address() will currently
truncate physical addresses to 32 bits unless long mode is enabled.
This is incorrect when using physical address extensions (PAE) outside
of long mode, with the result that a 32-bit operating system using PAE
to access memory above 4G will experience undefined behaviour.
Instead, truncation must be applied only to non-paging mode, because
all paths that go through page table accesses already produce a
correctly-masked address.

Furthermore, when inspecting the code I noticed that the A20 mask is
applied incorrectly when NPT is active.  The mask should not be applied
to the addresses that are looked up in the NPT, only to the physical
addresses.  Obviously no hypervisor is going to leave A20 masking on,
but the code actually becomes simpler so let's do it.

Patches 1 and 2 fix cases in which the addresses must be masked,
or overflow is otherwise invalid, for MMU_PHYS_IDX accesses.

Patch 3 fixes the bug, by limiting the masking to the case of CR0.PG=0.

Patches 4 and 5 further clean up the MMU functions to centralize
application of the A20 mask and fix bugs in the process.

Untested except for running the SVM tests from kvm-unit-tests
(which is better than nothing, still).

Supersedes: <0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com>

Paolo Bonzini (5):
  target/i386: mask high bits of CR3 in 32-bit mode
  target/i386: check validity of VMCB addresses
  target/i386: Fix physical address truncation
  target/i386: remove unnecessary/wrong application of the A20 mask
  target/i386: leave the A20 bit set in the final NPT walk

 target/i386/tcg/sysemu/excp_helper.c | 44 ++++++++++++----------------
 target/i386/tcg/sysemu/misc_helper.c |  3 ++
 target/i386/tcg/sysemu/svm_helper.c  | 27 +++++++++++++----
 3 files changed, 43 insertions(+), 31 deletions(-)

-- 
2.43.0


