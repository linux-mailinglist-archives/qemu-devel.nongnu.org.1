Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9447B7B9D1B
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:58:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNvb-0007DN-Q6; Thu, 05 Oct 2023 08:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoNvZ-0007DE-Q7
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:06 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoNvX-0007Zv-QT
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB8E3218FC;
 Thu,  5 Oct 2023 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696510681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5EIz57xAdaOquTcPFcaKrMp2hKnY7zytYFq7qJ1w5ek=;
 b=JTuPtDfn0B+CZ2AVNJwFhGg96Yc0pdn8HroWcoewLzXLVOnTRIMVhzaPWtLDMjMt1e23zQ
 ftAheFCBXfVO2wBAQrPxKYsAUD+epsJutk8sx5FjTzBeL0qe1H1uw1iv/MHuhOyX3/UxhF
 GCizeXYDxDw5qN5x3CsE1CBiM3vE/uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696510681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5EIz57xAdaOquTcPFcaKrMp2hKnY7zytYFq7qJ1w5ek=;
 b=+pgVmujP4iL+FdAr69ZCEkkCxxl9WT+29dVMERqzJ5zbYag5k3Swd6J+Hys4xDNifh0bEg
 jPJrgFIWHoSfp0Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E68813438;
 Thu,  5 Oct 2023 12:58:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4Dj+BtmyHmX/eQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 05 Oct 2023 12:58:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 03/10] migration: Refactor error handling in source
 return path
In-Reply-To: <20231004220240.167175-4-peterx@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-4-peterx@redhat.com>
Date: Thu, 05 Oct 2023 09:57:58 -0300
Message-ID: <87il7lfcq1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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

> @@ -1882,48 +1870,46 @@ static void *source_return_path_thread(void *opaque)
>      uint32_t tmp32, sibling_error;
>      ram_addr_t start = 0; /* =0 to silence warning */
>      size_t  len = 0, expected_len;
> +    Error *err = NULL;
>      int res;
>  
>      trace_source_return_path_thread_entry();
>      rcu_register_thread();
>  
> -    while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
> +    while (!migrate_has_error(ms) && !qemu_file_get_error(rp) &&
>             migration_is_setup_or_active(ms->state)) {
>          trace_source_return_path_thread_loop_top();
> +
>          header_type = qemu_get_be16(rp);
>          header_len = qemu_get_be16(rp);
>  
>          if (qemu_file_get_error(rp)) {
> -            mark_source_rp_bad(ms);
>              goto out;
>          }

This error will be lost because outside the loop we only check for err.

>  
>          if (header_type >= MIG_RP_MSG_MAX ||
>              header_type == MIG_RP_MSG_INVALID) {
> -            error_report("RP: Received invalid message 0x%04x length 0x%04x",
> -                         header_type, header_len);
> -            mark_source_rp_bad(ms);
> +            error_setg(&err, "Received invalid message 0x%04x length 0x%04x",
> +                       header_type, header_len);
>              goto out;
>          }
>  
>          if ((rp_cmd_args[header_type].len != -1 &&
>              header_len != rp_cmd_args[header_type].len) ||
>              header_len > sizeof(buf)) {
> -            error_report("RP: Received '%s' message (0x%04x) with"
> -                         "incorrect length %d expecting %zu",
> -                         rp_cmd_args[header_type].name, header_type, header_len,
> -                         (size_t)rp_cmd_args[header_type].len);
> -            mark_source_rp_bad(ms);
> +            error_setg(&err, "Received '%s' message (0x%04x) with"
> +                       "incorrect length %d expecting %zu",
> +                       rp_cmd_args[header_type].name, header_type, header_len,
> +                       (size_t)rp_cmd_args[header_type].len);
>              goto out;
>          }
>  
>          /* We know we've got a valid header by this point */
>          res = qemu_get_buffer(rp, buf, header_len);
>          if (res != header_len) {
> -            error_report("RP: Failed reading data for message 0x%04x"
> -                         " read %d expected %d",
> -                         header_type, res, header_len);
> -            mark_source_rp_bad(ms);
> +            error_setg(&err, "Failed reading data for message 0x%04x"
> +                       " read %d expected %d",
> +                       header_type, res, header_len);
>              goto out;
>          }
>  
> @@ -1933,8 +1919,7 @@ static void *source_return_path_thread(void *opaque)
>              sibling_error = ldl_be_p(buf);
>              trace_source_return_path_thread_shut(sibling_error);
>              if (sibling_error) {
> -                error_report("RP: Sibling indicated error %d", sibling_error);
> -                mark_source_rp_bad(ms);
> +                error_setg(&err, "Sibling indicated error %d", sibling_error);
>              }
>              /*
>               * We'll let the main thread deal with closing the RP
> @@ -1952,7 +1937,10 @@ static void *source_return_path_thread(void *opaque)
>          case MIG_RP_MSG_REQ_PAGES:
>              start = ldq_be_p(buf);
>              len = ldl_be_p(buf + 8);
> -            migrate_handle_rp_req_pages(ms, NULL, start, len);
> +            migrate_handle_rp_req_pages(ms, NULL, start, len, &err);
> +            if (err) {
> +                goto out;
> +            }
>              break;
>  
>          case MIG_RP_MSG_REQ_PAGES_ID:
> @@ -1967,32 +1955,32 @@ static void *source_return_path_thread(void *opaque)
>                  expected_len += tmp32;
>              }
>              if (header_len != expected_len) {
> -                error_report("RP: Req_Page_id with length %d expecting %zd",
> -                             header_len, expected_len);
> -                mark_source_rp_bad(ms);
> +                error_setg(&err, "Req_Page_id with length %d expecting %zd",
> +                           header_len, expected_len);
> +                goto out;
> +            }
> +            migrate_handle_rp_req_pages(ms, (char *)&buf[13], start, len,
> +                                        &err);
> +            if (err) {
>                  goto out;
>              }
> -            migrate_handle_rp_req_pages(ms, (char *)&buf[13], start, len);
>              break;
>  
>          case MIG_RP_MSG_RECV_BITMAP:
>              if (header_len < 1) {
> -                error_report("%s: missing block name", __func__);
> -                mark_source_rp_bad(ms);
> +                error_setg(&err, "MIG_RP_MSG_RECV_BITMAP missing block name");
>                  goto out;
>              }
>              /* Format: len (1B) + idstr (<255B). This ends the idstr. */
>              buf[buf[0] + 1] = '\0';
> -            if (migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1))) {
> -                mark_source_rp_bad(ms);
> +            if (migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1), &err)) {
>                  goto out;
>              }
>              break;
>  
>          case MIG_RP_MSG_RESUME_ACK:
>              tmp32 = ldl_be_p(buf);
> -            if (migrate_handle_rp_resume_ack(ms, tmp32)) {
> -                mark_source_rp_bad(ms);
> +            if (migrate_handle_rp_resume_ack(ms, tmp32, &err)) {
>                  goto out;
>              }
>              break;
> @@ -2008,9 +1996,14 @@ static void *source_return_path_thread(void *opaque)
>      }
>  
>  out:
> -    if (qemu_file_get_error(rp)) {
> +    if (err) {

Need to keep both checks here.

> +        /*
> +         * Collect any error in return-path thread and report it to the
> +         * migration state object.
> +         */
> +        migrate_set_error(ms, err);
> +        error_free(err);
>          trace_source_return_path_thread_bad_end();
> -        mark_source_rp_bad(ms);
>      }
>  
>      trace_source_return_path_thread_end();
> @@ -2036,13 +2029,10 @@ static int open_return_path_on_source(MigrationState *ms)
>      return 0;
>  }

