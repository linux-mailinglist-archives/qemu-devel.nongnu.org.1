Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5C753B4B
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:48:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIDC-0005bn-7w; Fri, 14 Jul 2023 08:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qKID6-0005Zs-3q
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:47:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qKID4-0008Gr-Ag
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:47:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D33FA220FB;
 Fri, 14 Jul 2023 12:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689338846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCxf5i095nO0zNAXwzyuDZy9HhfjO1uNF7zPwVyteK4=;
 b=BUgIJHinw7GId2EqH18B9NZajnIpWDE1nb+3WgrcvzO0AizNT1oD7mYXDIY/xWKhtE39t4
 gb8b+Y7pR9U2+azJXmSUQrqWQMRU4nE3rzPdmnhlukQctKTTByUeQaRS2ZHR/YJ2mPmX5e
 xlkII1cehXENtVnb3XhSWFK8hoQf/B0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689338846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCxf5i095nO0zNAXwzyuDZy9HhfjO1uNF7zPwVyteK4=;
 b=+qIilW/aDwCSyxpj8r/wdwGj9wkWFFRqzXVtC8dTgCpPGuR4RjryVJysNizu5Ahv8L8OrQ
 BeG+MvvUXvOyCmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62B6313A15;
 Fri, 14 Jul 2023 12:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6IasC95DsWQBXQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 14 Jul 2023 12:47:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 01/10] vl: start on wakeup request
In-Reply-To: <1688132988-314397-2-git-send-email-steven.sistare@oracle.com>
References: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
 <1688132988-314397-2-git-send-email-steven.sistare@oracle.com>
Date: Fri, 14 Jul 2023 09:47:23 -0300
Message-ID: <874jm6k6ck.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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

Steve Sistare <steven.sistare@oracle.com> writes:

> If qemu starts and loads a VM in the suspended state, then a later wakeup
> request directly sets the state to running.  This skips vm_start() and its
> initialization steps, which is fatal for the guest.  See
> qemu_system_wakeup_request(), and qemu_system_wakeup() in
> main_loop_should_exit().
>
> Remember if vm_start has been called.  If not, then call vm_start from
> qemu_system_wakeup_request.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

