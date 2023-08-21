Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E787824AC
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:41:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzTp-0000o0-Rl; Mon, 21 Aug 2023 03:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSs-0008WN-VB
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSk-00069C-SX
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j17MvYFWCAhJSWaN961rMuVj+cD6ONIKgHhlISOQBr4=;
 b=D6k/I9HndejUWF5SQ0vJSx6YrbdjLXeepQ8cGq+nch5N1jkai4srZ+uQvpAIgxwvsEb6bl
 AstttjEw+4uqV9DYkgT38p9RqPSAwXF2p1qn0XoN7L8Z0TZcCHw+wLsiewQXpOKmBrqwMB
 bS1nWLotf5+QrHcPAggOwFgV+AQTS04=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-xGIahxmkNsiV0skiwq9fDw-1; Mon, 21 Aug 2023 03:35:28 -0400
X-MC-Unique: xGIahxmkNsiV0skiwq9fDw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fef2dde99dso2655985e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603327; x=1693208127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j17MvYFWCAhJSWaN961rMuVj+cD6ONIKgHhlISOQBr4=;
 b=PX6jB2z4Ii+gF4w7Wmbql0274HSsAFVjgRztKxh0/Osk/QXB0NOkPCOXAhDr1LNW2X
 cMglTqCGi5z17+p7CaYui31zA57uqkwfAfGE6AaTBBIloZqsrj8Ysu8jbcQMrpsmsTOv
 GKFOT5AXNSqeYQvoEMEzo3vfGV5z9eQjvYkB7OmpKETWnbn3A5p7oVy9uzItvZdQ9XFb
 7sf44SoahrWwblQHCPqkuXQA63yJ/eAdPSjeWVWCFdk7+r4OLM//e5XHjcaMuvxw64Md
 hXPQQU4o1zWU9n6UEs2O6Y/ZdcuKqt46etb+s0ylz5N1hQYphufVxNgCGjKFUDyZDAi8
 ZozQ==
X-Gm-Message-State: AOJu0YwXef7KpDLEY+2ZcNzGRNfGaECuVkmazczEXhtyg7OcjtEYRi84
 9qu7fICf/uUMsvQCw3vXAe5tNXHARdMdYREpHF766vrhRJrCIMEmKfnSqZYvb7IZEFBrsGQjpc0
 /N4GFZCEl6t2PAnE=
X-Received: by 2002:a7b:ca50:0:b0:3fd:29cf:20c5 with SMTP id
 m16-20020a7bca50000000b003fd29cf20c5mr4063694wml.7.1692603327468; 
 Mon, 21 Aug 2023 00:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpcT2WB523yD67bSxeFKqfm5+QG2TLDAq+/blRMkT10qNy59E2fETZyYGluP6wPkLW/ngIzg==
X-Received: by 2002:a7b:ca50:0:b0:3fd:29cf:20c5 with SMTP id
 m16-20020a7bca50000000b003fd29cf20c5mr4063682wml.7.1692603327279; 
 Mon, 21 Aug 2023 00:35:27 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 c3-20020adfe703000000b0031433443265sm11468095wrm.53.2023.08.21.00.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:27 -0700 (PDT)
Message-ID: <3ce44192-6cc8-6798-e242-1fc879222353@redhat.com>
Date: Mon, 21 Aug 2023 09:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 18/21] block: Take graph rdlock in
 bdrv_change_aio_context()
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-19-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-19-kwolf@redhat.com>
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
> The function reads the parents list, so it needs to hold the graph lock.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


