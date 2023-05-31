Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC13717DAC
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Jfr-0006zd-IM; Wed, 31 May 2023 07:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q4JfX-0006nv-6S
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q4JfU-0002tT-Ns
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685531223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/vIx6llZCg7zStJE2lMasPApUjV/9UPzEy3eJ/kLTXo=;
 b=awQ3XNzwv1lBGBjYHSYxN8hAwWWTyYQuwQyktXzz6xEIEmR68wc4Bxt66Wwc00ww6iQDb4
 xVzqHKDPJmAQ5JtqRflioi+zEvW68HMUeejqaDURvWDR4DALOHe57gEa3KFjL2M/RS2tk7
 D2WKkSAeTF7Ylo1ClUpm8EMbwmxCDhc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-coEUADjVMsC_iqlHBzsQLA-1; Wed, 31 May 2023 07:07:00 -0400
X-MC-Unique: coEUADjVMsC_iqlHBzsQLA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f60911a417so25559735e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 04:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685531219; x=1688123219;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vIx6llZCg7zStJE2lMasPApUjV/9UPzEy3eJ/kLTXo=;
 b=RAKtVoifZKtrOSbWg2NzRaclcQwbKIU1r3nNUNdV+0erneh/MAQH+XUNiQLiLKtS7y
 C+mm168Ct3oSbDNxufmvbJiufp7WlZw8k7QSnj7UiNp4CoVOQW/NHdriQgdMYwGSrSbR
 74OZonQQJuH61guRDTvCiFi46vQtDPsajxwgGifB06YnuNyWT7u+QsAjiGXAvN3Atk+t
 kJukFd3x9UY27e8HVfxnfGRkXgNjEAZFpMOviTnPld42lcQrnnUAGcJhcvKw4+9QRvpq
 Ixp01U69LxTEapTTm5s6X9YoBf+QK078Pq8jpm+FOlaZA43Pa+QXuYrDFLF3zJTec1lz
 5HfQ==
X-Gm-Message-State: AC+VfDx+PDdvlHr0XqUzh6RFLuJbEsbq2t4IIG+j66sc4540M7EvYSOx
 N36xMShbkZ2x/zeUM/zyrxCe4JlXv+2BxxQ5Qfi0nYfQb2C/asKVR/ig/NV2wqqmC9T2D7h49wc
 dN8cHSrO9Dpqf1DU=
X-Received: by 2002:a1c:4b09:0:b0:3f6:d09:5d46 with SMTP id
 y9-20020a1c4b09000000b003f60d095d46mr4046647wma.20.1685531219036; 
 Wed, 31 May 2023 04:06:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42MBVrNR71i4dUlKOjmv/eZU34y4gjjum1F7SgNEVe+VJM6jBZ4fVbYQgczwyKTIS3zPz6ZQ==
X-Received: by 2002:a1c:4b09:0:b0:3f6:d09:5d46 with SMTP id
 y9-20020a1c4b09000000b003f60d095d46mr4046637wma.20.1685531218740; 
 Wed, 31 May 2023 04:06:58 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a7bc3d3000000b003f423508c6bsm20068302wmj.44.2023.05.31.04.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 04:06:57 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com,  stefanha@redhat.com,  alex.bennee@linaro.org
Subject: Re: [PATCH 3/4] tests/qtest: Fix a comment typo in vhost-user-test.c
References: <cover.1685476786.git.mzamazal@redhat.com>
 <89d88ee1cab67b8412617e593ea786f1014d737b.1685476786.git.mzamazal@redhat.com>
 <cc482875-6007-466d-808a-fc3ddec2a659@redhat.com>
Date: Wed, 31 May 2023 13:06:53 +0200
In-Reply-To: <cc482875-6007-466d-808a-fc3ddec2a659@redhat.com> (Thomas Huth's
 message of "Wed, 31 May 2023 07:02:24 +0200")
Message-ID: <87pm6g7oaa.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 24/05/2023 15.34, Milan Zamazal wrote:
>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>> ---
>
>>   tests/qtest/vhost-user-test.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/tests/qtest/vhost-user-test.c
>> b/tests/qtest/vhost-user-test.c
>> index e4f95b2858..8ab10732f8 100644
>> --- a/tests/qtest/vhost-user-test.c
>> +++ b/tests/qtest/vhost-user-test.c
>> @@ -281,7 +281,7 @@ static void read_guest_mem_server(QTestState *qts, TestServer *s)
>>       /* iterate all regions */
>>       for (i = 0; i < s->fds_num; i++) {
>>   -        /* We'll check only the region statring at 0x0*/
>> +        /* We'll check only the region starting at 0x0*/
>
> While you're at it, I'd also add a space between the "0x0" and the "*/".

I'll add it in the next patch iteration, thanks for pointing this out.

> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>>           if (s->memory.regions[i].guest_phys_addr != 0x0) {
>>               continue;
>>           }


