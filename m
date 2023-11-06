Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5104C7E2B69
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:45:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03et-0007xO-Ih; Mon, 06 Nov 2023 12:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03eq-0007wv-LP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:45:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03em-0006j5-Kd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699292699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZUHhAmFtlrN+lohzBJX2U+0m1HWMz1LbnL3CWxlmHY=;
 b=DgLO9OqIdfpAUcIiBsspOPO7Vgf0Ljx/Edkn9e/gpDgwBqPHRQT0HGuHIgNcgOJLtSlcT8
 qaLEd9tw7o23zcl0WXuywX4MtD0F6af70WYFiJLGkAwFKam1VKpZncDMgogTjnr1msnpfT
 xbyWydgNGRjioGHttA1D3GAQyWSE4gw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-YVjKI4LKNHOE8_05Z-y-Zg-1; Mon, 06 Nov 2023 12:44:58 -0500
X-MC-Unique: YVjKI4LKNHOE8_05Z-y-Zg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-407da05ee50so30043125e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699292697; x=1699897497;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YZUHhAmFtlrN+lohzBJX2U+0m1HWMz1LbnL3CWxlmHY=;
 b=wkvN8HWkFMb/Sn646EqaUmhHDwCQ/HOuZajFqvgQWzh59SrAszLMfdbhz7tLdgcKVy
 lVWhoIPOHWTOXP8nnS39nY43/JoIAIEmciI84JuHmG6r/uLUV1J9hMc2yyNoLYhtBkBt
 aXGVIoln6GzlGFsJIYv7ciJMH9lZeen2PsnPfA6ScDXHFYMgKty830puB/nRqcDL4HcK
 fNCow3TN5WJqohgEV4WjedBCJHbXqpj1jD2CJWOjJaqrZ6Za0lZyfMKFvNPITG4Ab2v+
 ylRjG+RJb8wnKzUO1ginqM005BhitmHHcrD1w8Hltd6ddaJA9o4TJb19TJ+pnrIcFw8s
 7t4g==
X-Gm-Message-State: AOJu0Yzb5mNcDhioRvbK1k22zFUKHQ5+ltHl2Y0Bk9abXrSWqR1CdOxO
 iJvEjmO9cmUXuBc2dU+FGPEw8BYsbOva/XHmLMDM824hAmx7ZGHD66Nd7/DaPAc33LkVOrMM3VC
 SkUhU9ge3l8dSKk4=
X-Received: by 2002:a7b:c4d5:0:b0:405:39c1:a98b with SMTP id
 g21-20020a7bc4d5000000b0040539c1a98bmr358411wmk.20.1699292697036; 
 Mon, 06 Nov 2023 09:44:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2vlRaV0ayrWTqUw9jK2V0uP31GeQna+wOvtELbBkYXzTf3njr0QYIkkwYUiUeZQgjbU2Q6g==
X-Received: by 2002:a7b:c4d5:0:b0:405:39c1:a98b with SMTP id
 g21-20020a7bc4d5000000b0040539c1a98bmr358400wmk.20.1699292696701; 
 Mon, 06 Nov 2023 09:44:56 -0800 (PST)
Received: from redhat.com ([5.102.242.158]) by smtp.gmail.com with ESMTPSA id
 n3-20020a05600c4f8300b004064288597bsm13057822wmq.30.2023.11.06.09.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 09:44:56 -0800 (PST)
Date: Mon, 6 Nov 2023 12:44:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 0/6] migration: check required entries and sections
 are loaded
Message-ID: <20231106124405-mutt-send-email-mst@kernel.org>
References: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 06, 2023 at 03:35:54PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> Surprisingly, the migration code doesn't check that required migration entries
> and subsections are loaded. Either optional or required sections are both
> ignored when missing. According to the documentation a "newer QEMU that knows
> about a subsection can (with care) load a stream from an older QEMU that didn't
> send the subsection". I propose this behaviour to be limited to "optional"
> sections only.
> 
> This series has a few preliminary fixes, add new checks that entries are
> loaded once and required ones have been loaded, add some tests and
> documentation update.
> 
> thanks

I think this kind of thing is better deferred to the next release -
unless you have something specific in mind this fixes?

> v3:
>  - rebased, drop RFC status
>  - switch from tracepoint + returning an error to report for missing
>    subsections, as we worry about potential regressions
>  - add r-b tags
> 
> v2:
>  - add "migration: rename vmstate_save_needed->vmstate_section_needed"
>  - add "migration: set file error on subsection loading"
>  - add subsection tests
>  - update the documentation
> 
> Marc-André Lureau (6):
>   block/fdc: 'phase' is not needed on load
>   virtio: make endian_needed() work during loading
>   migration: check required subsections are loaded, once
>   migration: check required entries are loaded, once
>   test-vmstate: add some subsection tests
>   docs/migration: reflect the changes about needed subsections
> 
>  docs/devel/migration.rst  |  17 +++---
>  hw/block/fdc.c            |   5 ++
>  hw/virtio/virtio.c        |   6 +-
>  migration/savevm.c        |  43 ++++++++++++++
>  migration/vmstate.c       |  40 ++++++++++++-
>  tests/unit/test-vmstate.c | 116 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 215 insertions(+), 12 deletions(-)
> 
> -- 
> 2.41.0


