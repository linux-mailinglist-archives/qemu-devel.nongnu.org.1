Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8A828AA5
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:04:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFVS-0002qz-Iz; Tue, 09 Jan 2024 12:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNFVQ-0002mb-LA
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:03:12 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNFVO-0006RT-Uw
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:03:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7C221F809;
 Tue,  9 Jan 2024 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704819787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uYXFNZRsF0NjaEtss/CRMckN4kOG7hn5WO9W9DLnkNs=;
 b=pfSubKhVmE3ljVYsk3NFT86Vkr20SN+kjffmGpPztC1rYy13o2s/dhZ/CoNFCpEQUTOnvI
 N5im0m2yOpinMrkS1H5i4QQ0Am8APaXkdtG/gziEAvo1KUJRlcPl7TwzvqOiCjq2zueQeV
 kdV3rxuFNIBV1ysTlKzDFTAhkN0j9n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704819787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uYXFNZRsF0NjaEtss/CRMckN4kOG7hn5WO9W9DLnkNs=;
 b=aRX9ONCI5IcVPU3oCUpuGqyILAYDhaUmaSOMWCoEbjLn10WzjoXQFcnvFG2i1CA5TjLTk7
 Vl77KwYMWjoAhuCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704819787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uYXFNZRsF0NjaEtss/CRMckN4kOG7hn5WO9W9DLnkNs=;
 b=pfSubKhVmE3ljVYsk3NFT86Vkr20SN+kjffmGpPztC1rYy13o2s/dhZ/CoNFCpEQUTOnvI
 N5im0m2yOpinMrkS1H5i4QQ0Am8APaXkdtG/gziEAvo1KUJRlcPl7TwzvqOiCjq2zueQeV
 kdV3rxuFNIBV1ysTlKzDFTAhkN0j9n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704819787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uYXFNZRsF0NjaEtss/CRMckN4kOG7hn5WO9W9DLnkNs=;
 b=aRX9ONCI5IcVPU3oCUpuGqyILAYDhaUmaSOMWCoEbjLn10WzjoXQFcnvFG2i1CA5TjLTk7
 Vl77KwYMWjoAhuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A7A51370C;
 Tue,  9 Jan 2024 17:03:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 74RvOEp8nWV1FgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jan 2024 17:03:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, peterx@redhat.com, Alex Williamson
 <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, Bandan Das
 <bdas@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH 05/10] docs/migration: Split "Debugging" and "Firmware"
In-Reply-To: <20240109064628.595453-6-peterx@redhat.com>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-6-peterx@redhat.com>
Date: Tue, 09 Jan 2024 14:03:04 -0300
Message-ID: <87sf36783b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B7C221F809
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pfSubKhV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aRX9ONCI
X-Spam-Score: -6.40
X-Spamd-Result: default: False [-6.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-2.89)[99.54%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[9]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> Move the two sections into a separate file called "best-practises.rst".

s/practises/practices/


