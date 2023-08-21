Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8078248C
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:39:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzTv-0001FL-DJ; Mon, 21 Aug 2023 03:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTH-0000Ip-CB
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTB-0006G8-S1
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j17MvYFWCAhJSWaN961rMuVj+cD6ONIKgHhlISOQBr4=;
 b=iPVopUv6uK2hnwCUkQ5wMaxCAmleClfDUqdKV482gkmMElqBrBQKJJPmr2n1Rx0Hp8JOUH
 gq78eWZbn5RptkiGUCT82HMYErEBn8SvBIwVh2iWh0J4E5BdJADRIcv+ELnhPIsDgpLIla
 nvCfblBU1kEqZ9/7knBLdmHz95MhAtM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-piaLKqgLOYO0znGi3AwMxA-1; Mon, 21 Aug 2023 03:35:24 -0400
X-MC-Unique: piaLKqgLOYO0znGi3AwMxA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50081b0dba6so557647e87.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603322; x=1693208122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j17MvYFWCAhJSWaN961rMuVj+cD6ONIKgHhlISOQBr4=;
 b=HbY/xH9lbC7hP8ddrCAsTzxzmf0uF3AOFJ3bJ2bTUmc4THsK4XFCzgdQgT8slaMAMf
 qSHgWOgMIYrGIVYeME98DGJTxsVu2le1SeezsvTA7l7jMobXsUWI7q722dzLPjZsZvRy
 EF9MiPfaIM7i+32/PIoREgEzMtiNsjsEK0l1k7wqeT3LPb6o7gMhF/e4MxldlBEhDLx1
 JWr3vHPZNCQgvU8OL5nZ1JfXLejd2QWJbUeVYRifRmD3cotK+M/4dUkpD6/sM3TYe61j
 awKsEUbY6Ap5B8fsdGc24lqUMbFjw2OPvCDzwpamujUV9GuPMn6hiMZGcFJqsAYLd6L+
 AJ1g==
X-Gm-Message-State: AOJu0Yy/bAnhqDKgsE5uCFf7sKzWmYtYjmhqbhjCz4NIHIMIuM8Hg/Y9
 YnYrs2reQWJq8TtbfPZvOfgYiFwb54CWVVfvB0zKTXH0sTxXas3RrmOwUP4cmvpSr2E4YNVqeYZ
 pejbONpPHnLyg7Pg=
X-Received: by 2002:a2e:86c4:0:b0:2bb:aed0:328a with SMTP id
 n4-20020a2e86c4000000b002bbaed0328amr4094912ljj.48.1692603322005; 
 Mon, 21 Aug 2023 00:35:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqNMij0KyH1aCKqflcU1BA0aRfeyE2cI7AQIgeuZWMsLnxcVC+74YQ6BQnKGn+fCWS2Ss+aA==
X-Received: by 2002:a2e:86c4:0:b0:2bb:aed0:328a with SMTP id
 n4-20020a2e86c4000000b002bbaed0328amr4094896ljj.48.1692603321721; 
 Mon, 21 Aug 2023 00:35:21 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 n41-20020a05600c3ba900b003fe4e1c5bcfsm666567wms.0.2023.08.21.00.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:21 -0700 (PDT)
Message-ID: <4a990414-2961-f37b-4dc9-40f13262e785@redhat.com>
Date: Mon, 21 Aug 2023 09:35:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 16/21] block: Mark bdrv_parent_cb_change_media()
 GRAPH_RDLOCK
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-17-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-17-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eesposit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.279, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> The function reads the parents list, so it needs to hold the graph lock.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


