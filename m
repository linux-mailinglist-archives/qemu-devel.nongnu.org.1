Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC3AAE5AE
	for <lists+qemu-devel@lfdr.de>; Wed,  7 May 2025 17:59:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uChAU-0004mu-Sk; Wed, 07 May 2025 11:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uChAS-0004mW-NJ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:58:44 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uChAQ-0003Hn-Ur
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:58:44 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C9A9211C6;
 Wed,  7 May 2025 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746633519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yD+1WuEozqBURcWyzAB0aKwnMWfR5gjTvYfAjfbit8U=;
 b=mOmo8V0mvpJn9nTjCnNx688rCr7OmR4VwjZsiIbXKaAUzPa4K74DYnFhNpRHPKmwqnuk5C
 icck2XaGLZgOFPG8HBDkYM1ZIrXHNcVyItrkyOdI6hFc9kjtKwDdTfzVaagTlLMBfvh2jW
 5lyrJs6fHjUZilU+pxdzPYfxtm+jzZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746633519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yD+1WuEozqBURcWyzAB0aKwnMWfR5gjTvYfAjfbit8U=;
 b=XZFPk+wdgMOngm2sIjdDq1BAXgHnRlvUjEjUld/kWhv2TFmRXe+LO/IONt98+MN25aLzPS
 qD1wX179KXlEk0Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746633519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yD+1WuEozqBURcWyzAB0aKwnMWfR5gjTvYfAjfbit8U=;
 b=mOmo8V0mvpJn9nTjCnNx688rCr7OmR4VwjZsiIbXKaAUzPa4K74DYnFhNpRHPKmwqnuk5C
 icck2XaGLZgOFPG8HBDkYM1ZIrXHNcVyItrkyOdI6hFc9kjtKwDdTfzVaagTlLMBfvh2jW
 5lyrJs6fHjUZilU+pxdzPYfxtm+jzZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746633519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yD+1WuEozqBURcWyzAB0aKwnMWfR5gjTvYfAjfbit8U=;
 b=XZFPk+wdgMOngm2sIjdDq1BAXgHnRlvUjEjUld/kWhv2TFmRXe+LO/IONt98+MN25aLzPS
 qD1wX179KXlEk0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64875139D9;
 Wed,  7 May 2025 15:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dD06CC6DG2gncQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 07 May 2025 15:58:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/3] migration, ci: Tweaks to migration-compat jobs
Date: Wed,  7 May 2025 12:58:32 -0300
Message-Id: <20250507155835.31074-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

A couple of cleanups to the migration jobs, plus a fix for an issue
that may happen during the QEMU release.

Fabiano Rosas (3):
  ci: Re-enable python subtests in qtest migration suite
  ci: Fix build-previous-qemu when the version tag is absent
  ci: Reduce the size of artifacts for build-previous-qemu

 .gitlab-ci.d/buildtest.yml | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

-- 
2.35.3


