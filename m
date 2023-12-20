Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4422181A004
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:41:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwoW-00027d-GD; Wed, 20 Dec 2023 08:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFwoB-00022H-4S; Wed, 20 Dec 2023 08:40:26 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFwo8-000274-Qc; Wed, 20 Dec 2023 08:40:22 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-594178b3959so24167eaf.0; 
 Wed, 20 Dec 2023 05:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703079617; x=1703684417; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uMd4ADOFvkzah5me9T/+HHhJ6VCiXe+Wthd/vIvVj/o=;
 b=EYpBd9JHL2yu4ekCZO++nADn+1yCqzL2rFRdRUiExnMUUTCsvztRKH03PdXW4w826u
 f2jXb6HhB0y8fB2ipteuJRaAr1NSJuEEW4LuhSv1gzTb+3go9/KXX560u3Q3PtuPXEZ4
 JmnZLWTT9YnQ24tXMut2NnIiZnmykWGE72Lnv9tEKZ+cmJ+9KaLq3NGxC/vrndrGFgrQ
 U/WiYNBfD2TXt6tbdudmfLXpDflvSG7qglm4CoomcQerW/vjvh8HXjz7EoS3zYrP8/KL
 RS2UuJt8KjFihEzesqOp0M4hAsAiSK4rmIUWDzLTkbZWOu1lguXWuECckzBlt/PwJnBM
 ariQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703079617; x=1703684417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uMd4ADOFvkzah5me9T/+HHhJ6VCiXe+Wthd/vIvVj/o=;
 b=VJA5Y8qR9k2rcUmBEKjs5uSV9+MZMYNePCkXltPWQhVu8MePxYEDW9L4J9OTFDp4tM
 6K2EiLtgh/hhvgsrtMf0/1Gl99ibu/tXDoyfhOkBgpkp36c5v64PQDdSCmflni5w7ur2
 sKz60tMWLJOWM2wmbEPcyGqFro4n0z4lR6calQw61xthLWrMvCHDbGbrTmsbzOCEPnzr
 4ctvpBWmOf4zHQ1EHGCwjPqmBT2eUe8OO1PmPkcEUnmWiIqszizeoTfn3hNfGA05UJ9/
 kSqDOrwquMXXuU8ThWPm+GjXBI+nBSVHcqac15DKCqI0hYrSjbecaKO2nsDSHkFE4k5r
 MoaQ==
X-Gm-Message-State: AOJu0YxNus9xXg0k/NQAtikoy2ekWLYTry0t4g+Y91MG85yx/9VAvtSF
 w7GpEUzrJ8mGxUoc4U5fSC+wMDcSOGI0kUSqVhs=
X-Google-Smtp-Source: AGHT+IG4wiFT4rUzLfQAVpvMwGvhbloaVAniWXFbzQNYl02YYRfoCtVhV2QvGtYv0LsqGi1jEHbDB4q4s7vK0gg2PG4=
X-Received: by 2002:a4a:8c26:0:b0:593:e06a:5ade with SMTP id
 u35-20020a4a8c26000000b00593e06a5ademr2000642ooj.14.1703079616936; Wed, 20
 Dec 2023 05:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20231205182011.1976568-1-stefanha@redhat.com>
 <20231205182011.1976568-5-stefanha@redhat.com>
 <ZYG2mSe1JWnC0tq_@redhat.com> <ZYHew2poxuJJRyhC@redhat.com>
 <CAJSP0QX0fg0TGWuveJz6+QbF9EmY=vPiU-c99fHZMN=1jAnXkw@mail.gmail.com>
 <ZYK0pUSPFQiU4Qs_@redhat.com>
In-Reply-To: <ZYK0pUSPFQiU4Qs_@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 20 Dec 2023 08:40:04 -0500
Message-ID: <CAJSP0QXc2RVDHC_-CxbB_rvKOR36Q_wz5wWgCgaFtYt37oE6XA@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] aio: make
 aio_context_acquire()/aio_context_release() a no-op
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>, 
 Xie Changlong <xiechanglong.d@gmail.com>, Paul Durrant <paul@xen.org>,
 Ari Sundholm <ari@tuxera.com>, 
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Wen Congyang <wencongyang2@huawei.com>, 
 Alberto Garcia <berto@igalia.com>, Anthony Perard <anthony.perard@citrix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org, 
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Xu <peterx@redhat.com>, 
 Emanuele Giuseppe Esposito <eesposit@redhat.com>, Fam Zheng <fam@euphon.net>,
 Leonardo Bras <leobras@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 20 Dec 2023 at 04:32, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 19.12.2023 um 22:23 hat Stefan Hajnoczi geschrieben:
> > The following hack makes the test pass but there are larger safety
> > issues that I'll need to look at on Wednesday:
>
> I see, you're taking the same approach as in the SCSI layer: Don't make
> things thread-safe, but just always access them from the same thread.

Yes, but it feels like a hack to me. You pointed out that other parts
also don't look thread-safe (e.g. the clients list) and I agree. I've
started annotating the code and will try to come up with a full fix
today.

Stefan

