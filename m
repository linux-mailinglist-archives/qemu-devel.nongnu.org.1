Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A12A76970
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Mar 2025 17:09:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzGlU-0002Cy-K0; Mon, 31 Mar 2025 11:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzGlO-0002Cb-Dw
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:09:22 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzGlM-0004Up-KK
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:09:22 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75BAD211F2;
 Mon, 31 Mar 2025 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743433757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AdGFrr8FdFpnm7hVmucX75RCpvqrsI8fjHCEGLyXRqQ=;
 b=WnbDt8cyNQdSZsalh4MSq4vDQ3HwX8rgTFcq+qc1iqlSmxNGHyPwEE90SvpEGKTsAbY8Io
 SoA4JiNWYp5Gv6Pe02B1Gr/kJF54ry1wt16MO7NPWVsihwewX1+DtKFfxmM2usI0sFI2TV
 WGPf/FE/w8jvL9UvW/rs28Zn0fo/0zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743433757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AdGFrr8FdFpnm7hVmucX75RCpvqrsI8fjHCEGLyXRqQ=;
 b=/N4rsXr/a6R+yHNQYx97KNuJ8kdKrtOteYPiFrzqFzPyEgeXd3QKJK0YEk7hfRULKFsWzx
 MyGfRo9CCLl4tfCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WnbDt8cy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/N4rsXr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743433757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AdGFrr8FdFpnm7hVmucX75RCpvqrsI8fjHCEGLyXRqQ=;
 b=WnbDt8cyNQdSZsalh4MSq4vDQ3HwX8rgTFcq+qc1iqlSmxNGHyPwEE90SvpEGKTsAbY8Io
 SoA4JiNWYp5Gv6Pe02B1Gr/kJF54ry1wt16MO7NPWVsihwewX1+DtKFfxmM2usI0sFI2TV
 WGPf/FE/w8jvL9UvW/rs28Zn0fo/0zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743433757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AdGFrr8FdFpnm7hVmucX75RCpvqrsI8fjHCEGLyXRqQ=;
 b=/N4rsXr/a6R+yHNQYx97KNuJ8kdKrtOteYPiFrzqFzPyEgeXd3QKJK0YEk7hfRULKFsWzx
 MyGfRo9CCLl4tfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB305139A1;
 Mon, 31 Mar 2025 15:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QTIeJhyw6mcHRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 31 Mar 2025 15:09:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v8 6/7] migration: Add save_postcopy_prepare() savevm
 handler
In-Reply-To: <20250318123846.1370312-7-ppandit@redhat.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-7-ppandit@redhat.com>
Date: Mon, 31 Mar 2025 12:08:58 -0300
Message-ID: <87v7rpkzjp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 75BAD211F2
X-Spamd-Result: default: False [-2.87 / 50.00]; BAYES_HAM(-1.36)[90.56%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.87
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Prasad Pandit <ppandit@redhat.com> writes:

This patch and the next one need to come before 3/7.


