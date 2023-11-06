Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE57E26CD
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:28:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00ZT-0002ty-FF; Mon, 06 Nov 2023 09:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r00ZM-0002tB-Tu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r00ZK-0006rO-Pu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699280829;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=STw7PPXKTwq/79ZC+zWpWW3I5vyrQnVcv7UcsPJeMxc=;
 b=OL1dOsABnBHXGndW4L0o8cLgjydZ3U9BY556mywhcNLTSGdLyN1YC+REqtn/zh47zO9Xgy
 fQdvv3frTWidBn0WJcb9g/ZMvrlCz4HDlu9rPsFJ++wmkM+BU6ij64B932HZTHZ65n5YQP
 MW/eLRvCDbzqnnTDERaoqo6a9RYzBO4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-HITAUoGxOEOYV6iGJPj-2g-1; Mon, 06 Nov 2023 09:27:08 -0500
X-MC-Unique: HITAUoGxOEOYV6iGJPj-2g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4092164ee4eso28831425e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699280827; x=1699885627;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STw7PPXKTwq/79ZC+zWpWW3I5vyrQnVcv7UcsPJeMxc=;
 b=dgImjB6qsIZ4KlxIOAmPjsg9IBqEsPhkNG9EwBqhlripr5/ZQ11aF7O2Um9ZPWTqoI
 uCaT9LnvlhicINge/I3kfF0a4D8aVed5QWNG7PHBh5rLYzCkHDEYNBDVzsz9Bs9JAdDz
 efhoIXB1O3kBeOQD+lrdEpASvSwLCzjxgbwfCVApWSeKL66eIxqgVT24ZbfO/ba0y4TG
 NhNwzz22Z717b1k1F+BfkC7lVNYziFj70rk+1Z6f9DbeY7vTKiqcS3FLImXhicK5xT9k
 2cGyPKDWTmnxWrEZcYpK3ruVJDZ/beskulh2tGW2f0aEzMhLuFJlR9Jj0v8YFRIjP5bb
 Zfqg==
X-Gm-Message-State: AOJu0YzOUbLRNBqBPVVsQHLoStwi/CpkDieR9HXxa1mM89ITsCJzpzvo
 kraiNBAReLRj/qMUK5bBX2KX3ZFCXuYejWCdT2lcRE7Xs/dKBtY+HU0luhKgcGmn6Qcq+UGVydH
 neVFIMkkGg9+HzxU=
X-Received: by 2002:a05:600c:548f:b0:405:49aa:d578 with SMTP id
 iv15-20020a05600c548f00b0040549aad578mr24013268wmb.37.1699280826905; 
 Mon, 06 Nov 2023 06:27:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ6tU1umroeHZowCDJRsCsoOiwE52FYbt8y0+9ErG/u8D+w4+3yeFKdb4v38uAX3rjfU+L6w==
X-Received: by 2002:a05:600c:548f:b0:405:49aa:d578 with SMTP id
 iv15-20020a05600c548f00b0040549aad578mr24013203wmb.37.1699280826470; 
 Mon, 06 Nov 2023 06:27:06 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004064cd71aa8sm12471303wmo.34.2023.11.06.06.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 06:27:05 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Eric Farman <farman@linux.ibm.com>,  Laurent
 Vivier <lvivier@redhat.com>,  David Gibson <david@gibson.dropbear.id.au>,
 qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>,  Samuel Thibault
 <samuel.thibault@ens-lyon.org>,  qemu-s390x@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Leonardo Bras <leobras@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,  qemu-ppc@nongnu.org,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Halil Pasic <pasic@linux.ibm.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Li
 Zhijian <lizhijian@fujitsu.com>,  Eric Blake <eblake@redhat.com>,  "Denis
 V. Lunev" <den@openvz.org>,  Hanna Reitz <hreitz@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-arm@nongnu.org,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,  Corey Minyard <minyard@acm.org>,  John
 Snow <jsnow@redhat.com>,  Jeff Cody <codyprime@gmail.com>,  Peter Xu
 <peterx@redhat.com>,  Nicholas Piggin <npiggin@gmail.com>,  Harsh Prateek
 Bora <harshpb@linux.ibm.com>,  Jason Wang <jasowang@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Weil
 <sw@weilnetz.de>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Fam Zheng <fam@euphon.net>,
 Het Gala <het.gala@nutanix.com>,  Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>
