Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA939127DF
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jun 2024 16:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfH8-0001F5-8H; Fri, 21 Jun 2024 10:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sKfH4-0001D6-NH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:29:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sKfH2-0005hV-V9
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:29:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1B4721B3C;
 Fri, 21 Jun 2024 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1718980195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVDQqMuW6UL1S4ZSHBFO1seEUCR8KNLGtUAgeSXHYhc=;
 b=W+vkcSCFPfzeB+3/hkNA2fKxfPKlzDcDPJN4AZXx+7/srX+QgdZX/mKIbaG+f2+lU17r84
 iPk7D1pDv6TtGqLbn57VbVevy/MzfJvirWKstEOJv/xZ0QOnqxxlF2qljGS1qG5fSwQif4
 s9bCyZyYzMps9CF4oVJf493OAjgjvT8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1718980195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVDQqMuW6UL1S4ZSHBFO1seEUCR8KNLGtUAgeSXHYhc=;
 b=W+vkcSCFPfzeB+3/hkNA2fKxfPKlzDcDPJN4AZXx+7/srX+QgdZX/mKIbaG+f2+lU17r84
 iPk7D1pDv6TtGqLbn57VbVevy/MzfJvirWKstEOJv/xZ0QOnqxxlF2qljGS1qG5fSwQif4
 s9bCyZyYzMps9CF4oVJf493OAjgjvT8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E77DC13ACE;
 Fri, 21 Jun 2024 14:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eNCKNmKOdWbwKQAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Fri, 21 Jun 2024 14:29:54 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v3 11/15] backends/confidential-guest-support: Add
 set_guest_policy() function
Date: Fri, 21 Jun 2024 15:29:14 +0100
Message-ID: <80cad0c4c658a439426336da29c12e900ea8eef2.1718979106.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718979106.git.roy.hopkins@suse.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 R_RATELIMIT(0.00)[to_ip_from(RLm8d31jk6dhzwhww9bgqrb1jt)];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.130;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For confidential guests a policy can be provided that defines the
security level, debug status, expected launch measurement and other
parameters that define the configuration of the confidential platform.

This commit adds a new function named set_guest_policy() that can be
implemented by each confidential platform, such as AMD SEV to set the
policy. This will allow configuration of the policy from a
multi-platform resource such as an IGVM file without the IGVM processor
requiring specific implementation details for each platform.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 include/exec/confidential-guest-support.h | 21 +++++++++++++++++++++
 backends/confidential-guest-support.c     | 12 ++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index 4834efbe38..218bab9714 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -59,6 +59,10 @@ typedef enum ConfidentialGuestPageType {
     CGS_PAGE_TYPE_REQUIRED_MEMORY,
 } ConfidentialGuestPageType;
 
+typedef enum ConfidentialGuestPolicyType {
+    GUEST_POLICY_SEV,
+} ConfidentialGuestPolicyType;
+
 struct ConfidentialGuestSupport {
     Object parent;
 
@@ -123,6 +127,23 @@ typedef struct ConfidentialGuestSupportClass {
                            ConfidentialGuestPageType memory_type,
                            uint16_t cpu_index, Error **errp);
 
+    /*
+     * Set the guest policy. The policy can be used to configure the
+     * confidential platform, such as if debug is enabled or not and can contain
+     * information about expected launch measurements, signed verification of
+     * guest configuration and other platform data.
+     *
+     * The format of the policy data is specific to each platform. For example,
+     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
+     * ID block and ID authentication in the 'policy_data' parameters. The type
+     * of policy data is identified by the 'policy_type' argument.
+     */
+    int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
+                            uint64_t policy,
+                            void *policy_data1, uint32_t policy_data1_size,
+                            void *policy_data2, uint32_t policy_data2_size,
+                            Error **errp);
+
     /*
      * Iterate the system memory map, getting the entry with the given index
      * that can be populated into guest memory.
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 68e6fd9d18..3c46b2cd6b 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -38,6 +38,17 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     return -1;
 }
 
+static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
+                            uint64_t policy,
+                            void *policy_data1, uint32_t policy_data1_size,
+                            void *policy_data2, uint32_t policy_data2_size,
+                            Error **errp)
+{
+    error_setg(errp,
+               "Setting confidential guest policy is not supported for this platform");
+    return -1;
+}
+
 static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp)
 {
@@ -52,6 +63,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
+    cgsc->set_guest_policy = set_guest_policy;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
-- 
2.43.0


