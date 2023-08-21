Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC59782486
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:37:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzTc-0000Fa-UH; Mon, 21 Aug 2023 03:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSL-0008IK-GT
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSJ-00063H-By
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hX40otzxxu4KDPLBKODXhBk1bmxikuWi/BgtXmYfEM=;
 b=PFQTfk73vbVZN4R4rCfWPkDU65YXIRI5pJxnu04kw48YCdTRFN2eY8/qDPdmhlqlsBt5Rg
 p6GAW6+WpDuO8kWYnSEaXd2OCK4fZnU0kpbc45rGYwXlw/fLbICrAtO31qJsvrJu/ZPv2g
 HMOaRyKgIQLilGDmaRJLpLQOWt+qPMc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-C4Zm4OfnNomiwKV5C9fEpw-1; Mon, 21 Aug 2023 03:34:58 -0400
X-MC-Unique: C4Zm4OfnNomiwKV5C9fEpw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bcc462506cso1849431fa.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603296; x=1693208096;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9hX40otzxxu4KDPLBKODXhBk1bmxikuWi/BgtXmYfEM=;
 b=Uk9mPRRHbM2G8NTibg6lg2qnzOYBg5GcQWD9EcIQIqLWEPSqPx97a7VNH1Wjw+PVK7
 yeSQthL2FqBvfPwoH1CB9hMx2zrxgU6dbnv+LtDlabZhwGu4ryq0YGQYvuBUPKDFYfX9
 rftnvM1Cf5ReslWby8ZC3xrPI5+puHrifrf3F4zeal8AVPHaA5Z8y76eYiVjFiOSPh5A
 /kcLdParMvCl4Tp8MZreVBOBRpj09fvLA7Qi6psZc+pq2a44hTQIDYEHESnv6nRpbQk5
 1/Cz/Le3bkkz49NQm4L/SgzkdEI7E/vbKeamGQqYLiBdyw7MH/nKNfoTwSE1UL+gycD7
 asRQ==
X-Gm-Message-State: AOJu0YxA4n5E6tgDxA61ppX9fI87rZlNgKHYmtT+CXgFV62hKSmIQRnu
 PJCN4A5X2KJf6nl3Z12FYiHk6/SXS+r3s9bws+FbvSMn5RCWOowEhK1+VuXUhpamonLqkVqUuaN
 2AjZ09tJHkVYoOeQ=
X-Received: by 2002:a2e:9610:0:b0:2bc:b56c:5e7a with SMTP id
 v16-20020a2e9610000000b002bcb56c5e7amr2235246ljh.40.1692603296298; 
 Mon, 21 Aug 2023 00:34:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTyqLFVC9bIMuMGYbIcXRbcuRjXhgsUCeXjUpusS6HyV0blufvpQhVKqGSOyIOZG6tSjyPuA==
X-Received: by 2002:a2e:9610:0:b0:2bc:b56c:5e7a with SMTP id
 v16-20020a2e9610000000b002bcb56c5e7amr2235235ljh.40.1692603295991; 
 Mon, 21 Aug 2023 00:34:55 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a05600c365500b003fef19bb55csm2255358wmq.34.2023.08.21.00.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:34:55 -0700 (PDT)
Message-ID: <cc1afd38-2e93-9c31-00f3-ae56b7ba7c3b@redhat.com>
Date: Mon, 21 Aug 2023 09:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 04/21] block: Take AioContext lock for bdrv_append() more
 consistently
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-5-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-5-kwolf@redhat.com>
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
> The documentation for bdrv_append() says that the caller must hold the
> AioContext lock for bs_top. Change all callers to actually adhere to the
> contract.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


