Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AACAA10999
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Jan 2025 15:43:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXi7X-0003nf-IL; Tue, 14 Jan 2025 09:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tXi7Q-0003lj-Le
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:42:13 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tXi7O-0003MF-Jq
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:42:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C950C21157;
 Tue, 14 Jan 2025 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736865720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOMSptrN+Kwq+k8g6EcGJ1QlnyjwrAaefX0+1OP7Kgs=;
 b=L9aeTIdxdbxBDyB2EJ3TVNXQNjkDcuxEh/K8fWVkG7O8i4vFf7gMgiz1k98RptIlQgwtHn
 qmKRu1fJayJy6wy0kIc/yzOdGrHNK70IOD5DaN3WuTrSR1EzGaT4BDcNVblgGDjEcK58RI
 /RXxuVemIpyldcMDr4uOkIhft0/slVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736865720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOMSptrN+Kwq+k8g6EcGJ1QlnyjwrAaefX0+1OP7Kgs=;
 b=SJPn7OuRYxlmJLsKLiozh4J4c4waLQpAj1ZVSCSJhHHk9+chmU089jkIs2VknIsPhxZP0F
 vTmyr3J4eh9yA5BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M+V64MAs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CcOvRmJn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736865719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOMSptrN+Kwq+k8g6EcGJ1QlnyjwrAaefX0+1OP7Kgs=;
 b=M+V64MAsV8ogEOc+n2alnNj7Guf+jGut6W1fz1RDloHiuE0CZarBz70GtDV2QfxOnswLdT
 p2vj3rXJ3Vrq7Z0qDr7ctLEVICHBTyqlkzZxr1NQC4qqPN/xmssQvIAF7jDFa7KYM6lvjr
 vpVqKMAxpV39EvaEhPJtT/QyEzDnnfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736865719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOMSptrN+Kwq+k8g6EcGJ1QlnyjwrAaefX0+1OP7Kgs=;
 b=CcOvRmJnRfRJJGYk8jHY3Xtua2380BBfyTFhuQKN71S4gFB3CQC30+iXgnHpC/0wGxa2Oy
 LwjJsPHyVSILMlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 500721384C;
 Tue, 14 Jan 2025 14:41:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6vqvBbd3hmdcZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Jan 2025 14:41:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH] migration: fix -Werror=maybe-uninitialized
In-Reply-To: <20250114104811.2612846-1-marcandre.lureau@redhat.com>
References: <20250114104811.2612846-1-marcandre.lureau@redhat.com>
Date: Tue, 14 Jan 2025 11:41:56 -0300
Message-ID: <87zfjtfoej.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C950C21157
X-Spam-Score: -4.47
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.47 / 50.00]; BAYES_HAM(-2.96)[99.84%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ../migration/savevm.c: In function =E2=80=98qemu_savevm_state_complete_pr=
ecopy_non_iterable=E2=80=99:
> ../migration/savevm.c:1560:20: error: =E2=80=98ret=E2=80=99 may be used u=
ninitialized [-Werror=3Dmaybe-uninitialized]
>  1560 |             return ret;
>       |                    ^~~

Weird that this didn't show up anywhere.

>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  migration/savevm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c929da1ca5..6e56d4cf1d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1557,7 +1557,7 @@ int qemu_savevm_state_complete_precopy_non_iterable=
(QEMUFile *f,
>              migrate_set_error(ms, local_err);
>              error_report_err(local_err);
>              qemu_file_set_error(f, -EFAULT);
> -            return ret;
> +            return -1;
>          }
>      }
>      if (!in_postcopy) {

