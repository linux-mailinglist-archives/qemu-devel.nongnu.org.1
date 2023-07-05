Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5BB748F72
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:56:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH9Xf-0001zw-PH; Wed, 05 Jul 2023 16:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qH9Xd-0001ze-Jw
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:56:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qH9Xc-0002Qt-2i
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:56:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97C6E21C43;
 Wed,  5 Jul 2023 20:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688590558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kt/w+nTn5uZSUtsm1pyhk0QOst41mqcBSG+w0OzgBOk=;
 b=rWKB4aLZv/1AerGwnMJOm1dqBszlCpuyPzCrMP27Ucwl6egpNchaqfatHyBP4G9AjD22VY
 /egeNC/mzmq2fBxSHYL8DJhI5Bhnqg1PC1ubs3ccKxArCTsxIAYAj3aIpmClPMfB8+WDtb
 DX39m3jMpgaNld0IqOpYLAz83pmsleU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688590558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kt/w+nTn5uZSUtsm1pyhk0QOst41mqcBSG+w0OzgBOk=;
 b=52EE5QkNthTF04aSHIVVMsqpoEysVyKzYXOR1aS6sUrTAxoEQE+mzv12VOjHJQMCbAskQ9
 ya4pucJLXrK0mADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F12A113460;
 Wed,  5 Jul 2023 20:55:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Nf8qLd3YpWQVPAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 05 Jul 2023 20:55:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek
 <lersek@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v2 3/7] migration: Introduce migrate_has_error()
In-Reply-To: <20230705163502.331007-4-peterx@redhat.com>
References: <20230705163502.331007-1-peterx@redhat.com>
 <20230705163502.331007-4-peterx@redhat.com>
Date: Wed, 05 Jul 2023 17:55:54 -0300
Message-ID: <87edlm3wo5.fsf@suse.de>
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

Peter Xu <peterx@redhat.com> writes:

> Introduce a helper to detect whether MigrationState.error is set for
> whatever reason.  It is intended to not taking the error_mutex here because
> neither do we reference the pointer, nor do we modify the pointer.  State
> why it's safe to do so.
>
> This is preparation work for any thread (e.g. source return path thread) to
> setup errors in an unified way to MigrationState, rather than relying on
> its own way to set errors (mark_source_rp_bad()).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

