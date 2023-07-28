Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4E76787C
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 00:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPVBn-0000Kr-So; Fri, 28 Jul 2023 17:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPVBm-0000Kh-QJ
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 17:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPVBl-0006rH-BL
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 17:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690580396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVp/7NREXfaWjdQLRdHvNiSkU0DMfyvTjHhUQFyZ7Wc=;
 b=XwV+sq/oxh4kDT/+9XdRGSNs4xoi+cu8+BIeim4n1jWssagLYuwNH+sijnpnHPqcuEk7/4
 IRyNGMUUgtXOImC9eCzVGxnnCIHCzp2zI2s61NGdDcE8qDkjyl28jCPTNME2A/BG91vJCj
 utcE3uSjKDLaQ6KVjF8VZYc58G+hLEw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-OOO-komQPDSHsYzT3hp4Sg-1; Fri, 28 Jul 2023 17:39:54 -0400
X-MC-Unique: OOO-komQPDSHsYzT3hp4Sg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4054266d0beso5591871cf.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 14:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690580393; x=1691185193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVp/7NREXfaWjdQLRdHvNiSkU0DMfyvTjHhUQFyZ7Wc=;
 b=inJLH1HfQo8H0qdhYSo8+w09waJhrb69Q2gy3TtgXKasnijiHGxvYnxfN2ecqCSn1/
 3QFeDC59mngakp7I+Dsj89sa2pYW7Qan5HUxDkLkzM9dm6siB/DGjOUBrpYz4SmT9z+n
 Zgy53+U8cAEUBCBcckHDxps1Tgl3myqhPQNDaKYrIXeOj6o8/BPebEsvcGRnm/2gNiXz
 eumYstUGliDRBDqCLlbMo3AOOCMecrnmMxKNsA0aajRVK2JjFyO82zDeMb17dTmTkPga
 9dneg31mJkrChchdYcTCyCk+G0tETmLBhhbdNnZm/dz6uEF5bPoupwUINBIqtPfEi8Tw
 8TkA==
X-Gm-Message-State: ABy/qLYCiE/uxk2rPF82qFFLEZE25m/Lb4rMatWJLuEXLuZV+TU4vhkW
 3H/qVaZ3JIHoASuY7iRPbzurUZmn7yX6uQUvoJn9jWZniMAgXChz9HH+7emqmVsXa5eCfHq6hTX
 JDStgOfq+ODLNX1o=
X-Received: by 2002:a05:622a:19a4:b0:405:379e:c78d with SMTP id
 u36-20020a05622a19a400b00405379ec78dmr890415qtc.3.1690580393474; 
 Fri, 28 Jul 2023 14:39:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHtH6Hlea1xIoXI8FUne6bliofq+MoPsD0ygTYLlGLXLMOHLE0DhZU3Zq9cNWCAb7Ui3LQ5Gg==
X-Received: by 2002:a05:622a:19a4:b0:405:379e:c78d with SMTP id
 u36-20020a05622a19a400b00405379ec78dmr890404qtc.3.1690580393220; 
 Fri, 28 Jul 2023 14:39:53 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z24-20020ac84558000000b003f872332a9asm1432188qtn.64.2023.07.28.14.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 14:39:52 -0700 (PDT)
Date: Fri, 28 Jul 2023 17:39:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/3] migration: Simplify calling of
 await_return_path_close_on_source
Message-ID: <ZMQ1ppAIJVbk8ZBg@x1n>
References: <20230728121516.16258-1-farosas@suse.de>
 <20230728121516.16258-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728121516.16258-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jul 28, 2023 at 09:15:15AM -0300, Fabiano Rosas wrote:
> We're about to reuse this function so move the 'rp_thread_created'
> check into it and remove the redundant tracing and comment.
> 
> Add a new tracepoint akin to what is already done at
> migration_completion().
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c  | 21 +++++++--------------
>  migration/trace-events |  3 +--
>  2 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 051067f8c5..d6f4470265 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2038,6 +2038,10 @@ static int open_return_path_on_source(MigrationState *ms,
>  /* Returns 0 if the RP was ok, otherwise there was an error on the RP */
>  static int await_return_path_close_on_source(MigrationState *ms)
>  {
> +    if (!ms->rp_state.rp_thread_created) {
> +        return 0;
> +    }
> +
>      /*
>       * If this is a normal exit then the destination will send a SHUT and the
>       * rp_thread will exit, however if there's an error we need to cause
> @@ -2350,20 +2354,9 @@ static void migration_completion(MigrationState *s)
>          goto fail;
>      }
>  
> -    /*
> -     * If rp was opened we must clean up the thread before
> -     * cleaning everything else up (since if there are no failures
> -     * it will wait for the destination to send it's status in
> -     * a SHUT command).
> -     */
> -    if (s->rp_state.rp_thread_created) {
> -        int rp_error;
> -        trace_migration_return_path_end_before();
> -        rp_error = await_return_path_close_on_source(s);
> -        trace_migration_return_path_end_after(rp_error);
> -        if (rp_error) {
> -            goto fail;
> -        }
> +    if (await_return_path_close_on_source(s)) {
> +        trace_migration_completion_rp_err();
> +        goto fail;
>      }
>  
>      if (qemu_file_get_error(s->to_dst_file)) {
> diff --git a/migration/trace-events b/migration/trace-events
> index 5259c1044b..33a69064ca 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -157,13 +157,12 @@ migrate_pending_estimate(uint64_t size, uint64_t pre, uint64_t post) "estimate p
>  migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
>  migrate_send_rp_recv_bitmap(char *name, int64_t size) "block '%s' size 0x%"PRIi64
>  migration_completion_file_err(void) ""
> +migration_completion_rp_err(void) ""
>  migration_completion_vm_stop(int ret) "ret %d"
>  migration_completion_postcopy_end(void) ""
>  migration_completion_postcopy_end_after_complete(void) ""
>  migration_rate_limit_pre(int ms) "%d ms"
>  migration_rate_limit_post(int urgent) "urgent: %d"
> -migration_return_path_end_before(void) ""
> -migration_return_path_end_after(int rp_error) "%d"
>  migration_thread_after_loop(void) ""
>  migration_thread_file_err(void) ""
>  migration_thread_setup_complete(void) ""
> -- 
> 2.35.3
> 

Just in case someone may still want to see the old
trace_migration_return_path_end_before() tracepoint, maybe just move them
all over?

-- 
Peter Xu


