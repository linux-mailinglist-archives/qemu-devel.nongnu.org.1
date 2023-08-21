Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB178249F
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:40:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzUK-00020D-A4; Mon, 21 Aug 2023 03:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTH-0000Im-8q
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTB-0006Fm-NM
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j17MvYFWCAhJSWaN961rMuVj+cD6ONIKgHhlISOQBr4=;
 b=csArZepB6w2WuAOvghoPiWVaLqR3tJWJCTAsVZTYHLM9Pe5PNjTLC/7qzsWs412edb0OsZ
 hwip+u27a8p5a9NGvnJQeIyvV3VVKQk4J+7pxnDXz61F9mofqbT2Rqn3OgVJbnXZhJ/p5z
 rM+N9bAtcnWnmhXlykvPUbYG26YYaLI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-u0Zr-spZNWScWZeXrZFJUg-1; Mon, 21 Aug 2023 03:35:26 -0400
X-MC-Unique: u0Zr-spZNWScWZeXrZFJUg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe1dadb5d2so19397745e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603325; x=1693208125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j17MvYFWCAhJSWaN961rMuVj+cD6ONIKgHhlISOQBr4=;
 b=ex/zA7LxE2J+kdMvXLXvlhOvWRxHQqBR9bco23+eROlRZsuZd142eZhxTkQDS9L0O5
 Iz6cB7jzKR7XpLcSEXyB9/uhtF1PgjPQLsFIlTTGWhV+Jk697/EuHy0jQ3Ze4I5VZOuz
 oMnYy4M3IL5aGZhcr8ZQZ4XdbqvnkgqKPq+ZUGkw5TEgfaj97n/DbDBiTmWE9SgdRqnR
 5q7brBtvek3WPC6mfDqRC3wEPPOFIbeN1INDz0rd28q7ap2WRyBT8XDV7N4pK1q2NTOl
 9i45t8m8wPCrEnDGU7uvemyYwiir7Tm3FzwqRaANWQnwmAAMJcuMjqWwI3DNph6IWI/q
 TzBw==
X-Gm-Message-State: AOJu0Yz0wcSdVSqmWhAj51q3fRmczj7HeAlBlR7Et5YNjUq5tnzeUSVc
 DOh0e6GuRnHEGalfBndTy/q72kqDmxdFY/g09hy5xJG7EGOPkl3qLlyJQT/UjQv15Sh+KOqWZWA
 5cGmvsExLodpxB4c=
X-Received: by 2002:a05:600c:b42:b0:3fb:b34f:6cd6 with SMTP id
 k2-20020a05600c0b4200b003fbb34f6cd6mr4521968wmr.41.1692603325052; 
 Mon, 21 Aug 2023 00:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf1eSKG6myPLSBencfhPMJ8JJT7qgbe32ah3xrJf2DuopZeR4guuQKn8GEoTpYAs6TQO6ifA==
X-Received: by 2002:a05:600c:b42:b0:3fb:b34f:6cd6 with SMTP id
 k2-20020a05600c0b4200b003fbb34f6cd6mr4521962wmr.41.1692603324904; 
 Mon, 21 Aug 2023 00:35:24 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a7bc8ce000000b003fed4fa0c19sm10352449wml.5.2023.08.21.00.35.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:24 -0700 (PDT)
Message-ID: <e7e95308-c1b2-da96-6317-aa48ff9c7a1d@redhat.com>
Date: Mon, 21 Aug 2023 09:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 17/21] block: Take graph rdlock in bdrv_drop_intermediate()
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-18-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-18-kwolf@redhat.com>
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
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


