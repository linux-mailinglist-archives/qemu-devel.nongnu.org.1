Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4207E232A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:09:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzzKO-0001Pl-Ne; Mon, 06 Nov 2023 08:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qzzKM-0001Mg-Am
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qzzKK-0006gR-Aj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699276055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnknmNBycGCZXj2lzFU1B1Wrbkkt2hbfKppQqLEXFbg=;
 b=SSpUEQjNIVnE3lyp+jut0dfagLOvuTqCL87FJklKRMwtzYwHtB/N8dEG46s4tR6MQIk7kZ
 NK1Ty0I5YU4Ww8MbuRJXCWYj0fO9tRiQv0qHsOSi0sHVrgiTX3WvtM/ZKCEzr5orSmUhic
 AThuGXQMvK0yCL5AZaiiD2RTducZCpg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-wE5GN6m-Pv2rWwQTZ1iS8Q-1; Mon, 06 Nov 2023 08:07:32 -0500
X-MC-Unique: wE5GN6m-Pv2rWwQTZ1iS8Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-408f9cee5e8so28174075e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 05:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699276051; x=1699880851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WnknmNBycGCZXj2lzFU1B1Wrbkkt2hbfKppQqLEXFbg=;
 b=e6aimHU9zVy9teMD2NSij4Sb+KRGNyqnZWJ3E25/QOP9oqePO2HIXS8ljEP6fRV+WQ
 h8V9+J1L6c7ehb8JaXnlpYrQVs+fbep44cAyEIYRGEffKgkFzMktZr/cJ3gGOy3APqhv
 0WDxStlN5qdQv5MztXyEsH2H+996bWqSSC2LExcliO3Bi5L2QC163BtKQ3KBTSTb3xAJ
 JeYZcAGr611tb2+f4seEUT4QfPzvn+BmkQ0UZOPKDg9v4SbTYfg8GJR2+UNcGKqMN+R+
 Eljc3+g5H8A6bOLU/hyBDyT8Q5nPalTM10UhcRtjRquNKimXhC1MdWjCPnt64tRqaIb3
 tioQ==
X-Gm-Message-State: AOJu0YxU1rCn89sddMk2NWr+VX7lu7m7czrCdE1YjPawbZqYOBfJCWdC
 xMHcCWMxluXHwFcPBk/qs/RGEIqxpA45nxoMihnNAQXjUj2RzhTE01ZzViAcPbKhUdmbcmSMiG5
 01UEH7/eyqpr/Bkw=
X-Received: by 2002:a05:6000:184e:b0:32f:7b14:89d9 with SMTP id
 c14-20020a056000184e00b0032f7b1489d9mr26425610wri.9.1699276051054; 
 Mon, 06 Nov 2023 05:07:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1cY/XObAUzSPZJWPjKq8BDe/ImfrRY+TodKHMk5MbEehPgCu8qeWf7JfuM8s7d2tkLD8Dtg==
X-Received: by 2002:a05:6000:184e:b0:32f:7b14:89d9 with SMTP id
 c14-20020a056000184e00b0032f7b1489d9mr26425585wri.9.1699276050712; 
 Mon, 06 Nov 2023 05:07:30 -0800 (PST)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a5d6a88000000b0032fbd0c7d04sm8385288wru.55.2023.11.06.05.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 05:07:30 -0800 (PST)
Message-ID: <8c00b1f8-dd80-481f-9474-9514c40cd5fe@redhat.com>
Date: Mon, 6 Nov 2023 14:07:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] block: Don't query all block devices at
 hmp_nbd_server_start
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Jo=C3=A3o_Silva?=
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-9-farosas@suse.de>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230609201910.12100-9-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

On 09.06.23 22:19, Fabiano Rosas wrote:
> We're currently doing a full query-block just to enumerate the devices
> for qmp_nbd_server_add and then discarding the BlockInfoList
> afterwards. Alter hmp_nbd_server_start to instead iterate explicitly
> over the block_backends list.
>
> This allows the removal of the dependency on qmp_query_block from
> hmp_nbd_server_start. This is desirable because we're about to move
> qmp_query_block into a coroutine and don't need to change the NBD code
> at the same time.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   block/monitor/block-hmp-cmds.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index ca2599de44..26116fe831 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -394,7 +394,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
>       bool writable = qdict_get_try_bool(qdict, "writable", false);
>       bool all = qdict_get_try_bool(qdict, "all", false);
>       Error *local_err = NULL;
> -    BlockInfoList *block_list, *info;
> +    BlockBackend *blk;
>       SocketAddress *addr;
>       NbdServerAddOptions export;
>   
> @@ -419,18 +419,24 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
>           return;
>       }
>   
> -    /* Then try adding all block devices.  If one fails, close all and
> +    /*
> +     * Then try adding all block devices.  If one fails, close all and
>        * exit.
>        */
> -    block_list = qmp_query_block(NULL);
> +    for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
> +        BlockDriverState *bs = blk_bs(blk);
>   
> -    for (info = block_list; info; info = info->next) {
> -        if (!info->value->inserted) {
> +        if (!*blk_name(blk) && !blk_get_attached_dev(blk)) {

I’d like a comment here that historically, we’ve used qmp_query_block() 
here, and this is the same condition that it uses.  (Otherwise, it’s 
hard to see why it matters whether a device is attached or not.)

> +            continue;
> +        }
> +
> +        bs = bdrv_skip_implicit_filters(bs);
> +        if (!bs || !bs->drv) {

Same here.  Just checking blk_is_inserted() would make more sense in 
this place, but if you want to absolutely keep behavior unchanged, then 
there should be a comment here why this check is done (because 
bdrv_query_info() does it to determine whether info->inserted should be 
set, which was historically used to determine whether this BlockBackend 
can be exported).

>               continue;
>           }
>   
>           export = (NbdServerAddOptions) {
> -            .device         = info->value->device,
> +            .device         = g_strdup(blk_name(blk)),

Do we need to g_strdup() here?  We didn’t before, so I think this will 
leak export.device.

I know bdrv_query_info() uses g_strdup(), but that was released by the 
qapi_free_BlockInfoList() below, which is now removed without replacement.

(On that note, it also looks like qmp_nbd_server_add() can leak 
arg->name (i.e. device.name) if it is not set by the caller.  It also 
uses g_strdup() there, but never frees it.  It does free the export_opts 
it creates, and `arg` is put into it, but as a deep copy, so anything in 
`arg` is leaked.)

Hanna

>               .has_writable   = true,
>               .writable       = writable,
>           };
> @@ -443,8 +449,6 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
>           }
>       }
>   
> -    qapi_free_BlockInfoList(block_list);
> -
>   exit:
>       hmp_handle_error(mon, local_err);
>   }


