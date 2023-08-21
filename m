Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3AE782483
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzT0-0008Tl-TB; Mon, 21 Aug 2023 03:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSJ-0008HR-Ft
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSE-00062G-BC
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXrXiwdGGU8JRaIVBsuDqwiuYmYJ2h7Q1VyFBcyDIAI=;
 b=iw1uGB26o0WBAsF5U6efJsM2dc5M0kGhPqxR5cBxO39rJqENxFExNE7zz8SWbeH7Sg3p63
 jEwySAFYgwM50ZEI6Z7L+Nw7SgAdsPUx3bjC+UdWGanU6kFlxNDNuigg6bnzdKJuZS3Jtw
 Y40JFS+CJgbxvqYr38F9YXk7Wu0ujvs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Fd6rIH4uNxy69MPOqLK8Yw-1; Mon, 21 Aug 2023 03:34:50 -0400
X-MC-Unique: Fd6rIH4uNxy69MPOqLK8Yw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-317d5b38194so1338120f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603289; x=1693208089;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXrXiwdGGU8JRaIVBsuDqwiuYmYJ2h7Q1VyFBcyDIAI=;
 b=cghcz/B/Qz+hj3bVTDN6DQEmbkRtvW/uuFYzwtpJ2Ia7Zyoxt4fbcGEvgyXZwLwRBG
 LS1O988r0MshtYqsyPyqpVWvbHJlfhExEIBNT6jcoms6S+x43Bw65RnsTpuCgRQg605W
 6XMtvzBPSwAWNTFM04bIHjs69TcQwfGhFlUwdDCPwAMjDHFdhuspgflixj7WZ0U5O/1Y
 t0wjc/OPfBOD9E+QWP8kvKtBEUMtMKT2cBjfxdljFeNah1QGSUVW1IUQBBq9A12fKUjv
 S/JMdyfKP8Yn7BnRbiqSGiDMoGg/Qm5BV4xl18GHIeEPhKIEf3eM2wkWgdmuMNVTf9Og
 nhdQ==
X-Gm-Message-State: AOJu0YxB6zhRbyfaMVsenguzORcGorWxUmb8tIcOKsMrXS4e10IAPJxk
 pWuMng/a4HYE54X8IQeMKtHRta7wAukfSfIud6cjhSHdmJl4Ccfz2Gwwsk4PQfilv+9QoyYRHf0
 Tr2sSxFiZAcWcwNI=
X-Received: by 2002:adf:e5c1:0:b0:314:3e96:bd7e with SMTP id
 a1-20020adfe5c1000000b003143e96bd7emr4040962wrn.4.1692603289701; 
 Mon, 21 Aug 2023 00:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjKSn7HJqSlfT+FYaPxLu44y0JUzm378TYqAl0sdMB/o/2p140oKR01dDnpIep2UF4Hqn3BQ==
X-Received: by 2002:adf:e5c1:0:b0:314:3e96:bd7e with SMTP id
 a1-20020adfe5c1000000b003143e96bd7emr4040954wrn.4.1692603289418; 
 Mon, 21 Aug 2023 00:34:49 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a5d638a000000b003177074f830sm11543738wru.59.2023.08.21.00.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:34:49 -0700 (PDT)
Message-ID: <4bbf6fd9-2fc8-c753-bb1a-9e8d66d97c3b@redhat.com>
Date: Mon, 21 Aug 2023 09:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 01/21] block: Remove unused
 BlockReopenQueueEntry.perms_checked
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-2-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-2-kwolf@redhat.com>
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
> This field has been unused since commit 72373e40fbc ('block:
> bdrv_reopen_multiple: refresh permissions on updated graph').
> Remove it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


