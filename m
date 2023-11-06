Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B61E7E2637
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:59:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r007J-0007qZ-4P; Mon, 06 Nov 2023 08:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0075-0007k5-4Z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:57:59 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r006n-0008Mx-O4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:57:58 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5435336ab0bso7677300a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 05:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699279050; x=1699883850; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8juuqB3KQv3MX4EVmuDwH3ry2+ZPqxR4k5vcIJitXfk=;
 b=rsheXHDSktvjQZVs8rU+Na0n3tUomg9T+vaskkulc6spCEirE3YIZsX1SvBDfXfTMn
 149fJIttt7WEZ6mGx1Qzx/XkTVnuuYJswZeOFIxu2DI9/6utbd8LmGo/sakuZRdlS9pM
 RZWQI4+aoj8//1NAzMA2yY6sg+XHNY/v05zMD0G4bIdZFOGCDnW50Zkfkdkq7ru6PFsQ
 CMVbV8LbbuM2iVO4iu6W9lzrTe2DkIlKm0Polr0Y5G2Aw/BF5EDigbz/e4RLoxzvSNN2
 RjlYnDpIzy0udwCIxlILnwnOe3Xc7WVuZM+twTq0cDTjGNSDh58GKiWvbCCX/Tr8lDj+
 QD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699279050; x=1699883850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8juuqB3KQv3MX4EVmuDwH3ry2+ZPqxR4k5vcIJitXfk=;
 b=P9COYP/Y1yUjZYnFhKZuTu4gEUMl1XOoAVv8LAsL8DeyBwYFuIeqj/GrydVViMfYYY
 EY6ZnOB+CvmuMrdFkHpk+p+fQZGuEXEjIykVmay2mAnmCMVlb9OD/gk7gzstzy0d9A9L
 Eh3SbK/rhRzvNQvaftk1nhjeooJmjFk+5yMKpgjrGRr6C5vUuietluIje1hedNIrAeJr
 zh3dfSZHL5/d98SXgfud38MMFkLK1bZkZMLKj9F4v1xhSdgZra4Xh0Y/6wIfuNCRYTSR
 ToMQXE93jU1W2ll9Owi5YB+FRGtemMPcMah1qePfGk2KHxl0pi+2O0nKLcNHZENbAw40
 foYg==
X-Gm-Message-State: AOJu0Ywp7lpFONYaTLKpfcjtgfI5+jj9eC17dDAHnVBwsHbVDhrlVyzS
 EESSk4XkBfOpvn4ub1YQhhvKgQli/iNskwB/VCDG2g==
X-Google-Smtp-Source: AGHT+IHtHYhRt1OPCbQHj5Rub0Usz+e4PhiQBMA05xnAG/LlEuul6nlqIo0kvmQJJa8fHhXPivjuabmHcexHoLuDtyw=
X-Received: by 2002:a50:e70f:0:b0:53e:6da7:72ba with SMTP id
 a15-20020a50e70f000000b0053e6da772bamr24584906edn.38.1699279050337; Mon, 06
 Nov 2023 05:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20231102114054.44360-1-quintela@redhat.com>
 <20231102114054.44360-39-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-39-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2023 13:57:19 +0000
Message-ID: <CAFEAcA90R-Yg-LrMmbotCQDMPGPrOi6dN1ZyC0ufBziPREzyyA@mail.gmail.com>
Subject: Re: [PULL 38/40] migration: Implement MigrateChannelList to qmp
 migration flow.
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, John Snow <jsnow@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, 
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Het Gala <het.gala@nutanix.com>, 
 Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 2 Nov 2023 at 11:46, Juan Quintela <quintela@redhat.com> wrote:
>
> From: Het Gala <het.gala@nutanix.com>
>
> Integrate MigrateChannelList with all transport backends
> (socket, exec and rdma) for both src and dest migration
> endpoints for qmp migration.
>
> For current series, limit the size of MigrateChannelList
> to single element (single interface) as runtime check.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-ID: <20231023182053.8711-13-farosas@suse.de>

Hi; after this migration pull there seem to be a lot of
new Coverity issues in migration code. Could somebody
take a look at them, please?

Here's one in particular (CID 1523826, 1523828):

> @@ -1927,35 +1933,38 @@ void qmp_migrate(const char *uri, bool has_channels,
>      bool resume_requested;
>      Error *local_err = NULL;
>      MigrationState *s = migrate_get_current();
> -    g_autoptr(MigrationAddress) channel = NULL;
> +    MigrationChannel *channel = NULL;
> +    MigrationAddress *addr = NULL;

'channel' in this function used to be auto-freed, but now it is not...

>
>      /*
>       * Having preliminary checks for uri and channel
>       */
> -    if (has_channels) {
> -        error_setg(errp, "'channels' argument should not be set yet.");
> -        return;
> -    }
> -
>      if (uri && has_channels) {
>          error_setg(errp, "'uri' and 'channels' arguments are mutually "
>                     "exclusive; exactly one of the two should be present in "
>                     "'migrate' qmp command ");
>          return;
> -    }
> -
> -    if (!uri && !has_channels) {
> +    } else if (channels) {
> +        /* To verify that Migrate channel list has only item */
> +        if (channels->next) {
> +            error_setg(errp, "Channel list has more than one entries");
> +            return;
> +        }
> +        channel = channels->value;
> +    } else if (uri) {
> +        /* caller uses the old URI syntax */
> +        if (!migrate_uri_parse(uri, &channel, errp)) {
> +            return;
> +        }

...and here migrate_uri_parse() allocates memory which is
returned into 'channel'...

> +    } else {
>          error_setg(errp, "neither 'uri' or 'channels' argument are "
>                     "specified in 'migrate' qmp command ");
>          return;
>      }
> -
> -    if (!migrate_uri_parse(uri, &channel, errp)) {
> -        return;
> -    }
> +    addr = channel->addr;
>
>      /* transport mechanism not suitable for migration? */
> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
> +    if (!migration_channels_and_transport_compatible(addr, errp)) {
>          return;
>      }
>
> @@ -1972,8 +1981,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>          }
>      }
>
> -    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> -        SocketAddress *saddr = &channel->u.socket;
> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> +        SocketAddress *saddr = &addr->u.socket;
>          if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>              saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>              saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
> @@ -1982,13 +1991,13 @@ void qmp_migrate(const char *uri, bool has_channels,
>              fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
>          }
>  #ifdef CONFIG_RDMA
> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> -        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> +        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
>  #endif
> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> -        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> -        file_start_outgoing_migration(s, &channel->u.file, &local_err);
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> +        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> +        file_start_outgoing_migration(s, &addr->u.file, &local_err);
>      } else {
>          error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
>                     "a valid migration protocol");

...which is leaked because we don't add any code for freeing
channel to compensate for it no longer being autofreed.

thanks
-- PMM

