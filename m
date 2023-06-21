Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0F737BEB
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBs35-0004I7-I8; Wed, 21 Jun 2023 03:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBs32-0004Hh-Et
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBs2z-0000Ir-Ct
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687331672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IW8QdzLYwMynAAzkJXWqtWmN/YuXAGXnhif2y6LTdZU=;
 b=WZ+he7aIM6x0bDFEX9ElJi0cpaUU6WVYriuFaj6LEd+BBcjRsDNFitPMf4O/MxRR5x6q4B
 8VeGucnVoIk4MyAUiaKWd1BYFZ7stU74jt3kJAn/hd8f7gqI8cENBcu1kW1b1ypT3okw54
 wdkVk0PtEFt3PlzGMTphnwxeM/ooZeo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-l53dtaH2MCqd-f3ClxtPjg-1; Wed, 21 Jun 2023 03:14:31 -0400
X-MC-Unique: l53dtaH2MCqd-f3ClxtPjg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f9b7fdbd95so9465155e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 00:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687331669; x=1689923669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IW8QdzLYwMynAAzkJXWqtWmN/YuXAGXnhif2y6LTdZU=;
 b=ckB8iaH262qviW4MAosNVis4FCyUqj0xd291vqtZxuvKpOwYiBvt9KVZiFXvN++YVD
 797N3k/isTam1h3N8h9PUdJuLx5t6i7bYYdGHU/lB8x8P6Wj+EcLGf9rzblqbMT5SM2g
 DWo3tBVydH/CzSCOgg3TSGv4d1KGC1tD0zi5ElnduxQ+w6nIEASdB8Zinipj0xFEvKB6
 vFAJmnFKQotjBLhIGr5n4RmKZACcNbnL7dCrtm2wOcVO8Gtimn8xPI7laZwapBkJhGw5
 9iiajOfZt4G/tQmb3KtokJHo3z9Sb2VzwXN/0e7wp2nyFajmjXfsHTl1L30DyDgfKQp6
 6pcw==
X-Gm-Message-State: AC+VfDzVixTX6ezDWX6XPp+O8+O/Sz3gImFh5HMkCAvtkXin32YKgDQn
 JEwfRKqCnQjIXfDADz01up6Coj6wvwbRK7f4w3VkiaDcHc1tLg29LA+x8q/0DbiKpWU+re32FGU
 iQxBmjMgfoHBnc1A=
X-Received: by 2002:a05:600c:220b:b0:3f9:b0fe:7e11 with SMTP id
 z11-20020a05600c220b00b003f9b0fe7e11mr5898400wml.28.1687331669147; 
 Wed, 21 Jun 2023 00:14:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7gv88rzDdbJaW3/q51OS1CavjaJTyGThMXNaGBTiHiuYUOEAnw0bEPz5Yq0+nuXF+WxDLi/A==
X-Received: by 2002:a05:600c:220b:b0:3f9:b0fe:7e11 with SMTP id
 z11-20020a05600c220b00b003f9b0fe7e11mr5898369wml.28.1687331668641; 
 Wed, 21 Jun 2023 00:14:28 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f9bd9e3226sm1035695wmi.7.2023.06.21.00.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 00:14:28 -0700 (PDT)
