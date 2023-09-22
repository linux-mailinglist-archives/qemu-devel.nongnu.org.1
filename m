Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2690E7AB505
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:44:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiKD-00064c-PI; Fri, 22 Sep 2023 11:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qjiKB-000642-Kr
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qjiKA-0002vr-99
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zz+ryLGoxop7LZeePNaUA48GnOr2JGcYyCn54dN2GS8=;
 b=eL81hrlEkPfbcJnROcyU1Z1ILopHSy3Hg/IilXuyDdEzvYPvEVxsX9kTkS13sLCOzhr/7U
 oXYyg1OA5oVJzvGrwc1uMMKcBpQ1RcE6Riv0/kz99q7rktwvtSUxdGvx+C1HO2AOm0eUZJ
 XKt1Kbi2wXEpInnNep07PIM2z+pz1zI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-o0pIPIZwOvCZz_uq3_k9Sw-1; Fri, 22 Sep 2023 11:44:08 -0400
X-MC-Unique: o0pIPIZwOvCZz_uq3_k9Sw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-774032c7c7dso47128685a.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397447; x=1696002247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zz+ryLGoxop7LZeePNaUA48GnOr2JGcYyCn54dN2GS8=;
 b=FoGQY8f0qnfQdMUPo2kbvGSz+ah0ELNgAdHs2PM7pV/GeVXWrmb5nrUHtxpJKeu5XH
 TVndn07pRQFr2zE+8E7DbOs+63GcDHnOMUDcJScKMHaHxmBbyvhZRUD/YjyAiPlehxSL
 H1/Y5M7W0hJWsHJv2yGbKKwhzc1xAYN3KLu74Xi9poZ6tDCSJ/OOSk6YM6QdjbvBKU3I
 s48HobkPJk3j3K5sWsMIYsQzOvyV0h/3AtycJy2yRxdpsD8JxfxKrvhPY4wC/bnj8tUf
 BQZ8uvaUORjyF8E4wP1OEKEAnzrxTDemkSQ/CnXkiFBWR76jnSMQFAg0gLlLfx2HaVpi
 geqw==
X-Gm-Message-State: AOJu0YzdoFYrTxWKoMUrMu9Dhmlhj7UnXP01CYsRhMsbfY7p2IPuzKml
 RXhQ0HVHqnC4OC7dkXSMOlYisxx7H6mi5QH/8GCRADda3EdifvuiQ1idMPZ7GEBDkrBss4vUfvJ
 OqPqB2zKcvIps2snluQR/mrM=
X-Received: by 2002:a05:620a:1a24:b0:76d:9234:1db4 with SMTP id
 bk36-20020a05620a1a2400b0076d92341db4mr8943418qkb.7.1695397447677; 
 Fri, 22 Sep 2023 08:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOV/U+GFeJtOVuW1cj43zBl2fwUANm5gVRCYRjwX/V07JoW+bMbhPnveTZxp2IbUzv8bjsRw==
X-Received: by 2002:a05:620a:1a24:b0:76d:9234:1db4 with SMTP id
 bk36-20020a05620a1a2400b0076d92341db4mr8943399qkb.7.1695397447335; 
 Fri, 22 Sep 2023 08:44:07 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m30-20020a05620a215e00b0076ee82f7726sm1038912qkm.132.2023.09.22.08.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:44:07 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:44:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: quintela@redhat.com, leobras@redhat.com, qemu-devel@nongnu.org,
 Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] migration/rdma: zore out head.repeat to make the
 error more clear
Message-ID: <ZQ22RR7opgrbOAh9@x1n>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
 <20230920090412.726725-2-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920090412.726725-2-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 20, 2023 at 05:04:12PM +0800, Li Zhijian wrote:
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
> 
> Previously, we got a confusion error that complains
> the RDMAControlHeader.repeat:
> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
> 
> Actually, it's caused by an unexpected RDMAControlHeader.type.
> After this patch, error will become:
> qemu-system-x86_64: Unknown control message QEMU FILE
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


