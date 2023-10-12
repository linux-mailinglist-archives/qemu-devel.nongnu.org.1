Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC3F7C700C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwLh-0008RM-44; Thu, 12 Oct 2023 10:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwL9-0008KN-0d
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:05 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwL5-0008E6-4o
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0B0E42185E;
 Thu, 12 Oct 2023 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697119615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/QLUtBixYeqKDechwDPGlRWccDUfVrWYa1zkzmf4mHU=;
 b=TRqpTMqynumHf3GJuarThz0bnaZczXG7N89x3I2JWbBIGQEPG0De76w4NkZ4lyDRaLlG5a
 vAVff1t6NkrA50k7FFaxUUcvrX9sgT8j+n3y1S4uTu236hSVl8TkHFIy0taz3yDg6xxfCP
 AhjK8CoDCwbFLjekH0+uAeaiFoTul3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697119615;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/QLUtBixYeqKDechwDPGlRWccDUfVrWYa1zkzmf4mHU=;
 b=jZyf+gFNYJMU6rYVF/HXkaC0pDUpHwxOLozJCDBqsTK6uW6K2j3axaSXgwYi3WQrKvQjgz
 2qn13ZOqN08ejwCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85742139ED;
 Thu, 12 Oct 2023 14:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jGfkE339J2U5CgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 14:06:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH v2 0/6] migration/multifd: Locking changes
Date: Thu, 12 Oct 2023 11:06:45 -0300
Message-Id: <20231012140651.13122-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[31.47%]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

was:
migration/multifd: SYNC packet changes
https://lore.kernel.org/r/20230922145319.27380-1-farosas@suse.de

Here are the patches I mentioned in our discussion in the other
thread. The main purpose of this series is to be a PoC on how we can
move some stuff around and avoid taking the channel params lock.

I'm also trying to show that sem_sync on the sending side could be
made a bit more useful by using it to inform completion of any batch
of packets, rather than only completion of the SYNC packet.

I understand this is a disruptive series, so let's take it slow.

Thanks!

Fabiano Rosas (6):
  migration/multifd: Remove channels_ready semaphore
  migration/multifd: Stop checking p->quit in multifd_send_thread
  migration/multifd: Decouple control flow from the SYNC packet
  migration/multifd: Extract sem_done waiting into a function
  migration/multifd: Stop setting 'quit' outside of channels
  migration/multifd: Bring back the 'ready' semaphore

 migration/multifd.c    | 127 ++++++++++++++++++++---------------------
 migration/multifd.h    |   9 ++-
 migration/trace-events |   2 +-
 3 files changed, 68 insertions(+), 70 deletions(-)

-- 
2.35.3


