Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 279CE726138
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 15:26:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6tAv-0004Yj-Gf; Wed, 07 Jun 2023 09:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6tAq-0004YH-1j
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6tAl-00028r-3U
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686144357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dA646okxIxZ4yORZLfmdLs4bDP7beT21a0hQXGPPrQk=;
 b=fdBjfd0GLpP2zhWK0PDmqVaEhZ5rPEy1RpJmF4Mojvcp2n05rVlLDBtFLJBLAk0xJQTNFZ
 lQpMNdMLxBuXiLxXwY5qi+tqdkHwKov9+f65L3Qz45EpP53/0WJVvh1F8hR1+cVH+Lv56a
 fOmdnnHQAok0RlKJAXdBY9calXCz9e8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-y091-s9eMJyoZ2dwcAEGow-1; Wed, 07 Jun 2023 09:25:55 -0400
X-MC-Unique: y091-s9eMJyoZ2dwcAEGow-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62615f764b4so8903906d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686144355; x=1688736355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dA646okxIxZ4yORZLfmdLs4bDP7beT21a0hQXGPPrQk=;
 b=lqbUj3XxXwcGzK8FUiCyyvwrCaLOh4MidvLqVgfs/+mBMFHHaeUUHyV08ealWHJImv
 vJyJHiVqgr0TadMbEeMWteMIlUvg9bGdCtytHXGpK2N8Kqtw1dfRSaIE9F2WlNXWK8lE
 GfnCRV5fJQuDbmt4ww3J11A4fm+03YjHm/fkXITLXl98S8pKPIw7itHEf8qCAEiB5W5w
 G0o4KdjlJpXAPKg+2NsheFFt6cNGBMlcO5V+3Z+f2xmc10KXY7VkXul5lIEfkbSO6jo5
 /94IoefTvQDL7Jj5k0eLvdGEURBOU8rqrkYbRTdKpmTV3JPBWHFkdObUFfHJg6MnrJxT
 RqgQ==
X-Gm-Message-State: AC+VfDxOnArpTQTGmWBIH0aLvJIiVM51dhaIgAeTCrrH6mqoId3n+V0K
 7L/0QSov+zd9+pI6mX1yMv6Ksu8adylza4jJMQUpoo7L4nKPfKIsBEdweiCCHul7+kJgHEE40fA
 2yFKCUM/Tz1AJTwQ=
X-Received: by 2002:ad4:5c84:0:b0:622:265e:3473 with SMTP id
 o4-20020ad45c84000000b00622265e3473mr2085854qvh.1.1686144354937; 
 Wed, 07 Jun 2023 06:25:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6i9hpt8vF+/RlaE3CJ1MKHUCNkdksrb90G2kMwHAGOcvSAFr7hscM2uZudXJUf0GzhL/Q1xA==
X-Received: by 2002:ad4:5c84:0:b0:622:265e:3473 with SMTP id
 o4-20020ad45c84000000b00622265e3473mr2085829qvh.1.1686144354692; 
 Wed, 07 Jun 2023 06:25:54 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 oj2-20020a056214440200b006262956aa0dsm161230qvb.99.2023.06.07.06.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 06:25:53 -0700 (PDT)
Date: Wed, 7 Jun 2023 09:25:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: quintela@redhat.com, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/3] migration/multifd: Protect accesses to
 migration_threads
Message-ID: <ZICFWm+qTOHBgzzN@x1n>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-3-farosas@suse.de>
 <87y1kvoezi.fsf@secure.mitica> <87o7lrh48h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7lrh48h.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 07, 2023 at 09:00:14AM -0300, Fabiano Rosas wrote:
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index e731fc98a1..b3b8345eb2 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -1146,6 +1146,7 @@ static void migrate_fd_cleanup(MigrationState *s)
> >>          qemu_mutex_lock_iothread();
> >>  
> >>          multifd_save_cleanup();
> >> +        qmp_migration_threads_cleanup();
> >
> > I think I will spare this one as the mutex is static, so we are not
> > winning any memory back.
> >
> 
> Ok

We could consider __attribute__((__constructor__)) in this case.

-- 
Peter Xu


