Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB76C7D597E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:11:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKuU-0001lR-TO; Tue, 24 Oct 2023 13:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvKuS-0001lE-Gl
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:09:40 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvKuR-0005UH-0Q
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:09:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C146921C1C;
 Tue, 24 Oct 2023 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698167373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylSR4WBHDZv0B6TbuaPLkhSggvpQagosOCtZ9OAZ4/c=;
 b=gVzD5jlVpLAv4bRTo5e/D7wCYvWtXmqlUGXrg8cRwFI+tOIOjRtbJ9duoApUWKn9Vfd4DJ
 cLt0IJpg7TZnZmck9C853TsE+1FlCbmoyiPXMZvRyHeukqW5U3HSuRHrlHaxIvpnlAg8Iq
 2EDxdDnZYycpSIYNdm88arNSIsvPGPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698167373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylSR4WBHDZv0B6TbuaPLkhSggvpQagosOCtZ9OAZ4/c=;
 b=LtTeh7OLjiL8qwcINPcf0TW8ba7KiWaPfKxXxpz0KL2YwJcGvOGM4eGKZmnuOO90sLcCsM
 8GGrIfWSINBuXlCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5423A134F5;
 Tue, 24 Oct 2023 17:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F0cyCE36N2XdfgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 17:09:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Zhijian Li <lizhijian@fujitsu.com>, Markus Armbruster
 <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3] migration: Stop migration immediately in RDMA error
 paths
In-Reply-To: <20231024163933.516546-1-peterx@redhat.com>
References: <20231024163933.516546-1-peterx@redhat.com>
Date: Tue, 24 Oct 2023 14:09:30 -0300
Message-ID: <87cyx4t0ad.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[99.99%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

Peter Xu <peterx@redhat.com> writes:

> In multiple places, RDMA errors are handled in a strange way, where it only
> sets qemu_file_set_error() but not stop the migration immediately.
>
> It's not obvious what will happen later if there is already an error.  Make
> all such failures stop migration immediately.
>
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

