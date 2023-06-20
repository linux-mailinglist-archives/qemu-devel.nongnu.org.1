Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1C736F86
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:59:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcpN-00043Z-GI; Tue, 20 Jun 2023 10:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcpM-00043L-50
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcpK-0003PV-K2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687273165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UZJONrqidLnOTueOvFeGToI3spE8nHde+390MtE+xsE=;
 b=UAJg9sF3u1POgKOkM681X8gUXoOVM1ZagU0Gvcbt7u7rih51u1I56Tb1TGNCImtl9jdmoy
 AGzMriPyrLUKcrUfWVXJPzwh5OucSzeoXy2ri7ZtkLqhO3ImY3mvS+9vj7Nm6CFzACji3z
 zpjV1DRPxQe7mI75qPCmwE37iMy7K+A=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-k6uPm4iXOMK9FTLXcPWAVg-1; Tue, 20 Jun 2023 10:59:23 -0400
X-MC-Unique: k6uPm4iXOMK9FTLXcPWAVg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-43f4bbb836fso84270137.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 07:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687273162; x=1689865162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZJONrqidLnOTueOvFeGToI3spE8nHde+390MtE+xsE=;
 b=TrKp41GhM105Q4KGlaBuvRduJmobdTew0zmWb56494Y3yc//HmzrdImPxcWnbT/iU8
 h0NN43TilOIS9e25qJVxRykO0v0ubRJEVijbPzHXRatzr7abA7iONNAQuGmfAF2+jAmG
 fsTyozZpzXCPPPNVVeO7lKtOTs6YUbDlNaOrbO4H4Uh0kinL0YIraXk4U4w2wchvMZi6
 4DywuoZeprc6fLsnE6FsHssy19/W2JfTlx4uOUpzJGn6rKJBhRmfstlHOeKlgGTok3iT
 7j3arOagd8CRpsFBy1OubTfGYG8uytnTfPW2r3C9aZDS7H2bNTpkWqruuBU4ISpG1YJ7
 NHXA==
X-Gm-Message-State: AC+VfDyaHcDOGSnSOwDv2QTPAWwSl3cIEe1T6s21xRiqgBD49fePFytk
 O5dyD1lRORuS0nOp+R0PKkUrlqnjBLd/UzE8oc7+AwYwtveSdEl85SdwL3qKWy85mTdazmhg6/p
 sAgRPGU+irpokDME=
X-Received: by 2002:a05:6102:3382:b0:440:ab53:9cb3 with SMTP id
 i2-20020a056102338200b00440ab539cb3mr2793879vsh.2.1687273161899; 
 Tue, 20 Jun 2023 07:59:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ77y4Hd1b864T4SBjQaT7p/7IU5fu02Z4Za8aWapXXWs9ZQueSjkl6sI/Ycnph2M9pjOpPMvw==
X-Received: by 2002:a05:6102:3382:b0:440:ab53:9cb3 with SMTP id
 i2-20020a056102338200b00440ab539cb3mr2793861vsh.2.1687273161565; 
 Tue, 20 Jun 2023 07:59:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t8-20020a0ce2c8000000b0062dd56e3821sm1311925qvl.62.2023.06.20.07.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 07:59:21 -0700 (PDT)
Date: Tue, 20 Jun 2023 10:59:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 02/42] migration-test: Make ignore_stderr regular with
 other options
Message-ID: <ZJG+x0iHS46dLqSB@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-3-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 09, 2023 at 12:49:03AM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/qtest/migration-test.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index c5e0c69c6b..73b2f01427 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -602,7 +602,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      g_autofree gchar *arch_target = NULL;
>      g_autofree gchar *cmd_source = NULL;
>      g_autofree gchar *cmd_target = NULL;
> -    const gchar *ignore_stderr;
> +    const gchar *ignore_stderr = NULL;
>      g_autofree char *bootpath = NULL;
>      g_autofree char *shmem_opts = NULL;
>      g_autofree char *shmem_path = NULL;
> @@ -672,10 +672,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>           * IO redirection does not work, so don't bother adding IO redirection
>           * to the command line.
>           */
> -        ignore_stderr = "";

Personally maybe I won't bother with such a patch as a whole.. but if we do
want to, we could also remove "#else" here and move comment above it.

>  #endif
> -    } else {
> -        ignore_stderr = "";
>      }
>  
>      if (args->use_shmem) {
> @@ -701,7 +698,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   memory_size, tmpfs,
>                                   arch_source, shmem_opts,
>                                   args->opts_source ? args->opts_source : "",
> -                                 ignore_stderr);
> +                                 ignore_stderr ? ignore_stderr : "");
> +
>      if (!args->only_target) {
>          *from = qtest_init(cmd_source);
>          qtest_qmp_set_event_callback(*from,
> @@ -722,7 +720,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   memory_size, tmpfs, uri,
>                                   arch_target, shmem_opts,
>                                   args->opts_target ? args->opts_target : "",
> -                                 ignore_stderr);
> +                                 ignore_stderr ? ignore_stderr : "");
>      *to = qtest_init(cmd_target);
>      qtest_qmp_set_event_callback(*to,
>                                   migrate_watch_for_resume,
> -- 
> 2.40.1
> 

-- 
Peter Xu


