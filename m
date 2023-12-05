Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 887B1805E80
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 20:21:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAaxh-0006nb-Tq; Tue, 05 Dec 2023 14:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rAaxf-0006nS-Os
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 14:20:03 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rAaxe-0002oC-3h
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 14:20:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 994F91FBAE;
 Tue,  5 Dec 2023 19:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701803998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fi2/VjN21n4BsNaj75yo+zB/HIguYCKJmEDTrayWC2Y=;
 b=JAW/EI44lbHhmBJJVs3M19rBakWTQeHooflZjfTPT8tnvqmveRZLpTvJaDNuMZI6NEaOaM
 VJpR+XfJVP5G3ta/QRen1CmmiJYVs7eJtGHe9/Hzs3S2+6mAM0FpIPsyRYLcba8jFUveZz
 Mwsxp+IH6/fPJnIBMfxrMAjkLm5ZxF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701803998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fi2/VjN21n4BsNaj75yo+zB/HIguYCKJmEDTrayWC2Y=;
 b=/ndT/LEmOe9A88EXBw1OXgMQQjAPSBj4xR03NmFBqrVskYmL39g9Z3KkOOadUnDfOuee9K
 KTu0gw5zSYFL+tBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B01E136CF;
 Tue,  5 Dec 2023 19:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dG0QNN13b2XmOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Dec 2023 19:19:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org, Peter
 Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH V6 00/14] fix migration of suspended runstate
In-Reply-To: <a0350701-617e-43a2-b856-02c35a203fb8@oracle.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <a0350701-617e-43a2-b856-02c35a203fb8@oracle.com>
Date: Tue, 05 Dec 2023 16:19:55 -0300
Message-ID: <874jgwmp7o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.79
X-Spamd-Result: default: False [-0.79 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.50)[79.91%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.978]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Steven Sistare <steven.sistare@oracle.com> writes:

> Hi Peter and Fabiano,
>
> Any comments on these patches, before I send V7?  They are not affected by
> the other changes we have discussed, except for renaming runstate_is_started
> to runstate_is_live.
>
>   [PATCH V6 04/14] cpus: vm_resume
>   [PATCH V6 06/14] migration: preserve suspended runstate
>   [PATCH V6 07/14] migration: preserve suspended for snapshot

Nothing catches my eye for now.

>   [PATCH V6 08/14] migration: preserve suspended for bg_migration

This has my r-b already.


