Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7929D7B86EF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:48:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5yi-0006Kb-S0; Wed, 04 Oct 2023 13:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5yX-0006Hw-GE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5yU-0006VR-5R
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696441673;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vwBAPAdZ5TCG/FMbh+3dvMv9loFC60B2aA9Z3WArG3E=;
 b=dHwvOd60LX0iIw/aTWwAiZIB9ljXoxp2tRHpa5wCZ/90yp8Jo8bw4LBdU8AWqVt34T52F0
 Vj/d19Kk/QeMkYX4Hyv/USaTW1aJKfFamF8yukkubFYKlo00lKT1GC+l/0n+ooX3qwFZdy
 3tT6ThPACe413ZDy/sp1KaloCuFiO1Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-taYLSLLWO_ucqv-rXg2Mfw-1; Wed, 04 Oct 2023 13:47:49 -0400
X-MC-Unique: taYLSLLWO_ucqv-rXg2Mfw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32686c75f8fso94809f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696441668; x=1697046468;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwBAPAdZ5TCG/FMbh+3dvMv9loFC60B2aA9Z3WArG3E=;
 b=Q+/xbx717p6PTIdEksXwNihzNHGF/ld6gx+IU70lngUKkOaY8TBvHM/z73dmKsu9jH
 dfxdd2iC0u7ZMuxI9KIyzg6hB+RMvNgVAkezMW2NwsR/Yo785ApY+EMDXsnlsdisXnqw
 o2u4x3cDgnx/j5337wYjDGH+T6sosUVuBKQYG3opFOmBP1qF+S1yIgjsCX8cN1FnR/qV
 4zOQ4DbynKv+tkgLs5GB8x4/fIVG7/gbSW1o5WzvLKMQZug/SB6ceOW6haj2oLDVe+ue
 umoml2DSMDvYhccdDkq8jEDVcV0Om7mdLcZu6CJfzJ+D26srzKHP1oA0Ryp3NCSJh75T
 MXGA==
X-Gm-Message-State: AOJu0Yz5ijq2X10xI+dUE984MFKi8fg8cdpnzYn5GFDPemcqjXjvkjds
 xViyP0BLWrL5AFgMqaxyLtW2vrZdYKfbhDdr3iCC1QULBR1YuLRd7nnHwSC+F/lBoD9Xu22ep+c
 hhxmNeBpExfAtasU=
X-Received: by 2002:a05:6000:369:b0:313:f0d7:a43 with SMTP id
 f9-20020a056000036900b00313f0d70a43mr2576228wrf.23.1696441668665; 
 Wed, 04 Oct 2023 10:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9rb0I0xkDbqzsynOlbDDiOuSNOa6a2DYpyqZASAvAoMAnqjogRggb1A36inEuQJSvcQWxcA==
X-Received: by 2002:a05:6000:369:b0:313:f0d7:a43 with SMTP id
 f9-20020a056000036900b00313f0d70a43mr2576209wrf.23.1696441668339; 
 Wed, 04 Oct 2023 10:47:48 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6110000000b0031912c0ffebsm4498191wrt.23.2023.10.04.10.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 10:47:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 51/53] migration/rdma: Downgrade qemu_rdma_cleanup()
 errors to warnings
In-Reply-To: <20230928132019.2544702-52-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:17 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-52-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 19:47:46 +0200
Message-ID: <87pm1us2il.fsf@secure.mitica>
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

Markus Armbruster <armbru@redhat.com> wrote:
> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
>
> qemu_rdma_source_init(), qemu_rdma_connect(),
> rdma_start_incoming_migration(), and rdma_start_outgoing_migration()
> violate this principle: they call error_report() via
> qemu_rdma_cleanup().
>
> Moreover, qemu_rdma_cleanup() can't fail.  It is called on error
> paths, and QIOChannel close and finalization.  Are the conditions it
> reports really errors?  I doubt it.
>
> Downgrade qemu_rdma_cleanup()'s errors to warnings.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


