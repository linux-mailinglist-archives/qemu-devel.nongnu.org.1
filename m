Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 196857FF841
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 18:31:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8kr5-0001Cw-Hm; Thu, 30 Nov 2023 12:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8kr3-0001CJ-Gf
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:29:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8kr0-000070-WF
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701365371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2syQazUixQ9MRGEWciltuCA7KgWyHKWfewPM6ZmXPj4=;
 b=FKy2OEeW07soO3UiJFW9yoi28Nis8iIpEq3mT7OfuRwU7BJ/r+ay4PTIQG5AjAcS0KskVb
 GtSnEaHFM9wDm66vDylGieCay9b1ZjKcOzXr5/p4ZD8bT6zFvLE1yxMRicCRt7dqXdI2Gg
 NXl1ryYrEXP3zp8ms5tKlYQx1ApGXO8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-EXgM-7hFNaCgS-a7ZUKmAA-1; Thu, 30 Nov 2023 12:29:29 -0500
X-MC-Unique: EXgM-7hFNaCgS-a7ZUKmAA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77d98b1df76so26833085a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 09:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701365369; x=1701970169;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2syQazUixQ9MRGEWciltuCA7KgWyHKWfewPM6ZmXPj4=;
 b=jluvqXgKP7oGLGqwz7a6aDaeNy+lZBPEXgWpgEcsy1myyyB9MfmCK9RHGay8AWFGm4
 y4FyCJlh/o8xiLO0rnDnWRXLnD64oVtUm7HGTpMbIVjzl/xzklzMa5TTMlCA2V2a//FR
 ViBe3pzEHCUiToLUXbm5++otwnjDO0RECPBDhfbUqoGkQiPGGCb4/cKtGlFYnExRWSJm
 CMXLwLfCWLmcp0xB7V/fW6XxGUeMu+GAdCzTDgxY6B+W0br/M6cWUNEcD+vQXeami3dG
 xQi+WbK5ui8ysxoiG2RUyucV8fNTG9OUzNumFmIvEGwfNuP4D1lRAkuuZpFItBSQZhBk
 Qjmw==
X-Gm-Message-State: AOJu0YwthaZwTq59LUDgpHfyR1JVSRIFjHvf4OZB36OZWR9Q3RXt5FI3
 I4xhltUvxWpEq1RaPef3X+NtI2ICX+yd/PclaDrno4W9NSvl5qoCMa0u+6EePVJB9HelTJkhLMz
 AJhyf7U70HeYS380=
X-Received: by 2002:a05:620a:372a:b0:77d:8c81:ea2d with SMTP id
 de42-20020a05620a372a00b0077d8c81ea2dmr21566926qkb.0.1701365369326; 
 Thu, 30 Nov 2023 09:29:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESWKFJ/OpUIBL90CSTO4eJGiNWnzSnSXO4MNLlkZqCXfDQoSszoBxeAs5QXzVH5OgQwpRC5A==
X-Received: by 2002:a05:620a:372a:b0:77d:8c81:ea2d with SMTP id
 de42-20020a05620a372a00b0077d8c81ea2dmr21566913qkb.0.1701365369033; 
 Thu, 30 Nov 2023 09:29:29 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 e15-20020a37ac0f000000b007659935ce64sm673442qkm.71.2023.11.30.09.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 09:29:28 -0800 (PST)
Date: Thu, 30 Nov 2023 12:29:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, farosas@suse.de,
 armbru@redhat.com
Subject: Re: [PATCH v4] migration: Plug memory leak with migration URIs
Message-ID: <ZWjGdg-gic-C1PA_@x1n>
References: <20231129204301.131228-1-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129204301.131228-1-het.gala@nutanix.com>
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

On Wed, Nov 29, 2023 at 08:43:01PM +0000, Het Gala wrote:
> migrate_uri_parse() allocates memory to 'channel' if the user
> opts for old syntax - uri, which is leaked because there is no
> code for freeing 'channel'.
> So, free channel to avoid memory leak in case where 'channels'
> is empty and uri parsing is required.
> 
> Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp migration flow")
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> @@ -533,18 +533,18 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>              error_setg(errp, "Channel list has more than one entries");
>              return;
>          }
> -        channel = channels->value;
> +        addr = channels->value->addr;
>      } else if (uri) {
>          /* caller uses the old URI syntax */
>          if (!migrate_uri_parse(uri, &channel, errp)) {
>              return;
>          }
> +        addr = channel->addr;
>      } else {
>          error_setg(errp, "neither 'uri' or 'channels' argument are "
>                     "specified in 'migrate-incoming' qmp command ");
>          return;
>      }
> -    addr = channel->addr;

Why these "addr" lines need change?  Won't that behave the same as before?

Thanks,

-- 
Peter Xu


