Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C4B1260F
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Jul 2025 23:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufPi9-0006GB-1J; Fri, 25 Jul 2025 17:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ufPhc-0006Fm-Sr
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 17:11:40 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ufPhb-0008SD-5W
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 17:11:40 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 06A941F387;
 Fri, 25 Jul 2025 21:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753477897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BtujC/o0vQWg2MMv6eRfGTXljzWfxisL7BNnXKAfP/Q=;
 b=keIxCikWixpL79RPrIX4PYrX9VcpReEfX77Z51+V3ocziR4BiRYhmr2LTL6ZVfNWSqCaLU
 THus8lHoZUdR3+qN4ZdV0H5nw4CPuFFxMTSrElYAEAvSJZ41cuAPXr8MdJBpIVwKcKdkMn
 mMiOLREfd57aDyiCTFpHSuSYN7S03h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753477897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BtujC/o0vQWg2MMv6eRfGTXljzWfxisL7BNnXKAfP/Q=;
 b=74HDniRGsfrzhg2Avo+wr9+zBrtEsMgHPp9k9VYLT0M9B+UY3HtjOpGpsUztoKCAg9Wr4A
 Zjo5GbsbUsaw+cDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=keIxCikW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=74HDniRG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753477897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BtujC/o0vQWg2MMv6eRfGTXljzWfxisL7BNnXKAfP/Q=;
 b=keIxCikWixpL79RPrIX4PYrX9VcpReEfX77Z51+V3ocziR4BiRYhmr2LTL6ZVfNWSqCaLU
 THus8lHoZUdR3+qN4ZdV0H5nw4CPuFFxMTSrElYAEAvSJZ41cuAPXr8MdJBpIVwKcKdkMn
 mMiOLREfd57aDyiCTFpHSuSYN7S03h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753477897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BtujC/o0vQWg2MMv6eRfGTXljzWfxisL7BNnXKAfP/Q=;
 b=74HDniRGsfrzhg2Avo+wr9+zBrtEsMgHPp9k9VYLT0M9B+UY3HtjOpGpsUztoKCAg9Wr4A
 Zjo5GbsbUsaw+cDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74F14134E8;
 Fri, 25 Jul 2025 21:11:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vNEqDQjzg2jqRAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 25 Jul 2025 21:11:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 0/3] single-binary: compile once migration files
In-Reply-To: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
References: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
Date: Fri, 25 Jul 2025 18:11:33 -0300
Message-ID: <87jz3w3ri2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 06A941F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This series removes target dependencies in migration code.
>
> Pierrick Bouvier (3):
>   migration: compile migration/ram.c once
>   migration: rename target.c to vfio.c
>   migration/vfio: compile only once
>
>  migration/vfio-stub.c          | 16 ++++++++++++++++
>  migration/{target.c => vfio.c} | 16 +---------------
>  migration/meson.build          |  8 ++++----
>  3 files changed, 21 insertions(+), 19 deletions(-)
>  create mode 100644 migration/vfio-stub.c
>  rename migration/{target.c => vfio.c} (67%)

Series:

Acked-by: Fabiano Rosas <farosas@suse.de>

