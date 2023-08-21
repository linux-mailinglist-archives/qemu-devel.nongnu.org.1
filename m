Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C27824A8
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:41:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzTd-0000Fn-Qa; Mon, 21 Aug 2023 03:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSc-0008KX-FJ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSY-00066r-NK
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VqldkfkE5q70E70SXoLL9b3+In5bb27u2Hq45f2n7iQ=;
 b=Vtt1e3+jb7WoxqlGa0Gdl60E+8B1ywA/ZakOymr54HGxQCONGtNc+2Tmk4K6cbVjPTUDhz
 gFaVOrs1P/YlDkZi3NMwDHcI9VAhSct8nYyjaQbyIlFoou7PAtEYrOfJ8GnSaVkLBxKhfq
 KOXlosLxubhxJlNJfa5AcWfEtwG5Obw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-d9suZfknNIWvAbkTiURB8A-1; Mon, 21 Aug 2023 03:35:12 -0400
X-MC-Unique: d9suZfknNIWvAbkTiURB8A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31ad77537ebso1814116f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603311; x=1693208111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VqldkfkE5q70E70SXoLL9b3+In5bb27u2Hq45f2n7iQ=;
 b=YGJai9LZbtV5kn6KFgTR84M7P/NkKu+MUbTFFkaZt17O+1SoB5uuLS7cIEOuqhIE1T
 Ylt53XTGM9gp3DvVw3+srYoC69aaOoHF1gyaOzfjN37tVDNj29DRMAlaElDBHRnuSVQj
 8Y/XSS3Agv+iedi1ITuFyunG6g9/AQB+FHrpSjPFwQcYCWLVa0X1yP+TzZWgY6RybN52
 UtUxtulIbC68J23uGwKIyxnOvLIfppeNUMHqFQMWED88OLxT4vIGcw9YdAUB+WtEovdF
 +2aEm1iPYZ4FFUtg38ontbnIH04ffjmzrAsUHklf5vomN40fzTokmUcAIWRvdnyX1goQ
 /vQA==
X-Gm-Message-State: AOJu0Yz2CUqL0rc/4N+X3c7p2vLjmM0bgJ2tJUvrIkIsW8mV6lZerKZH
 hvWFuHHGxtQYr/hPTIOUrDtzg4bhvooqBdV6VNwa3oWGye1fTWtDb8O87/cyeirSCcBuc3vb7I1
 tup9tOWGSSJsXpbA=
X-Received: by 2002:adf:f3cd:0:b0:313:e9f6:3378 with SMTP id
 g13-20020adff3cd000000b00313e9f63378mr4272357wrp.4.1692603311578; 
 Mon, 21 Aug 2023 00:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuDepTYlKMQhKr7W29e657nAsZW+pq5YYFGvO4Bx4tfe1VhbWH4a1CYuGMrH9WMv5+MttCSg==
X-Received: by 2002:adf:f3cd:0:b0:313:e9f6:3378 with SMTP id
 g13-20020adff3cd000000b00313e9f63378mr4272348wrp.4.1692603311423; 
 Mon, 21 Aug 2023 00:35:11 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a5d638a000000b003177074f830sm11544844wru.59.2023.08.21.00.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:11 -0700 (PDT)
Message-ID: <d0cf7d54-37f7-78fb-270d-9d0d5a38f1a3@redhat.com>
Date: Mon, 21 Aug 2023 09:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 12/21] block: Mark bdrv_attach_child() GRAPH_WRLOCK
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-13-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-13-kwolf@redhat.com>
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
> hold it when calling bdrv_attach_child_common(). These callers will
> typically already hold the graph lock once the locking work is
> completed, which means that they can't call functions that take it
> internally.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


