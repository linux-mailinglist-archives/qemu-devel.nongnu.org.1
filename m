Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D96D7BE3E6
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 17:08:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprrE-0006AC-2J; Mon, 09 Oct 2023 11:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qprrC-00064r-6w
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:07:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qprrA-0008JZ-Lw
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:07:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49D1621883;
 Mon,  9 Oct 2023 15:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696864059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZORS+/lCs/RBg5I2IkjeVCkwDT8HleXLeWdRqY+2uO4=;
 b=GthseVeVf1R1a7EoIw204WMej7lZDA/4OH7b+kDej6IJBd72zNrWWD7Nx3hUJKRg19n+Uu
 ZBG/QK2P0ICuPl4lFbi9rHhMIcUBZc/YdGKZJ/6iUYkB0F3xK3MD+CX4i2jZoGgWWsv/ry
 G0lgg9P0QMfM/yInTQikTZWHMoeN7JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696864059;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZORS+/lCs/RBg5I2IkjeVCkwDT8HleXLeWdRqY+2uO4=;
 b=C14aH0fW5ZZZdRlvIK2T0PqrBf0j6eoFgBqRJ1bwrivjcslpBB1ELR6K6qmcpErvYXuuHf
 EtwQC4UnTS5X8GCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFE1513905;
 Mon,  9 Oct 2023 15:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r4nEJToXJGV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 15:07:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] migration: Use g_autofree to simplify
 ram_dirty_bitmap_reload()
In-Reply-To: <20231008114001.95348-1-philmd@linaro.org>
References: <20231008114001.95348-1-philmd@linaro.org>
Date: Mon, 09 Oct 2023 12:07:36 -0300
Message-ID: <871qe3g7gn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Based-on: <ZR7e3cmxCH9LAdnS@x1n>
> ---
>  migration/ram.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 982fbbeee1..4cb948cfd0 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4164,11 +4164,11 @@ bool ram_dirty_bitmap_reload(MigrationState *s, R=
AMBlock *block, Error **errp)
>  {
>      /* from_dst_file is always valid because we're within rp_thread */
>      QEMUFile *file =3D s->rp_state.from_dst_file;
> -    unsigned long *le_bitmap, nbits =3D block->used_length >> TARGET_PAG=
E_BITS;
> +    unsigned long *le_bitmap =3D NULL;

Aren't you missing the actual g_autofree here?

> +    unsigned long nbits =3D block->used_length >> TARGET_PAGE_BITS;
>      uint64_t local_size =3D DIV_ROUND_UP(nbits, 8);
>      uint64_t size, end_mark;
>      RAMState *rs =3D ram_state;
> -    bool result =3D false;
>=20=20
>      trace_ram_dirty_bitmap_reload_begin(block->idstr);
>=20=20
> @@ -4193,7 +4193,7 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAM=
Block *block, Error **errp)
>      if (size !=3D local_size) {
>          error_setg(errp, "ramblock '%s' bitmap size mismatch (0x%"PRIx64
>                     " !=3D 0x%"PRIx64")", block->idstr, size, local_size);
> -        goto out;
> +        return false;
>      }
>=20=20
>      size =3D qemu_get_buffer(file, (uint8_t *)le_bitmap, local_size);
> @@ -4203,13 +4203,13 @@ bool ram_dirty_bitmap_reload(MigrationState *s, R=
AMBlock *block, Error **errp)
>          error_setg(errp, "read bitmap failed for ramblock '%s': "
>                     "(size 0x%"PRIx64", got: 0x%"PRIx64")",
>                     block->idstr, local_size, size);
> -        goto out;
> +        return false;
>      }
>=20=20
>      if (end_mark !=3D RAMBLOCK_RECV_BITMAP_ENDING) {
>          error_setg(errp, "ramblock '%s' end mark incorrect: 0x%"PRIx64,
>                     block->idstr, end_mark);
> -        goto out;
> +        return false;
>      }
>=20=20
>      /*
> @@ -4241,10 +4241,7 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RA=
MBlock *block, Error **errp)
>       */
>      migration_rp_kick(s);
>=20=20
> -    result =3D true;
> -out:
> -    g_free(le_bitmap);
> -    return result;
> +    return true;
>  }
>=20=20
>  static int ram_resume_prepare(MigrationState *s, void *opaque)

