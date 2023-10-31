Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB917DD4DA
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 18:44:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxsld-00034H-3P; Tue, 31 Oct 2023 13:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsla-00033y-5m
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxslY-0000kE-FL
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698774179;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TKqyrUYCLbFOFuK9Bd63GLJZs5NjPk81M/0q6E4ogBA=;
 b=hBJY3taJ8wfnxB7wfP4hfJeXhz5kaj608RuHC8h6A4W529v+QCV1bpS0ucmBsEZi/IKrWn
 +PWNGnXCqhMcKJQTBqG1rhIpClh1Q/1SwDNJAwE9ZsQxZ48fDHh+c6TQMLN0xEYuIcPSjH
 XZEUobZZ9Err5VbY8Z6zEgFvNZUnebA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-CHWlH_gdM4GuEThNOsGB4w-1; Tue, 31 Oct 2023 13:42:47 -0400
X-MC-Unique: CHWlH_gdM4GuEThNOsGB4w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c515541a25so60342251fa.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 10:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774166; x=1699378966;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKqyrUYCLbFOFuK9Bd63GLJZs5NjPk81M/0q6E4ogBA=;
 b=pb7nCHztTZ5ZaSHt7D/OAOqRDavdcNgGnYDhoYgSax4kksv1V9AoPaVz5QybYlVgfJ
 MtCZj1DkrL6W+jR8GwDqdcqaedg2j6lq9ewAur6zltIQhyq3UWPfrBkzqw4QL4l7CCbl
 M7oZjUPsfx6pGZgyt9J9voYHWswBIBflIb408EZ7W27MOnSDtaDAMWSz1SkSL2TSMvS8
 +LCgvEKuqEZmYRJVq8bHi/WEFGeEcS78GAjGl5TKUWPqdebz9Iw+Ofvm3CmRjLBSi7d4
 fn1ggrMODJ9/MxaM4N8y5P8n/6Nj6orLtUptynFnjqP6oD9jwW8/pWu+0BqlaeugTA3h
 ZeqA==
X-Gm-Message-State: AOJu0YxgJjrUue9/YABLuc5QE9SYD9RHvs4s8HjThmz9QZXH2q0vuIeX
 UnAhmwQSRYmtqprnJQeG+PAhFP++vVhqZWEEsxgHTwhWRJRxQq+wa1PTv+uZ5GoeNWw1lxxsPsS
 SySDBNCG6NLXNREQ=
X-Received: by 2002:a2e:b711:0:b0:2c5:55a:b6b5 with SMTP id
 j17-20020a2eb711000000b002c5055ab6b5mr11018209ljo.28.1698774166080; 
 Tue, 31 Oct 2023 10:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGthrNa7ln3r8iZ17jWBWS9tkmbo+rQsk+KwDj4AYiFjnhzGcEUaZFdtadPiuoyeYnatJntUg==
X-Received: by 2002:a2e:b711:0:b0:2c5:55a:b6b5 with SMTP id
 j17-20020a2eb711000000b002c5055ab6b5mr11018183ljo.28.1698774165759; 
 Tue, 31 Oct 2023 10:42:45 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 q6-20020a05600c46c600b004063c9f68f2sm2321667wmo.26.2023.10.31.10.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:42:44 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 13/14] migration: Implement MigrateChannelList to
 hmp migration flow.
In-Reply-To: <20231023182053.8711-14-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:52 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-14-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 18:42:43 +0100
Message-ID: <87msvy4rjg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> From: Het Gala <het.gala@nutanix.com>
>
> Integrate MigrateChannelList with all transport backends
> (socket, exec and rdma) for both src and dest migration
> endpoints for hmp migration.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>


>      bool resume = qdict_get_try_bool(qdict, "resume", false);
>      const char *uri = qdict_get_str(qdict, "uri");
>      Error *err = NULL;
> +    MigrationChannelList *caps = NULL;
> +    g_autoptr(MigrationChannel) channel = NULL;
>  
> -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
> +    if (!migrate_uri_parse(uri, &channel, &err)) {
> +        goto end;
> +    }
> +    QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
> +
> +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
>                   false, false, true, resume, &err);


> -    if (hmp_handle_error(mon, err)) {
> -        return;
> -    }

I think that dropping this chunk is wrong.  What assures that
qmp_migrate will not give an error?

> +    qapi_free_MigrationChannelList(caps);





>  
>      if (!detach) {
>          HMPMigrationStatus *status;
> @@ -766,6 +780,9 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>                                            status);
>          timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
>      }
> +
> +end:
> +    hmp_handle_error(mon, err);


Oh, you put it here, but you enter in the detach case even if there is
one error.

I think it is easier to just repeat the hmp_mhandle_error() inplace of
the goto.

Later, Juan.


