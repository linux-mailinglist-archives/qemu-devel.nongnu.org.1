Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BD74A494
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:53:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHV1O-0003xE-KU; Thu, 06 Jul 2023 15:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHV1L-0003x4-Ul
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:52:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHV1K-0005eN-Gx
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:52:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 101A022753;
 Thu,  6 Jul 2023 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688673125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iXcNz6wfOcc6Kout2lrw2XFDd3zyzx3/hKcsTkiS9ZY=;
 b=dcyHaLoH9aVIiKoxl8LiEbkRhamWOqqKU+86ipEmV2KfriPme+UwuYOYndGTsELYMdYi6E
 bAcDJK7EbtzE8eCDZYonOW3U/gZgd2VaR/GRmZ1n6J/Iv6nqULcIYowxFeJi5jtT2runUO
 3WAcIMRdhnzSggQJe6+Vd5xbnNJlag8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688673125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iXcNz6wfOcc6Kout2lrw2XFDd3zyzx3/hKcsTkiS9ZY=;
 b=0hHUVlMUVgFYY75zZ/mdHT+dmvPi+xKP3/Sc56NgQOnAc2tl4uZ9ws+QJh75TGi0SZFKVR
 3Tn6euzIjfE7+gDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24444138FC;
 Thu,  6 Jul 2023 19:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p8vGN2Mbp2STDQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 06 Jul 2023 19:52:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>
Subject: [PATCH 0/2] migration: Only pass negative values to
 qemu_file_set_error()
Date: Thu,  6 Jul 2023 16:51:59 -0300
Message-Id: <20230706195201.18595-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

qemu_file_set_error() sets f->last_error, which is later used by
functions in qemu-file.c to return the error to callers.

The following functions expect f->last_error to be -errno:

qemu_file_get_error_obj()
qemu_file_get_error()
qemu_fclose()

Make sure qemu_file_set_error() always receives a negative number and
document the assumption.

Fabiano Rosas (2):
  target/arm: Return negative value on power state migration error
  migration: Make it clear that qemu_file_set_error() needs a negative
    value

 migration/qemu-file.c | 2 ++
 migration/savevm.c    | 6 +++---
 target/arm/machine.c  | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.35.3