Message-ID: <ae0ed423-ef17-9f6f-e7eb-537e2d53df8c@redhat.com>
Date: Wed, 21 Jun 2023 09:14:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 6/6] migration: Deprecated old compression method
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-7-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230612193344.3796-7-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/06/2023 21.33, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   docs/about/deprecated.rst |  8 ++++
>   qapi/migration.json       | 92 ++++++++++++++++++++++++---------------
>   migration/options.c       | 13 ++++++
>   3 files changed, 79 insertions(+), 34 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 173c5ba5cb..fe7f2bbde8 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -460,3 +460,11 @@ block migration (since 8.1)
>   Block migration is too inflexible.  It needs to migrate all block
>   devices or none.  Use driver_mirror+NBD instead.
>   
> +old compression method (since 8.1)
> +''''''''''''''''''''''''''''''''''
> +
> +Compression method fails too much.  Too many races.  We are going to
> +remove it if nobody fixes it.  For starters, migration-test
> +compression tests are disabled becase they hand randomly.  If you need

"because they fail randomly" ?

> +compression, use multifd compression methods.
> +
> diff --git a/qapi/migration.json b/qapi/migration.json
> index a8497de48d..40a8b5d124 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -244,6 +244,7 @@
>   #
>   # @compression: migration compression statistics, only returned if
>   #     compression feature is on and status is 'active' or 'completed'
> +#     It is obsolete and deprecated.  Use multifd compression methods.
>   #     (Since 3.1)
>   #
>   # @socket-address: Only used for tcp, to know what the real port is
> @@ -261,7 +262,8 @@
>   # Features:
>   #
>   # @deprecated: @disk migration is deprecated.  Use driver_mirror+NBD
> -#     instead.
> +#     instead. @compression is obsolete use multifd compression

Use a dot or comma after "obsolete".

> +#     methods instead.
>   #
>   # Since: 0.14
>   ##
> @@ -279,7 +281,7 @@
>              '*blocked-reasons': ['str'],
>              '*postcopy-blocktime': 'uint32',
>              '*postcopy-vcpu-blocktime': ['uint32'],
> -           '*compression': 'CompressionStats',
> +           '*compression': { 'type': 'CompressionStats', 'features': ['deprecated'] },
>              '*socket-address': ['SocketAddress'] } }
>   
>   ##
> @@ -432,7 +434,8 @@
>   #     compress and xbzrle are both on, compress only takes effect in
>   #     the ram bulk stage, after that, it will be disabled and only
>   #     xbzrle takes effect, this can help to minimize migration
> -#     traffic.  The feature is disabled by default.  (since 2.4 )
> +#     traffic.  The feature is disabled by default.  Obsolete.  Use
> +#     multifd compression methods if needed. (since 2.4 )
>   #
>   # @events: generate events for each migration state change (since 2.4
>   #     )
> @@ -503,6 +506,7 @@
>   # Features:
>   #
>   # @deprecated: @block migration is deprecated.  Use driver_mirror+NBD
> +#     instead. @compress is obsolete use multifd compression methods

dito

>   #     instead.
>   #
>   # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -511,7 +515,8 @@
>   ##
>   { 'enum': 'MigrationCapability',
>     'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> -           'compress', 'events', 'postcopy-ram',
> +           { 'name': 'compress', 'features': [ 'deprecated' ] },
> +           'events', 'postcopy-ram',
>              { 'name': 'x-colo', 'features': [ 'unstable' ] },
>              'release-ram',
>              { 'name': 'block', 'features': [ 'deprecated' ] },
> @@ -671,22 +676,24 @@
>   #     migration, the compression level is an integer between 0 and 9,
>   #     where 0 means no compression, 1 means the best compression
>   #     speed, and 9 means best compression ratio which will consume
> -#     more CPU.
> +#     more CPU. Obsolete, see multifd compression if needed.
>   #
>   # @compress-threads: Set compression thread count to be used in live
>   #     migration, the compression thread count is an integer between 1
> -#     and 255.
> +#     and 255. Obsolete, see multifd compression if needed.
>   #
>   # @compress-wait-thread: Controls behavior when all compression
>   #     threads are currently busy.  If true (default), wait for a free
>   #     compression thread to become available; otherwise, send the page
> -#     uncompressed.  (Since 3.1)
> +#     uncompressed. Obsolete, see multifd compression if
> +#     needed. (Since 3.1)
>   #
>   # @decompress-threads: Set decompression thread count to be used in
>   #     live migration, the decompression thread count is an integer
>   #     between 1 and 255. Usually, decompression is at least 4 times as
>   #     fast as compression, so set the decompress-threads to the number
> -#     about 1/4 of compress-threads is adequate.
> +#     about 1/4 of compress-threads is adequate. Obsolete, see multifd
> +#     compression if needed.
>   #
>   # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
>   #     bytes_xfer_period to trigger throttling.  It is expressed as
> @@ -799,7 +806,9 @@
>   # Features:
>   #
>   # @deprecated: Member @block-incremental is obsolete. Use
> -#     driver_mirror+NBD instead.
> +#     driver_mirror+NBD instead. Compression is obsolete, so members
> +#     @compress-level, @compress-threads, @decompress-threads and
> +#     @compress-wait-thread should not be used.
>   #
>   # @unstable: Member @x-checkpoint-delay is experimental.
>   #
> @@ -808,8 +817,11 @@
>   { 'enum': 'MigrationParameter',
>     'data': ['announce-initial', 'announce-max',
>              'announce-rounds', 'announce-step',
> -           'compress-level', 'compress-threads', 'decompress-threads',
> -           'compress-wait-thread', 'throttle-trigger-threshold',
> +           { 'name': 'compress-level', 'features': [ 'deprecated' ] },
> +           { 'name': 'compress-threads', 'features': [ 'deprecated' ] },
> +           { 'name': 'decompress-threads', 'features': [ 'deprecated' ] },
> +           { 'name': 'compress-wait-thread', 'features': [ 'deprecated' ] },
> +           'throttle-trigger-threshold',
>              'cpu-throttle-initial', 'cpu-throttle-increment',
>              'cpu-throttle-tailslow',
>              'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> @@ -837,16 +849,17 @@
>   # @announce-step: Increase in delay (in milliseconds) between
>   #     subsequent packets in the announcement (Since 4.0)
>   #
> -# @compress-level: compression level
> +# @compress-level: compression level. Obsolete and deprecated.
>   #
> -# @compress-threads: compression thread count
> +# @compress-threads: compression thread count. Obsolete and deprecated.
>   #
>   # @compress-wait-thread: Controls behavior when all compression
>   #     threads are currently busy.  If true (default), wait for a free
>   #     compression thread to become available; otherwise, send the page
> -#     uncompressed.  (Since 3.1)
> +#     uncompressed.  Obsolete and deprecated. (Since 3.1)
>   #
> -# @decompress-threads: decompression thread count
> +# @decompress-threads: decompression thread count. Obsolete and
> +#     deprecated.
>   #
>   # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
>   #     bytes_xfer_period to trigger throttling.  It is expressed as
> @@ -958,7 +971,9 @@
>   # Features:
>   #
>   # @deprecated: Member @block-incremental is obsolete. Use
> -#     driver_mirror+NBD instead.
> +#     driver_mirror+NBD instead. Compression is obsolete, so members
> +#     @compress-level, @compress-threads, @decompress-threads and
> +#     @compress-wait-thread should not be used.
>   #
>   # @unstable: Member @x-checkpoint-delay is experimental.
>   #
> @@ -972,10 +987,14 @@
>               '*announce-max': 'size',
>               '*announce-rounds': 'size',
>               '*announce-step': 'size',
> -            '*compress-level': 'uint8',
> -            '*compress-threads': 'uint8',
> -            '*compress-wait-thread': 'bool',
> -            '*decompress-threads': 'uint8',
> +            '*compress-level': { 'type': 'uint8',
> +                                 'features': [ 'deprecated' ] },
> +            '*compress-threads':  { 'type': 'uint8',
> +                                    'features': [ 'deprecated' ] },
> +            '*compress-wait-thread':  { 'type': 'bool',
> +                                        'features': [ 'deprecated' ] },
> +            '*decompress-threads':  { 'type': 'uint8',
> +                                      'features': [ 'deprecated' ] },
>               '*throttle-trigger-threshold': 'uint8',
>               '*cpu-throttle-initial': 'uint8',
>               '*cpu-throttle-increment': 'uint8',
> @@ -1008,7 +1027,7 @@
>   # Example:
>   #
>   # -> { "execute": "migrate-set-parameters" ,
> -#      "arguments": { "compress-level": 1 } }
> +#      "arguments": { "multifd-channels": 5 } }
>   # <- { "return": {} }
>   ##
>   { 'command': 'migrate-set-parameters', 'boxed': true,
> @@ -1031,16 +1050,18 @@
>   # @announce-step: Increase in delay (in milliseconds) between
>   #     subsequent packets in the announcement (Since 4.0)
>   #
> -# @compress-level: compression level
> +# @compress-level: compression level. Obsolete and deprecated.
>   #
> -# @compress-threads: compression thread count
> +# @compress-threads: compression thread count. Obsolote and

Obsolete

> +#     deprecated.
>   #
>   # @compress-wait-thread: Controls behavior when all compression
>   #     threads are currently busy.  If true (default), wait for a free
>   #     compression thread to become available; otherwise, send the page
> -#     uncompressed.  (Since 3.1)
> +#     uncompressed. Obsolete and deprecated. (Since 3.1)
>   #
> -# @decompress-threads: decompression thread count
> +# @decompress-threads: decompression thread count. Obsolete and
> +#     deprecated.
>   #
>   # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
>   #     bytes_xfer_period to trigger throttling.  It is expressed as
> @@ -1154,7 +1175,9 @@
>   # Features:
>   #
>   # @deprecated: Member @block-incremental is obsolete. Use
> -#     driver_mirror+NBD instead.
> +#     driver_mirror+NBD instead. Compression is obsolete, so members
> +#     @compress-level, @compress-threads, @decompress-threads and
> +#     @compress-wait-thread should not be used.
>   #
>   # @unstable: Member @x-checkpoint-delay is experimental.
>   #
> @@ -1165,10 +1188,14 @@
>               '*announce-max': 'size',
>               '*announce-rounds': 'size',
>               '*announce-step': 'size',
> -            '*compress-level': 'uint8',
> -            '*compress-threads': 'uint8',
> -            '*compress-wait-thread': 'bool',
> -            '*decompress-threads': 'uint8',
> +            '*compress-level': { 'type': 'uint8',
> +                                 'features': [ 'deprecated' ] },
> +            '*compress-threads': { 'type': 'uint8',
> +                                   'features': [ 'deprecated' ] },
> +            '*compress-wait-thread': { 'type': 'bool',
> +                                       'features': [ 'deprecated' ] },
> +            '*decompress-threads': { 'type': 'uint8',
> +                                     'features': [ 'deprecated' ] },
>               '*throttle-trigger-threshold': 'uint8',
>               '*cpu-throttle-initial': 'uint8',
>               '*cpu-throttle-increment': 'uint8',
> @@ -1182,7 +1209,6 @@
>                                        'features': [ 'unstable' ] },
>               '*block-incremental': { 'type': 'bool',
>                                       'features': [ 'deprecated' ] },
> -            '*block-incremental': 'bool',

That hunk should go into a previous patch, I think.

>               '*multifd-channels': 'uint8',
>               '*xbzrle-cache-size': 'size',
>               '*max-postcopy-bandwidth': 'size',
> @@ -1205,10 +1231,8 @@
>   #
>   # -> { "execute": "query-migrate-parameters" }
>   # <- { "return": {
> -#          "decompress-threads": 2,
> +#          "multifd-channels": 2,
>   #          "cpu-throttle-increment": 10,
> -#          "compress-threads": 8,
> -#          "compress-level": 1,
>   #          "cpu-throttle-initial": 20,
>   #          "max-bandwidth": 33554432,
>   #          "downtime-limit": 300

  Thomas



