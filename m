Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE890E8B4
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jun 2024 12:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJswP-0001b9-M9; Wed, 19 Jun 2024 06:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJswN-0001aY-8D
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:53:23 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJswL-0003SG-NU
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:53:23 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B530D21A8E;
 Wed, 19 Jun 2024 10:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718794398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7dl9qEna4iRQ2hD+NUEZaDLSUAnnzAOQNWH0W0vwhw=;
 b=xIyoYpmk7dbfM/tIklLNYFpTcLBrKmsw+28MdQENVRHR7koINxdTPq5JRNU7igIlvagBzK
 QaaA/Cc5HdsFOOC5KG96ojhLSWjqpbWGV8vesC+R4aCHPuxH5S532uu+KRKQ886rPWB5LM
 aF4JZYSXxVEKwBC6nGpEaz0cD9E+ZIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718794398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7dl9qEna4iRQ2hD+NUEZaDLSUAnnzAOQNWH0W0vwhw=;
 b=sE3GnOoskCKRyRLn4NN9kkeajiwdV28Eeibx3qWARjp+zTFH4pP6EO++ncu5CtMItfwGWh
 dYlRDcIdhcPPQABA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718794397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7dl9qEna4iRQ2hD+NUEZaDLSUAnnzAOQNWH0W0vwhw=;
 b=Y0fvEu3LUcFKrKGVQK4laHT0K48BZYIMliLFpDhYzwOw2Ye3UPyPKvh+/tDpGMjf1NDWap
 fiHrxY3xVhGEBCor1stybuM+KqWcSWpTvJLhKgpK/4A3WRu5aEsmDe/x873CF2qc3JP+gW
 60JzslM50+z/XkRsxP/70q/jJYN5LQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718794397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7dl9qEna4iRQ2hD+NUEZaDLSUAnnzAOQNWH0W0vwhw=;
 b=ue4cUO16bmumWVkWtpDAnRoF8/qcjNhXj0SfFWKpYSIvdgbI9/K7oJIGS0Uhw2EnBVfTFx
 KZkclaY177mO8RCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 329CC13AAA;
 Wed, 19 Jun 2024 10:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5m4aOZy4cmZMSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Jun 2024 10:53:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier
 <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Cover all tests/qtest/migration-* files
In-Reply-To: <20240619055447.129943-1-thuth@redhat.com>
References: <20240619055447.129943-1-thuth@redhat.com>
Date: Wed, 19 Jun 2024 07:53:14 -0300
Message-ID: <87y1719pb9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.28
X-Spamd-Result: default: False [-4.28 / 50.00]; BAYES_HAM(-2.98)[99.93%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
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

Thomas Huth <thuth@redhat.com> writes:

> Beside migration-test.c, there is nowadays migration-helpers.[ch],
> too, so update the entry in the migration section to also cover these
> files now.
> While we're at it, exclude these files in the common qtest section,
> since the migration test is well covered by the migration maintainers
> already. Since the test is under very active development, it was causing
> a lot of distraction to the generic qtest maintainers with regards to
> the patches that need to be reviewed by the migration maintainers anyway.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Fabiano Rosas <farosas@suse.de>

