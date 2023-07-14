Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A66753B4E
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIDy-0006qD-GQ; Fri, 14 Jul 2023 08:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qKIDw-0006pH-KG
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:48:40 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qKIDu-0008PN-MK
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:48:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 631C922121;
 Fri, 14 Jul 2023 12:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689338916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIMkPSnfA1BzIh8APOT/J+sbhvROkWkc0e13KiDgNyk=;
 b=DDSLCV8btRFza9PsSOihcz2Wja+EKZrzP8To9odqVygIg0DOfbh14S5jeK74xHkDAoOPKa
 03c1omQF1EaH1nIg40xkBk2OLPHtK/D7OKLRP2UGUwCnBbXlFkjAO5a4pBV85j2diwkyVw
 eR1540ii/mGDo5a+bXvWyAxEBeX9+80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689338916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIMkPSnfA1BzIh8APOT/J+sbhvROkWkc0e13KiDgNyk=;
 b=P6vcsSXWOQHa1TOYFp1DBOhBvlOZ6atjsN7R01O95aMy5+jNV+rk3WflOJtHTPvu6j1zcI
 lO4vGnX3tlLY1eBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E733513A15;
 Fri, 14 Jul 2023 12:48:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zK3WKyNEsWSbXQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 14 Jul 2023 12:48:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 03/10] migration: add runstate function
In-Reply-To: <1688132988-314397-4-git-send-email-steven.sistare@oracle.com>
References: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
 <1688132988-314397-4-git-send-email-steven.sistare@oracle.com>
Date: Fri, 14 Jul 2023 09:48:33 -0300
Message-ID: <87y1jiirq6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Create a subroutine for preserving the runstate after migration,
> to be used in a subsequent patch.  No functional change.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

