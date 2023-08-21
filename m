Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C57824A7
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzUp-0002NT-Cc; Mon, 21 Aug 2023 03:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTF-0000If-HJ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTB-0006Fc-BB
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IdTUrY85cAdwJsobg0qJhAbUgEdg38YpxzfL8nFNScU=;
 b=dMN2ctssie5ioXER6B0+mbIZfoSP45j+GitGc1UNOWd+1PpofZ632ZWBfanrXud2MhcyYQ
 CVxObziOCtCrggx/wcw2+CZXQbZ1zBWmkNvdFdEL6pkXq+AGDM3QNszfjHg3hB1fXWa35R
 tmXBVci10SrvnCXPiu0WcmytnY8OTOc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-GJs1hGvZNPCjH6y81qWhPA-1; Mon, 21 Aug 2023 03:35:18 -0400
X-MC-Unique: GJs1hGvZNPCjH6y81qWhPA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31c5cc5537dso5642f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603317; x=1693208117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdTUrY85cAdwJsobg0qJhAbUgEdg38YpxzfL8nFNScU=;
 b=dFa6LNtDYKgJKjt9iahLqa6V8QjwrFwTzOjdVbKg93iNFdOaVtoezLBfvojAutMde/
 9SbIct4N9QWZMRWLY5cPtWNrbLhAhPsZ9M73et28cPpvFVnexBQE+go6sCPxCTxtt1tJ
 Zvo2XQgEWzu0o590ri8Ni+vuw3l6ve1/PU8yIycmgYuKEk5PO2YRVsivBVmNrl+X7YRn
 WNvhotFy8xyjcAMqz+pXxsVPQGRYT8Sl0CAJHmXjetg8g08gUypAfolZrKEjvMTJcH18
 tCYErQlm0kgdVeEnOmxacj+w7sO5AVn4s/z38d65y2FtC8p5DwAioM5y2JK0M4ZvqGxU
 A7GA==
X-Gm-Message-State: AOJu0Ywvwkga34CB4of8hGMff4vZgVRndqVX805g9ZKtJkF2FkEL2cQ+
 MEt87M1bplbM546ixWqe94C0ZBxBcMqer3Jd7gB6lZtfZ/i6jdF2N3gLySSN7CPLwIWAdWRwmF3
 ET1Nqn1FIK0jZWQ0/Co9SAG0=
X-Received: by 2002:a5d:68cc:0:b0:314:475:bc6b with SMTP id
 p12-20020a5d68cc000000b003140475bc6bmr7448575wrw.18.1692603316860; 
 Mon, 21 Aug 2023 00:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTwnz3wtDBRHqaV3d3MKPrj9MALBQ5QUT65u/j0VgvvR/5iSq/IriruC0gqeb0Q2DYU40n2g==
X-Received: by 2002:a5d:68cc:0:b0:314:475:bc6b with SMTP id
 p12-20020a5d68cc000000b003140475bc6bmr7448567wrw.18.1692603316710; 
 Mon, 21 Aug 2023 00:35:16 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 p11-20020adfe60b000000b003176c6e87b1sm11509329wrm.81.2023.08.21.00.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:16 -0700 (PDT)
Message-ID: <d2401878-93b1-e10a-ccc6-fe21115deb57@redhat.com>
Date: Mon, 21 Aug 2023 09:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 14/21] block: Mark bdrv_get_cumulative_perm() and callers
 GRAPH_RDLOCK
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-15-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-15-kwolf@redhat.com>
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
> The function reads the parents list, so it needs to hold the graph lock.
> 
> This happens to result in BlockDriver.bdrv_set_perm() to be called with
> the graph lock held. For consistency, make it the same for all of the
> BlockDriver callbacks for updating permissions and annotate the function
> pointers with GRAPH_RDLOCK_PTR.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


