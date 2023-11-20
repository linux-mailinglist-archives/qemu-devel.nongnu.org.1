Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D97F1A05
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:32:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r586c-0003UH-4a; Mon, 20 Nov 2023 12:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r586Y-0003Qa-1J
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:30:39 -0500
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r586T-0000yw-Kh
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:30:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A36D218FD;
 Mon, 20 Nov 2023 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700501429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4oWtJJblmC3DHmJvRToYNBAT7KCTc2LbpujaC8/zuLo=;
 b=RgmVuRT+GAEA1Vd30WyFsmA1LZeLbs37f4gx+MgWeHzgBIDdsNtZW5lbt4fZvtsrAxIwGc
 plqZs0Di0j1IC2WHTSYU+rrBehna/v8Toku7J+YdT6LRKv9VO/EwiIOxNDOgSESjbqxNJU
 0lqAtAx4aIn/hLZ6qCFj+R4y4fBMkMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700501429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4oWtJJblmC3DHmJvRToYNBAT7KCTc2LbpujaC8/zuLo=;
 b=gFyU+gJ11wm0vxCo7KNK3PCj3h6j5Ehv9ux+DcXTKRy2iLTMNubheuR9sUmDxwr7JOp2hp
 Yot6iQ5qO1Pkd4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14034134AD;
 Mon, 20 Nov 2023 17:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NEsfNLSXW2UuEgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 20 Nov 2023 17:30:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V5 05/12] migration: preserve suspended runstate
In-Reply-To: <1699900440-207345-6-git-send-email-steven.sistare@oracle.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-6-git-send-email-steven.sistare@oracle.com>
Date: Mon, 20 Nov 2023 14:30:26 -0300
Message-ID: <87cyw45o3x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.24
X-Spamd-Result: default: False [-1.24 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[29.43%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.14)[-0.701]; RCPT_COUNT_SEVEN(0.00)[9];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

> A guest that is migrated in the suspended state automaticaly wakes and
> continues execution.  This is wrong; the guest should end migration in
> the same state it started.  The root cause is that the outgoing migration
> code automatically wakes the guest, then saves the RUNNING runstate in
> global_state_store(), hence the incoming migration code thinks the guest is
> running and continues the guest if autostart is true.
>
> Simply deleting the call to qemu_system_wakeup_request() on the outgoing
> side, to migrate the vm in state suspended, does not solve the problem.
> The old vm_stop_force_state does little if the vm is suspended, so the cpu
> clock remains running, and runstate notifiers for the stop transition are
> not called (and were not called on transition to suspended). Stale cpu
> timers_state is saved to the migration stream, causing time errors in the
> guest when it wakes from suspend.  State that would have been modified by
> runstate notifiers is wrong.
>
> The new version of vm_stop_force_state solves the outgoing problems, by
> completely stopping a vm in the suspended state.
>
> On the incoming side for precopy, compute the desired new state from global
> state received, and call runstate_restore, which will partially
> resume the vm if the state is suspended.  A future system_wakeup monitor
> request will cause the vm to resume running.
>
> On the incoming side for postcopy, apply the the same restore logic found
> in precopy.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

