Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 431267C7037
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:23:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwZo-0002zh-95; Thu, 12 Oct 2023 10:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwZe-0002yi-Th
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:22:04 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwZd-0002ng-B7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:22:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD70421884;
 Thu, 12 Oct 2023 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697120518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bbOoHAlvHndGzTdtlZvU8RCPNyvZnebuGQsDEQ99ew0=;
 b=Lrfx6gWD966rgOLa0ExtMu5ZE3f0KM1VCTb+w6LrWfA3k/OH1vi2I/23Qcc6ceMs9+n4BO
 a/W2dH02hQa2qgzzmdql0XZ0B+td2+3Hc6GxWoGMqGlmF3mLBPCbIELewFLzTF5SWc28V5
 UEzLzkvdhOThhwLGoPMgGLlHS7QrtY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697120518;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bbOoHAlvHndGzTdtlZvU8RCPNyvZnebuGQsDEQ99ew0=;
 b=uUdpgyrAKRepTZAQyjsinlHmomuqJvLZHK7DJFxYWzJ6aszCJZYDKXS6xkQXSCRZqFtvg9
 OzEVaziAfZms/SAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FF96139ED;
 Thu, 12 Oct 2023 14:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vANsAwYBKGUzEgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 14:21:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 02/13] migration/rdma: Unfold
 ram_control_before_iterate()
In-Reply-To: <20231011203527.9061-3-quintela@redhat.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-3-quintela@redhat.com>
Date: Thu, 12 Oct 2023 11:21:55 -0300
Message-ID: <877cnr2a64.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -6.99
X-Spamd-Result: default: False [-6.99 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.89)[99.52%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

Juan Quintela <quintela@redhat.com> writes:

> Once there:
> - Remove unused data parameter
> - unfold it in its callers.
> - change all callers to call qemu_rdma_registration_start()
> - We need to call QIO_CHANNEL_RDMA() after we check for migrate_rdma()
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> --
>
> initilazize rioc after checknig that rdma is enabled.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

