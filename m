Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFD87E2811
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:04:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r018G-0006dC-82; Mon, 06 Nov 2023 10:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r018D-0006cs-Va
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:03:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r018B-0006NK-KD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699282990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUbh50SagS+irDOIyXunkzTwSUQKFpveICtH6EqFHWU=;
 b=ALn4po6grhYp0e51t4gqDN4zxDCOsTa/SQ3m9lnyqNZAmQtGklfHhk9YIhoL8cdpO9HUOv
 D9afEPgIP8aTUJc4z1Olxmuo8k350t0+plHjf1+gMpy2mIACVqxLrGjkBz1Sx2Z0ZUcJo2
 1Js+r68osdKZ8VKZRbS+c+tWbAzm15w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-5sPaX7YiMJu8-7f9dZK4Yw-1; Mon, 06 Nov 2023 10:02:56 -0500
X-MC-Unique: 5sPaX7YiMJu8-7f9dZK4Yw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408374a3d6bso28680545e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699282975; x=1699887775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUbh50SagS+irDOIyXunkzTwSUQKFpveICtH6EqFHWU=;
 b=nAeyKAGo9nPsZUCvALeueJCRYAari1D/L2HPnDESKv+pIoPRgMijSRt6X4X1MUlHux
 BOoSZUGIZpATuA3Bashd2R/TDDNJbP0OYYIvXUlfgLxpBk1lzUIKb/KJ0JkEOyI9rPib
 AGuYwtgXgnkvOtzt6wQHfYOyuRh1MmvgvPRwuC0+vp2Swv1QdaJF1WQn6Xohpd3ERSUg
 43pMn+VvhmGokqr2qDumZDv73ddJP4rYIyPH5beWyWCda/n2N1mhxXwlaftLDKmwGIdV
 qUJylnXoii2veznSjh6VGF/jzRtPMWfXZVZxq5ioo/T9s9h3gVKPHiinmYWAHupMu3cF
 15yA==
X-Gm-Message-State: AOJu0Yy5/Vj24RY2IjqtYbcwVuhVqw/RyxFSwT1HN3ISAJ1qqrshZlS7
 s5BNIIVgMVAXbV+yAmtOCdu8x8l1hQTNR4oAyeF4tZAdcdpuVEQTasxgkTd35V8Ns4tocZ45/vl
 dM29Ke0SOwcrbCnU=
X-Received: by 2002:a5d:47ab:0:b0:32f:8254:c97c with SMTP id
 11-20020a5d47ab000000b0032f8254c97cmr21313137wrb.36.1699282974935; 
 Mon, 06 Nov 2023 07:02:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO2j1TIAhN5U5FM5JihG5OAdp0HMPCULs3qveZgEVnKPAaf0SdFuvvvXcsDF0+3xbPSB/nLw==
X-Received: by 2002:a5d:47ab:0:b0:32f:8254:c97c with SMTP id
 11-20020a5d47ab000000b0032f8254c97cmr21313115wrb.36.1699282974636; 
 Mon, 06 Nov 2023 07:02:54 -0800 (PST)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a5d6644000000b0032da49e18fasm9715361wrw.23.2023.11.06.07.02.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:02:54 -0800 (PST)
Message-ID: <b1f840cc-82c7-4ff5-8ab8-38382e425181@redhat.com>
Date: Mon, 6 Nov 2023 16:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] block: Convert qmp_query_block() to coroutine_fn
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Jo=C3=A3o_Silva?=
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-10-farosas@suse.de>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230609201910.12100-10-farosas@suse.de>
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
> This is another caller of bdrv_get_allocated_file_size() that needs to
> be converted to a coroutine because that function will be made
> asynchronous when called (indirectly) from the QMP dispatcher.
>
> This QMP command is a candidate because it calls bdrv_do_query_node_info(),
> which in turn calls bdrv_get_allocated_file_size().
>
> We've determined bdrv_do_query_node_info() to be coroutine-safe (see
> previous commits), so we can just put this QMP command in a coroutine.
>
> Since qmp_query_block() now expects to run in a coroutine, its callers
> need to be converted as well. Convert hmp_info_block(), which calls
> only coroutine-safe code, including qmp_query_named_block_nodes()
> which has been converted to coroutine in the previous patches.
>
> Now that all callers of bdrv_[co_]block_device_info() are using the
> coroutine version, a few things happen:
>
>   - we can return to using bdrv_block_device_info() without a wrapper;
>
>   - bdrv_get_allocated_file_size() can stop being mixed;
>
>   - bdrv_co_get_allocated_file_size() needs to be put under the graph
>     lock because it is being called wthout the wrapper;
>
>   - bdrv_do_query_node_info() doesn't need to acquire the AioContext
>     because it doesn't call aio_poll anymore;
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   block.c                        |  2 +-
>   block/monitor/block-hmp-cmds.c |  2 +-
>   block/qapi.c                   | 18 +++++++++---------
>   hmp-commands-info.hx           |  1 +
>   include/block/block-hmp-cmds.h |  2 +-
>   include/block/block-io.h       |  2 +-
>   include/block/qapi.h           | 12 ++++--------
>   qapi/block-core.json           |  2 +-
>   8 files changed, 19 insertions(+), 22 deletions(-)

After this series has been sent, we got some usages of 
GRAPH_RDLOCK_GUARD_MAINLOOP() that no longer fit with this patch – I’ve 
also mentioned one case on patch 7, not yet realizing that this was a 
new thing.  Those must now be fixed (e.g. in qmp_query_block(), or in 
bdrv_snapshot_list()), or they’ll crash.

Hanna


