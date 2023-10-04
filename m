Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E037B86F6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:50:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo610-0007iu-Ef; Wed, 04 Oct 2023 13:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo60s-0007gW-NB
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo60r-000750-6f
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696441819;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=H/xw6pEylmt19p3HnSKvFEATddF5VrgLkHWhfHDkJG4=;
 b=YJ57yLoHYlGugJXqKIxuPyBqHj1tTX1DxKDz4/XrGMbwlOVF/A6yCQ22W4LlLwSJxW1sHK
 SnUys7mtGPiIUPdGFnN1fW/a/Dl+Oxk0HXCqilkv8UPN17iyEkMhRAPoKwrfu4ArGRw1dJ
 4ck/nEUzDumpZZn3j4RUBiFP9/P6220=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-5gFo7110O_WoAtTNyrRGlA-1; Wed, 04 Oct 2023 13:50:08 -0400
X-MC-Unique: 5gFo7110O_WoAtTNyrRGlA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3233a13b47eso112118f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696441807; x=1697046607;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/xw6pEylmt19p3HnSKvFEATddF5VrgLkHWhfHDkJG4=;
 b=GcOznVPLUBPLkuw8EJ3t63/ldGy3DxnU3tGDX0NTMEoEIoC8vdkqRh+s3VVXHqMRKw
 F3Qhjq/bYzGkLYWOiGWo1XFkJaWJpz3U7rhyaHspBwX4OOrFphNsK243wI9sGH7Q5BtB
 ndKuttk6OniWMKtcrApJugbF2fktQzNHV1ww95P7cvcwxRZ/WUiyePjkHh9KzjPtZWt8
 wLWPHwh+3iApGwrAISrJlKU7zN/MkKyp8iuSMwMIK3QHMqJuL0YIckrjUAX/KHDAnFEn
 V5L6yQTjRINs4EN+bCtCVey10HMiPLZyL3SgZdPC1IKKEoI4cgcoSGYWirUOEGjvw3af
 1hZw==
X-Gm-Message-State: AOJu0YyxtqqCL11us9q/NXQiIhaD59D3phAreCa1c0ufLo2Pk8Ob2LyF
 07NYBMVreVgIB1nXljUL5F2nPDmoIIK2u18eajIc8tZjmtsHfMfaGKvfzw/lC214JsrUfsrTSwd
 VwdcWewrC9h7JKD0=
X-Received: by 2002:a5d:4e49:0:b0:322:5d58:99c1 with SMTP id
 r9-20020a5d4e49000000b003225d5899c1mr2593153wrt.10.1696441807239; 
 Wed, 04 Oct 2023 10:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWirEs1ZUJqR+6xwxVrOWlaACGA5VJSDW/kwac2sa9gR7ipWq3VeAcSXO5ReJHO1ivBf3dgg==
X-Received: by 2002:a5d:4e49:0:b0:322:5d58:99c1 with SMTP id
 r9-20020a5d4e49000000b003225d5899c1mr2593141wrt.10.1696441806916; 
 Wed, 04 Oct 2023 10:50:06 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r5-20020adfce85000000b00315af025098sm4500201wrn.46.2023.10.04.10.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 10:50:06 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 53/53] migration/rdma: Replace flawed device detail
 dump by tracing
In-Reply-To: <20230928132019.2544702-54-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:19 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-54-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 19:50:05 +0200
Message-ID: <87lecis2eq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> wrote:
> qemu_rdma_dump_id() dumps RDMA device details to stdout.
>
> rdma_start_outgoing_migration() calls it via qemu_rdma_source_init()
> and qemu_rdma_resolve_host() to show source device details.
> rdma_start_incoming_migration() arranges its call via
> rdma_accept_incoming_migration() and qemu_rdma_accept() to show
> destination device details.
>
> Two issues:
>
> 1. rdma_start_outgoing_migration() can run in HMP context.  The
>    information should arguably go the monitor, not stdout.
>
> 2. ibv_query_port() failure is reported as error.  Its callers remain
>    unaware of this failure (qemu_rdma_dump_id() can't fail), so
>    reporting this to the user as an error is problematic.
>
> Fixable, but the device detail dump is noise, except when
> troubleshooting.  Tracing is a better fit.  Similar function
> qemu_rdma_dump_id() was converted to tracing in commit
> 733252deb8b (Tracify migration/rdma.c).
>
> Convert qemu_rdma_dump_id(), too.
>
> While there, touch up qemu_rdma_dump_gid()'s outdated comment.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


