Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3381AF63
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 08:27:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGDSg-0005yn-Jb; Thu, 21 Dec 2023 02:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGDSe-0005vm-A4
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:27:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGDSc-0003Wj-T3
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703143634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b6qq1t8SY9Vv4g52XovFScUpREoVFfaCGKPKZf0QJu8=;
 b=Se73Tkub8TBZnjJTtNFKvkQH6FrAXD2z4ILZv03/jadRRiSHhK3h2lrtJVvIW0NBVoY6V/
 vR6fxUmFfMpUjLsGl2B8BXHqtgoYA4sQ0bHLm0QAVL7Cyu7zKp1DG5A5u53l0PMW52gZC1
 wd0tt1B8b4Fu08vyrWfdzydLYVq1LRY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-AG3pWqC5PRm-J73SwTivIQ-1; Thu, 21 Dec 2023 02:27:12 -0500
X-MC-Unique: AG3pWqC5PRm-J73SwTivIQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a1f6c9e3296so15832866b.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 23:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703143631; x=1703748431;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b6qq1t8SY9Vv4g52XovFScUpREoVFfaCGKPKZf0QJu8=;
 b=jPTCrzsRXhrv06imFpiaKZtVjlqhSG4VZNQqfKHUy3UWmQq2OnNiENvWhywlQ9+XZn
 OY4q1ouc9b7H7eerwWlFLCp8BkPUwI0CG6tl7ATUf7LZRe1AZIYekrAAoXQOPaDOM2/4
 /9LUDry9ZUbgB9OBH1WKgkLYKu1Ar+rFDgRE6n9pwHouh9Ij9mAL3z+PQ+Ng3dShKL3G
 0ik73gQ+wxVnXJKeFho5SfsZqQd5AhXBHz+T9M3a9C1B32VIdzF2i4QIKcac1pi+VH4o
 Xw5NXMpaklGx43GMzymAzLtT22tjRotVTg0/vxttmSjIcayJZes3njU1l4yGBtR4GTYK
 XhHg==
X-Gm-Message-State: AOJu0YztNMV/vSZhNMXR+QOFY182dvZ5/DYxmSFjwsod64fb2K89bY5Q
 E5huPDg3SPVPkwwNd1dqXFtdNmbKALQ5SN6vRX/nLMghYMLLKsUdcKzGcFCMkbUONcp73dgczks
 PY4dfNeHzl9kp8i0=
X-Received: by 2002:a17:907:90d8:b0:a23:5f5f:cb94 with SMTP id
 gk24-20020a17090790d800b00a235f5fcb94mr2864911ejb.47.1703143630955; 
 Wed, 20 Dec 2023 23:27:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO7dhAKiB2GLCIdMfUcYg3voz4WlwM9cXCQfSuK7OhRPf/zZzzy5aJGZb25kCQvcE7QwMCHw==
X-Received: by 2002:a17:907:90d8:b0:a23:5f5f:cb94 with SMTP id
 gk24-20020a17090790d800b00a235f5fcb94mr2864897ejb.47.1703143630606; 
 Wed, 20 Dec 2023 23:27:10 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 wb8-20020a170907d50800b00a234ae227d2sm633592ejc.219.2023.12.20.23.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 23:27:10 -0800 (PST)
Message-ID: <913d0d34-a1ce-4bf3-9ed2-e194cbae1a78@redhat.com>
Date: Thu, 21 Dec 2023 08:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nbd/server: avoid per-NBDRequest nbd_client_get/put()
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20231221014903.1537962-1-stefanha@redhat.com>
 <20231221014903.1537962-5-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231221014903.1537962-5-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 12/21/23 02:49, Stefan Hajnoczi wrote:
> nbd_trip() processes a single NBD request from start to finish and holds
> an NBDClient reference throughout. NBDRequest does not outlive the scope
> of nbd_trip(). Therefore it is unnecessary to ref/unref NBDClient for
> each NBDRequest.
> 
> Removing these nbd_client_get()/nbd_client_put() calls will make
> thread-safety easier in the commits that follow.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   nbd/server.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 895cf0a752..0b09ccc8dc 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1557,7 +1557,6 @@ static NBDRequestData *nbd_request_get(NBDClient *client)
>       client->nb_requests++;
>   
>       req = g_new0(NBDRequestData, 1);
> -    nbd_client_get(client);
>       req->client = client;
>       return req;
>   }
> @@ -1578,8 +1577,6 @@ static void nbd_request_put(NBDRequestData *req)
>       }
>   
>       nbd_client_receive_next_request(client);
> -
> -    nbd_client_put(client);
>   }
>   
>   static void blk_aio_attached(AioContext *ctx, void *opaque)

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>



