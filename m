Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B38AF7C6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Apr 2024 22:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzMOr-0001z5-Qd; Tue, 23 Apr 2024 16:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzMOh-0001yi-AX
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 16:05:48 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzMOf-0004G8-Ja
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 16:05:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9CA9760599;
 Tue, 23 Apr 2024 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713902743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tesKB/DR/0OoDCqYZAUigjlyHF1+YqNsjCRHuLbihNE=;
 b=yRcd9xKpwJ60jbPVlhINbtYBaLes+WrToAZdCZ1OR3Nadum+OmKVMBNoTcq830ovywbZwg
 cxCWognHr+US+YHee8ZPs/gRzwxWl1vho4RLy3vHi7jV1rT53mYZ3cMcDRPl0FsSxndfPX
 6B9WavKDzoXKqjoIcXqy4u4KxEWClXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713902743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tesKB/DR/0OoDCqYZAUigjlyHF1+YqNsjCRHuLbihNE=;
 b=9cX5WAzlqpEO58SGfltFeYNVM5anSkQOuOCCHCezyLM5DM4fAhSYTZ/P6PXZEs4WdxuLz6
 uPE5Z6bFpdkvCvBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yRcd9xKp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9cX5WAzl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713902743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tesKB/DR/0OoDCqYZAUigjlyHF1+YqNsjCRHuLbihNE=;
 b=yRcd9xKpwJ60jbPVlhINbtYBaLes+WrToAZdCZ1OR3Nadum+OmKVMBNoTcq830ovywbZwg
 cxCWognHr+US+YHee8ZPs/gRzwxWl1vho4RLy3vHi7jV1rT53mYZ3cMcDRPl0FsSxndfPX
 6B9WavKDzoXKqjoIcXqy4u4KxEWClXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713902743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tesKB/DR/0OoDCqYZAUigjlyHF1+YqNsjCRHuLbihNE=;
 b=9cX5WAzlqpEO58SGfltFeYNVM5anSkQOuOCCHCezyLM5DM4fAhSYTZ/P6PXZEs4WdxuLz6
 uPE5Z6bFpdkvCvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CC5613929;
 Tue, 23 Apr 2024 20:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /BZPNZYUKGbXXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Apr 2024 20:05:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: Re: [PATCH 11/22] meson: make target endianneess available to Kconfig
In-Reply-To: <20240423131612.28362-12-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-12-pbonzini@redhat.com>
Date: Tue, 23 Apr 2024 17:05:40 -0300
Message-ID: <87edavj14b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.35
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9CA9760599
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.35 / 50.00]; BAYES_HAM(-2.84)[99.30%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> MIPS boards may only be available for big-endian or only for
> little-endian emulators, add a symbol so that this can be described
> with a "depends on" clause.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

