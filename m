Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 504977384A9
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:16:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBxfw-0002Ge-3G; Wed, 21 Jun 2023 09:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBxfh-0002FO-5b
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBxff-0001QW-4m
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687353287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vxoSofawamMOtpaArjik76SmGg02+VdpkJ4m9FNPYUU=;
 b=d4b8F97i3O40CeUYvjQwRPqtEz5QAfCDBkctgIsL9GuVvQ7SkPBbKcAoMC0BqLOCdA+mYH
 Fnk2bgBRijZ9jANBwUWdj2QCN7/oLjQuICLdfD9iUtvaKXIjjCJne0RwVfIYFibkvEAJfA
 p5StU5VBkWfGYgqvL756VlU/AiLb+X8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-vIth5LyYMWi7zZJZTdvPfg-1; Wed, 21 Jun 2023 09:14:46 -0400
X-MC-Unique: vIth5LyYMWi7zZJZTdvPfg-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6b468bdaea7so390996a34.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 06:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687353285; x=1689945285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxoSofawamMOtpaArjik76SmGg02+VdpkJ4m9FNPYUU=;
 b=Oq2njOZN4xsQOicMW36mY0DxXtiaa1ccpeacSV9uKfoBuQLRiZIA+/gK5hnI3fPH8f
 gzaVHgPDDrTizGzv0mznrbmG99AYv0T0/XoOByAAlJHJqmsrBkvj+O08cV3lQHsfFwoV
 fyKTWMvFuyiTor352/jfHNpvQfqyBH1ohWl1bqlqg9XdX7HqywZKIpRLLIAu+GqU2oCY
 FM4jOsUv4qjNmUnWE9ui5JUOov9q7PNhnEm3gOyf9wyAd43e30LxpKsABLrHYhWPBZDh
 +2tx82TELNdW/iQxLA/dRug7cL7pwDbXmp6AcIFEEappyTcCOPHvGbxPltBci2Al8PTl
 5wbw==
X-Gm-Message-State: AC+VfDyxscTZvRJXP+9r5W/2fF9VxKWrJsVH9vqfQpioS/VUk6vy7lN2
 pF+BkVo7t/FZ8qPPgjOLIvjpUf4m750dLrHXJ6vXNYhpg7lyKvTojEn/yksCuLbWy5bFJic5zE5
 Xwn4eLEqGa2t0AQ4=
X-Received: by 2002:a05:6870:c6a8:b0:18e:2bb2:3f95 with SMTP id
 cv40-20020a056870c6a800b0018e2bb23f95mr14501663oab.4.1687353285365; 
 Wed, 21 Jun 2023 06:14:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Lh0z8iUeTt0VLz56cMMiFtGAYedxJmPAK8u/NJ9fLuz38+uS8milWbZT6rtGUuSz82wRiSw==
X-Received: by 2002:a05:6870:c6a8:b0:18e:2bb2:3f95 with SMTP id
 cv40-20020a056870c6a800b0018e2bb23f95mr14501649oab.4.1687353285091; 
 Wed, 21 Jun 2023 06:14:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z19-20020ac84553000000b003f6ac526568sm2333496qtn.39.2023.06.21.06.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 06:14:44 -0700 (PDT)
Date: Wed, 21 Jun 2023 09:14:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 13/42] migration-test: Check for shared memory like for
 everything else
Message-ID: <ZJL3w7i+disrA+i1@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-14-quintela@redhat.com> <ZJHGq847FcrpobuD@x1n>
 <87h6r1b02v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6r1b02v.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 21, 2023 at 12:07:20PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Fri, Jun 09, 2023 at 12:49:14AM +0200, Juan Quintela wrote:
> >> Makes things easier and cleaner.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  tests/qtest/migration-test.c | 20 ++++++++++++--------
> >>  1 file changed, 12 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> >> index daaf5cd71a..5837060138 100644
> >> --- a/tests/qtest/migration-test.c
> >> +++ b/tests/qtest/migration-test.c
> >> @@ -645,13 +645,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >>      const char *arch = qtest_get_arch();
> >>      const char *memory_size;
> >>  
> >> -    if (args->use_shmem) {
> >> -        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> >> -            g_test_skip("/dev/shm is not supported");
> >> -            return -1;
> >> -        }
> >> -    }
> >
> > Maybe assert on: "!args->use_shmem || shm_supported()" here?
> 
> Nope.
> 
> We are being extra defensive in some tests.

This will protect a new test passing in use_shmem=true without checking
shm_supported().  It'll then fail at starting the VM I think otherwise.

> 
> It is tested here
> 
> >> -    qtest_add_func("/migration/ignore_shared", test_ignore_shared);
> >> +    if (shm_supported()) {
> >> +        qtest_add_func("/migration/ignore_shared", test_ignore_shared);
> >> +    }
> 
> Checking (in the same code path) once in the same file looks like enough
> to me.
> 
> Thanks, Juan.
> 

-- 
Peter Xu


