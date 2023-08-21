Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D87824A6
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzU0-0001L3-7n; Mon, 21 Aug 2023 03:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTF-0000Ih-Hx
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTB-0006Fe-B3
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ProDBu5Ag25pBTgiiIYMqUeBZB4depYMcRXKdKs1r4=;
 b=LXRAXL4KiooRV4uidS0AMYkT9aSovMZrLMzgsFLSfgIZ+hsjbDcMm6UuAMrM9ovFD5ogt9
 DK/PaebXtqF9pFjB7iXIGLlQgx2GH0YDbtGjIU39UnJpsg0pmMfEIR5tWv/ksET0Ejf8Ng
 vdRWfYKnCQIrxagfD5/4HXazvgMhbZY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-hj59WzmZMoqTYBqLT5erYw-1; Mon, 21 Aug 2023 03:35:36 -0400
X-MC-Unique: hj59WzmZMoqTYBqLT5erYw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fee703462dso9279415e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603335; x=1693208135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ProDBu5Ag25pBTgiiIYMqUeBZB4depYMcRXKdKs1r4=;
 b=FyI8ioM8Ye+NBwymi2u2QELK2MGiV61K+5DWFWSBLMbJ0N7Bev7WRh+zUY3Ji86+B9
 8FTOLmVU10IyxqC3cY+i3v5OBYlYUB8ywv3V18z0yDupGgJhUEQvF5clVS3K8zPm0Bm7
 SfD0UwdiV4gglFiACGEuFrBrRwjrMgYKzGClv7S4LSgkRpCSyeOXnVe7VC2UbaBjJPKw
 RnW5zmSFE2f3MsBeXegnRJGlUVj1rDvkddMFBQTAnHXhuqI0D3lh6L+/JlJTRWZ/D2St
 J94T6VMvWsRY9CDDbiXvt/cVErfBAWPuBuW1yZoMLELtQGwcgm/FZxweRYMR53mcipg9
 eIAA==
X-Gm-Message-State: AOJu0Yx3gvvo3txzBNF4TSaUBCP2hvnsCDcBHlk0akf/nQSXKNBYesg1
 XPdwwAeEhqo9mZ3jwZXoH/xMaCkWy3DCwQiTWaj2eeNnT+etTRwddI4xTzi64M7SB67v1K408po
 WYUGlllFaD1bist4=
X-Received: by 2002:a7b:c051:0:b0:3fc:616:b0db with SMTP id
 u17-20020a7bc051000000b003fc0616b0dbmr4443155wmc.9.1692603335537; 
 Mon, 21 Aug 2023 00:35:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDlIOLabIjQoxrICm0TJtbWDFtJKauTHdrE5AjgnV9fsthqG+6Losw/3VqlGwJNgc2CfA88w==
X-Received: by 2002:a7b:c051:0:b0:3fc:616:b0db with SMTP id
 u17-20020a7bc051000000b003fc0616b0dbmr4443147wmc.9.1692603335348; 
 Mon, 21 Aug 2023 00:35:35 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a1c7210000000b003fbb0c01d4bsm11752398wmc.16.2023.08.21.00.35.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:35 -0700 (PDT)
Message-ID: <ec9f73d0-51c0-858f-b228-df848047f8c7@redhat.com>
Date: Mon, 21 Aug 2023 09:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 21/21] block: Mark bdrv_add/del_child() and caller
 GRAPH_WRLOCK
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-22-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-22-kwolf@redhat.com>
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
> The functions read the parents list in the generic block layer, so we
> need to hold the graph lock already there. The BlockDriver
> implementations actually modify the graph, so it has to be a writer
> lock.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


