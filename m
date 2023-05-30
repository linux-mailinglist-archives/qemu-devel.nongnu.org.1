Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AA171612B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:11:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3z7p-0002bJ-DQ; Tue, 30 May 2023 09:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q3z7U-0002Ol-76; Tue, 30 May 2023 09:10:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q3z7S-0003tT-90; Tue, 30 May 2023 09:10:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 241D921AD0;
 Tue, 30 May 2023 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685452232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mxf7T6SCFaqU1Rc1k0FBorWOjigdNvFDSuILK2KQlpU=;
 b=QX3XtmpTjcg8ojlwZ2qqSkInnePRL2yXQ66HAx0j+6m3EXPdNrv37fFBa8nKgo28YGCbBl
 M8NDTFUQLjftpAzNUwtFNoH9j6MmUempEyiFbrsbjqS9RnrX/E1FZM6lczYNurnfISgg4w
 Tw4C5jWYwanA9bx1L+UOFvQVYP9GlgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685452232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mxf7T6SCFaqU1Rc1k0FBorWOjigdNvFDSuILK2KQlpU=;
 b=JHOP6GjeMYjBt/DpBiclKSPzzQG3QlfR78Ir8ei0yk4oe2tPGcwPKnAxhsMs+X4gjhDNsP
 7FVydDQ+tsAcyQDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F0D213478;
 Tue, 30 May 2023 13:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GkcHGcf1dWTWNgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 30 May 2023 13:10:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>, Fam Zheng
 <fam@euphon.net>, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH 10/16] qemu-file: Remove _noflush from
 qemu_file_transferred_noflush()
In-Reply-To: <20230530122813.2674-11-quintela@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-11-quintela@redhat.com>
Date: Tue, 30 May 2023 10:10:29 -0300
Message-ID: <87a5xmarsq.fsf@suse.de>
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

Juan Quintela <quintela@redhat.com> writes:

> qemu_file_transferred() don't exist anymore, so we can reuse the name.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/qemu-file.h | 4 ++--
>  migration/block.c     | 4 ++--
>  migration/qemu-file.c | 2 +-
>  migration/savevm.c    | 6 +++---
>  migration/vmstate.c   | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index b4fb872018..3575dfa5ff 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -34,7 +34,7 @@ QEMUFile *qemu_file_new_output(QIOChannel *ioc);
>  int qemu_fclose(QEMUFile *f);
>  
>  /*
> - * qemu_file_transferred_noflush:
> + * qemu_file_transferred:
>   *
>   * As qemu_file_transferred except for writable files, where no flush

Docs need updating^

>   * is performed and the reported amount will include the size of any
> @@ -42,7 +42,7 @@ int qemu_fclose(QEMUFile *f);
>   *
>   * Returns: the total bytes transferred and queued
>   */
> -uint64_t qemu_file_transferred_noflush(QEMUFile *f);
> +uint64_t qemu_file_transferred(QEMUFile *f);

