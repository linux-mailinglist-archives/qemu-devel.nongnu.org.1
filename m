Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 815447185F3
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:17:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NZH-0004Pd-Ru; Wed, 31 May 2023 11:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q4NZD-0004Os-Jm
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q4NZB-00060r-Rt
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685546208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TyOC7sncnr76nPnXwqZkhd0buV8S2WLg9m7P8VE5P8=;
 b=dDQwpowXAGVk9SBIwz/wL5+wIi8P9GcIK6BX5WlrALODHnotxZVxdsfMENjrENH4dEJk9T
 Iw5CmS5eoj6eAYlCxwYOHlcIRLEm9PoHswGpvDMoFk1v8sETS0akWTEyhCnicmn+UW+jvG
 HEdN/zV52S/2hs+EnxMimv+oVwMWuJ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-dnpooNG5O_qxRo1PvGOnNA-1; Wed, 31 May 2023 11:16:46 -0400
X-MC-Unique: dnpooNG5O_qxRo1PvGOnNA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96f9aa23593so494323366b.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685546205; x=1688138205;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4TyOC7sncnr76nPnXwqZkhd0buV8S2WLg9m7P8VE5P8=;
 b=C/DJVjXotmE/LD5kDiNW2YkpRxa4xHUkzNbwL6phiNBHHfMf9TvtwW8UeaRBs1Qwq9
 Ql2tLYFa1s7zXUHQBz2bPdCQm3JQdQcWdit7oC7tj26fP8g9W6yxai66dzlsOzSkPybP
 JY00jc/ia35OhsX4Dc6rsQS677cl1w5BcUAhkF6UZVGdBcwZ3NZlNHe9bxhS9qjTzGvg
 StKDOnJ7IiTrgg8m4zcRTkdywe33RudbSQSJMsmecB7soUEVTJ6R40yhUKKscHA6p2N/
 XHPZxdlArgZdGmnyH/2HRTV6YOsAablbtLvusE0DP3ZBf85S0iYDBuVS0WJ3gy86n8yC
 U3RQ==
X-Gm-Message-State: AC+VfDyAOHrl/9Aj3rP0C/OtuhDVL5YfnRrqtc4GQI5OnYV7ciGkEK7o
 q52EEGMEqDNuBzKh4HnBkbxFxj2J5E5kSpdcGnaEh4d0mQOxgdu2BvNQXh5KHuOegvksb+fVLtN
 N5fw8zlxD0mIz7JdWG3wRYlE=
X-Received: by 2002:a17:907:c0c:b0:973:edba:df30 with SMTP id
 ga12-20020a1709070c0c00b00973edbadf30mr5801055ejc.61.1685546204801; 
 Wed, 31 May 2023 08:16:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70oIjscJ/CENNfUlgPySMD4YWkLuTb0zp1/4WiKTpX1mxyDIr2XCIzf3VAY4ORiqza4W9FwA==
X-Received: by 2002:a17:907:c0c:b0:973:edba:df30 with SMTP id
 ga12-20020a1709070c0c00b00973edbadf30mr5801043ejc.61.1685546204494; 
 Wed, 31 May 2023 08:16:44 -0700 (PDT)
Received: from ?IPV6:2003:cf:d72e:f7e0:1010:46a4:2212:92f9?
 (p200300cfd72ef7e0101046a4221292f9.dip0.t-ipconnect.de.
 [2003:cf:d72e:f7e0:1010:46a4:2212:92f9])
 by smtp.gmail.com with ESMTPSA id
 us8-20020a170906bfc800b0094bb4c75695sm9102957ejb.194.2023.05.31.08.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 08:16:44 -0700 (PDT)
Message-ID: <aa75a5a7-c643-0ef0-bf1f-cb2bfecbecb0@redhat.com>
Date: Wed, 31 May 2023 17:16:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] qcow2: add discard-no-unref option
Content-Language: en-US
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
References: <20230515073644.166677-1-jean-louis@dupond.be>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230515073644.166677-1-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15.05.23 09:36, Jean-Louis Dupond wrote:
> When we for example have a sparse qcow2 image and discard: unmap is enabled,
> there can be a lot of fragmentation in the image after some time. Surely on VM's
> that do a lot of writes/deletes.
> This causes the qcow2 image to grow even over 110% of its virtual size,
> because the free gaps in the image get to small to allocate new
> continuous clusters. So it allocates new space as the end of the image.
>
> Disabling discard is not an option, as discard is needed to keep the
> incremental backup size as low as possible. Without discard, the
> incremental backups would become large, as qemu thinks it's just dirty
> blocks but it doesn't know the blocks are empty/useless.
> So we need to avoid fragmentation but also 'empty' the useless blocks in
> the image to have a small incremental backup.
>
> Next to that we also want to send the discards futher down the stack, so
> the underlying blocks are still discarded.
>
> Therefor we introduce a new qcow2 option "discard-no-unref". When
> setting this option to true (defaults to false), the discard requests
> will still be executed, but it will keep the offset of the cluster. And
> it will also pass the discard request further down the stack (if
> discard:unmap is enabled).
> This will avoid fragmentation and for example on a fully preallocated
> qcow2 image, this will make sure the image is perfectly continuous.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2-cluster.c  |  16 ++++-
>   block/qcow2-refcount.c | 136 ++++++++++++++++++++++++-----------------
>   block/qcow2.c          |  12 ++++
>   block/qcow2.h          |   3 +
>   qapi/block-core.json   |   4 ++
>   qemu-options.hx        |   6 ++
>   6 files changed, 120 insertions(+), 57 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 39cda7f907..88da70db5e 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1943,10 +1943,22 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>               new_l2_entry = new_l2_bitmap = 0;
>           } else if (bs->backing || qcow2_cluster_is_allocated(cluster_type)) {
>               if (has_subclusters(s)) {
> -                new_l2_entry = 0;
> +                if (s->discard_no_unref && (type & QCOW2_DISCARD_REQUEST)) {
> +                    new_l2_entry = old_l2_entry;
> +                } else {
> +                    new_l2_entry = 0;
> +                }
>                   new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
>               } else {
> -                new_l2_entry = s->qcow_version >= 3 ? QCOW_OFLAG_ZERO : 0;
> +                if (s->qcow_version >= 3) {
> +                    if (s->discard_no_unref && (type & QCOW2_DISCARD_REQUEST)) {
> +                        new_l2_entry |= QCOW_OFLAG_ZERO;
> +                    } else {
> +                        new_l2_entry = QCOW_OFLAG_ZERO;
> +                    }
> +                } else {
> +                    new_l2_entry = 0;
> +                }
>               }
>           }

Forgot to note something: So this option only works for qcow2 v3. Can we 
have qcow2_update_options_prepare() return an error if s->qcow_version < 
3 and discard_no_unref is set?

Hanna


