Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5912716496
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:43:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40Xq-0003Qk-OS; Tue, 30 May 2023 10:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q40XU-0002rF-Sa
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q40XM-0005tF-MB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685457682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+QVtSukdWMJFWJbQHDk1BfUiTNQh6fR/w5xCGVr0CCg=;
 b=A4hs0jMTqIO6dtXb28Gvl5mlBZYDhncrjKaxZgpK7YjepjWJlcQp5Te/g99DN2/1Ubp7WH
 4xHipvUVNMtZbya0DJraFTA5cJ6yUcYcZvgPGHytSRS0jTRiWVaCoHOH+hzDB7eh+YR1yL
 0y5GDeovu7QA4LW4v93C8ZB0ZX9xIwQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-Uxdgp1YkOoqNwLBWq_tHlw-1; Tue, 30 May 2023 10:41:20 -0400
X-MC-Unique: Uxdgp1YkOoqNwLBWq_tHlw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75cb47e5507so9682585a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685457680; x=1688049680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QVtSukdWMJFWJbQHDk1BfUiTNQh6fR/w5xCGVr0CCg=;
 b=O720TwD9PVJ0JN2GnZS12KCN2rmM1CvHpvW6YbgTlnVevAgpeaN8281AjSW4sF9cL0
 7vDeXuvagZcBnVJXIybn6HfXjoLsFn5vrgsyILmGp02Tc+Aivsc2GiU6ZMhh4XvNnRaN
 Vll+JspzJTscsYZsSScdU8snqPOV/oaAJjFnaiw7XchwBba3o12OqlDBPuN8uUWBUH5w
 bhVuPdB4L/QfozN46MLnXdXMhN53csWk28tpnLdjChlnZ5OllxXEyvhkRJCri4/QWpKQ
 qk/O1RJIkVt69ljxtcPWeaUW1+KO0nnhDfsHGeg8fUlFGOMa//Y8ZR7ST7MJaeYUBGcl
 tyYA==
X-Gm-Message-State: AC+VfDy7z70XnD6Xrdur6DLIuffAL+mTKkrE0nDI2Cnc+eld9jSV6B24
 LtxPRgzYzywdZ0NrUEe2NvF+2N931Tx8HRVDMgzkn6GU5tFsAIKd0cYePwUBxE/wGIBZpriwdt2
 dOpjZyP7Lu2mR6sY=
X-Received: by 2002:a05:620a:2b9a:b0:75b:23a1:82a3 with SMTP id
 dz26-20020a05620a2b9a00b0075b23a182a3mr2149519qkb.4.1685457680267; 
 Tue, 30 May 2023 07:41:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OsD/YiZrfAtE/BuL5nbN69HPi+LIotc1NklF0tbSEJzNqsCwIJsLAuuRUe2z5H0sVoKAvYA==
X-Received: by 2002:a05:620a:2b9a:b0:75b:23a1:82a3 with SMTP id
 dz26-20020a05620a2b9a00b0075b23a182a3mr2149507qkb.4.1685457679919; 
 Tue, 30 May 2023 07:41:19 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 y15-20020a37e30f000000b00759273c10eesm4129042qki.33.2023.05.30.07.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 07:41:18 -0700 (PDT)
Date: Tue, 30 May 2023 10:41:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: quintela@redhat.com, lei4.wang@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] qtest/migration-tests.c: use "-incoming defer"
 for postcopy tests
Message-ID: <ZHYLDSZiP+BQXv6K@x1n>
References: <20230530090259.189462-1-wei.w.wang@intel.com>
 <20230530090259.189462-3-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530090259.189462-3-wei.w.wang@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, May 30, 2023 at 05:02:59PM +0800, Wei Wang wrote:
> The Postcopy preempt capability requires to be set before incoming
> starts, so change the postcopy tests to start with deferred incoming and
> call migrate-incoming after the cap has been set.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Hmm.. so we used to do socket_start_incoming_migration_internal() before
setting the right num for the preempt test, then I'm curious why it wasn't
failing before this patch when trying to connect with the preempt channel..

Wei, do you know?

> ---
>  tests/qtest/migration-test.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index b99b49a314..31ce3d959c 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1158,10 +1158,11 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>                                      QTestState **to_ptr,
>                                      MigrateCommon *args)
>  {
> -    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +    g_autofree char *uri = NULL;
>      QTestState *from, *to;
> +    QDict *rsp;
>  
> -    if (test_migrate_start(&from, &to, uri, &args->start)) {
> +    if (test_migrate_start(&from, &to, "defer", &args->start)) {
>          return -1;
>      }
>  
> @@ -1180,9 +1181,14 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>  
>      migrate_ensure_non_converge(from);
>  
> +    rsp = wait_command(to, "{ 'execute': 'migrate-incoming',"
> +                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
> +    qobject_unref(rsp);
> +
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> +    uri = migrate_get_socket_address(to, "socket-address");
>      migrate_qmp(from, uri, "{}");
>  
>      wait_for_migration_pass(from);
> -- 
> 2.27.0
> 

-- 
Peter Xu