Subject: Re: [PULL 38/40] migration: Implement MigrateChannelList to qmp
 migration flow.
In-Reply-To: <CAFEAcA90R-Yg-LrMmbotCQDMPGPrOi6dN1ZyC0ufBziPREzyyA@mail.gmail.com>
 (Peter Maydell's message of "Mon, 6 Nov 2023 13:57:19 +0000")
References: <20231102114054.44360-1-quintela@redhat.com>
 <20231102114054.44360-39-quintela@redhat.com>
 <CAFEAcA90R-Yg-LrMmbotCQDMPGPrOi6dN1ZyC0ufBziPREzyyA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 06 Nov 2023 15:27:05 +0100
Message-ID: <87y1fbyn2e.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Thu, 2 Nov 2023 at 11:46, Juan Quintela <quintela@redhat.com> wrote:
>>
>> From: Het Gala <het.gala@nutanix.com>
>>
>> Integrate MigrateChannelList with all transport backends
>> (socket, exec and rdma) for both src and dest migration
>> endpoints for qmp migration.
>>
>> For current series, limit the size of MigrateChannelList
>> to single element (single interface) as runtime check.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Message-ID: <20231023182053.8711-13-farosas@suse.de>
>
> Hi; after this migration pull there seem to be a lot of
> new Coverity issues in migration code. Could somebody
> take a look at them, please?


Hi

I received this, looking into it.

Later, Juan.

>
> Here's one in particular (CID 1523826, 1523828):
>
>> @@ -1927,35 +1933,38 @@ void qmp_migrate(const char *uri, bool has_channels,
>>      bool resume_requested;
>>      Error *local_err = NULL;
>>      MigrationState *s = migrate_get_current();
>> -    g_autoptr(MigrationAddress) channel = NULL;
>> +    MigrationChannel *channel = NULL;
>> +    MigrationAddress *addr = NULL;
>
> 'channel' in this function used to be auto-freed, but now it is not...
>
>>
>>      /*
>>       * Having preliminary checks for uri and channel
>>       */
>> -    if (has_channels) {
>> -        error_setg(errp, "'channels' argument should not be set yet.");
>> -        return;
>> -    }
>> -
>>      if (uri && has_channels) {
>>          error_setg(errp, "'uri' and 'channels' arguments are mutually "
>>                     "exclusive; exactly one of the two should be present in "
>>                     "'migrate' qmp command ");
>>          return;
>> -    }
>> -
>> -    if (!uri && !has_channels) {
>> +    } else if (channels) {
>> +        /* To verify that Migrate channel list has only item */
>> +        if (channels->next) {
>> +            error_setg(errp, "Channel list has more than one entries");
>> +            return;
>> +        }
>> +        channel = channels->value;
>> +    } else if (uri) {
>> +        /* caller uses the old URI syntax */
>> +        if (!migrate_uri_parse(uri, &channel, errp)) {
>> +            return;
>> +        }
>
> ...and here migrate_uri_parse() allocates memory which is
> returned into 'channel'...
>
>> +    } else {
>>          error_setg(errp, "neither 'uri' or 'channels' argument are "
>>                     "specified in 'migrate' qmp command ");
>>          return;
>>      }
>> -
>> -    if (!migrate_uri_parse(uri, &channel, errp)) {
>> -        return;
>> -    }
>> +    addr = channel->addr;
>>
>>      /* transport mechanism not suitable for migration? */
>> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
>> +    if (!migration_channels_and_transport_compatible(addr, errp)) {
>>          return;
>>      }
>>
>> @@ -1972,8 +1981,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>>          }
>>      }
>>
>> -    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>> -        SocketAddress *saddr = &channel->u.socket;
>> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>> +        SocketAddress *saddr = &addr->u.socket;
>>          if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>>              saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>>              saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
>> @@ -1982,13 +1991,13 @@ void qmp_migrate(const char *uri, bool has_channels,
>>              fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
>>          }
>>  #ifdef CONFIG_RDMA
>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>> -        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>> +        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
>>  #endif
>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>> -        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_FILE) {
>> -        file_start_outgoing_migration(s, &channel->u.file, &local_err);
>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>> +        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
>> +        file_start_outgoing_migration(s, &addr->u.file, &local_err);
>>      } else {
>>          error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
>>                     "a valid migration protocol");
>
> ...which is leaked because we don't add any code for freeing
> channel to compensate for it no longer being autofreed.
>
> thanks
> -- PMM


