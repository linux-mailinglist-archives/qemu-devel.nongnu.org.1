Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A478249D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:39:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzUJ-0001YM-Ef; Mon, 21 Aug 2023 03:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTF-0000Ij-Ix
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTB-0006Fk-IX
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gtk/yKQDe/qs/PCp9S8NpvDwRh+M8EzG29QarMQMlKc=;
 b=diNKyoDCPSHcpkA3I4jq9E6yu2f5QpJYAeBlEk1jhu9yOzpy6hqr/pGKpzOKlzeQ1JfqMc
 OZoGfhfAhd4BRKcu+7usxhiaWyLAG+MldyvRpdIoKijLJPxTuxA5PoJwUzLhcq9j8XXPHY
 9RitBqTDDN3JbCiCt9KaPS8a2zwgWUw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-cL0lFvZUPOKoz3sFfQn0XQ-1; Mon, 21 Aug 2023 03:35:34 -0400
X-MC-Unique: cL0lFvZUPOKoz3sFfQn0XQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso32932291fa.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603332; x=1693208132;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gtk/yKQDe/qs/PCp9S8NpvDwRh+M8EzG29QarMQMlKc=;
 b=AebelK15OEdoCH7BAJkOuYP7JEScvM0aKulz/Q5yv7Bh+NTe5rUrfR7tqHRtfETgZH
 FLlpxEHv1VNjCJFNJad9U/16OkRGRYlrOrnXTOGdIhKsGeQT/tMW6b5InvR64QAumNtM
 0XiAXkujLjrxROW0/9SMcShP39yhd85uq58X9zv9vEcVaKIIbLrLkXyEqiHbBbICHDJD
 BFP98/zgZ2JHGIfnBB7uQN+Ti+P5bmS1YvZxuWc2zpKrCjWnV7SK37rl6KSrwjF52whw
 ToOwbMhk0LPPIH/j90uuW5D9necVyWLq5iJC0JtP96M7fFUMX8oTpu9eBpa5eShkVJe9
 /m0w==
X-Gm-Message-State: AOJu0Yz7OkTlZpIjVMKvED2Yc8XoK16VczZhGFaGSzNH5vscT8bpVzDm
 aAMYmpE63A0L3UaZeCfUDrfhZ6xZTBX2mmn/AxL3ByDWLzKaw3vN8L9TUQ1U1eVJNISmGmuchKB
 2R0In27AYiWD94jJ3i99Odak=
X-Received: by 2002:a2e:3801:0:b0:2bc:b29e:8fef with SMTP id
 f1-20020a2e3801000000b002bcb29e8fefmr3049001lja.34.1692603332749; 
 Mon, 21 Aug 2023 00:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERhKjd/w+hrrMUbP1kl9XbyJ+S2gpiLEPvKiAV+ex9wS2XQK2VUjTO8eVqIUc98Qy9UyGOTg==
X-Received: by 2002:a2e:3801:0:b0:2bc:b29e:8fef with SMTP id
 f1-20020a2e3801000000b002bcb29e8fefmr3048990lja.34.1692603332576; 
 Mon, 21 Aug 2023 00:35:32 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a05600c221600b003fee9cdf55esm5285393wml.14.2023.08.21.00.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:32 -0700 (PDT)
Message-ID: <a51cdce7-5b38-9a43-a70e-8e0d3974b11b@redhat.com>
Date: Mon, 21 Aug 2023 09:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 20/21] block: Mark bdrv_unref_child() GRAPH_WRLOCK
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-21-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-21-kwolf@redhat.com>
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
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_unref_child(). These callers will typically
> already hold the graph lock once the locking work is completed, which
> means that they can't call functions that take it internally.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


