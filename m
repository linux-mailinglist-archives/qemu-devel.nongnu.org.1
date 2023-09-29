Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1001E7B366C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 17:11:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmF8U-0000x8-1o; Fri, 29 Sep 2023 11:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qmF8J-0000v2-1r
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:10:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qmF8A-0000PA-HD
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:10:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E47901F45E;
 Fri, 29 Sep 2023 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696000212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A/nky0NUAqru42KqbelHov033OQK7bLb3KEK8CanrTA=;
 b=EgfgXI75k2qII7Bo/wOLfjzw6VnQaIgHAim6nXaiQp+HClxdnr7jbuRwzmYQ/xvw2JAyxG
 PhD/EHuV+I65hqwB9Ijr8VR+ewhFiX8Rabf9ntVSbvMHBNnQThn9G4yxf4Rn1R+ss4hZ5K
 gwH8Yjyc6EtIF56SynUW0jXqHPxohxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696000212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A/nky0NUAqru42KqbelHov033OQK7bLb3KEK8CanrTA=;
 b=WHktAuPAR5YJOTg0zwT+JIrR7sjyj8xFl6nWCgrdNWJy0HkBN+qazAepHa809PkWQCMNw9
 fu2Tex/rKdNzWFDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CF6B13434;
 Fri, 29 Sep 2023 15:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1KhSDtToFmXELwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 29 Sep 2023 15:10:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 lizhijian@fujitsu.com, eblake@redhat.com
Subject: Re: [PATCH v2 22/53] migration/rdma: Drop dead
 qemu_rdma_data_init() code for !@host_port
In-Reply-To: <20230928132019.2544702-23-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-23-armbru@redhat.com>
Date: Fri, 29 Sep 2023 12:10:10 -0300
Message-ID: <87v8btyq0d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

Markus Armbruster <armbru@redhat.com> writes:

> qemu_rdma_data_init() neglects to set an Error when it fails because
> @host_port is null.  Fortunately, no caller passes null, so this is
> merely a latent bug.  Drop the flawed code handling null argument.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

