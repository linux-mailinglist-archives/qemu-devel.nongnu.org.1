Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 916CD78249B
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzT4-00008h-GP; Mon, 21 Aug 2023 03:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSR-0008JL-2t
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSP-00064k-0y
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjVO7LxH41a2XNHBEXptsFFMB137XF+VuTYBqhKOeJc=;
 b=Ie+rDaxkcZthnWGRfPj3O820Z6IfRzTnM90+FnFvB/U+CLeEK727H3S/VNTx0gjlddwB+F
 bgi6aqJk/I3F1aIn1LmKuxcBa545I2Fyiqe89Xs1hbo58iBVTDGM8no8tANPoqq+EGn2lw
 b7uMz5S2rd6emd8pPcLfv27YObtGQnM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-ZeQnbopfNP2HZQFouNHjog-1; Mon, 21 Aug 2023 03:35:04 -0400
X-MC-Unique: ZeQnbopfNP2HZQFouNHjog-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fed8814117so14200085e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603303; x=1693208103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kjVO7LxH41a2XNHBEXptsFFMB137XF+VuTYBqhKOeJc=;
 b=Hhk8X25/Mj8d1REQEsXM6eSH9GAxqUGpMwucqxfxyIwucjjBaQYwh7tjBBiuURAEs0
 SekakgsHONCOSNSoY6JPOwxRbMSh3wFyqqcIUb2lU0sxY9U3kxAYfximIiSaMe0w34k2
 vO6XyC2qGCh94VuehG2Zt7UgGVA+qI8niTZOBFtC6BkwLkUS6cgbzYZBHNoc1YtFf6SR
 Yq7KBE1FEb0a7xH6bE1NmALiiofiz6jCDLdFFvXrQjhFaDphrCOLsE/wIy/6teqU6p45
 CrAe74Ufswdbx2Zddz72aVaHEUB19lQnCidtV9gfki0ZaaH8fm4PhO7B+lWKqM0RwJh1
 T/FA==
X-Gm-Message-State: AOJu0YyXXmUEIOQXEh+FgjiqGX9RLCu6TiTvHL9rlgvvpoIqVJG9e1kv
 LZKQDG8LlyWhimj0b5k/xa6nXP53vhlacm4pFxcYbBIvhgN1KUwBvFQ6xd9LXXVnPfDQoQlxz5K
 689Q+ki8tWhFokQYUwEseOtQ=
X-Received: by 2002:a5d:6143:0:b0:31a:d6cb:7f95 with SMTP id
 y3-20020a5d6143000000b0031ad6cb7f95mr4619051wrt.18.1692603303670; 
 Mon, 21 Aug 2023 00:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ+1Z93CmYNdj2EEivRXUgGT7zhba9k/nGv8MWeP0c3jP34NdMpomJA1I9E/oWvBsl/F8ZaA==
X-Received: by 2002:a5d:6143:0:b0:31a:d6cb:7f95 with SMTP id
 y3-20020a5d6143000000b0031ad6cb7f95mr4619043wrt.18.1692603303508; 
 Mon, 21 Aug 2023 00:35:03 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 t4-20020adff604000000b003176aa612b1sm11394852wrp.38.2023.08.21.00.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:03 -0700 (PDT)
Message-ID: <6e0c2012-4d14-31f7-ef1b-f52b85a61ee5@redhat.com>
Date: Mon, 21 Aug 2023 09:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/21] block: Mark bdrv_replace_child_noperm() GRAPH_WRLOCK
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-9-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-9-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eesposit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.279, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 17/08/2023 um 14:50 schrieb Kevin Wolf:
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_replace_child_noperm(). These callers will
> typically already hold the graph lock once the locking work is
> completed, which means that they can't call functions that take it
> internally.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


