Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 975917D59E4
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:43:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvLQ7-0005Dl-8n; Tue, 24 Oct 2023 13:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvLQ3-00059n-06; Tue, 24 Oct 2023 13:42:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvLQ1-0005NJ-3J; Tue, 24 Oct 2023 13:42:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67AA821AB8;
 Tue, 24 Oct 2023 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698169335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bsmfy5isu6dwZtc9j4nGRB4hkuteTjn3YcfmNd07Zr4=;
 b=1qGalg2JDsg0H86ELJqi81KDpvWM48YLVKoQGrWQ8+UQuueIidVWomqbiSRDCtheXMdpaU
 vD9YDzR2Knj2CfTv6y/DvUVK8uAVf79vJ6SOg7x1QDWIHG2fPCTdpUb8xLD2EX66//XHxZ
 AV94vwFR7JRg5Ez1VeT0ZcuAoY3Rqco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698169335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bsmfy5isu6dwZtc9j4nGRB4hkuteTjn3YcfmNd07Zr4=;
 b=yFyGiD3BpjAgx879FKViybaOt/JwNgn5pq0b22MLB8MY69b/bcJ6tcaYO2qwVWKnyQnKs/
 Id/EZcpio1j6VsCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E40931391C;
 Tue, 24 Oct 2023 17:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B7lwK/MBOGW7DwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 17:42:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, =?utf-8?Q?Daniel_P?=
 =?utf-8?Q?_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter
 Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 06/12] qemu-file: Remove _noflush from
 qemu_file_transferred_noflush()
In-Reply-To: <20231024151042.90349-7-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
 <20231024151042.90349-7-quintela@redhat.com>
Date: Tue, 24 Oct 2023 14:42:09 -0300
Message-ID: <87v8avsyry.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

Juan Quintela <quintela@redhat.com> writes:

> qemu_file_transferred() don't exist anymore, so we can reuse the name.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> ---
>
> v2: Update the documentation (thanks fabiano)
> ---
>  migration/qemu-file.h | 9 ++++-----
>  migration/block.c     | 4 ++--
>  migration/qemu-file.c | 2 +-
>  migration/savevm.c    | 6 +++---
>  migration/vmstate.c   | 4 ++--
>  5 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 8b71152754..1b2f6b8d8f 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -34,15 +34,14 @@ QEMUFile *qemu_file_new_output(QIOChannel *ioc);
>  int qemu_fclose(QEMUFile *f);
>  
>  /*
> - * qemu_file_transferred_noflush:
> + * qemu_file_transferred:
>   *
> - * As qemu_file_transferred except for writable files, where no flush
> - * is performed and the reported amount will include the size of any
> - * queued buffers, on top of the amount actually transferred.
> + * No flush is performed and the reported amount will include the size
> + * of any queued buffers, on top of the amount actually transferred.
>   *
>   * Returns: the total bytes transferred and queued
>   */
> -uint64_t qemu_file_transferred_noflush(QEMUFile *f);
> +uint64_t qemu_file_transferred(QEMUFile *f);
>  
>  /*
>   * put_buffer without copying the buffer.
> diff --git a/migration/block.c b/migration/block.c
> index b60698d6e2..47f11d0e4f 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -752,7 +752,7 @@ static int block_save_setup(QEMUFile *f, void *opaque)
>  static int block_save_iterate(QEMUFile *f, void *opaque)
>  {
>      int ret;
> -    uint64_t last_bytes = qemu_file_transferred_noflush(f);
> +    uint64_t last_bytes = qemu_file_transferred(f);
>  
>      trace_migration_block_save("iterate", block_mig_state.submitted,
>                                 block_mig_state.transferred);
> @@ -804,7 +804,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
>      }
>  
>      qemu_put_be64(f, BLK_MIG_FLAG_EOS);
> -    uint64_t delta_bytes = qemu_file_transferred_noflush(f) - last_bytes;
> +    uint64_t delta_bytes = qemu_file_transferred(f) - last_bytes;
>      return (delta_bytes > 0);
>  }
>  
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index efa5f11033..0158db2a54 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -618,7 +618,7 @@ int coroutine_mixed_fn qemu_get_byte(QEMUFile *f)
>      return result;
>  }
>  
> -uint64_t qemu_file_transferred_noflush(QEMUFile *f)
> +uint64_t qemu_file_transferred(QEMUFile *f)
>  {
>      uint64_t ret = stat64_get(&mig_stats.qemu_file_transferred);
>      int i;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 8622f229e5..9c90499609 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -927,9 +927,9 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
>  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
>                                     JSONWriter *vmdesc)
>  {
> -    uint64_t old_offset = qemu_file_transferred_noflush(f);
> +    uint64_t old_offset = qemu_file_transferred(f);
>      se->ops->save_state(f, se->opaque);
> -    uint64_t size = qemu_file_transferred_noflush(f) - old_offset;
> +    uint64_t size = qemu_file_transferred(f) - old_offset;
>  
>      if (vmdesc) {
>          json_writer_int64(vmdesc, "size", size);
> @@ -3053,7 +3053,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>          goto the_end;
>      }
>      ret = qemu_savevm_state(f, errp);
> -    vm_state_size = qemu_file_transferred_noflush(f);
> +    vm_state_size = qemu_file_transferred(f);
>      ret2 = qemu_fclose(f);
>      if (ret < 0) {
>          goto the_end;
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 1cf9e45b85..16420fa9a3 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -386,7 +386,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  void *curr_elem = first_elem + size * i;
>  
>                  vmsd_desc_field_start(vmsd, vmdesc_loop, field, i, n_elems);
> -                old_offset = qemu_file_transferred_noflush(f);
> +                old_offset = qemu_file_transferred(f);
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      assert(curr_elem);
>                      curr_elem = *(void **)curr_elem;
> @@ -416,7 +416,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                      return ret;
>                  }
>  
> -                written_bytes = qemu_file_transferred_noflush(f) - old_offset;
> +                written_bytes = qemu_file_transferred(f) - old_offset;
>                  vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes, i);
>  
>                  /* Compressed arrays only care about the first element */

Reviewed-by: Fabiano Rosas <farosas@suse.de>

