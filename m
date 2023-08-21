Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA744782485
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzT5-0000CZ-Qs; Mon, 21 Aug 2023 03:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSN-0008Ih-F8
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSJ-00063J-Cq
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOqmsxyQz/+esoujPR0sG4w0Mnp7eccHLgcGIhNwSQA=;
 b=XkI+/NXB6V2lD8Fq0ThREHt1TBTCQLPL78Y1POCNFF00seT7GdGmi/7men+vTb4fO57BOw
 pG8Xg0XQSlO3VjSBBRSljEqfdhFL6Ir5emmq0pTghOOEZfSTS3k5UrMOafuiSjte2sVLXw
 0DnWNlfOCVeiz8kV5iYkcMmSekBTSt4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-Jrw8wfWsNyuRBm6F34dKFw-1; Mon, 21 Aug 2023 03:34:59 -0400
X-MC-Unique: Jrw8wfWsNyuRBm6F34dKFw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31adc3ca07aso1777361f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603298; x=1693208098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IOqmsxyQz/+esoujPR0sG4w0Mnp7eccHLgcGIhNwSQA=;
 b=c14UBFFSLa6pFcwNwDkP7aVkPkVI+4DMOiPNE9Pve2GQwqZQcoRWrEJxT/NTaOPiKT
 8MH/UUtFW+R5V8NAXvUZNSTcZPTF26c3KkdeWffCGrSwvl1826H83joCOs4E9mqBmuID
 pdHdrChz6iqeELFI7g++8Wa/10Tf/1eXAcsQwv0nHhTiXoJFQ+sdiTHtFM6J+2zGcpvX
 8zz9Zp+dR1Is0//7ApXWsahtlj268bhLP6r8tMYWLHQ4jHcb7XwvLCZE/2mQw0Xi0drM
 kiypZKWORH/kF+Z43A98jehHE5bkT4S3j2z1vK+jUtZjQWA1byDF0NDOWGgPFlzw5s0F
 dAfw==
X-Gm-Message-State: AOJu0Yz2yu1xJhP2Vt1THZBOZ6AW0OW0UiAqXpebIfPEnGpjYnTK8SbK
 9SqSeUsZ1F7DzJEpX0rVBpgAwaMkNOIVYGjzZ3UdgSBgX76vocUi1ewSDy7uK6538oqePfV5XFE
 hBx4ZzdEYJ25Vyps=
X-Received: by 2002:adf:f6c7:0:b0:319:6d8a:75f5 with SMTP id
 y7-20020adff6c7000000b003196d8a75f5mr4452188wrp.20.1692603297912; 
 Mon, 21 Aug 2023 00:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF0V12mIYKdAB1Kozqkod2+32zFlWvUfQSdacWSXuXHtLgJe1qoRCChN7sF9ktFDJ37YygqQ==
X-Received: by 2002:adf:f6c7:0:b0:319:6d8a:75f5 with SMTP id
 y7-20020adff6c7000000b003196d8a75f5mr4452184wrp.20.1692603297754; 
 Mon, 21 Aug 2023 00:34:57 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 d4-20020adfe844000000b003196b1bb528sm11460393wrn.64.2023.08.21.00.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:34:57 -0700 (PDT)
Message-ID: <6e0ad551-055d-02c8-981f-9a711ce443fd@redhat.com>
Date: Mon, 21 Aug 2023 09:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/21] block-coroutine-wrapper: Add
 no_co_wrapper_bdrv_wrlock functions
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-7-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-7-kwolf@redhat.com>
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
> Add a new wrapper type for GRAPH_WRLOCK functions that should be called
> from coroutine context.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


