Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 148FE741C1F
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 01:03:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEeAL-0004gs-KM; Wed, 28 Jun 2023 19:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qEeAC-0004ZA-Uy
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 19:01:28 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qEeAB-0003Oz-FY
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 19:01:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8AB0921850;
 Wed, 28 Jun 2023 23:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687993285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPdkMKeN2YGLnNGZaB1gHBHX3KJgyXD+o7htRGCqlBQ=;
 b=ztzoF1f4MaIfOmP05yxuoqNtnuP1Enau+dgTF93kQjW0dJv+IRh3O3GJW8Nyr6hLub+Sc2
 lCBEiYEmeBFd/jgXJD/9LesDjsxUsaFs33YHaKgOpIoMQYSzfXhUmpI3akPvseHo5Ljcm2
 ucWN7WKdoLzEAwnOf9498ZvL2T4o4F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687993285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPdkMKeN2YGLnNGZaB1gHBHX3KJgyXD+o7htRGCqlBQ=;
 b=9SCWpX8QjzPifhIkQV+lDPE4J07RRTndQ4MUZqGvbdR4nEskP5PolfuFjI5FMwBLYP/isu
 wla2FlX4sSJ+bOBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17F43138E8;
 Wed, 28 Jun 2023 23:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hmAFNcS7nGSBeQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 28 Jun 2023 23:01:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 5/7] migration: Display error in query-migrate
 irrelevant of status
In-Reply-To: <20230628215002.73546-6-peterx@redhat.com>
References: <20230628215002.73546-1-peterx@redhat.com>
 <20230628215002.73546-6-peterx@redhat.com>
Date: Wed, 28 Jun 2023 20:01:22 -0300
Message-ID: <87y1k3p4xp.fsf@suse.de>
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

Peter Xu <peterx@redhat.com> writes:

> Display it as long as being set, irrelevant of FAILED status.  E.g., it may
> also be applicable to PAUSED stage of postcopy, to provide hint on what has
> gone wrong.

This might have made the documentation slightly inaccurate:

# @error-desc: the human readable error description string, when
#     @status is 'failed'. Clients should not attempt to parse the
#     error strings.  (Since 2.7)

But it's not wrong, so:

Reviewed-by: Fabiano Rosas <farosas@suse.de>


