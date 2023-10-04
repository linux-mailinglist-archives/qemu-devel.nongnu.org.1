Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B17B8210
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2gf-00049B-7c; Wed, 04 Oct 2023 10:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2gR-00047I-Gg
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2gN-0005FR-5V
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696429017;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=iLTKkZOSMAtA7etidNFnUnYn7xYm1fQU2GPYCuy0zpY=;
 b=Vk5ANUSwMo4HlpGxSBtls14NMhkBn/HNym+j4Ey8Cz/0r6K91YORjP/MJBU9h8lDuSONHh
 LwtZHgxBLR3Cy/krP4HJjR1ZWDyEscrXP8xomPvS+LMAb6bt1yjZ91lMp1UrAIHtyI6xYD
 Vht+Il5Mqw+kLAS+6PeELRoSWDK7u3w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-ogolJYXdP7aUfsdUMl_SoA-1; Wed, 04 Oct 2023 10:16:46 -0400
X-MC-Unique: ogolJYXdP7aUfsdUMl_SoA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4064e7a166dso15901005e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696429004; x=1697033804;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLTKkZOSMAtA7etidNFnUnYn7xYm1fQU2GPYCuy0zpY=;
 b=BpSWtnNUe9FSB9uw7xUIT5/P8NU2fSxUO9Zbx7QCufMMV/3RJbEwSEKctN4noJ7fSP
 HpB45p5Ftb2CezTa+aKSmdlGJzxjnJJ49kI6RKA6SsvHEJcl6CVb+M3xpxIfYuPDFz+k
 13Lgf7mCw+AHg8WsCV01FsrUglyGXwIIIBq3lMK736aF8jWf/mSZKp9NvwI2OVDVpzG6
 glt4Ligc0QxF18V5ggDK36KANyqkrGUmM6+PBTSeLvFhGjSOsRZ3HETrYxIcKUzZMjBv
 A8yISbyr+yUTrfBBvuuM8uZSRzdigED5vfeT+8ikpUeLca0yXVssiPNgGZov9IpHLEsU
 gCKQ==
X-Gm-Message-State: AOJu0YzWf7UlYeZzzm72sSoiETCUVEkxYGIdD7NuCin8fPBttSPFd+He
 7t8yiP9vTamDVwefNvMqR5ZrU7Lh90ws9S+T8iTBQFWvacRgnbsnEiTebuRYUqbag/TPCBMLpaU
 CDAUC5ytuFLVhjVk=
X-Received: by 2002:a05:600c:2113:b0:401:73b2:f043 with SMTP id
 u19-20020a05600c211300b0040173b2f043mr2562001wml.1.1696429004685; 
 Wed, 04 Oct 2023 07:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2Ct4ROQVoIpYbhSgv9nph0ay2b44BPsC2+xsoadBiU3u1VF0Lb6f2MWeGaTGUK+eU82gTKw==
X-Received: by 2002:a05:600c:2113:b0:401:73b2:f043 with SMTP id
 u19-20020a05600c211300b0040173b2f043mr2561980wml.1.1696429004282; 
 Wed, 04 Oct 2023 07:16:44 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m19-20020a7bcb93000000b003fe61c33df5sm1652973wmi.3.2023.10.04.07.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:16:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Steve Sistare
 <steven.sistare@oracle.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v5 0/6] migration: Test the new "file:" migration
In-Reply-To: <20230712190742.22294-1-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 12 Jul 2023 16:07:36 -0300")
References: <20230712190742.22294-1-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:16:42 +0200
Message-ID: <87jzs21nhx.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Based-on:
> [PATCH V4 0/2] migration file URI
> https://lore.kernel.org/r/1688135108-316997-1-git-send-email-steven.sistare@oracle.com

Full series are integrated for next PULL request.

Thanks, Juan.

>
> Since v4:
>
> - Implemented a separate version of test_precopy_common to be used
>   with the file transport (patch 6).
>
> v4:
> https://lore.kernel.org/r/20230706201927.15442-1-farosas@suse.de
>
> v3:
> https://lore.kernel.org/r/20230630212902.19925-1-farosas@suse.de
>
> v2:
> https://lore.kernel.org/r/20230628165542.17214-1-farosas@suse.de
>
> v1:
> https://lore.kernel.org/r/20230626182210.8792-1-farosas@suse.de
>
> Fabiano Rosas (6):
>   tests/qtest: migration: Expose migrate_set_capability
>   tests/qtest: migration: Add migrate_incoming_qmp helper
>   tests/qtest: migration: Use migrate_incoming_qmp where appropriate
>   migration: Set migration status early in incoming side
>   tests/qtest: migration: Add support for negative testing of
>     qmp_migrate
>   tests/qtest: migration-test: Add tests for file-based migration
>
>  migration/migration.c             |   7 +-
>  tests/qtest/libqtest.c            |  33 ++++++
>  tests/qtest/libqtest.h            |  28 +++++
>  tests/qtest/meson.build           |   1 +
>  tests/qtest/migration-helpers.c   |  60 ++++++++++
>  tests/qtest/migration-helpers.h   |  10 ++
>  tests/qtest/migration-test.c      | 185 ++++++++++++++++++++++++++----
>  tests/qtest/virtio-net-failover.c |  77 ++-----------
>  8 files changed, 308 insertions(+), 93 deletions(-)


