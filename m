Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F14EB7D381D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quv38-00061J-Of; Mon, 23 Oct 2023 09:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quv2y-0005zM-Bi
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:32:44 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quv2u-0005FI-Vq
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:32:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FC381FE18;
 Mon, 23 Oct 2023 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698067959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IgQSp5dt+ERV54WOCN2+Iq4P4KdGH2XBU46BaOGR/kw=;
 b=I/qYn1ABdhLjbW2MgxXaX+tqLqLsiBWSBMgu7PvCA0omdmlMBNUEiIjJAsiEDgUdkKezzD
 g9RAtq0KBJZdDbdts/VGvBvuGg58rwKgF9E5K2ormdfYfylGcdoBQjUzEbb618X4cdvLRI
 7QxTG9BY46WPeJ6OyzVu8C3ndCjQTnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698067959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IgQSp5dt+ERV54WOCN2+Iq4P4KdGH2XBU46BaOGR/kw=;
 b=yBDSgR/srPe79xf5I5FHsSvP+E5OhFTfN1MOd2NMTV2Bf/VAjMrkL3ePsIJK2n2XoesVNI
 sgOycwEymdzpBIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03C09132FD;
 Mon, 23 Oct 2023 13:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NTo7MPZ1NmVZUQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 13:32:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>, Juan
 Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 02/11] migration: Give one error if trying to set
 COMPRESSION and XBZRLE
In-Reply-To: <20231019110724.15324-3-quintela@redhat.com>
References: <20231019110724.15324-1-quintela@redhat.com>
 <20231019110724.15324-3-quintela@redhat.com>
Date: Mon, 23 Oct 2023 10:32:36 -0300
Message-ID: <87ttqhbh1n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.07
X-Spamd-Result: default: False [-7.07 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-2.97)[99.85%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/options.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/migration/options.c b/migration/options.c
> index b8c3c3218d..37fa1cfe74 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -625,6 +625,13 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>          }
>      }
>  
> +    if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
> +        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
> +            error_setg(errp, "Compression is not compatible with xbzrle");
> +            return false;
> +        }
> +    }
> +
>      return true;
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

