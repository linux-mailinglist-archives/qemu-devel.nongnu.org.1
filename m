Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 693867D03FF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:27:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaUa-0001kx-Im; Thu, 19 Oct 2023 17:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtaUY-0001TN-F5
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:42 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtaUW-0001mU-Tm
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A33C1F45B;
 Thu, 19 Oct 2023 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697750619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2kwqI8mOveVpP06Ur8RJy1f9QASw52bmBjPxFk1SAMc=;
 b=Qcls3jwl9trG3qFHMGwMMiZ9VNFw85+1woAIk8g3G5jP+o45k5FnqN5gl+vkJHroay7nfb
 9AppyVzgsyTGfAMWnvTJ36zW581Z49JSrDVHsLIKTTOWnzQ9nAVuEybtComFf+qcq9PWZI
 KawGJRGNQbuJYbGKXV0H8NLWPluaVVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697750619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2kwqI8mOveVpP06Ur8RJy1f9QASw52bmBjPxFk1SAMc=;
 b=3E5ygPbJxSPXxi4vuRh4XKMRgVcOSG2rTqapoQeGGl0oWMSz/Y2U2z0z91QL4QP/08DPoM
 hALafaVu7n6v2nDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10BDA139C2;
 Thu, 19 Oct 2023 21:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pz/0MlqeMWVgRQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 21:23:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] migration: Rename ram_handle_compressed() to
 ram_handle_zero()
In-Reply-To: <20231019085259.13307-3-quintela@redhat.com>
References: <20231019085259.13307-1-quintela@redhat.com>
 <20231019085259.13307-3-quintela@redhat.com>
Date: Thu, 19 Oct 2023 18:23:36 -0300
Message-ID: <87zg0egvc7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.08
X-Spamd-Result: default: False [-7.08 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.98)[99.93%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Juan Quintela <quintela@redhat.com> writes:

> Now that we know it only handles zero, we can remove the ch parameter.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>


